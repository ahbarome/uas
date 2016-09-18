--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description: Data definition for store procedures
--*******************************************************************
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
--*******************************************************************
--ATTENDANCE SCHEMA
--*******************************************************************
--GETALLSTUDENTMOVEMENTSBYTEACHERDOCUMENTNUMBER STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-24
-- Description:	Get all student movements by 
--				teacher document number
-- =============================================
CREATE PROCEDURE [Attendance].[GetAllStudentMovementsByTeacherDocumentNumber] 
	@TeacherDocumentNumber INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--==================================================
	--Filters
	DECLARE @CurrentDocumentNumberOfTheMovement INT = 0,
			@CurrentDateOfTheMovement			DATE,
			@CurrentTimeOfTheMovement			TIME,
			@CurrentSemester					INT = 0,
			@CurrentDayOfTheWeek				INT = 0,
			@CourseId							INT = 0,
			@CourseStartTime					TIME,
			@CourseEndTime						TIME
	--==================================================
	DECLARE @StudentMovements TABLE (
		StudentDocumentNumber		INT,
		StudentCode					INT,
		StudentFullName				NVARCHAR(MAX),
		StudentEmail				NVARCHAR(MAX),
		StudentTelephoneNumber		INT,
		StudentAddress				NVARCHAR(MAX),
		StudentImageRelativePath	NVARCHAR(MAX),
		CareerName					NVARCHAR(MAX),
		CourseName					NVARCHAR(MAX),
		EnrollmentStatus			NVARCHAR(MAX));
	--==================================================

	SET @CurrentSemester		= [Integration].GetCurrentSemester()
	SET @CurrentDayOfTheWeek	= [Integration].[GetCurrentDay]()

	--==================================================
	
	SELECT  TOP 1 @CourseStartTime		= [CCT].[StartTime]
				, @CourseEndTime		= [CCT].[EndTime]
				, @CourseId				= [CCT].[CourseId] 
	FROM	 [Integration].GetCurrentCoursesByTeacherDocumentNumber( @TeacherDocumentNumber ) [CCT]

	--==================================================
	--Get the movements of the current day
	DECLARE MovementsCursor CURSOR FOR
		SELECT * FROM [Attendance].GetTodayMovements()
	
	OPEN MovementsCursor;
	
	FETCH NEXT FROM MovementsCursor   
	INTO @CurrentDocumentNumberOfTheMovement

	WHILE @@FETCH_STATUS = 0  
	BEGIN
		
		INSERT INTO @StudentMovements (
			StudentDocumentNumber, 
			StudentCode, 
			StudentFullName,
			StudentEmail,
			StudentTelephoneNumber,
			StudentAddress,
			StudentImageRelativePath,
			CareerName,
			CourseName,
			EnrollmentStatus) 
		SELECT	[StudentDocumentNumber], 
				[StudentCode], 
				[StudentFullName],
				[StudentEmail],
				[StudentTelephoneNumber],
				[StudentAddress],
				[StudentImageRelativePath],
				[CareerName],
				[CourseName],
				[EnrollmentStatus]
		FROM	[Integration].GetEnrollmentStudents(@CourseId, @CourseStartTime, @CourseEndTime, @CurrentDocumentNumberOfTheMovement );   
		
		FETCH NEXT FROM MovementsCursor INTO @CurrentDocumentNumberOfTheMovement
	END

	CLOSE MovementsCursor;  
	DEALLOCATE MovementsCursor;  

	SELECT	[StudentDocumentNumber]
			, [StudentCode]
			, [StudentFullName]
			, [StudentEmail]
			, [StudentTelephoneNumber]
			, [StudentAddress]
			, [StudentImageRelativePath]
			, [CareerName]
			, [CourseName]
			, [EnrollmentStatus]
			, @CurrentDateOfTheMovement AS MovementDate
			, @CurrentTimeOfTheMovement AS MovementTime
	FROM	@StudentMovements;
	--==================================================

END

GO

--*******************************************************************
--GETALLSTUDENTMOVEMENTSBYTEACHERDOCUMENTNUMBERANDCOURSEID STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-24
-- Description:	Get all student movements by 
--				teacher document number and 
--				course id
-- =============================================
CREATE PROCEDURE [Attendance].[GetAllStudentMovementsByTeacherDocumentNumberAndCourseId] 
	@TeacherDocumentNumber	INT,
	@CourseId				INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--==================================================
	--Filters
	DECLARE @CurrentDocumentNumberOfTheMovement INT = 0,
			@CurrentSemester					INT = 0,
			@CurrentDayOfTheWeek				INT = 0,
			@CourseStartTime					TIME,
			@CourseEndTime						TIME
	--==================================================
	DECLARE @StudentMovements TABLE (
		StudentDocumentNumber		INT,
		StudentCode					INT,
		StudentFullName				NVARCHAR(MAX),
		StudentEmail				NVARCHAR(MAX),
		StudentTelephoneNumber		INT,
		StudentAddress				NVARCHAR(MAX),
		StudentImageRelativePath	NVARCHAR(MAX),
		CareerName					NVARCHAR(MAX),
		CourseName					NVARCHAR(MAX),
		EnrollmentStatus			NVARCHAR(MAX));
	--==================================================

	SET @CurrentSemester		= [Integration].GetCurrentSemester()
	SET @CurrentDayOfTheWeek	= [Integration].[GetCurrentDay]()

	--==================================================
	
	SELECT  TOP 1 @CourseStartTime		= [CCT].[StartTime]
				, @CourseEndTime		= [CCT].[EndTime]
				, @CourseId				= [CCT].[CourseId] 
	FROM	 [Integration].GetCurrentCoursesByTeacherDocumentNumber( @TeacherDocumentNumber ) [CCT]

	--==================================================
	--Get the movements of the current day
	DECLARE MovementsCursor CURSOR FOR
		SELECT * FROM [Attendance].GetTodayMovements()
	
	OPEN MovementsCursor;
	
	FETCH NEXT FROM MovementsCursor   
	INTO @CurrentDocumentNumberOfTheMovement

	WHILE @@FETCH_STATUS = 0  
	BEGIN
		
		INSERT INTO @StudentMovements (
			StudentDocumentNumber, 
			StudentCode, 
			StudentFullName,
			StudentEmail,
			StudentTelephoneNumber,
			StudentAddress,
			StudentImageRelativePath,
			CareerName,
			CourseName,
			EnrollmentStatus) 
		SELECT	[StudentDocumentNumber], 
				[StudentCode], 
				[StudentFullName],
				[StudentEmail],
				[StudentTelephoneNumber],
				[StudentAddress],
				[StudentImageRelativePath],
				[CareerName],
				[CourseName],
				[EnrollmentStatus]
		FROM	[Integration].GetEnrollmentStudents(@CourseId, @CourseStartTime, @CourseEndTime, @CurrentDocumentNumberOfTheMovement);
		
		FETCH NEXT FROM MovementsCursor INTO @CurrentDocumentNumberOfTheMovement
	END

	CLOSE MovementsCursor;  
	DEALLOCATE MovementsCursor;  

	SELECT	[StudentDocumentNumber]
			, [StudentCode]
			, [StudentFullName]
			, [StudentEmail]
			, [StudentTelephoneNumber]
			, [StudentAddress]
			, [StudentImageRelativePath]
			, [CareerName]
			, [CourseName]
			, [EnrollmentStatus]
	FROM	@StudentMovements;
	--==================================================

END

GO

