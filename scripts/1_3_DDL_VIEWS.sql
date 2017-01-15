--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description: Data definition for views
--*******************************************************************
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
--SECURITY SCHEMA
--*******************************************************************
--USER VIEW 
--*******************************************************************
CREATE VIEW [Security].[UserView] AS
(	SELECT	[USR].[Id]
			, [USR].[DocumentNumber] 
			, CONCAT([USR].[Name], ' ', [USR].[LastName])	AS FullName
			, [USR].[Name]
			, [USR].[LastName]
			, [USR].[Username]
			, [USR].[Password]
			, [USR].[IdRole]
			, [ROL].[Name]									AS RoleName
			, [ROL].[Alias]		
			, [USR].[ImageRelativePath]
			, [USR].[IsActive]
	FROM	[Security].[User]		[USR] WITH(NOLOCK)
	INNER JOIN [Security].[Role]	[ROL] WITH(NOLOCK) ON [USR].[IdRole] = [ROL].[Id]
);
GO

--*******************************************************************
--PAGEPERMISSION VIEW 
--*******************************************************************
CREATE VIEW [Security].[PagePermissionView] AS
(	SELECT	[USV].*
			, [PAG].[Id]			AS IdPage
			, [PAG].[Title]
			, [PAG].[MenuItem]
			, [PAG].[ParentId]
			, [PAG].[Icon]
			, [PPR].[IsVisible]
			, [PPR].[CanSelect]
			, [PPR].[CanEdit]
			, [PPR].[CanDelete]
			, [PPR].[IsDefault]
	FROM	[Security].[UserView]					[USV] WITH(NOLOCK)
	INNER JOIN	[Security].[PagePermissionByRole]	[PPR] WITH(NOLOCK) ON	[PPR].[IdRole]	= [USV].[IdRole]
	INNER JOIN	[Security].[Page]					[PAG] WITH(NOLOCK) ON	[PAG].[Id]		= [PPR].[IdPage]
);
GO
--*******************************************************************
--ATTENDANCE SCHEMA
--*******************************************************************
--STUDENTMOVEMENT VIEW 
--*******************************************************************
CREATE VIEW [Attendance].[StudentMovementView] AS
(	SELECT	[MOV].[DocumentNumber]						AS DocumentNumber
		, [STU].[Code]									AS Code
		, ISNULL([STU].[Name], 'Sin nombre')			AS Name
		, ISNULL([STU].[LastName], 'Sin apellido')		AS LastName
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
		, [MOV].[Id]									AS MovementId
		, [MOV].[RegisterDate]							AS MovementDateTime
		, CONVERT(DATE, [MOV].[RegisterDate])			AS MovementDate
		, CONVERT(TIME, [MOV].[RegisterDate])			AS MovementTime
FROM		[Attendance].[Movement]				[MOV] WITH(NOLOCK)
INNER JOIN	[Integration].[Student]				[STU] WITH(NOLOCK) ON [STU].[DocumentNumber] = [MOV].[DocumentNumber]
INNER JOIN	[Integration].[Space]				[SPA] WITH(NOLOCK) ON [SPA].[Id]				= [MOV].[IdSpace]
INNER JOIN	[Integration].[SpaceType]			[SPT] WITH(NOLOCK) ON [SPT].[Id]				= [SPA].[IdSpaceType] )
GO

--*******************************************************************
--TEACHERMOVEMENT VIEW 
--*******************************************************************
CREATE VIEW [Attendance].[TeacherMovementView] AS
(	SELECT	 [MOV].[DocumentNumber]							AS DocumentNumber
			, [TEA].[Code]									AS Code
			, ISNULL([TEA].[Name], 'Sin nombre')			AS Name
			, ISNULL([TEA].[LastName], 'Sin apellido')		AS LastName
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
			, [MOV].[Id]									AS MovementId
			, [MOV].[RegisterDate]							AS MovementDateTime
			, CONVERT(DATE, [MOV].[RegisterDate])			AS MovementDate
			, CONVERT(TIME, [MOV].[RegisterDate])			AS MovementTime
	FROM		[Attendance].[Movement]				[MOV] WITH(NOLOCK)
	INNER JOIN	[Integration].[Teacher]				[TEA] WITH(NOLOCK) ON [TEA].[DocumentNumber] = [MOV].[DocumentNumber]
	INNER JOIN	[Integration].[Space]				[SPA] WITH(NOLOCK) ON [SPA].[Id]				= [MOV].[IdSpace]
	INNER JOIN	[Integration].[SpaceType]			[SPT] WITH(NOLOCK) ON [SPT].[Id]				= [SPA].[IdSpaceType] )
