--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description: Data definition for functions
--*******************************************************************
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
--*******************************************************************
--ATTENDANCE SCHEMA
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
	-- Add the SELECT statement with parameter references here
	SELECT	DISTINCT [MOV].[DocumentNumber]
	FROM	[Attendance].[Movement] [MOV] WITH(NOLOCK)
	WHERE	CONVERT(DATE, [MOV].[RegisterDate]) = CONVERT(DATE, GETDATE())
	GROUP BY [MOV].[DocumentNumber]
)

GO

--*******************************************************************
--INTEGRATION SCHEMA
--*******************************************************************
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
	FROM	[Integration].[EnrollmentDetailView] [EDV]
	WHERE	( [EDV].[EndDate] >= GETDATE() AND [EDV].[StartDate] <=  GETDATE() ) AND-- Course of the semester
			[EDV].[DayOfTheWeek] = DATEPART(WEEKDAY, GETDATE() - 1)	AND -- Course for today
			( [EDV].[EndTime] >= CONVERT(TIME, GETDATE()) AND  [EDV].[StartTime] <=  CONVERT(TIME, GETDATE())) AND-- Current course
			[EDV].[TeacherDocumentNumber] = @TeacherDocumentNumber 
	ORDER BY [EDV].[StartTime] DESC
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