--*******************************************************************
--GENERATEATTENDANCEDATA STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Generate all the data for the 
--				attendance
-- =============================================
CREATE PROCEDURE [Attendance].[GenerateAttendanceData]
AS
	BEGIN
	DECLARE @RandomOption			INT,
			@DocumentNumber			INT,
			@RoleId					INT,
			@StartSemesterDate		DATETIME;

	DECLARE PersonsCursor CURSOR FOR(
		SELECT DISTINCT StudentDocumentNumber	AS DocumentNumber
				, 4								AS RoleId
		FROM [Integration].[EnrollmentDetailView] WITH(NOLOCK)
		UNION 
		SELECT	DISTINCT TeacherDocumentNumber	AS DocumentNumber
				, 3								AS RoleId
		FROM [Integration].[EnrollmentDetailView] WITH(NOLOCK));

	OPEN PersonsCursor;
	
	FETCH NEXT FROM PersonsCursor   
	INTO @DocumentNumber, @RoleId


	WHILE @@FETCH_STATUS = 0  
	BEGIN

		SELECT	@StartSemesterDate = StartDate
		FROM	[Integration].[AcademicPeriod] WITH(NOLOCK)
		WHERE	Semester = [Integration].[GetCurrentSemester]()

		SET @RandomOption		= CONVERT(INT, RAND() * 10);

		PRINT ''
		PRINT CONCAT('********* BEGIN: DOCUMENT NUMBER',@DocumentNumber, ' ROLE ID', @RoleId, ' *********' )
		PRINT CONCAT('=== EVALUATING DATE ', @StartSemesterDate,'===')

		WHILE (@StartSemesterDate < GETDATE() - 1)
		BEGIN
		
			DECLARE @SpaceId				INT,
					@StartTime				TIME;

			IF( @RoleId = 4 )
	
			BEGIN
				PRINT '===STUDENTS ROLE (4)=='
				SELECT	@SpaceId		= SpaceId
						, @StartTime	= StartTime
				FROM	[Integration].[EnrollmentDetailView] WITH(NOLOCK)
				WHERE	StudentDocumentNumber	= @DocumentNumber AND
						DayOfTheWeek			= DATEPART(WEEKDAY, @StartSemesterDate)
			END

			ELSE
			BEGIN
				PRINT '===TEACHERS ROLE (3)=='
				SELECT	@SpaceId		= SpaceId
						, @StartTime	= StartTime
				FROM	[Integration].[EnrollmentDetailView] WITH(NOLOCK)
				WHERE	TeacherDocumentNumber	= @DocumentNumber AND
						DayOfTheWeek			= DATEPART(WEEKDAY, @StartSemesterDate)
			END 

		
			PRINT CONCAT('===EVALUATING ', @DocumentNumber, ' IN THE SPACE ', @SpaceId, ' FOR THE TIME ', @StartTime, ' AND WITH OPTION ', @RandomOption ) 
			IF( (@RandomOption % 2) != 0 AND @SpaceId != 0)
	
			BEGIN
				DECLARE @RandomMinutes	INT,
						@RegisterDate	DATETIME = @StartSemesterDate;

				SET @RandomMinutes		= CONVERT(INT, RAND() * 100);
			
				SET @RegisterDate		= DATEADD(HOUR, DATEPART(HOUR, @StartTime), @RegisterDate);
				SET @RegisterDate		= DATEADD(MINUTE, DATEPART(MINUTE, @StartTime) + @RandomMinutes, @RegisterDate) ;

				PRINT CONCAT( '===ATTENDANCE DATE ', @RegisterDate) 
				INSERT INTO [Attendance].[Movement](IdSpace, DocumentNumber, RegisterDate)
				SELECT	@SpaceId
						, @DocumentNumber
						, @RegisterDate
	
			END
			
			SET @StartSemesterDate = DATEADD(DD, 1, @StartSemesterDate);
		END
		PRINT CONCAT('=== EVALUATING DATE ', @StartSemesterDate,'===')
		PRINT CONCAT('********* END: DOCUMENT NUMBER',@DocumentNumber, ' ROLE ID', @RoleId, ' *********' )
		PRINT ''
		
		FETCH NEXT FROM PersonsCursor INTO  @DocumentNumber, @RoleId
	END

	CLOSE PersonsCursor;  
	DEALLOCATE PersonsCursor;  

END

GO

--*******************************************************************
--INTEGRATION SCHEMA
--*******************************************************************
--GETCURRENTCOURSEBYTEACHERDOCUMENTNUMBER STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-26
-- Description:	Get the current course
-- 
-- =============================================
CREATE PROCEDURE [Integration].[GetCurrentCourseByTeacherDocumentNumber]
	@TeacherDocumentNumber INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT	* 
	FROM	[Integration].[ScheduleDetailView] [SDV] WITH(NOLOCK)
	WHERE	( [SDV].[EndDate] >= GETDATE() AND [SDV].[StartDate] <=  GETDATE() ) AND-- Course of the semester
			[SDV].[DayOfTheWeek] = [Integration].[GetCurrentDay]()	AND -- Course for today
			( [SDV].[EndTime] >= CONVERT(TIME, GETDATE()) AND  [SDV].[StartTime] <=  CONVERT(TIME, GETDATE())) AND-- Current course
			[SDV].[TeacherDocumentNumber] = @TeacherDocumentNumber 
	ORDER BY [SDV].[StartTime] DESC
END

GO

--*******************************************************************
--GETCURRENTCOURSESUMMARYBYTEACHERDOCUMENTNUMBER STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-07-26
-- Description:	Get the current course summary
--				by teacher document number
-- =============================================
CREATE PROCEDURE [Integration].[GetCurrentCourseSummaryByTeacherDocumentNumber]
	@TeacherDocumentNumber	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--==================================================
	--Filters
	DECLARE @CurrentDocumentNumberOfTheMovement INT = 0,
			@CurrentSemester					INT = 0,
			@CurrentDayOfTheWeek				INT = 0,
			@CourseId							INT = 0,
			@CourseStartTime					TIME,
			@CourseEndTime						TIME
	--==================================================
	DECLARE @CourseAttendance					INT
	--==================================================
	DECLARE @CourseMovements TABLE (
		StudentDocumentNumber		INT,
		StudentCode					INT,
		StudentFullName				NVARCHAR(MAX),
		StudentEmail				NVARCHAR(MAX),
		StudentTelephoneNumber		INT,
		StudentAddress				NVARCHAR(MAX),
		StudentImageRelativePath	NVARCHAR(MAX),
		CareerName					NVARCHAR(MAX),
		CourseName					NVARCHAR(MAX),
		EnrollmentStatus			NVARCHAR(MAX));
	--==================================================
	
	SELECT  TOP 1 @CourseStartTime		= [CCT].[StartTime]
				, @CourseEndTime		= [CCT].[EndTime]
				, @CourseId				= [CCT].[CourseId] 
	FROM	 [Integration].GetCurrentCoursesByTeacherDocumentNumber( @TeacherDocumentNumber ) [CCT]

	--==================================================

	SET @CurrentSemester		= [Integration].GetCurrentSemester()
	SET @CurrentDayOfTheWeek	= [Integration].[GetCurrentDay]()
	SET @CourseAttendance		= ( SELECT	[Total]
									FROM	[Integration].[GetCourseWithTotalStudentsById](@CourseId) )

	--==================================================
	
	SELECT  TOP 1 @CourseStartTime		= [CCT].[StartTime]
				, @CourseEndTime		= [CCT].[EndTime]
				, @CourseId				= [CCT].[CourseId] 
	FROM	 [Integration].GetCurrentCoursesByTeacherDocumentNumber( @TeacherDocumentNumber ) [CCT]

	--==================================================
	--Get the movements of the current day
	DECLARE MovementsCursor CURSOR FOR
		SELECT * FROM [Attendance].GetTodayMovements()
	
	OPEN MovementsCursor;
	
	FETCH NEXT FROM MovementsCursor   
	INTO @CurrentDocumentNumberOfTheMovement

	WHILE @@FETCH_STATUS = 0  
	BEGIN
		
		INSERT INTO @CourseMovements (
			StudentDocumentNumber, 
			StudentCode, 
			StudentFullName,
			StudentEmail,
			StudentTelephoneNumber,
			StudentAddress,
			StudentImageRelativePath,
			CareerName,
			CourseName,
			EnrollmentStatus) 
		SELECT	[StudentDocumentNumber], 
				[StudentCode], 
				[StudentFullName],
				[StudentEmail],
				[StudentTelephoneNumber],
				[StudentAddress],
				[StudentImageRelativePath],
				[CareerName],
				[CourseName],
				[EnrollmentStatus]
		FROM	[Integration].GetEnrollmentStudents(@CourseId, @CourseStartTime, @CourseEndTime, @CurrentDocumentNumberOfTheMovement);
		
		FETCH NEXT FROM MovementsCursor INTO @CurrentDocumentNumberOfTheMovement
	END

	CLOSE MovementsCursor;  
	DEALLOCATE MovementsCursor;  

	DECLARE @TotalMovements INT = 0;

	SELECT @TotalMovements = COUNT(1) FROM @CourseMovements;

	IF( @TotalMovements > 1 )
	BEGIN
		SELECT	@CourseId			AS CourseId
				, [CourseName]
				, 'Asistentes'		AS EnrollmentStatus
				, COUNT(1)			AS Total
		FROM	@CourseMovements 
		GROUP BY [CourseName]	
		UNION 
		SELECT @CourseId															AS CourseId
				, ( SELECT	TOP 1 CourseName FROM @CourseMovements )				AS CourseName
				, 'Inasistentes'													AS EnrollmentStatus
				, ABS(ISNULL(( SELECT	COUNT(1)			
					FROM	@CourseMovements 
					GROUP BY [CourseName]	 ), 0)	- ISNULL(@CourseAttendance, 0))	AS Total
	END
	ELSE
	BEGIN
		SELECT	-1							AS CourseId
				, 'Sin curso programado'	AS CourseName
				, 'Asistentes'				AS EnrollmentStatus
				, 0							AS Total
		UNION 
		SELECT -1							AS CourseId
				, 'Sin curso programado'	AS CourseName
				, 'Inasistentes'			AS EnrollmentStatus
				, 0							AS Total
	END
	--==================================================