GO

--*******************************************************************
--MOVEMENT VIEW 
--*******************************************************************
CREATE VIEW [Attendance].[MovementView] AS
(	SELECT	*
	FROM	[Attendance].[StudentMovementView] WITH(NOLOCK)
	UNION
	SELECT	*
	FROM	[Attendance].[TeacherMovementView]  WITH(NOLOCK)
);
GO

--*******************************************************************
--INTEGRATION SCHEMA 
--*******************************************************************
--ACADEMICPERIOD VIEW 
--*******************************************************************
CREATE VIEW [Integration].[AcademicPeriodView] AS(
	SELECT [ACA].[Id]
			, [ACA].[Period]
			, [ACA].[Semester]
			, CONCAT('Semestre ', [ACA].[Semester] )	AS SemesterAlias
			, [ACA].[StartDate]
			, [ACA].[EndDate]
			, DATENAME(MONTH, [ACA].[StartDate])		AS StartDateMonthName
			, DATENAME(MONTH, [ACA].[EndDate])			AS EndDateMonthName
	FROM	[Integration].[AcademicPeriod] [ACA] WITH(NOLOCK)
);

GO
--*******************************************************************
--SCHEDULEDETAIL VIEW 
--*******************************************************************
CREATE VIEW [Integration].[ScheduleDetailView] AS
(	SELECT	 [SCH].[Id]										AS ScheduleId
			, [TEA].[DocumentNumber]						AS TeacherDocumentNumber
			, CONCAT([TEA].[Name], ' ', [TEA].[LastName])	AS TeacherFullName
			, [TEA].[ImageRelativePath]
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
	FROM		[Integration].[Schedule]			[SCH] WITH(NOLOCK) 
	INNER JOIN	[Integration].[ScheduleDetail]		[SCD] WITH(NOLOCK) ON [SCD].[IdSchedule]		= [SCH].[Id]
	INNER JOIN	[Integration].[Teacher]				[TEA] WITH(NOLOCK) ON [TEA].[DocumentNumber] = [SCH].[TeacherDocumentNumber]
	INNER JOIN	[Integration].[Course]				[COU] WITH(NOLOCK) ON [COU].[Id]				= [SCH].[IdCourse]	
	INNER JOIN	[Integration].[AcademicPeriod]		[ACA] WITH(NOLOCK) ON [ACA].[Id]				= [SCH].[IdAcademicPeriod]
	INNER JOIN	[Integration].[Space]				[SPA] WITH(NOLOCK) ON [SPA].[Id]				= [SCD].[IdSpace]
	INNER JOIN	[Integration].[SpaceType]			[SPT] WITH(NOLOCK) ON [SPT].[Id]				= [SPA].[IdSpaceType])
GO

