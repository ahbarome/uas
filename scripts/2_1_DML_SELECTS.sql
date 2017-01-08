--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description: Helper query
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
SELECT * FROM [Security].[User]
SELECT * FROM [Security].[Role]
SELECT * FROM [Security].[Page]
SELECT * FROM [Security].[PagePermissionByRole]
SELECT * FROM [Attendance].[Movement]
SELECT * FROM [Integration].[AcademicPeriod]
SELECT * FROM [Integration].[Course]
SELECT * FROM [Integration].[Schedule]
SELECT * FROM [Integration].[Enrollment]
SELECT * FROM [Integration].[EnrollmentDetail]
SELECT * FROM [NonAttendance].[Status]
SELECT * FROM [NonAttendance].[StatusApproverByRole]
SELECT * FROM [Integration].[ScheduleDetailView]
SELECT * FROM [Integration].[EnrollmentDetailView]

-- Get the current Academic Period
SELECT * 
FROM Integration.GetCurrentAcademicPeriod()

SELECT	* 
FROM	Integration.ScheduleDetailView
WHERE	AcademicPeriod = ( SELECT Period
						FROM Integration.GetCurrentAcademicPeriod()) 
		AND DayOfTheWeek = [Integration].[GetCurrentDay]()

SELECT	*
FROM	[Integration].[EnrollmentDetailView] [EDV]
WHERE	AcademicPeriod = ( SELECT Period
						FROM Integration.GetCurrentAcademicPeriod()) 
		AND DayOfTheWeek = [Integration].[GetCurrentDay]()


SELECT  [Integration].[GetCurrentDay]()

SELECT	*
FROM	[Integration].[GetCourseSummaryById](13)


SELECT	*
FROM	[Integration].[GetCoursesWithTotalStudents]()

SELECT	*
FROM	[Integration].[GetCourseWithTotalStudentsById](13)


SELECT	* 
FROM	[Attendance].[MovementView]
WHERE	DocumentNumber IN (SELECT DocumentNumber FROM [Attendance].[GetMovementsByDate](CONVERT(DATE, GETDATE()-1)))

SELECT	* 
FROM	Integration.GetCurrentCoursesByTeacherDocumentNumber(1130677682)

SELECT	* 
FROM	[Integration].[GetCoursesByDate](CONVERT(DATE, GETDATE()))

SELECT TOP 10 *
FROM	[NonAttendance].[StatusByRoleView]

SELECT TOP 10 *
FROM	[NonAttendance].[ClassificationByRoleView]


SELECT *
FROM	[Attendance].[AttendanceView]

SELECT TOP 10 *
FROM	[NonAttendance].[NonAttendanceView] 
WHERE	[RoleId] = 4

SELECT TOP 10 *
FROM	[NonAttendance].[ExcuseApproval] 

SELECT TOP 10 *
FROM	[NonAttendance].[ExcuseApprovalView] 

SELECT	*
FROM	[Security].[PagePermissionView]
ORDER BY [IdRole], [DocumentNumber], [IdPage]


SELECT TOP 5 [ATV].CourseId						AS CourseId
	, [ATV].CourseName						AS CourseName
	, [ATV].DocumentNumber					AS PersonDocumentNumber
	, [ATV].FullName						AS PersonFullName
	, [ATV].RoleId							AS PersonRoleId
	, [ATV].RoleAlias						AS PersonRoleAlias
	, COUNT( 1 )							AS EventTotal
FROM	[Attendance].[AttendanceView] [ATV]
GROUP BY  [ATV].CourseId		
		, [ATV].CourseName		
		, [ATV].DocumentNumber	
		, [ATV].FullName		
		, [ATV].RoleId			
		, [ATV].RoleAlias	
ORDER BY	COUNT( 1 )	DESC

SELECT TOP 5 [NAV].CourseId						AS CourseId
	, [NAV].CourseName						AS CourseName
	, [NAV].DocumentNumber					AS PersonDocumentNumber
	, [NAV].FullName						AS PersonFullName
	, [NAV].RoleId							AS PersonRoleId
	, [NAV].RoleAlias						AS PersonRoleAlias
	, COUNT( 1 )							AS EventTotal
FROM	[NonAttendance].[NonAttendanceView] [NAV]
GROUP BY  [NAV].CourseId		
		, [NAV].CourseName		
		, [NAV].DocumentNumber	
		, [NAV].FullName		
		, [NAV].RoleId			
		, [NAV].RoleAlias	
ORDER BY	COUNT( 1 )	DESC


SELECT DISTINCT NonAttendanceDate
		, CourseId
		, CourseName
		, (SELECT TOP 1 TeacherFullName FROM [Integration].[GetTeacherByCourse] (CourseId) ) TeacherFullName
		, MAX(EventTotal) AS EventTotal
FROM (
		SELECT DATENAME(MONTH, [NAV].[NonAttendanceDate])	AS NonAttendanceDate
			, [NAV].CourseId								AS CourseId
			, [NAV].CourseName								AS CourseName
			, COUNT( 1 )									AS EventTotal
		FROM	[NonAttendance].[NonAttendanceView] [NAV]
		GROUP BY  DATENAME(MONTH, [NAV].[NonAttendanceDate])
				, [NAV].CourseId		
				, [NAV].CourseName		) AS Summary
GROUP BY NonAttendanceDate
		, CourseId
		, CourseName
HAVING CONCAT(NonAttendanceDate, MAX(EventTotal)) IN (
							SELECT DISTINCT CONCAT(NonAttendanceDate, MAX(EventTotal)) AS EventTotal
							FROM (
							SELECT DATENAME(MONTH, [NAV].[NonAttendanceDate])	AS NonAttendanceDate
									, [NAV].CourseId								AS CourseId
									, [NAV].CourseName								AS CourseName
									, COUNT( 1 )									AS EventTotal
							FROM	[NonAttendance].[NonAttendanceView] [NAV]
							GROUP BY  DATENAME(MONTH, [NAV].[NonAttendanceDate] )
									, [NAV].CourseId		
									, [NAV].CourseName		) AS Summary
							GROUP BY NonAttendanceDate ) 