END

GO

--*******************************************************************
--POPULATELASTNONATTENDANCE STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-02
-- Description:	Populate the NonAttendance
-- =============================================
CREATE PROCEDURE [NonAttendance].[PopulateLastNonAttendance]

AS
BEGIN

	DECLARE @LastDate DATE;

	SET		@LastDate = CONVERT(DATE, GETDATE() - 1);

	SET NOCOUNT ON;
	
	
	INSERT INTO [NonAttendance].[NonAttendance] ([DocumentNumber], [IdRole], [IdCourse], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime], [NonAttendanceDate], [HasExcuse])
	SELECT	[PAV].[DocumentNumber]
			, [PAV].[RoleId]
			, [PAV].[CourseId] 
			, [PAV].[SpaceId] 
			, [PAV].[DayOfTheWeek]
			, [PAV].[StartTime]
			, [PAV].[EndTime]
			, @LastDate				AS NonAttendanceDate
			, 0						AS HasExcuse
	FROM	[Integration].[PersonActivitiesView]			[PAV] WITH(NOLOCK)
	LEFT OUTER JOIN [Attendance].[AttendanceRegisterView]	[CMV] WITH(NOLOCK) ON 
		[CMV].[DocumentNumber]	= [PAV].[DocumentNumber]	AND
		[CMV].[CourseId]		= [PAV].[CourseId]			AND
		[CMV].[RoleId]			= [PAV].[RoleId]			AND
		[CMV].[SpaceId]			= [PAV].[SpaceId]			AND
		[CMV].[DayOfTheWeek]	= [PAV].[DayOfTheWeek] 
	WHERE	[PAV].[DayOfTheWeek] = DATEPART(WEEKDAY, @LastDate) AND
			[CMV].[DocumentNumber] IS NULL


END

GO

--*******************************************************************
--POPULATENONATTENDANCE STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-02
-- Description:	Populate the NonAttendance
-- =============================================
CREATE PROCEDURE [NonAttendance].[PopulateNonAttendance] 
	@Date DATE

AS
BEGIN

	SET NOCOUNT ON;
	
	INSERT INTO [NonAttendance].[NonAttendance] ([DocumentNumber], [IdRole], [IdCourse], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime], [NonAttendanceDate], [HasExcuse])
	SELECT	[PAV].[DocumentNumber]
			, [PAV].[RoleId]
			, [PAV].[CourseId] 
			, [PAV].[SpaceId] 
			, [PAV].[DayOfTheWeek]
			, [PAV].[StartTime]
			, [PAV].[EndTime]
			, @Date					AS NonAttendanceDate
			, 0						AS HasExcuse
	FROM	[Integration].[PersonActivitiesView]			[PAV] WITH(NOLOCK)
	LEFT OUTER JOIN [Attendance].[AttendanceRegisterView]	[CMV] WITH(NOLOCK) ON 
		[CMV].[DocumentNumber]	= [PAV].[DocumentNumber]	AND
		[CMV].[CourseId]		= [PAV].[CourseId]			AND
		[CMV].[RoleId]			= [PAV].[RoleId]			AND
		[CMV].[SpaceId]			= [PAV].[SpaceId]			AND
		[CMV].[DayOfTheWeek]	= [PAV].[DayOfTheWeek] 
	WHERE	[PAV].[DayOfTheWeek] = DATEPART(WEEKDAY, @Date) AND
			[CMV].[DocumentNumber] IS NULL


END

GO

--*******************************************************************
--GENERATEAPPROVERSREGISTER STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-15
-- Description:	Generate the register for the
--				approvers excuse
-- =============================================
CREATE PROCEDURE [NonAttendance].[GenerateApproversRegister]
	@NonAttendanceId	INT,
	@ExcuseId			INT
AS
BEGIN

	DECLARE @SQLQuery							NVARCHAR(500),
			@NonAttendanceDocumentNumber		INT,
			@NonAttendanceRoleId				INT,
			@NonAttendanceCourseId				INT,
			@NonAttendanceSpaceId				INT,
			@NonAttendanceDayOfTheWeek			INT,
			@DirectorRoleId						INT,
			@TeacherRoleId						INT,
			@StudentRoleId						INT;

	SET NOCOUNT ON;
	
	SET @DirectorRoleId = 2;
	SET @TeacherRoleId	= 3;
	SET @StudentRoleId	= 4;

	SELECT	TOP 1 @NonAttendanceDocumentNumber	= [DocumentNumber]
			, @NonAttendanceRoleId				= [IdRole] 
			, @NonAttendanceCourseId			= [IdCourse]
			, @NonAttendanceSpaceId				= [IdSpace]
			, @NonAttendanceDayOfTheWeek		= [DayOfTheWeek]
	FROM	[NonAttendance].[NonAttendance] WITH(NOLOCK)
	WHERE	[Id] = @NonAttendanceId 

	
	IF([NonAttendance].[TeacherExcuseApprovalExist](@ExcuseId) = 1  AND [Security].[DirectorExist]() = 1 )
	BEGIN
		INSERT INTO [NonAttendance].[ExcuseApproval] ([IdExcuse], [IdStatus], [Approver], [IdRole])
		SELECT  @ExcuseId
				, 1
				, [DocumentNumber]
				, [IdRole] 
		FROM	[Security].[User] WITH(NOLOCK)
		WHERE	[IdRole] = @DirectorRoleId
	END
	--INSERT A DIRECTOR FOR THE APPROVAL
	ELSE 
	BEGIN
		IF(@NonAttendanceRoleId = @TeacherRoleId  AND [Security].[DirectorExist]() = 1 )
		BEGIN
			INSERT INTO [NonAttendance].[ExcuseApproval] ([IdExcuse], [IdStatus], [Approver], [IdRole])
			SELECT  @ExcuseId
					, 1
					, [DocumentNumber]
					, [IdRole] 
			FROM	[Security].[User] WITH(NOLOCK)
			WHERE	[IdRole] = @DirectorRoleId
		END
		--VALIDATE IF THE NONATTENDANCE WAS OF ONE STUDENT
		ELSE
		BEGIN
			IF(@NonAttendanceRoleId = @StudentRoleId)
			BEGIN

				--INSERT A DIRECTOR FOR THE APPROVAL
				INSERT INTO [NonAttendance].[ExcuseApproval] ([IdExcuse], [IdStatus], [Approver], [IdRole])
				SELECT TOP 1 @ExcuseId
						, 1
						, [DocumentNumber]
						, [RoleId] 
				FROM	[Integration].[PersonActivitiesView] WITH(NOLOCK)
				WHERE	[CourseId]		= @NonAttendanceCourseId		AND
						[SpaceId]		= @NonAttendanceSpaceId			AND
						[DayOfTheWeek]	= @NonAttendanceDayOfTheWeek	AND
						[RoleId]		= @TeacherRoleId 
			END
		END
	END

END

GO

--*******************************************************************
--GENERATENONATTENDANCEDATA STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Generate all the data for the 
--				nonattendance
-- =============================================
CREATE PROCEDURE [NonAttendance].[GenerateNonAttendanceData]
AS
	BEGIN
	DECLARE @StartSemesterDate		DATETIME;

	SELECT	@StartSemesterDate = StartDate
		FROM	[Integration].[AcademicPeriod] WITH(NOLOCK)
		WHERE	Semester = [Integration].[GetCurrentSemester]()

	WHILE (@StartSemesterDate < GETDATE() - 1)
	BEGIN
		EXECUTE [NonAttendance].[PopulateNonAttendance] @StartSemesterDate

	SET @StartSemesterDate = DATEADD(DD, 1, @StartSemesterDate);
	END

END

GO

