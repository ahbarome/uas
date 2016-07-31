--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description: Data definition for views
--*******************************************************************
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
--ATTENDANCE SCHEMA
--*******************************************************************
--STUDENTMOVEMENT VIEW 
--*******************************************************************
CREATE VIEW [Attendance].[StudentMovementView] AS
SELECT	[MOV].[DocumentNumber]							AS DocumentNumber
		, [STU].[Code]									AS Code
		, [STU].[Name]									AS Name
		, [STU].[LastName]								AS LastName
		, CONCAT([STU].[Name], ' ', [STU].[LastName])	AS FullName
		, [STU].[Email]									AS Email
		, [STU].[TelephoneNumber]						AS TelephoneNumber
		, [STU].[Address]								AS Address
		, [STU].[ImageRelativePath]						AS ImageRelativePath
		, 4												AS RoleId
		, 'Student'										AS RoleName
		, 'Estudiante'									AS RoleAlias
		, [SPA].[Id]									AS SpaceId
		, [SPA].[Name]									AS SpaceName
		, [SPT].[Type]									AS SpaceType
		, [MOV].[RegisterDate]							AS MovementDateTime
		, CONVERT(DATE, [MOV].[RegisterDate])			AS MovementDate
		, CONVERT(TIME, [MOV].[RegisterDate])			AS MovementTime
FROM		[Attendance].[Movement]				[MOV]
INNER JOIN	[Integration].[Student]				[STU] ON [STU].[DocumentNumber] = [MOV].[DocumentNumber]
INNER JOIN	[Integration].[Space]				[SPA] ON [SPA].[Id]				= [MOV].[IdSpace]
INNER JOIN	[Integration].[SpaceType]			[SPT] ON [SPT].[Id]				= [SPA].[IdSpaceType]
GO

--*******************************************************************
--TEACHERMOVEMENT VIEW 
--*******************************************************************
CREATE VIEW [Attendance].[TeacherMovementView] AS
(	SELECT	 [MOV].[DocumentNumber]							AS DocumentNumber
			, [TEA].[Code]									AS Code
			, [TEA].[Name]									AS Name
			, [TEA].[LastName]								AS LastName
			, CONCAT([TEA].[Name], ' ', [TEA].[LastName])	AS FullName
			, [TEA].[Email]									AS Email
			, [TEA].[TelephoneNumber]						AS TelephoneNumber
			, [TEA].[Address]								AS Address
			, [TEA].[ImageRelativePath]						AS ImageRelativePath
			, 3												AS RoleId
			, 'Teacher'										AS RoleName
			, 'Profesor'									AS RoleAlias
			, [SPA].[Id]									AS SpaceId
			, [SPA].[Name]									AS SpaceName
			, [SPT].[Type]									AS SpaceType
			, [MOV].[RegisterDate]							AS MovementDateTime
			, CONVERT(DATE, [MOV].[RegisterDate])			AS MovementDate
			, CONVERT(TIME, [MOV].[RegisterDate])			AS MovementTime
	FROM		[Attendance].[Movement]				[MOV]
	INNER JOIN	[Integration].[Teacher]				[TEA] ON [TEA].[DocumentNumber] = [MOV].[DocumentNumber]
	INNER JOIN	[Integration].[Space]				[SPA] ON [SPA].[Id]				= [MOV].[IdSpace]
	INNER JOIN	[Integration].[SpaceType]			[SPT] ON [SPT].[Id]				= [SPA].[IdSpaceType] )
GO

--*******************************************************************
--MOVEMENT VIEW 
--*******************************************************************
CREATE VIEW [Attendance].[MovementView] AS
(	SELECT	*
	FROM	[Attendance].[StudentMovementView]
	UNION
	SELECT	*
	FROM	[Attendance].[TeacherMovementView])
GO

