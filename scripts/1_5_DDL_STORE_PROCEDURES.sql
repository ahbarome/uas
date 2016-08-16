--*******************************************************************
-- Author:		Agust�n Barona
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
-- Author:		Agust�n Barona
-- Create date: 2016-07-24
-- Description:	Get all student movements by 
--				teacher document number
-- =============================================
--[Attendance].[GetAllStudentMovementsByTeacherDocumentNumber] 1130677687
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
-- Author:		Agust�n Barona
-- Create date: 2016-07-24
-- Description:	Get all student movements by 
--				teacher document number and 
--				course id
-- =============================================
 --[Attendance].[GetAllStudentMovementsByTeacherDocumentNumberAndCourseId]  1130677687, 3
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
--INTEGRATION SCHEMA
--*******************************************************************
--GETCURRENTCOURSEBYTEACHERDOCUMENTNUMBER STORE PROCEDURE
--*******************************************************************
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Agust�n Barona
-- Create date: 2016-07-26
-- Description:	Get the current course
-- 
-- =============================================
--[Integration].[GetCurrentCourseByTeacherDocumentNumber] 1130677687
CREATE PROCEDURE [Integration].[GetCurrentCourseByTeacherDocumentNumber]
	@TeacherDocumentNumber INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT	* 
	FROM	[Integration].[ScheduleDetailView] [SDV]
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
-- Author:		Agust�n Barona
-- Create date: 2016-07-26
-- Description:	Get the current course summary
--				by teacher document number
-- =============================================
--[Integration].[GetCurrentCourseSummaryByTeacherDocumentNumber] 1130677685
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

	PRINT @CourseAttendance

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
-- Author:		Agust�n Barona
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
	FROM	[Integration].[PersonActivitiesView]		[PAV]
	LEFT OUTER JOIN [Attendance].[AttendanceRegisterView]	[CMV] ON 
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
-- Author:		Agust�n Barona
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
	FROM	[Integration].[PersonActivitiesView]		[PAV]
	LEFT OUTER JOIN [Attendance].[AttendanceRegisterView]	[CMV] ON 
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
-- Author:		Agust�n Barona
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
			@NonAttendanceDayOfTheWeek			INT;

	SET NOCOUNT ON;
	
	SELECT	@NonAttendanceDocumentNumber = [DocumentNumber]
			, @NonAttendanceRoleId		 = [IdRole] 
			, @NonAttendanceCourseId	 = [IdCourse]
			, @NonAttendanceSpaceId		 = [IdSpace]
			, @NonAttendanceDayOfTheWeek = [DayOfTheWeek]
	FROM	[NonAttendance].[NonAttendance] WITH(NOLOCK)
	WHERE	[Id] = @NonAttendanceId

	--Insert a director for the approval
	IF( [Security].[DirectorExist]() > 0 )
	BEGIN
		INSERT INTO [NonAttendance].[ExcuseApproval] ([IdExcuse], [IdStatus], [Approver], [IdRole])
		SELECT  @ExcuseId
				, 1
				, [DocumentNumber]
				, [IdRole] 
		FROM	[Security].[User] WITH(NOLOCK)
		WHERE	[IdRole] = 2
	END
	--Student
	IF(@NonAttendanceRoleId = 4)
	BEGIN

		--Insert a director for the approval
		INSERT INTO [NonAttendance].[ExcuseApproval] ([IdExcuse], [IdStatus], [Approver], [IdRole])
		SELECT TOP 1 @ExcuseId
				, 1
				, [DocumentNumber]
				, [RoleId] 
		FROM	[Integration].[PersonActivitiesView] WITH(NOLOCK)
		WHERE	[CourseId]		= @NonAttendanceCourseId		AND
				[SpaceId]		= @NonAttendanceSpaceId			AND
				[DayOfTheWeek]	= @NonAttendanceDayOfTheWeek	AND
				[RoleId]		= 3 
	END

END

GO
--*******************************************************************