--*******************************************************************
--GENERATEEXCUSEDATA STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Generate all the data for the 
--				excuses
-- =============================================
CREATE PROCEDURE [NonAttendance].[GenerateExcuseData]
AS
	BEGIN

	DECLARE @RandomOption			INT,
			@IdNonAttendance		INT,
			@DocumentNumber			INT,
			@RoleId					INT,
			@IdStatus				INT = 1,
			@IdClassification		INT = 1;


	DECLARE ExcuseCursor CURSOR FOR(
	SELECT  Id
			, DocumentNumber
			, RoleId
	FROM [NonAttendance].[NonAttendanceView] );

	OPEN ExcuseCursor;
	
	FETCH NEXT FROM ExcuseCursor   
	INTO @IdNonAttendance, @DocumentNumber, @RoleId

	WHILE @@FETCH_STATUS = 0  
	BEGIN
		SET @RandomOption		= CONVERT(INT, RAND() * 10);

		IF( (@RandomOption % 2) = 0  )
		BEGIN
		
		SET @IdStatus			=	ISNULL(( SELECT TOP 1 Id 
									  FROM	[NonAttendance].[GetRandomStatus](RAND()) ), 1 );

		SET @IdClassification	=	ISNULL(( SELECT TOP 1 Id 
									  FROM	[NonAttendance].[GetRandomClassification](RAND()) ), 1);

		INSERT INTO [NonAttendance].[Excuse](IdNonAttendance, DocumentNumber, IdRole, IdStatus, IdClassification)
		SELECT @IdNonAttendance
			, @DocumentNumber
			, @RoleId
			, @IdStatus			
			, @IdClassification 
		END

		FETCH NEXT FROM ExcuseCursor INTO  @IdNonAttendance, @DocumentNumber, @RoleId
	END

	CLOSE ExcuseCursor;  
	DEALLOCATE ExcuseCursor; 

END

GO

--*******************************************************************
--GETGENERALSTATISTICSATTENDANCE STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-22
-- Description:	Get the statistics of the 
--              attendance and the nonattendance
-- =============================================
CREATE PROCEDURE [Dashboard].[GetStatistictsAttendanceVsNonAttendance] 
	@DocumentNumber INT = NULL
	, @RoleId		INT = NULL