--*******************************************************************
--INTEGRATION SCHEMA 
--*******************************************************************
--SCHEDULEDETAIL VIEW 
--*******************************************************************
CREATE VIEW [Integration].[ScheduleDetailView] AS
(	SELECT	 [SCH].[Id]										AS ScheduleId
			, [TEA].[DocumentNumber]						AS TeacherDocumentNumber
			, CONCAT([TEA].[Name], ' ', [TEA].[LastName])	AS TeacherFullName
			, [COU].[Id]									AS CourseId
			, [COU].[Name]									AS CourseName
			, [COU].[NumberOfCredits]						AS CourseCredits
			, [SCD].[DayOfTheWeek]
			, DATENAME(WEEKDAY, [SCD].[DayOfTheWeek] - 1)   AS DayOfTheWeekName
			, [SCD].[StartTime]
			, [SCD].[EndTime]
			, [SPA].[Id]									AS SpaceId
			, [SPA].[Name]									AS SpaceName
			, [SPT].[Type]									AS SpaceType
			, [ACA].[Period]								AS AcademicPeriod
			, [ACA].[Semester]								AS AcademicSemester
			, [ACA].[StartDate]
			, [ACA].[EndDate]
	FROM		[Integration].[Schedule]			[SCH] 
	INNER JOIN	[Integration].[ScheduleDetail]		[SCD] ON [SCD].[IdSchedule]		= [SCH].[Id]
	INNER JOIN	[Integration].[Teacher]				[TEA] ON [TEA].[DocumentNumber] = [SCH].[TeacherDocumentNumber]
	INNER JOIN	[Integration].[Course]				[COU] ON [COU].[Id]				= [SCH].[IdCourse]	
	INNER JOIN	[Integration].[AcademicPeriod]		[ACA] ON [ACA].[Id]				= [SCH].[IdAcademicPeriod]
	INNER JOIN	[Integration].[Space]				[SPA] ON [SPA].[Id]				= [SCD].[IdSpace]
	INNER JOIN	[Integration].[SpaceType]			[SPT] ON [SPT].[Id]				= [SPA].[IdSpaceType])
GO

--*******************************************************************
--ENROLLMENTDETAIL VIEW 
--*******************************************************************
CREATE VIEW [Integration].[EnrollmentDetailView] AS
(	SELECT	[ENR].[Id]										AS EnrollmentId
			, [STU].[DocumentNumber]						AS StudentDocumentNumber
			, CONCAT([STU].[Name], ' ', [STU].[LastName])	AS StudentFullName
			, [CAR].[Id]									AS CareerId
			, [CAR].[Code]									AS CareerCode
			, [CAR].[Name]									AS CareerName
			, [FRI].[Name]									AS FringeName
			, [TEA].[DocumentNumber]						AS TeacherDocumentNumber
			, CONCAT([TEA].[Name], ' ', [TEA].[LastName])	AS TeacherFullName
			, [COU].[Id]									AS CourseId
			, [COU].[Name]									AS CourseName
			, [COU].[NumberOfCredits]						AS CourseCredits
			, [SCD].[DayOfTheWeek]
			, DATENAME(WEEKDAY, [SCD].[DayOfTheWeek] - 1)   AS DayOfTheWeekName
			, [SCD].[StartTime]
			, [SCD].[EndTime]
			, [SPA].[Id]									AS SpaceId
			, [SPA].[Name]									AS SpaceName
			, [SPT].[Type]									AS SpaceType
			, [ACA].[Period]								AS AcademicPeriod
			, [ACA].[Semester]								AS AcademicSemester
			, [ACA].[StartDate]
			, [ACA].[EndDate]
			, [ENS].[Name]									AS EnrollmentStatus
	FROM		[Integration].[Enrollment]			[ENR]
	INNER JOIN	[Integration].[EnrollmentDetail]	[END] ON [END].[IdEnrollment]	= [ENR].Id
	INNER JOIN	[Integration].[Student]				[STU] ON [STU].[DocumentNumber] = [ENR].[StudentDocumentNumber]
	INNER JOIN	[Integration].[Schedule]			[SCH] ON [SCH].[Id]				= [END].[IdSchedule]
	INNER JOIN	[Integration].[ScheduleDetail]		[SCD] ON [SCD].[IdSchedule]		= [SCH].[Id]
	INNER JOIN	[Integration].[Teacher]				[TEA] ON [TEA].[DocumentNumber] = [SCH].[TeacherDocumentNumber]
	INNER JOIN	[Integration].[Course]				[COU] ON [COU].[Id]				= [SCH].[IdCourse]	
	INNER JOIN	[Integration].[AcademicPeriod]		[ACA] ON [ACA].[Id]				= [SCH].[IdAcademicPeriod]	
	INNER JOIN	[Integration].[Career]				[CAR] ON [CAR].[Id]				= [STU].[IdCareer]
	INNER JOIN	[Integration].[Fringe]				[FRI] ON [FRI].[Id]				= [STU].[IdFringe]
	INNER JOIN	[Integration].[EnrollmentStatus]	[ENS] ON [ENS].[Id]				= [ENR].[IdEnrollmentStatus]
	INNER JOIN	[Integration].[Space]				[SPA] ON [SPA].[Id]				= [SCD].[IdSpace]
	INNER JOIN	[Integration].[SpaceType]			[SPT] ON [SPT].[Id]				= [SPA].[IdSpaceType])
