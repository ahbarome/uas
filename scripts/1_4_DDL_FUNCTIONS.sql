--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description: Data definition for functions
--*******************************************************************
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
--UTILITIES SCHEMA
--*******************************************************************
--RANDOM FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get a random betweem two values
-- =============================================
CREATE FUNCTION [Utilities].[Random] (@Upper INT,@Lower INT, @RandomValue NUMERIC(18,10))
RETURNS INT
AS
BEGIN
	DECLARE @Random INT
	SELECT @Random = ROUND(((@Upper - @Lower -1) * @RandomValue + @Lower), 0)
	RETURN @Random
END;

GO

--*******************************************************************
--ATTENDANCE SCHEMA
--*******************************************************************
--GETMOVEMENTSBYDATE FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-28
-- Description:	Get the movements by a specific
--				date
-- =============================================

CREATE FUNCTION [Attendance].[GetMovementsByDate](@Date DATE)
RETURNS TABLE
AS
RETURN 
(
	SELECT	DISTINCT [MOV].[DocumentNumber]
	FROM	[Attendance].[MovementView] [MOV] WITH(NOLOCK)
	WHERE	[MOV].[MovementDate] = @Date
	GROUP BY [MOV].[DocumentNumber]
)

GO

--*******************************************************************
--GETTODAYMOVEMENTS FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-28
-- Description:	Get only the movements for today
-- =============================================

CREATE FUNCTION [Attendance].[GetTodayMovements]()
RETURNS TABLE
AS
RETURN 
(
	SELECT	[DocumentNumber]
	FROM	[Attendance].[GetMovementsByDate](CONVERT(DATE, GETDATE()))
	GROUP BY [DocumentNumber]
)

GO

--*******************************************************************
--INTEGRATION SCHEMA
--*******************************************************************
--*******************************************************************
--GETCURRENTDAY FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description:	Get the current day
-- =============================================
CREATE FUNCTION [Integration].[GetCurrentDay]()

RETURNS INT
AS
BEGIN
	
	RETURN DATEPART(WEEKDAY, GETDATE())

END

GO

--*******************************************************************
--GETCOURSESBYDATE FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-28
-- Description:	Get the courses by specific date
-- =============================================
CREATE FUNCTION [Integration].[GetCoursesByDate](@Date DATE = NULL)
RETURNS TABLE
AS
RETURN 
(
	SELECT	* 
	FROM	[Integration].[ScheduleDetailView] [SDV]  WITH(NOLOCK)
	WHERE	( CONVERT(DATE, [SDV].[EndDate]) >= @Date AND CONVERT(DATE,[SDV].[StartDate]) <=  @Date ) AND-- Course of the semester
			[SDV].[DayOfTheWeek] = DATEPART(WEEKDAY, @Date)	
)

GO

--*******************************************************************
--GETCURRENTCOURSESBYTEACHERDOCUMENTNUMBER FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-28
-- Description:	Get the current courses in class
--				by teacher document number
-- =============================================

CREATE FUNCTION [Integration].[GetCurrentCoursesByTeacherDocumentNumber](@TeacherDocumentNumber INT)
RETURNS TABLE
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT  TOP 1 [EDV].[StartTime]
				, [EDV].[EndTime]
				, [EDV].[CourseId] 
	FROM	[Integration].[EnrollmentDetailView] [EDV]  WITH(NOLOCK)
	WHERE	( [EDV].[EndDate] >= GETDATE() AND [EDV].[StartDate] <=  GETDATE() ) AND-- Course of the semester
			[EDV].[DayOfTheWeek] = [Integration].[GetCurrentDay]()	AND -- Course for today
			( [EDV].[EndTime] >= CONVERT(TIME, GETDATE()) AND  [EDV].[StartTime] <=  CONVERT(TIME, GETDATE())) AND-- Current course
			[EDV].[TeacherDocumentNumber] = @TeacherDocumentNumber 
	ORDER BY [EDV].[StartTime] DESC
)

GO

--*******************************************************************
--GETCOURSESBYTEACHERDOCUMENTNUMBER FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-09-03
-- Description:	Get the current courses
--				by teacher document number
-- =============================================

CREATE FUNCTION [Integration].[GetCoursesByTeacherDocumentNumber](@TeacherDocumentNumber INT)
RETURNS TABLE
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT  DISTINCT [EDV].[CourseId] 
			, [EDV].[CourseName]
			, [EDV].[DayOfTheWeek]
			, [EDV].[DayOfTheWeekName]
			, [EDV].[StartTime]
			, [EDV].[EndTime]
	FROM	[Integration].[EnrollmentDetailView] [EDV]  WITH(NOLOCK)
	WHERE	( [EDV].[EndDate] >= GETDATE() AND [EDV].[StartDate] <=  GETDATE() ) AND-- Course of the semester
			[EDV].[TeacherDocumentNumber] = @TeacherDocumentNumber 
);

