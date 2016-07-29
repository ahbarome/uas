--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description: Helper query
--*******************************************************************
SELECT * FROM [Security].[User]
SELECT * FROM [Security].[Role]
SELECT * FROM [Security].[Page]
SELECT * FROM [Security].[PagePermissionByRole]
SELECT * FROM [Attendance].[Movement]
SELECT * FROM [Integration].[Course]
SELECT * FROM [Integration].[Schedule]
SELECT * FROM [Integration].[Enrollment]
SELECT * FROM [NonAttendance].[Status]
SELECT * FROM [NonAttendance].[StatusApproverByRole]
SELECT * FROM [Integration].[ScheduleDetailView]
SELECT * FROM [Integration].[EnrollmentDetailView]

SELECT	* 
FROM	Integration.ScheduleDetailView
WHERE	DayOfTheWeek = [Integration].[GetCurrentDay]()

SELECT	*
FROM	[Integration].[GetStudentsSummaryByCourseId](13)

SELECT	*
FROM	[Integration].[EnrollmentDetailView] [EDV]
WHERE	[EDV].[DayOfTheWeek] = [Integration].[GetCurrentDay]()

SELECT	* 
FROM	[Attendance].[MovementView]
WHERE	DocumentNumber IN (SELECT DocumentNumber FROM [Attendance].[GetTodayMovements]())

SELECT	* 
FROM	Integration.GetCurrentCoursesByTeacherDocumentNumber(1130677685)

SELECT	* 
FROM	[Integration].[GetCurrentCoursesByDate](CONVERT(DATE, GETDATE()))