GO

--*******************************************************************
--STUDENTENROLLMENT VIEW 
--*******************************************************************
CREATE VIEW [Integration].[StudentEnrollmentView] AS
(	SELECT	[STU].[DocumentNumber]							AS StudentDocumentNumber
			, [STU].[Code]									AS StudentCode
			, [STU].[Name]									AS StudentName
			, [STU].[LastName]								AS StudentLastName
			, CONCAT([STU].[Name], ' ', [STU].[LastName])	AS StudentFullName
			, [STU].[Email]									AS StudentEmail
			, [STU].[TelephoneNumber]						AS StudentTelephoneNumber
			, [STU].[Address]								AS StudentAddress
			, [STU].[ImageRelativePath]						AS StudentImageRelativePath
			, [CAR].[Id]									AS CareerId
			, [CAR].[Code]									AS CareerCode
			, [CAR].[Name]									AS CareerName
			, [FRI].[Name]									AS FringeName
			, [TEA].[DocumentNumber]						AS TeacherDocumentNumber
			, [TEA].[Code]									AS TeacherCode
			, [TEA].[Name]									AS TeacherName
			, [TEA].[LastName]								AS TeacherLastName
			, [TEA].[Email]									AS TeacherEmail
			, [TEA].[TelephoneNumber]						AS TeacherTelephoneNumber
			, [TEA].[Address]								AS TeacherAddress
			, [TEA].[ImageRelativePath]						AS TeacherImageRelativePath
			, CONCAT([TEA].[Name], ' ', [TEA].[LastName])	AS TeacherFullName
			, [COU].[Id]									AS CourseId
			, [COU].[Name]									AS CourseName
			, [COU].[NumberOfCredits]						AS CourseCredits
			, [SCD].[DayOfTheWeek]
			, DATENAME(WEEKDAY, [SCD].[DayOfTheWeek] - 1)   AS DayOfTheWeekName
			, [SCD].[StartTime]
			, [SCD].[EndTime]
			, [ACA].[Period]								AS AcademicPeriod
			, [ACA].[Semester]								AS AcademicSemester
			, [ACA].[StartDate]
			, [ACA].[EndDate]
			, [ENS].[Name]									AS EnrollmentStatus
	FROM		[Integration].[Enrollment]			[ENR]
	LEFT JOIN	[Integration].[EnrollmentDetail]	[END] ON [END].[IdEnrollment]	= [ENR].Id
	LEFT JOIN	[Integration].[Student]				[STU] ON [STU].[DocumentNumber] = [ENR].[StudentDocumentNumber]
	LEFT JOIN	[Integration].[Schedule]			[SCH] ON [SCH].[Id]				= [END].[IdSchedule]
	LEFT JOIN	[Integration].[ScheduleDetail]		[SCD] ON [SCD].[IdSchedule]		= [SCH].[Id]
	LEFT JOIN	[Integration].[Teacher]				[TEA] ON [TEA].[DocumentNumber] = [SCH].[TeacherDocumentNumber]
	LEFT JOIN	[Integration].[Course]				[COU] ON [COU].[Id]				= [SCH].[IdCourse]	
	LEFT JOIN	[Integration].[AcademicPeriod]		[ACA] ON [ACA].[Id]				= [SCH].[IdAcademicPeriod]	
	LEFT JOIN	[Integration].[Career]				[CAR] ON [CAR].[Id]				= [STU].[IdCareer]
	LEFT JOIN	[Integration].[Fringe]				[FRI] ON [FRI].[Id]				= [STU].[IdFringe]
	LEFT JOIN	[Integration].[EnrollmentStatus]	[ENS] ON [ENS].[Id]				= [ENR].[IdEnrollmentStatus])