GO

--*******************************************************************
--GETTEACHERBYCOURSE FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-24
-- Description:	Get the a teacher by the course
--				identifier
-- =============================================

CREATE FUNCTION [Integration].[GetTeacherByCourse](@CourseId INT)
RETURNS TABLE
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT  TeacherDocumentNumber
			, TeacherFullName
	FROM	[Integration].[EnrollmentDetailView] [EDV]  WITH(NOLOCK)
	WHERE	CourseId = @CourseId
)

GO

--*******************************************************************
--GETENROLLMENTSTUDENTS FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-28
-- Description:	Get enrollment students by
--				course id, start time, end time
--				and student document				
-- =============================================

CREATE FUNCTION [Integration].[GetEnrollmentStudents](@CourseId INT, @CourseStartTime TIME, @CourseEndTime TIME, @CurrentDocumentNumberOfTheMovement INT)
RETURNS TABLE
AS
RETURN 
(
	SELECT	[SEV].[StudentDocumentNumber]
				, [SEV].[StudentCode]
				, [SEV].[StudentFullName]
				, [SEV].[StudentEmail]
				, [SEV].[StudentTelephoneNumber]
				, [SEV].[StudentAddress]
				, [SEV].[StudentImageRelativePath]
				, [SEV].[CareerName]
				, [SEV].[CourseName]
				, [SEV].[EnrollmentStatus]
		FROM	[Integration].[StudentEnrollmentView] [SEV] WITH(NOLOCK)
		WHERE	[SEV].[CourseId]				= @CourseId AND 
				[SEV].[StartTime]				= @CourseStartTime AND
				[SEV].[EndTime]					= @CourseEndTime  AND
				[SEV].[StudentDocumentNumber]	= @CurrentDocumentNumberOfTheMovement
)

GO

--*******************************************************************
--GETCURRENTSEMESTER FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-28
-- Description:	Get the current semester
-- =============================================
CREATE FUNCTION [Integration].[GetCurrentSemester]()

RETURNS INT
AS
BEGIN
	DECLARE @Semester INT
	IF( DATEPART(MONTH, GETDATE()) > 6)
	BEGIN
		SET @Semester = 2;
	END
	ELSE
		SET @Semester = 1;

	RETURN @Semester

END

GO

--*******************************************************************
--GETCURRENTACADEMICPERIOD FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get the current academic period
-- =============================================
CREATE FUNCTION [Integration].[GetCurrentAcademicPeriod]()

RETURNS TABLE
RETURN(
	SELECT	*
	FROM	[Integration].[AcademicPeriodView] WITH(NOLOCK)
	WHERE	[Period]	= DATEPART(YEAR, GETDATE()) AND
			[Semester] = [Integration].[GetCurrentSemester]() 
);

GO
--*******************************************************************
--GETCOURSESUMMARYBYID FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description:	Get the	course summary by id
-- =============================================

CREATE FUNCTION [Integration].[GetCourseSummaryById](@CourseId INT)
RETURNS TABLE
AS
RETURN 
(
	SELECT	[EDV].[CourseId]
			,  [EDV].[CourseName]
			, [EDV].[EnrollmentStatus]
			, COUNT( [EDV].[EnrollmentStatus] ) AS Total
	FROM	[Integration].[EnrollmentDetailView] [EDV]  WITH(NOLOCK)
	WHERE	[EDV].[CourseId] = @CourseId
	GROUP BY [EDV].[CourseId]
			,  [EDV].[CourseName]
			, [EDV].[EnrollmentStatus]
	UNION 
	SELECT	[EDV].[CourseId]
			,  [EDV].[CourseName]
			, 'Total'							AS [EnrollmentStatus] 
			, COUNT( 1 ) AS Total
	FROM	[Integration].[EnrollmentDetailView] [EDV]  WITH(NOLOCK)
	WHERE	[EDV].[CourseId] = @CourseId
	GROUP BY [EDV].[CourseId]
			,  [EDV].[CourseName]
)

GO

--*******************************************************************
--GETCOURSESWITHTOTALSTUDENTS FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description:	Get the courses with the total
--				of students in each course
-- =============================================

CREATE FUNCTION [Integration].[GetCoursesWithTotalStudents]()
RETURNS TABLE
AS
RETURN 
(
	SELECT	[EDV].[CourseId]
			,  [EDV].[CourseName]
			, 'Total'							AS [EnrollmentStatus] 
			, COUNT( 1 ) AS Total
	FROM	[Integration].[EnrollmentDetailView] [EDV]  WITH(NOLOCK)
	GROUP BY [EDV].[CourseId]
			,  [EDV].[CourseName]
)