AS
BEGIN

	DECLARE	@SemesterStartDate	DATETIME,
			@SemesterEndDate	DATETIME;
	
	DECLARE @GeneralStatistictsAttendance TABLE (
		EventType			NVARCHAR(15),
		EventTypeAlias		NVARCHAR(10),
		EventDate			DATETIME,
		EventDateMonth		INT,
		EventDateMonthName	NVARCHAR(10),
		EventTotal			INT);

	DECLARE @AttendanceType		NVARCHAR(15),
			@AttendanceAlias	NVARCHAR(15),
			@NonAttendanceType	NVARCHAR(15),
			@NonAttendanceAlias	NVARCHAR(15);

	SET @AttendanceType			= 'Attendance';
	SET @AttendanceAlias		= 'Asistencia';
	SET @NonAttendanceType		= 'NonAttendance';
	SET @NonAttendanceAlias		= 'Ausentismo';

	SELECT	@SemesterStartDate = [StartDate]
			, @SemesterEndDate = [EndDate]
	FROM	[Integration].[AcademicPeriod]
	WHERE	[Semester] = [Integration].[GetCurrentSemester]()

	WHILE (@SemesterStartDate < @SemesterEndDate)
	BEGIN
		
		IF(ISNULL(@DocumentNumber, 0) > 0 AND  ISNULL(@RoleId, 0) > 0)
		BEGIN
			IF(@RoleId = 3) --Is a Teacher
			BEGIN
				INSERT INTO @GeneralStatistictsAttendance 
				SELECT  @AttendanceType							AS EventType
						, @AttendanceAlias						AS EventTypeAlias
						, @SemesterStartDate					AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, COUNT (1)				AS EventTotal
				FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
				WHERE	[ATV].[MovementDate]	= CONVERT(DATE, @SemesterStartDate) AND
						[ATV].[RoleId]			= 4									AND
						[ATV].[CourseId]		IN (
													SELECT	CourseId 
													FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
				UNION
				SELECT  @NonAttendanceType						AS EventType
						, @NonAttendanceAlias					AS EventTypeAlias
						, @SemesterStartDate	AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, COUNT (1)								AS EventTotal
				FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
				WHERE	[NAV].[NonAttendanceDate]	= CONVERT(DATE, @SemesterStartDate)	AND
						[NAV].[RoleId]				= 4									AND-- Students	
						[NAV].[CourseId]		IN (
													SELECT	CourseId 
													FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
			END
			ELSE -- Is a student
			BEGIN
				INSERT INTO @GeneralStatistictsAttendance 
				SELECT  @AttendanceType							AS EventType
						, @AttendanceAlias						AS EventTypeAlias
						, @SemesterStartDate					AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, COUNT (1)				AS EventTotal
				FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
				WHERE	[ATV].[MovementDate]	= CONVERT(DATE, @SemesterStartDate) AND
						[ATV].[DocumentNumber]	= @DocumentNumber					AND
						[ATV].[RoleId]			= @RoleId 
				UNION
				SELECT  @NonAttendanceType						AS EventType
						, @NonAttendanceAlias					AS EventTypeAlias
						, @SemesterStartDate	AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, COUNT (1)								AS EventTotal
				FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
				WHERE	[NAV].[NonAttendanceDate] = CONVERT(DATE, @SemesterStartDate)	AND
						[NAV].[DocumentNumber]	= @DocumentNumber						AND
						[NAV].[RoleId]			= @RoleId 
			END
		END
		ELSE -- Is an Administrator or Director
		BEGIN
			INSERT INTO @GeneralStatistictsAttendance 
			SELECT  @AttendanceType							AS EventType
					, @AttendanceAlias						AS EventTypeAlias
					, @SemesterStartDate					AS EventDate
					, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
					, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
					, COUNT (1)				AS EventTotal
			FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
			WHERE	[ATV].[MovementDate] = CONVERT(DATE, @SemesterStartDate) 
			UNION
			SELECT  @NonAttendanceType						AS EventType
					, @NonAttendanceAlias					AS EventTypeAlias
					, @SemesterStartDate	AS EventDate
					, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
					, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
					, COUNT (1)								AS EventTotal
			FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
			WHERE	[NAV].[NonAttendanceDate] = CONVERT(DATE, @SemesterStartDate) 
		END
		
		SET @SemesterStartDate = DATEADD(DD, 1, @SemesterStartDate);
	END


	SELECT [GST].EventType
			, [GST].EventTypeAlias
			, [GST].EventDateMonth
			, [GST].EventDateMonthName
			, SUM([GST].EventTotal)	AS EventTotal
	FROM	@GeneralStatistictsAttendance [GST] 
	GROUP BY [GST].EventType
			, [GST].EventTypeAlias
			, [GST].EventDateMonth
			, [GST].EventDateMonthName
	ORDER BY  [GST].EventType
			, [GST].EventDateMonth


END

GO
--*******************************************************************
--GETTOPSTATISTICTSMAJORMONTHSATTENDANCEANDNONATTENDANCE STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-22
-- Description:	Get the statistics of the major
--				month in terms of attendance
--				and nonattendance
-- =============================================
CREATE PROCEDURE [Dashboard].[GetTopStatistictsMajorMonthsAttendanceAndNonAttendance] 
		@DocumentNumber INT = NULL
		, @RoleId		INT = NULL
AS
BEGIN

	DECLARE	@SemesterStartDate	DATETIME,
			@SemesterEndDate	DATETIME;
	
	DECLARE @GeneralStatistictsAttendance TABLE (
		EventType			NVARCHAR(15),
		EventTypeAlias		NVARCHAR(10),
		EventDate			DATETIME,
		EventDateMonth		INT,
		EventDateMonthName	NVARCHAR(10),
		EventTotal			INT);

	DECLARE @AttendanceType		NVARCHAR(15),
			@AttendanceAlias	NVARCHAR(15),
			@NonAttendanceType	NVARCHAR(15),
			@NonAttendanceAlias	NVARCHAR(15);

	SET @AttendanceType			= 'Attendance';
	SET @AttendanceAlias		= 'Asistencia';
	SET @NonAttendanceType		= 'NonAttendance';
	SET @NonAttendanceAlias		= 'Ausentismo';

	SELECT	@SemesterStartDate = [StartDate]
			, @SemesterEndDate = [EndDate]
	FROM	[Integration].[AcademicPeriod]
	WHERE	[Semester] = [Integration].[GetCurrentSemester]()

	WHILE (@SemesterStartDate < @SemesterEndDate)
	BEGIN
		IF(ISNULL(@DocumentNumber, 0) > 0 AND  ISNULL(@RoleId, 0) > 0)
		BEGIN
			IF(@RoleId = 3) --Is a Teacher
			BEGIN
				INSERT INTO @GeneralStatistictsAttendance 
				SELECT  @AttendanceType							AS EventType
						, @AttendanceAlias						AS EventTypeAlias
						, @SemesterStartDate					AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, COUNT (1)				AS EventTotal
				FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
				WHERE	[ATV].[MovementDate] = CONVERT(DATE, @SemesterStartDate) AND
						[ATV].[RoleId]			= 4								 AND
						[ATV].[CourseId]		IN (
													SELECT	CourseId 
													FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher

				UNION

				SELECT  @NonAttendanceType						AS EventType
						, @NonAttendanceAlias					AS EventTypeAlias
						, @SemesterStartDate					AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, COUNT (1)								AS EventTotal
				FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
				WHERE	[NAV].[NonAttendanceDate]	= CONVERT(DATE, @SemesterStartDate) AND
						[NAV].[RoleId]				= 4									AND
						[NAV].[CourseId]		IN (
													SELECT	CourseId 
													FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
			END
			ELSE
			BEGIN
				INSERT INTO @GeneralStatistictsAttendance 
				SELECT  @AttendanceType							AS EventType
						, @AttendanceAlias						AS EventTypeAlias
						, @SemesterStartDate					AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, COUNT (1)				AS EventTotal
				FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
				WHERE	[ATV].[MovementDate] = CONVERT(DATE, @SemesterStartDate)	AND
						[ATV].[DocumentNumber]	= @DocumentNumber					AND
						[ATV].[RoleId]			= @RoleId 

				UNION

				SELECT  @NonAttendanceType						AS EventType
						, @NonAttendanceAlias					AS EventTypeAlias
						, @SemesterStartDate					AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, COUNT (1)								AS EventTotal
				FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
				WHERE	[NAV].[NonAttendanceDate] = CONVERT(DATE, @SemesterStartDate)	AND
						[NAV].[DocumentNumber]	= @DocumentNumber						AND
						[NAV].[RoleId]			= @RoleId 
			END
		END
		ELSE
		BEGIN
			INSERT INTO @GeneralStatistictsAttendance 
			SELECT  @AttendanceType							AS EventType
					, @AttendanceAlias						AS EventTypeAlias
					, @SemesterStartDate					AS EventDate
					, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
					, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
					, COUNT (1)				AS EventTotal
			FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
			WHERE	[ATV].[MovementDate] = CONVERT(DATE, @SemesterStartDate) 

			UNION

			SELECT  @NonAttendanceType						AS EventType
					, @NonAttendanceAlias					AS EventTypeAlias
					, @SemesterStartDate					AS EventDate
					, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
					, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
					, COUNT (1)								AS EventTotal
			FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
			WHERE	[NAV].[NonAttendanceDate] = CONVERT(DATE, @SemesterStartDate) 
		END

		SET @SemesterStartDate = DATEADD(DD, 1, @SemesterStartDate);
	END


	SELECT	 DISTINCT TOP 2 EventType
			, EventDateMonthName
			, MAX( EventTotal ) AS EventTotal
	FROM (
	SELECT [GST].EventType
			, [GST].EventTypeAlias
			, [GST].EventDateMonth
			, [GST].EventDateMonthName
			, SUM([GST].EventTotal)	AS EventTotal
	FROM	@GeneralStatistictsAttendance [GST]
	GROUP BY [GST].EventType
			, [GST].EventTypeAlias
			, [GST].EventDateMonth
			, [GST].EventDateMonthName )  AS Summary
	WHERE EventTotal IN (
						SELECT	 MAX( EventTotal ) AS EventTotal
						FROM (
						SELECT [GST].EventType
								, [GST].EventTypeAlias
								, [GST].EventDateMonth
								, [GST].EventDateMonthName
								, SUM([GST].EventTotal)	AS EventTotal
						FROM	@GeneralStatistictsAttendance [GST]
						GROUP BY [GST].EventType
								, [GST].EventTypeAlias
								, [GST].EventDateMonth
								, [GST].EventDateMonthName )  AS Summary
						GROUP BY EventType
	)
	GROUP BY EventType
			, EventDateMonthName

END

GO

--*******************************************************************
--GETTOPSTATISTICTSMAJORMONTHSATTENDANCEANDNONATTENDANCE STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-22
-- Description:	Get the statistics of the major
--				course in terms of attendance
--				and nonattendance
-- =============================================
CREATE PROCEDURE [Dashboard].[GetTopStatistictsMajorCourseAttendanceAndNonAttendance]
		@DocumentNumber INT = NULL
		, @RoleId		INT = NULL
AS
BEGIN

	DECLARE	@SemesterStartDate	DATETIME,
			@SemesterEndDate	DATETIME;
	
	DECLARE @GeneralStatistictsAttendance TABLE (
		EventType			NVARCHAR(15),
		EventTypeAlias		NVARCHAR(10),
		EventDate			DATETIME,
		EventDateMonth		INT,
		EventDateMonthName	NVARCHAR(10),
		EventCourseName		NVARCHAR(250),
		EventTotal			INT);

	DECLARE @AttendanceType		NVARCHAR(15),
			@AttendanceAlias	NVARCHAR(15),
			@NonAttendanceType	NVARCHAR(15),
			@NonAttendanceAlias	NVARCHAR(15);

	SET @AttendanceType			= 'Attendance';
	SET @AttendanceAlias		= 'Asistencia';
	SET @NonAttendanceType		= 'NonAttendance';
	SET @NonAttendanceAlias		= 'Ausentismo';

	SELECT	@SemesterStartDate = [StartDate]
			, @SemesterEndDate = [EndDate]
	FROM	[Integration].[AcademicPeriod]
	WHERE	[Semester] = [Integration].[GetCurrentSemester]()

	WHILE (@SemesterStartDate < @SemesterEndDate)
	BEGIN

		IF(ISNULL(@DocumentNumber, 0) > 0 AND  ISNULL(@RoleId, 0) > 0)
		BEGIN
			IF(@RoleId = 3) --Is a Teacher
			BEGIN		
				INSERT INTO @GeneralStatistictsAttendance 
				SELECT  @AttendanceType							AS EventType
						, @AttendanceAlias						AS EventTypeAlias
						, @SemesterStartDate					AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, [ATV].CourseName						AS EventCourseName
						, COUNT (1)				AS EventTotal
				FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
				WHERE	[ATV].[MovementDate] = CONVERT(DATE, @SemesterStartDate) AND
						[ATV].[RoleId]			= 4								 AND
						[ATV].[CourseId]		IN (
													SELECT	CourseId 
													FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
				GROUP BY  [ATV].CourseName	

				UNION

				SELECT  @NonAttendanceType						AS EventType
						, @NonAttendanceAlias					AS EventTypeAlias
						, @SemesterStartDate					AS EventDate
						, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
						, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
						, [NAV].CourseName						AS EventCourseName
						, COUNT (1)								AS EventTotal
				FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
				WHERE	[NAV].[NonAttendanceDate]	= CONVERT(DATE, @SemesterStartDate) AND
						[NAV].[RoleId]				= 4									AND
						[NAV].[CourseId]		IN (
												SELECT	CourseId 
												FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
				GROUP BY  [NAV].CourseName	
			END
			ELSE
			BEGIN
				INSERT INTO @GeneralStatistictsAttendance 
					SELECT  @AttendanceType							AS EventType
							, @AttendanceAlias						AS EventTypeAlias
							, @SemesterStartDate					AS EventDate
							, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
							, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
							, [ATV].CourseName						AS EventCourseName
							, COUNT (1)				AS EventTotal
					FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
					WHERE	[ATV].[MovementDate] = CONVERT(DATE, @SemesterStartDate)	AND
							[ATV].[DocumentNumber]	= @DocumentNumber					AND
							[ATV].[RoleId]			= @RoleId 
					GROUP BY  [ATV].CourseName	

					UNION

					SELECT  @NonAttendanceType						AS EventType
							, @NonAttendanceAlias					AS EventTypeAlias
							, @SemesterStartDate					AS EventDate
							, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
							, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
							, [NAV].CourseName						AS EventCourseName
							, COUNT (1)								AS EventTotal
					FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
					WHERE	[NAV].[NonAttendanceDate]	= CONVERT(DATE, @SemesterStartDate)	AND
							[NAV].[DocumentNumber]		= @DocumentNumber					AND
							[NAV].[RoleId]				= @RoleId 
					GROUP BY  [NAV].CourseName	
			END
		END
		ELSE
		BEGIN
			INSERT INTO @GeneralStatistictsAttendance 
			SELECT  @AttendanceType							AS EventType
					, @AttendanceAlias						AS EventTypeAlias
					, @SemesterStartDate					AS EventDate
					, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
					, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
					, [ATV].CourseName						AS EventCourseName
					, COUNT (1)				AS EventTotal
			FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
			WHERE	[ATV].[MovementDate] = CONVERT(DATE, @SemesterStartDate)
			GROUP BY  [ATV].CourseName	

			UNION

			SELECT  @NonAttendanceType						AS EventType
					, @NonAttendanceAlias					AS EventTypeAlias
					, @SemesterStartDate					AS EventDate
					, DATEPART(MONTH, @SemesterStartDate)	AS EventDateMonth
					, DATENAME(MONTH, @SemesterStartDate)	AS EventDateMonthName
					, [NAV].CourseName						AS EventCourseName
					, COUNT (1)								AS EventTotal
			FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
			WHERE	[NAV].[NonAttendanceDate] = CONVERT(DATE, @SemesterStartDate) 
			GROUP BY  [NAV].CourseName	
			
		END

		SET @SemesterStartDate = DATEADD(DD, 1, @SemesterStartDate);
	END


	SELECT	 DISTINCT EventType
			, EventDateMonthName
			, EventCourseName
			, MAX( EventTotal ) AS EventTotal
	FROM (
	SELECT [GST].EventType
			, [GST].EventTypeAlias
			, [GST].EventDateMonth
			, [GST].EventDateMonthName
			, [GST].EventCourseName
			, SUM([GST].EventTotal)	AS EventTotal
	FROM	@GeneralStatistictsAttendance [GST]
	GROUP BY [GST].EventType
			, [GST].EventTypeAlias
			, [GST].EventDateMonth
			, [GST].EventDateMonthName
			, [GST].EventCourseName )  AS Summary
	GROUP BY EventType
			, EventDateMonthName
			, EventCourseName
	HAVING CONCAT(EventDateMonthName, MAX( EventTotal )) IN (
						SELECT	 CONCAT(EventDateMonthName, MAX( EventTotal )) AS EventTotal
						FROM (
						SELECT [GST].EventType
								, [GST].EventTypeAlias
								, [GST].EventDateMonth
								, [GST].EventDateMonthName
								, [GST].EventCourseName
								, SUM([GST].EventTotal)	AS EventTotal
						FROM	@GeneralStatistictsAttendance [GST]
						GROUP BY [GST].EventType
								, [GST].EventTypeAlias
								, [GST].EventDateMonth
								, [GST].EventDateMonthName
								, [GST].EventCourseName )  AS Summary
						GROUP BY EventType, EventDateMonthName
	)

END

GO

--*******************************************************************
--GETTOPSTATISTICTATTENDANCEANDNONATTENDANCETEACHERCOURSE STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-22
-- Description:	Get the statistics of the
--				course and teacher with the major
--				attendance and nonattendance
-- =============================================
CREATE PROCEDURE [Dashboard].[GetTopStatistictAttendanceAndNonAttendanceTeacherCourse]
AS
BEGIN

	DECLARE	@SemesterStartDate	DATETIME,
			@SemesterEndDate	DATETIME;
	
	DECLARE @GeneralCourseStatistictsAttendance TABLE (
			EventType				NVARCHAR(15),
			EventTypeAlias			NVARCHAR(10),
			CourseId				INT,
			CourseName				NVARCHAR(250),
			PersonDocumentNumber	INT,
			PersonFullName			NVARCHAR(300),
			PersonRoleId			INT,
			PersonRoleAlias			NVARCHAR(20),
			PersonImageRelativePath	NVARCHAR(255),
			EventTotal				INT
	);

	DECLARE @AttendanceType		NVARCHAR(15),
			@AttendanceAlias	NVARCHAR(15),
			@NonAttendanceType	NVARCHAR(15),
			@NonAttendanceAlias	NVARCHAR(15);

	SET @AttendanceType			= 'Attendance';
	SET @AttendanceAlias		= 'Asistencia';
	SET @NonAttendanceType		= 'NonAttendance';
	SET @NonAttendanceAlias		= 'Ausentismo';

	SELECT	@SemesterStartDate = [StartDate]
			, @SemesterEndDate = [EndDate]
	FROM	[Integration].[AcademicPeriod]
	WHERE	[Semester] = [Integration].[GetCurrentSemester]()

	WHILE (@SemesterStartDate < @SemesterEndDate)
	BEGIN
		
		INSERT INTO @GeneralCourseStatistictsAttendance 
		
		SELECT  @AttendanceType							AS EventType
				, @AttendanceAlias						AS EventTypeAlias
				, [ATV].CourseId						AS CourseId
				, [ATV].CourseName						AS CourseName
				, [ATV].DocumentNumber					AS PersonDocumentNumber
				, [ATV].FullName						AS PersonFullName
				, [ATV].RoleId							AS PersonRoleId
				, [ATV].RoleAlias						AS PersonRoleAlias
				, [ATV].ImageRelativePath				AS PersonImageRelativePath
				, COUNT( 1 )							AS EventTotal
		FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
		WHERE	[ATV].[MovementDate]		= CONVERT(DATE, @SemesterStartDate) AND
				[ATV].[RoleId]				= 3 
		GROUP BY  [ATV].CourseId		
				 , [ATV].CourseName		
				 , [ATV].DocumentNumber	
				 , [ATV].FullName		
				 , [ATV].RoleId			
				 , [ATV].RoleAlias
				 , [ATV].ImageRelativePath		

		INSERT INTO @GeneralCourseStatistictsAttendance 

		SELECT @NonAttendanceType						AS EventType
				, @NonAttendanceAlias					AS EventTypeAlias
				, [NAV].CourseId						AS CourseId
				, [NAV].CourseName						AS CourseName
				, [NAV].DocumentNumber					AS PersonDocumentNumber
				, [NAV].FullName						AS PersonFullName
				, [NAV].RoleId							AS PersonRoleId
				, [NAV].RoleAlias						AS PersonRoleAlias
				, [NAV].ImageRelativePath				AS PersonImageRelativePath
				, COUNT( 1 )							AS EventTotal
		FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
		WHERE	[NAV].[NonAttendanceDate]	= CONVERT(DATE, @SemesterStartDate) AND
				[NAV].[RoleId]				= 3 
		GROUP BY  [NAV].CourseId		
				 , [NAV].CourseName		
				 , [NAV].DocumentNumber	
				 , [NAV].FullName		
				 , [NAV].RoleId			
				 , [NAV].RoleAlias
				 , [NAV].ImageRelativePath	

		SET @SemesterStartDate = DATEADD(DD, 1, @SemesterStartDate);
	END

	SELECT EventType
			, EventTypeAlias
			, CourseId
			, CourseName
			, PersonFullName
			, PersonImageRelativePath
			, EventTotal
	FROM (
		SELECT *
		FROM (
			SELECT TOP 5 *
			FROM (
				SELECT	EventType
						, EventTypeAlias
						, CourseId
						, CourseName
						, PersonFullName 
						, PersonImageRelativePath 
						, SUM(EventTotal)	AS EventTotal
				FROM	@GeneralCourseStatistictsAttendance
				WHERE	EventType		= @NonAttendanceType 
				GROUP BY EventType
						, EventTypeAlias
						, CourseId
						, CourseName
						, PersonFullName
						, PersonImageRelativePath ) AS Attendance
			ORDER BY EventTotal DESC ) AS AttendanceSummary
	 
			UNION

			SELECT *
			FROM (
				SELECT	TOP 5 *
				FROM (
					SELECT	EventType
							, EventTypeAlias
							, CourseId
							, CourseName
							, PersonFullName	
							, PersonImageRelativePath
							, SUM(EventTotal)	AS EventTotal
					FROM	@GeneralCourseStatistictsAttendance
					WHERE	EventType		= @AttendanceType
					GROUP BY EventType
							, EventTypeAlias
							, CourseId
							, CourseName
							, PersonFullName
							, PersonImageRelativePath ) AS NonAttendance 
				ORDER BY EventTotal DESC ) AS NonAttendanceSummary ) AS Summary
				ORDER BY EventType, EventTotal DESC 

END

GO

--*******************************************************************
--GETTOPSTATISTICTATTENDANCEANDNONATTENDANCESTUDENTCOURSE STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-22
-- Description:	Get the statistics of the
--				course and student with the major
--				attendance and nonattendance
-- =============================================
CREATE PROCEDURE [Dashboard].[GetTopStatistictAttendanceAndNonAttendanceStudentCourse]
		@DocumentNumber INT = NULL
		, @RoleId		INT = NULL
AS
BEGIN

	DECLARE	@SemesterStartDate	DATETIME,
			@SemesterEndDate	DATETIME;
	
	DECLARE @GeneralCourseStatistictsAttendance TABLE (
			EventType				NVARCHAR(15),
			EventTypeAlias			NVARCHAR(10),
			CourseId				INT,
			CourseName				NVARCHAR(250),
			PersonDocumentNumber	INT,
			PersonFullName			NVARCHAR(300),
			PersonRoleId			INT,
			PersonRoleAlias			NVARCHAR(20),
			PersonImageRelativePath	NVARCHAR(255),
			EventTotal				INT
	);

	DECLARE @AttendanceType		NVARCHAR(15),
			@AttendanceAlias	NVARCHAR(15),
			@NonAttendanceType	NVARCHAR(15),
			@NonAttendanceAlias	NVARCHAR(15);

	SET @AttendanceType			= 'Attendance';
	SET @AttendanceAlias		= 'Asistencia';
	SET @NonAttendanceType		= 'NonAttendance';
	SET @NonAttendanceAlias		= 'Ausentismo';

	SELECT	@SemesterStartDate = [StartDate]
			, @SemesterEndDate = [EndDate]
	FROM	[Integration].[AcademicPeriod]
	WHERE	[Semester] = [Integration].[GetCurrentSemester]()

	WHILE (@SemesterStartDate < @SemesterEndDate)
	BEGIN
		IF(ISNULL(@DocumentNumber, 0) > 0 AND  ISNULL(@RoleId, 0) > 0)
		BEGIN
			IF(@RoleId = 3) --Is a Teacher
			BEGIN
				INSERT INTO @GeneralCourseStatistictsAttendance 
		
				SELECT  @AttendanceType							AS EventType
						, @AttendanceAlias						AS EventTypeAlias
						, [ATV].CourseId						AS CourseId
						, [ATV].CourseName						AS CourseName
						, [ATV].DocumentNumber					AS PersonDocumentNumber
						, [ATV].FullName						AS PersonFullName
						, [ATV].RoleId							AS PersonRoleId
						, [ATV].RoleAlias						AS PersonRoleAlias
						, [ATV].ImageRelativePath				AS PersonImageRelativePath
						, COUNT( 1 )							AS EventTotal
				FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
				WHERE	[ATV].[MovementDate]	= CONVERT(DATE, @SemesterStartDate)  AND
						[ATV].RoleId			= 4									 AND
						[ATV].[CourseId]		IN (
													SELECT	CourseId 
													FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
				GROUP BY  [ATV].CourseId		
							, [ATV].CourseName		
							, [ATV].DocumentNumber	
							, [ATV].FullName		
							, [ATV].RoleId			
							, [ATV].RoleAlias
							, [ATV].ImageRelativePath

				INSERT INTO @GeneralCourseStatistictsAttendance 
		
				SELECT @NonAttendanceType						AS EventType
						, @NonAttendanceAlias					AS EventTypeAlias
						, [NAV].CourseId						AS CourseId
						, [NAV].CourseName						AS CourseName
						, [NAV].DocumentNumber					AS PersonDocumentNumber
						, [NAV].FullName						AS PersonFullName
						, [NAV].RoleId							AS PersonRoleId
						, [NAV].RoleAlias						AS PersonRoleAlias
						, [NAV].ImageRelativePath				AS PersonImageRelativePath
						, COUNT( 1 )							AS EventTotal
				FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
				WHERE	[NAV].[NonAttendanceDate]	= CONVERT(DATE, @SemesterStartDate) AND
						[NAV].RoleId				= 4									AND
						[NAV].[CourseId]		IN (
													SELECT	CourseId 
													FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
				GROUP BY  [NAV].CourseId		
							, [NAV].CourseName		
							, [NAV].DocumentNumber	
							, [NAV].FullName		
							, [NAV].RoleId			
							, [NAV].RoleAlias	
							, [NAV].ImageRelativePath
			END
		END
		ELSE
		BEGIN
			INSERT INTO @GeneralCourseStatistictsAttendance 
		
				SELECT  @AttendanceType							AS EventType
						, @AttendanceAlias						AS EventTypeAlias
						, [ATV].CourseId						AS CourseId
						, [ATV].CourseName						AS CourseName
						, [ATV].DocumentNumber					AS PersonDocumentNumber
						, [ATV].FullName						AS PersonFullName
						, [ATV].RoleId							AS PersonRoleId
						, [ATV].RoleAlias						AS PersonRoleAlias
						, [ATV].ImageRelativePath				AS PersonImageRelativePath
						, COUNT( 1 )							AS EventTotal
				FROM	[Attendance].[AttendanceView] [ATV] WITH(NOLOCK)
				WHERE	[ATV].[MovementDate]	= CONVERT(DATE, @SemesterStartDate)  AND
						[ATV].RoleId			= 4 
				GROUP BY  [ATV].CourseId		
							, [ATV].CourseName		
							, [ATV].DocumentNumber	
							, [ATV].FullName		
							, [ATV].RoleId			
							, [ATV].RoleAlias
							, [ATV].ImageRelativePath

				INSERT INTO @GeneralCourseStatistictsAttendance 
		
				SELECT @NonAttendanceType						AS EventType
						, @NonAttendanceAlias					AS EventTypeAlias
						, [NAV].CourseId						AS CourseId
						, [NAV].CourseName						AS CourseName
						, [NAV].DocumentNumber					AS PersonDocumentNumber
						, [NAV].FullName						AS PersonFullName
						, [NAV].RoleId							AS PersonRoleId
						, [NAV].RoleAlias						AS PersonRoleAlias
						, [NAV].ImageRelativePath				AS PersonImageRelativePath
						, COUNT( 1 )							AS EventTotal
				FROM	[NonAttendance].[NonAttendanceView] [NAV] WITH(NOLOCK)
				WHERE	[NAV].[NonAttendanceDate]	= CONVERT(DATE, @SemesterStartDate) AND
						[NAV].RoleId				= 4 
				GROUP BY  [NAV].CourseId		
							, [NAV].CourseName		
							, [NAV].DocumentNumber	
							, [NAV].FullName		
							, [NAV].RoleId			
							, [NAV].RoleAlias	
							, [NAV].ImageRelativePath
		END
		SET @SemesterStartDate = DATEADD(DD, 1, @SemesterStartDate);
	END

	SELECT EventType
			, EventTypeAlias
			, CourseId
			, CourseName
			, PersonFullName
			, PersonImageRelativePath
			, EventTotal
	FROM (
		SELECT *
		FROM (
			SELECT TOP 5 *
			FROM (
				SELECT	EventType
						, EventTypeAlias
						, CourseId
						, CourseName
						, PersonFullName 
						, PersonImageRelativePath
						, SUM(EventTotal)	AS EventTotal
				FROM	@GeneralCourseStatistictsAttendance
				WHERE	EventType		= @NonAttendanceType 
				GROUP BY EventType
						, EventTypeAlias
						, CourseId
						, CourseName
						, PersonFullName
						, PersonImageRelativePath ) AS Attendance
			ORDER BY EventTotal DESC ) AS AttendanceSummary
	 
			UNION

			SELECT *
			FROM (
				SELECT	TOP 5 *
				FROM (
					SELECT	EventType
							, EventTypeAlias
							, CourseId
							, CourseName
							, PersonFullName
							, PersonImageRelativePath	
							, SUM(EventTotal)	AS EventTotal
					FROM	@GeneralCourseStatistictsAttendance
					WHERE	EventType		= @AttendanceType
					GROUP BY EventType
							, EventTypeAlias
							, CourseId
							, CourseName
							, PersonFullName
							, PersonImageRelativePath  ) AS NonAttendance 
				ORDER BY EventTotal DESC ) AS NonAttendanceSummary ) AS Summary
				ORDER BY EventType, EventTotal DESC

END

GO

--*******************************************************************
--GETSTATISTICTEXCUSESTATES STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get the statistics with the
--				states of the excuses 
-- =============================================
CREATE PROCEDURE [Dashboard].[GetStatistictExcuseStates]
		@DocumentNumber INT = NULL
		, @RoleId		INT = NULL
AS

BEGIN

	DECLARE @Total				DECIMAL,
			@ExcuseResultAlias	NVARCHAR(20);

	DECLARE @ExcuseStatisticts TABLE (
			ResultAlias				NVARCHAR(30),
			Status					NVARCHAR(30),
			Total					INT,
			Percentage				NVARCHAR(5)
	);

	SET @ExcuseResultAlias	= 'ExcuseStatus';


	IF(ISNULL(@DocumentNumber, 0) > 0 AND  ISNULL(@RoleId, 0) > 0)
	BEGIN
		IF(@RoleId = 1 OR @RoleId = 2) -- Is Administrator or Director
		BEGIN
			SELECT	@Total  = COUNT( 1 )
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)

			INSERT INTO @ExcuseStatisticts
			SELECT	TOP 5 
					@ExcuseResultAlias								AS ResultAlias
					, [EXV].[Status]
					, COUNT( 1 )									AS Total
					, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			GROUP BY [EXV].[Status]
			ORDER BY COUNT( 1 ) DESC
		END
		IF(@RoleId = 3) --Is a Teacher
		BEGIN
			SELECT	@Total  = COUNT( 1 )
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantRoleId] = 4	AND
					[EXV].[CourseId]		IN (
											SELECT	CourseId 
											FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher

			INSERT INTO @ExcuseStatisticts
			SELECT	TOP 5 
					@ExcuseResultAlias								AS ResultAlias
					, [EXV].[Status]
					, COUNT( 1 )									AS Total
					, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantRoleId] = 4	AND
					[EXV].[CourseId]		IN (
											SELECT	CourseId 
											FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
			GROUP BY [EXV].[Status]
			ORDER BY COUNT( 1 ) DESC
		END
		IF(@RoleId = 4)
		BEGIN
			SELECT	@Total  = COUNT( 1 )
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantDocumentNumber]	= @DocumentNumber AND
					[EXV].[TruantRoleId]			= @RoleId

			INSERT INTO @ExcuseStatisticts
			SELECT	TOP 5 
					@ExcuseResultAlias								AS ResultAlias
					, [EXV].[Status]
					, COUNT( 1 )									AS Total
					, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantDocumentNumber]	= @DocumentNumber AND
					[EXV].[TruantRoleId]			= @RoleId
			GROUP BY [EXV].[Status]
			ORDER BY COUNT( 1 ) DESC
		END
	END
	ELSE
	BEGIN
		SELECT	@Total  = COUNT( 1 )
		FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)

		INSERT INTO @ExcuseStatisticts
		SELECT	TOP 5 
				@ExcuseResultAlias								AS ResultAlias
				, [EXV].[Status]
				, COUNT( 1 )									AS Total
				, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
		FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
		GROUP BY [EXV].[Status]
		ORDER BY COUNT( 1 ) DESC
	END

	SELECT	ResultAlias 
			, Status		
			, Total				
			, Percentage			
	FROM	@ExcuseStatisticts

END

GO

--*******************************************************************
--GETSTATISTICTEXCUSECLASSIFICATIONS STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get the statistics with the
--				classifications of the excuses 
-- =============================================
CREATE PROCEDURE [Dashboard].[GetStatistictExcuseClassifications]
		@DocumentNumber INT = NULL
		, @RoleId		INT = NULL
AS

BEGIN

	DECLARE @Total				DECIMAL,
			@ExcuseResultAlias	NVARCHAR(20)

	DECLARE @ExcuseStatisticts TABLE (
			ResultAlias				NVARCHAR(30),
			Classification			NVARCHAR(30),
			Total					INT,
			Percentage				NVARCHAR(5)
	);

	SET @ExcuseResultAlias	= 'ExcuseClassification';

	IF(ISNULL(@DocumentNumber, 0) > 0 AND  ISNULL(@RoleId, 0) > 0)
	BEGIN
		IF(@RoleId = 1 OR @RoleId = 2) -- Is Administrator or Director
		BEGIN
			SELECT	@Total  = COUNT( 1 )
				FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)

			INSERT INTO @ExcuseStatisticts
			SELECT	@ExcuseResultAlias								AS ResultAlias
					, [EXV].[Classification]
					, COUNT( 1 )									AS Total
					, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			GROUP BY [EXV].[Classification]
			ORDER BY COUNT( 1 ) DESC
		END
		IF(@RoleId = 3) --Is a Teacher
		BEGIN
			SELECT	@Total  = COUNT( 1 )
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantRoleId] = 4	AND
					[EXV].[CourseId]		IN (
											SELECT	CourseId 
											FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher

			INSERT INTO @ExcuseStatisticts
			SELECT	@ExcuseResultAlias								AS ResultAlias
					, [EXV].[Classification]
					, COUNT( 1 )									AS Total
					, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantRoleId] = 4	AND
					[EXV].[CourseId]		IN (
											SELECT	CourseId 
											FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
			GROUP BY [EXV].[Classification]
			ORDER BY COUNT( 1 ) DESC
		END
		IF(@RoleId = 4) --Is a student
		BEGIN
			SELECT	@Total  = COUNT( 1 )
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantDocumentNumber]	= @DocumentNumber AND
					[EXV].[TruantRoleId]			= @RoleId

			INSERT INTO @ExcuseStatisticts
			SELECT	@ExcuseResultAlias								AS ResultAlias
					, [EXV].[Classification]
					, COUNT( 1 )									AS Total
					, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantDocumentNumber]	= @DocumentNumber AND
					[EXV].[TruantRoleId]			= @RoleId
			GROUP BY [EXV].[Classification]
			ORDER BY COUNT( 1 ) DESC
		END
	END
	ELSE
	BEGIN
		SELECT	@Total  = COUNT( 1 )
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)

		INSERT INTO @ExcuseStatisticts
		SELECT	@ExcuseResultAlias								AS ResultAlias
				, [EXV].[Classification]
				, COUNT( 1 )									AS Total
				, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
		FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
		GROUP BY [EXV].[Classification]
		ORDER BY COUNT( 1 ) DESC
	END
	
	SELECT	ResultAlias 
			, Classification		
			, Total				
			, Percentage			
	FROM	@ExcuseStatisticts