GO
--*******************************************************************
--COURSE VIEW 
--*******************************************************************
CREATE VIEW [Integration].[CourseView] AS
(	SELECT	  [COU].[Id]									AS CourseId
			, [COU].[Name]									AS CourseName
			, [COU].[NumberOfCredits]						AS CourseCredits
			, [TEA].[DocumentNumber]						AS TeacherDocumentNumber
			, CONCAT([TEA].[Name], ' ', [TEA].[LastName])	AS TeacherFullName
			, [SCD].[DayOfTheWeek]
			, DATENAME(WEEKDAY, [SCD].[DayOfTheWeek] - 1)   AS DayOfTheWeekName
			, [SCD].[StartTime]
			, [SCD].[EndTime]
			, [SPA].[Id]									AS SpaceId
			, [SPA].[Name]									AS SpaceName
			, [SPT].[Type]									AS SpaceType
			, [ACA].[Period]								AS AcademicPeriod
			, [ACA].[Semester]								AS AcademicSemester
			, [ACA].[StartDate]
			, [ACA].[EndDate]
	FROM		[Integration].[Course]				[COU]
	INNER JOIN	[Integration].[Schedule]			[SCH] ON [COU].[Id]				= [SCH].[IdCourse]	
	INNER JOIN	[Integration].[ScheduleDetail]		[SCD] ON [SCD].[IdSchedule]		= [SCH].[Id]
	INNER JOIN	[Integration].[Teacher]				[TEA] ON [TEA].[DocumentNumber] = [SCH].[TeacherDocumentNumber]
	INNER JOIN	[Integration].[AcademicPeriod]		[ACA] ON [ACA].[Id]				= [SCH].[IdAcademicPeriod]	
	INNER JOIN	[Integration].[Space]				[SPA] ON [SPA].[Id]				= [SCD].[IdSpace]
	INNER JOIN	[Integration].[SpaceType]			[SPT] ON [SPT].[Id]				= [SPA].[IdSpaceType])
GO

--*******************************************************************
--PERSONACTIVITIES VIEW 
--*******************************************************************
CREATE VIEW [Integration].[PersonActivitiesView] AS
(	
	SELECT	[CourseId] 
			, [CourseName]
			, [TeacherDocumentNumber]		AS DocumentNumber
			, [TeacherFullName]				AS FullName
			, '3'							AS RoleId
			, 'Profesor'					AS RoleAlias
			, [SpaceId]
			, [SpaceName]
			, [DayOfTheWeek]
			, [StartTime]
			, [EndTime]
	FROM	[Integration].[ScheduleDetailView] [SCH]
	UNION
	SELECT	[CourseId] 
			, [CourseName]
			, [StudentDocumentNumber]		AS DocumentNumber
			, [StudentFullName]				AS FullName
			, '4'							AS RoleId
			, 'Estudiante'					AS RoleAlias
			, [SpaceId]
			, [SpaceName]
			, [DayOfTheWeek]
			, [StartTime]
			, [EndTime]
	FROM	[Integration].[EnrollmentDetailView] [EDV]
)
GO

--*******************************************************************
--REGISTER VIEW 
--*******************************************************************
CREATE VIEW [Attendance].[AttendanceRegisterView] AS
(	
	SELECT [MOV].[DocumentNumber]
			, [MOV].[Code]
			, [MOV].[Name]
			, [MOV].[LastName]
			, [MOV].[RoleId]
			, [MOV].[RoleName]
			, [PAV].[CourseId]
			, [PAV].[CourseName]
			, [PAV].[DayOfTheWeek]
			, [PAV].[StartTime]
			, [PAV].[EndTime]
			, [MOV].[SpaceId]
			, [MOV].[SpaceName]
			, [MOV].[MovementDateTime]
			, [MOV].[MovementDate]
			, [MOV].[MovementTime]
	FROM	[Attendance].[MovementView] [MOV]
	INNER JOIN [Integration].[PersonActivitiesView] [PAV] ON
		[MOV].[DocumentNumber]						= [PAV].[DocumentNumber] AND
		[MOV].[SpaceId]								= [PAV].[SpaceId] AND
		[MOV].[RoleId]								= [PAV].[RoleId] AND
		DATEPART(WEEKDAY, [MOV].[MovementDate])		= [PAV].[DayOfTheWeek]
	WHERE	[MOV].[MovementTime] BETWEEN [PAV].[StartTime] AND [PAV].[EndTime]
)
GO

--*******************************************************************
--COURSEMOVEMENT VIEW 
--*******************************************************************
CREATE VIEW [NonAttendance].[NonAttendanceRegisterView] AS
(	
	SELECT	[PAV].*
	FROM	[Integration].[PersonActivitiesView]		[PAV]
	LEFT OUTER JOIN [Attendance].[RegisterView]	[CMV] ON 
		[CMV].[DocumentNumber]	= [PAV].[DocumentNumber] AND
		[CMV].[CourseId]		= [PAV].[CourseId] AND
		[CMV].[RoleId]			= [PAV].[RoleId] AND
		[CMV].[SpaceId]			= [PAV].[SpaceId] AND
		[CMV].[DayOfTheWeek]	= [PAV].[DayOfTheWeek] 
	WHERE	[CMV].[DocumentNumber] IS NULL AND
			[PAV].[DayOfTheWeek] = [Integration].[GetCurrentDay]()
)
GO

--*******************************************************************