--*******************************************************************
--ENROLLMENTDETAIL VIEW 
--*******************************************************************
CREATE VIEW [Integration].[EnrollmentDetailView] AS
(	SELECT	[ENR].[Id]										AS EnrollmentId
			, [STU].[DocumentNumber]						AS StudentDocumentNumber
			, CONCAT([STU].[Name], ' ', [STU].[LastName])	AS StudentFullName
			, [STU].[ImageRelativePath]
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
	FROM		[Integration].[Enrollment]			[ENR] WITH(NOLOCK)
	INNER JOIN	[Integration].[EnrollmentDetail]	[END] WITH(NOLOCK) ON [END].[IdEnrollment]	= [ENR].Id
	INNER JOIN	[Integration].[Student]				[STU] WITH(NOLOCK) ON [STU].[DocumentNumber] = [ENR].[StudentDocumentNumber]
	INNER JOIN	[Integration].[Schedule]			[SCH] WITH(NOLOCK) ON [SCH].[Id]				= [END].[IdSchedule]
	INNER JOIN	[Integration].[ScheduleDetail]		[SCD] WITH(NOLOCK) ON [SCD].[IdSchedule]		= [SCH].[Id]
	INNER JOIN	[Integration].[Teacher]				[TEA] WITH(NOLOCK) ON [TEA].[DocumentNumber] = [SCH].[TeacherDocumentNumber]
	INNER JOIN	[Integration].[Course]				[COU] WITH(NOLOCK) ON [COU].[Id]				= [SCH].[IdCourse]	
	INNER JOIN	[Integration].[AcademicPeriod]		[ACA] WITH(NOLOCK) ON [ACA].[Id]				= [SCH].[IdAcademicPeriod]	
	INNER JOIN	[Integration].[Career]				[CAR] WITH(NOLOCK) ON [CAR].[Id]				= [STU].[IdCareer]
	INNER JOIN	[Integration].[Fringe]				[FRI] WITH(NOLOCK) ON [FRI].[Id]				= [STU].[IdFringe]
	INNER JOIN	[Integration].[EnrollmentStatus]	[ENS] WITH(NOLOCK) ON [ENS].[Id]				= [ENR].[IdEnrollmentStatus]
	INNER JOIN	[Integration].[Space]				[SPA] WITH(NOLOCK) ON [SPA].[Id]				= [SCD].[IdSpace]
	INNER JOIN	[Integration].[SpaceType]			[SPT] WITH(NOLOCK) ON [SPT].[Id]				= [SPA].[IdSpaceType])
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
	FROM		[Integration].[Enrollment]			[ENR] WITH(NOLOCK)
	LEFT JOIN	[Integration].[EnrollmentDetail]	[END] WITH(NOLOCK) ON [END].[IdEnrollment]	= [ENR].Id
	LEFT JOIN	[Integration].[Student]				[STU] WITH(NOLOCK) ON [STU].[DocumentNumber] = [ENR].[StudentDocumentNumber]
	LEFT JOIN	[Integration].[Schedule]			[SCH] WITH(NOLOCK) ON [SCH].[Id]				= [END].[IdSchedule]
	LEFT JOIN	[Integration].[ScheduleDetail]		[SCD] WITH(NOLOCK) ON [SCD].[IdSchedule]		= [SCH].[Id]
	LEFT JOIN	[Integration].[Teacher]				[TEA] WITH(NOLOCK) ON [TEA].[DocumentNumber] = [SCH].[TeacherDocumentNumber]
	LEFT JOIN	[Integration].[Course]				[COU] WITH(NOLOCK) ON [COU].[Id]				= [SCH].[IdCourse]	
	LEFT JOIN	[Integration].[AcademicPeriod]		[ACA] WITH(NOLOCK) ON [ACA].[Id]				= [SCH].[IdAcademicPeriod]	
	LEFT JOIN	[Integration].[Career]				[CAR] WITH(NOLOCK) ON [CAR].[Id]				= [STU].[IdCareer]
	LEFT JOIN	[Integration].[Fringe]				[FRI] WITH(NOLOCK) ON [FRI].[Id]				= [STU].[IdFringe]
	LEFT JOIN	[Integration].[EnrollmentStatus]	[ENS] WITH(NOLOCK) ON [ENS].[Id]				= [ENR].[IdEnrollmentStatus])
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
	FROM		[Integration].[Course]				[COU] WITH(NOLOCK)
	INNER JOIN	[Integration].[Schedule]			[SCH] WITH(NOLOCK) ON [COU].[Id]				= [SCH].[IdCourse]	
	INNER JOIN	[Integration].[ScheduleDetail]		[SCD] WITH(NOLOCK) ON [SCD].[IdSchedule]		= [SCH].[Id]
	INNER JOIN	[Integration].[Teacher]				[TEA] WITH(NOLOCK) ON [TEA].[DocumentNumber] = [SCH].[TeacherDocumentNumber]
	INNER JOIN	[Integration].[AcademicPeriod]		[ACA] WITH(NOLOCK) ON [ACA].[Id]				= [SCH].[IdAcademicPeriod]	
	INNER JOIN	[Integration].[Space]				[SPA] WITH(NOLOCK) ON [SPA].[Id]				= [SCD].[IdSpace]
	INNER JOIN	[Integration].[SpaceType]			[SPT] WITH(NOLOCK) ON [SPT].[Id]				= [SPA].[IdSpaceType])
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
			, [ImageRelativePath]
			, '3'							AS RoleId
			, 'Profesor'					AS RoleAlias
			, [SpaceId]
			, [SpaceName]
			, [SpaceType]
			, [DayOfTheWeek]
			, [StartTime]
			, [EndTime]
	FROM	[Integration].[ScheduleDetailView] [SCH] WITH(NOLOCK)
	UNION
	SELECT	[CourseId] 
			, [CourseName]
			, [StudentDocumentNumber]		AS DocumentNumber
			, [StudentFullName]				AS FullName
			, [ImageRelativePath]
			, '4'							AS RoleId
			, 'Estudiante'					AS RoleAlias
			, [SpaceId]
			, [SpaceName]
			, [SpaceType]
			, [DayOfTheWeek]
			, [StartTime]
			, [EndTime]
	FROM	[Integration].[EnrollmentDetailView] [EDV] WITH(NOLOCK)
)
GO