GO

--*******************************************************************
--GETCOURSEWITHTOTALSTUDENTSBYID FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description:	Get a course with the total
--				of students by course id
-- =============================================

CREATE FUNCTION [Integration].[GetCourseWithTotalStudentsById](@CourseId INT)
RETURNS TABLE
AS
RETURN 
(
	SELECT	*
	FROM	[Integration].[GetCoursesWithTotalStudents]()
	WHERE	[CourseId] = @CourseId
)
GO

--*******************************************************************
--GETCOURSEWITHTOTALSTUDENTSBYID FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-30
-- Description:	Get the course filtering by 
--				date, time, document number and 
--				space 
-- =============================================
CREATE FUNCTION [Integration].GetPersonActivities(@Date DATE, @Time TIME, @DocumentNumber INT, @SpaceId INT)

RETURNS TABLE 
AS
RETURN 
(
	SELECT	[CourseId] 
		, [CourseName]
		, [DocumentNumber]
		, [FullName]
		, [RoleId]
		, [RoleAlias]
		, [SpaceId]
		, [SpaceName]
		, [StartTime]
		, [EndTime]
	FROM	[Integration].[PersonActivitiesView] [PER] WITH(NOLOCK)
	WHERE	[PER].[DayOfTheWeek]			= DATEPART(WEEKDAY, @Date) AND 
			[PER].[DocumentNumber]			= @DocumentNumber AND
			[PER].[SpaceId]					= @SpaceId AND
			@Time BETWEEN [StartTime] AND [EndTime] 
)
GO

--*******************************************************************
--GETATTENDANCESUMMARY FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-31
-- Description:	Get the attendance summary
-- =============================================
CREATE FUNCTION [Attendance].GetAttendanceSummary(@Date DATE, @RoleId INT)

RETURNS TABLE 
AS
RETURN 
(
	SELECT	'Attendance'				AS [Alias]
		, 'Asistentes'					AS [Description]
		, COUNT([ARV].[DocumentNumber]) AS [Total]  
	FROM	[Attendance].[AttendanceRegisterView] [ARV] WITH(NOLOCK)
	WHERE	[ARV].[MovementDate]	= @Date AND
			[ARV].[RoleId]			= @RoleId
	UNION 
	SELECT	'NonAttendance'				AS [Alias]
		, 'Inasistentes'				AS [Description]
		, COUNT([NRV].[DocumentNumber]) AS [Total]  
	FROM	[NonAttendance].[NonAttendanceRegisterView] [NRV] WITH(NOLOCK)
	WHERE	[NRV].[DayOfTheWeek]	= DATEPART(WEEKDAY, @Date)  AND
			[NRV].[RoleId]			= @RoleId
	UNION 
	SELECT  'Total'							AS [Alias]
			, 'Total'						AS [Description]
			, COUNT([PAV].[DocumentNumber]) AS [Total]
	FROM	[Integration].[PersonActivitiesView] [PAV] WITH(NOLOCK)
	WHERE	[PAV].[DayOfTheWeek]	= DATEPART(WEEKDAY, @Date)  AND
			[PAV].[RoleId]			= @RoleId
)
GO

--*******************************************************************
--GETCURRENTTEACHERATTENDANCESUMMARY FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-31
-- Description:	Get the teachers attendance 
--				summary
-- =============================================
CREATE FUNCTION [Attendance].GetCurrentTeacherAttendanceSummary()

RETURNS TABLE 
AS
RETURN 
(
	SELECT	*
	FROM [Attendance].GetAttendanceSummary(CONVERT(DATE, GETDATE()), 3)
)
GO

--*******************************************************************
--GETCURRENTSTUDENTATTENDANCESUMMARY FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-31
-- Description:	Get the student attendance 
--				summary
-- =============================================
CREATE FUNCTION [Attendance].GetCurrentStudentAttendanceSummary()

RETURNS TABLE 
AS
RETURN 
(
	SELECT	*
	FROM [Attendance].GetAttendanceSummary(CONVERT(DATE, GETDATE()), 4)
)
GO

--*******************************************************************
--GETCURRENTTEACHERATTENDANCE FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-31
-- Description:	Get the current teacher attendance 
-- =============================================
CREATE FUNCTION [Attendance].GetCurrentTeacherAttendance()

RETURNS TABLE 
AS
RETURN 
(
	SELECT	*
	FROM	[Attendance].[AttendanceRegisterView] [ARV] WITH(NOLOCK)
	WHERE	[ARV].[DayOfTheWeek]	= [Integration].[GetCurrentDay]() AND
			CONVERT(TIME, GETDATE())	BETWEEN [ARV].[StartTime] AND [ARV].[EndTime] AND
			[ARV].[RoleId]			= 3
)
GO