END

GO

--*******************************************************************
--GETTOPSTATISTICTEXCUSECLASSIFICATIONS STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agustín Barona
-- Create date: 2016-08-27
-- Description:	Get the statistics with the
--				classifications of the excuses 
-- =============================================
CREATE PROCEDURE [Dashboard].[GetTopStatistictExcuseClassifications]
		@DocumentNumber INT = NULL
		, @RoleId		INT = NULL
AS

BEGIN

	DECLARE @Total				DECIMAL,
			@ExcuseResultAlias	NVARCHAR(20)

	DECLARE @ExcuseStatisticts TABLE (
			ResultAlias				NVARCHAR(30),
			Classification			NVARCHAR(30),
			Total					INT,
			Percentage				NVARCHAR(5)
	);

	SET @ExcuseResultAlias	= 'ExcuseClassification';

	IF(ISNULL(@DocumentNumber, 0) > 0 AND  ISNULL(@RoleId, 0) > 0)
	BEGIN
		IF(@RoleId = 1 OR @RoleId = 2) -- Is Administrator or Director
		BEGIN
			SELECT	@Total  = COUNT( 1 )
				FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)

				INSERT INTO @ExcuseStatisticts
				SELECT	TOP 5 
						@ExcuseResultAlias								AS ResultAlias
						, [EXV].[Classification]
						, COUNT( 1 )									AS Total
						, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
				FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
				GROUP BY [EXV].[Classification]
				ORDER BY COUNT( 1 ) DESC
		END
		IF(@RoleId = 3) --Is a Teacher
		BEGIN
			SELECT	@Total  = COUNT( 1 )
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantRoleId] = 4	AND
					[EXV].[CourseId]		IN (
											SELECT	CourseId 
											FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher

			INSERT INTO @ExcuseStatisticts
			SELECT	TOP 5 
					@ExcuseResultAlias								AS ResultAlias
					, [EXV].[Classification]
					, COUNT( 1 )									AS Total
					, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantRoleId] = 4	AND
					[EXV].[CourseId]		IN (
											SELECT	CourseId 
											FROM	[Integration].[GetCoursesByTeacherDocumentNumber](@DocumentNumber) ) -- Courses of the current teacher
			GROUP BY [EXV].[Classification]
			ORDER BY COUNT( 1 ) DESC
		END
		IF(@RoleId = 4)
		BEGIN
			SELECT	@Total  = COUNT( 1 )
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantDocumentNumber]	= @DocumentNumber AND
					[EXV].[TruantRoleId]			= @RoleId

			INSERT INTO @ExcuseStatisticts
			SELECT	TOP 5 
					@ExcuseResultAlias								AS ResultAlias
					, [EXV].[Classification]
					, COUNT( 1 )									AS Total
					, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			WHERE	[EXV].[TruantDocumentNumber]	= @DocumentNumber AND
					[EXV].[TruantRoleId]			= @RoleId
			GROUP BY [EXV].[Classification]
			ORDER BY COUNT( 1 ) DESC
		END
	END
	ELSE
	BEGIN
		SELECT	@Total  = COUNT( 1 )
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)

			INSERT INTO @ExcuseStatisticts
			SELECT	TOP 5 
					@ExcuseResultAlias								AS ResultAlias
					, [EXV].[Classification]
					, COUNT( 1 )									AS Total
					, FORMAT(COUNT( 1 ) / @Total, 'N', 'ES-CO')		AS Percentage
			FROM	[NonAttendance].[ExcuseView] [EXV] WITH(NOLOCK)
			GROUP BY [EXV].[Classification]
			ORDER BY COUNT( 1 ) DESC
	END

	SELECT	ResultAlias 
			, Classification		
			, Total				
			, Percentage			
	FROM	@ExcuseStatisticts
END

GO
--*******************************************************************