--*******************************************************************
--REGISTER VIEW 
--*******************************************************************
CREATE VIEW [Attendance].[AttendanceRegisterView] AS
(	
	SELECT [MOV].[MovementId]
			, [MOV].[DocumentNumber]
			, [MOV].[Code]
			, [MOV].[Name]
			, [MOV].[LastName]
			, [MOV].[FullName]
			, [MOV].[ImageRelativePath]
			, [MOV].[RoleId]
			, [MOV].[RoleName]
			, [PAV].[CourseId]
			, [PAV].[CourseName]
			, [PAV].[DayOfTheWeek]
			, [PAV].[StartTime]
			, [PAV].[EndTime]
			, [MOV].[SpaceId]
			, [MOV].[SpaceName]
			, [MOV].[SpaceType]
			, [MOV].[MovementDateTime]
			, [MOV].[MovementDate]
			, [MOV].[MovementTime]
	FROM	[Attendance].[MovementView]				[MOV] WITH(NOLOCK)
	INNER JOIN [Integration].[PersonActivitiesView] [PAV] WITH(NOLOCK) ON
		[MOV].[DocumentNumber]						= [PAV].[DocumentNumber]	AND
		[MOV].[SpaceId]								= [PAV].[SpaceId]			AND
		[MOV].[RoleId]								= [PAV].[RoleId]			AND
		DATEPART(WEEKDAY, [MOV].[MovementDate])		= [PAV].[DayOfTheWeek]
	WHERE	[MOV].[MovementTime] BETWEEN [PAV].[StartTime] AND [PAV].[EndTime]
)
GO

--*******************************************************************
--ATTENDANCE VIEW 
--*******************************************************************
CREATE VIEW [Attendance].[AttendanceView] AS
(	
	SELECT [MOV].[MovementId]
			, [MOV].[DocumentNumber]
			, [MOV].[Name]
			, [MOV].[LastName]
			, [MOV].[FullName]
			, [MOV].[ImageRelativePath]
			, [MOV].[RoleId]
			, [MOV].[RoleName]
			, [MOV].[RoleAlias]
			, [PAV].[CourseId]
			, [PAV].[CourseName]
			, [PAV].[DayOfTheWeek]
			, DATENAME(WEEKDAY, [PAV].[DayOfTheWeek] - 1)   AS DayOfTheWeekName
			, [PAV].[StartTime]
			, [PAV].[EndTime]
			, [MOV].[SpaceId]
			, [MOV].[SpaceName]
			, [MOV].[SpaceType]
			, [MOV].[MovementDateTime]
			, [MOV].[MovementDate]
			, [MOV].[MovementTime]
	FROM	[Attendance].[MovementView]				[MOV] WITH(NOLOCK)
	INNER JOIN [Integration].[PersonActivitiesView] [PAV] WITH(NOLOCK) ON
		[MOV].[DocumentNumber]						= [PAV].[DocumentNumber]	AND
		[MOV].[SpaceId]								= [PAV].[SpaceId]			AND
		[MOV].[RoleId]								= [PAV].[RoleId]			AND
		DATEPART(WEEKDAY, [MOV].[MovementDate])		= [PAV].[DayOfTheWeek]
	WHERE	[MOV].[MovementTime] BETWEEN [PAV].[StartTime] AND [PAV].[EndTime]
);
GO