--*******************************************************************
--SECURITY SCHEMA
--*******************************************************************
--*******************************************************************
--DIRECTOREXIST FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description:	Validate if the director exist
--              in the User table
-- =============================================
CREATE FUNCTION [Security].[DirectorExist]()
	
RETURNS BIT
AS
BEGIN
	DECLARE @Count INT;
	
	SELECT	@Count = COUNT( 1 )
	FROM	[Security].[User] WITH(NOLOCK)
	WHERE	[IdRole] = 2

	IF(@Count > 0)
	BEGIN
		RETURN  1;
	END
	
	RETURN  0;
END

GO
--*******************************************************************
--NONATTENDANCE SCHEMA
--*******************************************************************
--*******************************************************************
--EXCUSEAPPROVALEXIST FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-17
-- Description:	Validate if the excuse exist
--              in the ExcuseApproval table
-- =============================================
CREATE FUNCTION [NonAttendance].[ExcuseApprovalExist](@ExcuseId INT, @RoleId INT, @StatusId INT)
	
RETURNS BIT
AS
BEGIN
	DECLARE @Count INT;
	
	SELECT	@Count = COUNT( 1 )
	FROM	[NonAttendance].[ExcuseApproval] WITH(NOLOCK)
	WHERE	[IdExcuse]	= @ExcuseId AND
			[IdRole]	= @RoleId	AND
			[IdStatus]	= @StatusId

	IF(@Count > 0)
	BEGIN
		RETURN  1;
	END
	
	RETURN  0;
END

GO
--*******************************************************************
--TEACHEREXCUSEAPPROVALEXIST FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-20
-- Description:	Validate if the teacher approval
--              exist in the ExcuseApproval table
-- =============================================
CREATE FUNCTION [NonAttendance].[TeacherExcuseApprovalExist](@ExcuseId INT)
	
RETURNS BIT
AS
BEGIN
	RETURN  [NonAttendance].[ExcuseApprovalExist](@ExcuseId, 3, 2);
END

GO

--*******************************************************************
--GETMINIDSTATUS FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get the min id status
-- =============================================
CREATE FUNCTION [NonAttendance].[GetMinIdStatus]()
	
RETURNS INT 
AS
BEGIN 
	RETURN( SELECT MIN(Id) FROM [NonAttendance].[Status] )
END
GO

--*******************************************************************
--GETMAXIDSTATUS FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get the max id status
-- =============================================
CREATE FUNCTION [NonAttendance].[GetMaxIdStatus]()
	
RETURNS INT 
AS
BEGIN 
	RETURN( SELECT MAX(Id) FROM [NonAttendance].[Status] )
END
GO

--*******************************************************************

--*******************************************************************
--GETRANDOMSTATUS FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get a random status
-- =============================================
CREATE FUNCTION [NonAttendance].[GetRandomStatus](@RandomValue NUMERIC(18,10))
	
RETURNS TABLE 
AS
RETURN 
(

	SELECT	*
	FROM	[NonAttendance].[Status] [STA]  WITH(NOLOCK)
	WHERE	[STA].[Id] =  [Utilities].[Random]( 
		[NonAttendance].[GetMinIdStatus](),
		[NonAttendance].[GetMaxIdStatus](),
		@RandomValue
	 )
)
GO

--*******************************************************************
--GETMINIDCLASSIFICATION FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get the min id classification
-- =============================================
CREATE FUNCTION [NonAttendance].[GetMinIdClassification]()
	
RETURNS INT 
AS
BEGIN 
	RETURN( SELECT MIN(Id) FROM [NonAttendance].[Classification] WITH(NOLOCK) )
END
GO

--*******************************************************************
--GETMAXIDCLASSIFICATION FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get the max id classification
-- =============================================
CREATE FUNCTION [NonAttendance].[GetMaxIdClassification]()
	
RETURNS INT 
AS
BEGIN 
	RETURN( SELECT MAX(Id) FROM [NonAttendance].[Classification] WITH(NOLOCK) )
END
GO

--*******************************************************************

--*******************************************************************
--GETRANDOMCLASSIFICATION FUNCTION
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get a random classification
-- =============================================
CREATE FUNCTION [NonAttendance].[GetRandomClassification](@RandomValue NUMERIC(18,10))
	
RETURNS TABLE 
AS
RETURN 
(
	SELECT	*
	FROM	[NonAttendance].[Classification] [CLA] WITH(NOLOCK)
	WHERE	[CLA].[Id] =  [Utilities].[Random]( 
		[NonAttendance].[GetMinIdClassification](),
		[NonAttendance].[GetMaxIdClassification](),
		@RandomValue
	 )
)
GO
--*******************************************************************