--*******************************************************************
--COURSEMOVEMENT VIEW 
--*******************************************************************
CREATE VIEW [NonAttendance].[NonAttendanceRegisterView] AS
(	
	SELECT	[PAV].*
	FROM	[Integration].[PersonActivitiesView]			[PAV] WITH(NOLOCK)
	LEFT OUTER JOIN [Attendance].[AttendanceRegisterView]	[CMV] WITH(NOLOCK) ON 
		[CMV].[DocumentNumber]	= [PAV].[DocumentNumber]	AND
		[CMV].[CourseId]		= [PAV].[CourseId]			AND
		[CMV].[RoleId]			= [PAV].[RoleId]			AND
		[CMV].[SpaceId]			= [PAV].[SpaceId]			AND
		[CMV].[DayOfTheWeek]	= [PAV].[DayOfTheWeek] 
	WHERE	[CMV].[DocumentNumber] IS NULL 
			
)
GO

--*******************************************************************
--NONATTENDANCE VIEW 
--*******************************************************************
CREATE VIEW [NonAttendance].[NonAttendanceView] AS
(	
	SELECT	[NON].Id 
			, [PAV].*
			, DATENAME(WEEKDAY, [NON].[NonAttendanceDate]) AS NameDayOfTheWeek
			, [NON].[NonAttendanceDate]
			, [NON].[HasExcuse]
	FROM	[NonAttendance].[NonAttendance]				[NON] WITH(NOLOCK)
	INNER JOIN [Integration].[PersonActivitiesView]		[PAV] WITH(NOLOCK)	ON	[PAV].[DocumentNumber]		= [NON].[DocumentNumber]	AND
																				[PAV].[SpaceId]				= [NON].[IdSpace]			AND
																				[PAV].[CourseId]			= [NON].[IdCourse]			AND
																				[PAV].[RoleId]				= [NON].[IdRole]			AND
																				[PAV].[DayOfTheWeek]		= [NON].[DayOfTheWeek] 	
)
GO

--*******************************************************************
--EXCUSE VIEW 
--*******************************************************************
CREATE VIEW [NonAttendance].[ExcuseView] AS
(	
	SELECT	[EXC].[Id]
			, [EXC].[IdNonAttendance]
			, [EXC].[DocumentNumber]		AS TruantDocumentNumber
			, [NAV].[FullName]				AS TruantFullName
			, [NAV].[RoleId]				AS TruantRoleId
			, [NAV].[RoleAlias]				AS TruantRoleAlias
			, [NAV].[CourseId]				
			, [NAV].[CourseName]				
			, [NAV].[DayOfTheWeek]
			, [NAV].[NameDayOfTheWeek]
			, [NAV].[SpaceId]
			, [NAV].[SpaceName]
			, [NAV].[SpaceType]
			, [NAV].[StartTime]
			, [NAV].[EndTime]
			, [NAV].[NonAttendanceDate]
			, [NAV].[HasExcuse]
			, [EXC].[IdRole]
			, [EXC].[IdStatus]
			, [STA].[Status]
			, [STA].[IsLast]
			, [EXC].[IdClassification]
			, [CLA].[Classification]
			, [EXC].[Justification]		AS ExcuseJustification
			, [EXC].[Observation]		AS ExcuseObservation
	FROM	[NonAttendance].[Excuse]				[EXC] WITH(NOLOCK)
	INNER JOIN [NonAttendance].[NonAttendanceView]	[NAV] WITH(NOLOCK)	ON [NAV].[Id] = [EXC].[IdNonAttendance]
	INNER JOIN [NonAttendance].[Classification]		[CLA] WITH(NOLOCK)	ON [CLA].[Id] = [EXC].[IdClassification]
	INNER JOIN [NonAttendance].[Status]				[STA] WITH(NOLOCK)	ON [STA].[Id] = [EXC].[IdStatus]
 );
GO

--*******************************************************************
--EXCUSEAPPROVAL VIEW 
--*******************************************************************
CREATE VIEW [NonAttendance].[ExcuseApprovalView] AS
(	
	SELECT	[EXA].[Id]
			, [EXA].[IdExcuse]
			, [EXA].[IdStatus]				AS IdStatusApproval
			, [STA].[Status]				AS StatusApproval
			, [EXA].[Approver]
			, CASE 
				WHEN [EXA].[IdRole] = 3 
					THEN  	( SELECT	TOP 1 CONCAT([TEA].[Name], ' ', [TEA].[LastName]) 
							FROM	[Integration].[Teacher] [TEA] WITH(NOLOCK) 
							WHERE	[TEA].[DocumentNumber] = [EXA].[Approver] )
					ELSE ( SELECT	TOP 1 CONCAT([USR].[Name], ' ', [USR].[LastName]) 
							FROM	[Security].[User] [USR] WITH(NOLOCK) 
							WHERE	[USR].[DocumentNumber] = [EXA].[Approver] )
				END							AS ApproverFullName
			, [EXA].[IdRole]				AS IdRoleApprover
			, [EXA].[Observation]			AS ApproverObservation
			, [EXV].[IdNonAttendance]
			, [EXV].[TruantDocumentNumber]
			, [NAV].[FullName]				AS TruantFullName
			, [NAV].[RoleId]				AS TruantRoleId
			, [NAV].[RoleAlias]				AS TruantRoleAlias
			, [NAV].[CourseId]				
			, [NAV].[CourseName]				
			, [NAV].[DayOfTheWeek]
			, [NAV].[NameDayOfTheWeek]
			, [NAV].[SpaceId]
			, [NAV].[SpaceName]
			, [NAV].[SpaceType]
			, [NAV].[StartTime]
			, [NAV].[EndTime]
			, [NAV].[NonAttendanceDate]
			, [NAV].[HasExcuse]
			, [EXV].[IdStatus]				AS IdStatusExcuse
			, [EXV].[Status]				AS StatusExcuse
			, [EXV].[IdClassification]		AS IdClassificationExcuse
			, [EXV].[Classification]		AS ClassificationExcuse
			, [EXV].[ExcuseJustification]	
			, [EXV].[ExcuseObservation]	
	FROM	[NonAttendance].[ExcuseApproval]		[EXA] WITH(NOLOCK)
	INNER JOIN [NonAttendance].[Status]				[STA] WITH(NOLOCK) ON [STA].[Id] = [EXA].[IdStatus]
	INNER JOIN [NonAttendance].[ExcuseView]			[EXV] WITH(NOLOCK) ON [EXV].[Id] = [EXA].[IdExcuse]
	INNER JOIN [NonAttendance].[NonAttendanceView]	[NAV] WITH(NOLOCK) ON [NAV].[Id] = [EXV].[IdNonAttendance]
 );
GO

--*******************************************************************
--CLASSIFICATIONBYROLE VIEW 
--*******************************************************************
CREATE VIEW [NonAttendance].[StatusByRoleView] AS
(	
	SELECT	[SRB].[IdStatus]
			, [STA].[Status]
			, [SRB].[IdRole]
			, [ROL].[Name]		AS RoleName
			, [ROL].[Alias]		AS RoleAlias
			, [STA].[IsLast]
			, [SRB].[IsVisible]
	FROM	[NonAttendance].[StatusByRole]	[SRB] WITH(NOLOCK)
	INNER JOIN [Security].[Role]			[ROL] WITH(NOLOCK) ON [ROL].[Id]	= [SRB].[IdRole]
	INNER JOIN [NonAttendance].[Status]		[STA] WITH(NOLOCK) ON [STA].[Id]	= [SRB].[IdStatus]
 );
GO
--*******************************************************************
--CLASSIFICATIONBYROLE VIEW 
--*******************************************************************
CREATE VIEW [NonAttendance].[ClassificationByRoleView] AS
(	
	SELECT	[CBR].[IdClassification]
			, [CLA].[Classification]
			, [CBR].[IdRole]
			, [ROL].[Name]		AS RoleName
			, [ROL].[Alias]		AS RoleAlias
			, [CLA].[IsRequiredDescription]
	FROM	[NonAttendance].[ClassificationByRole]	[CBR] WITH(NOLOCK)
	INNER JOIN [Security].[Role]					[ROL] WITH(NOLOCK) ON [ROL].[Id]= [CBR].[IdRole]
	INNER JOIN [NonAttendance].[Classification]		[CLA] WITH(NOLOCK) ON [CLA].[Id] = [CBR].[IdClassification]
 );
GO
--*******************************************************************