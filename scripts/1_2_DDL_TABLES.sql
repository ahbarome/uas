--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description: Data definition for tables
--*******************************************************************
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
--SECURITY SCHEMA
--*******************************************************************
--ROLE TABLE 
--*******************************************************************
CREATE TABLE [Security].[Role](
	[Id] 			[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] 			[nvarchar](80) 		NOT NULL,
	[Alias] 		[nvarchar](150) 	NULL,
	[RegisterDate] 	[datetime] 			NULL)
GO

ALTER TABLE [Security].[Role] ADD  CONSTRAINT [DF_Role_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--USER TABLE 
--*******************************************************************
CREATE TABLE [Security].[User](
	[Id] 					[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[DocumentNumber]		[int]				NOT NULL,
	[Username] 				[nvarchar](80) 		NOT NULL,
	[Password] 				[nvarchar](150) 	NOT NULL,
	[IdRole] 				INT 				NOT NULL,
	[Name] 					[nvarchar](150) 	NULL,
	[LastName] 				[nvarchar](150) 	NULL,
	[Email] 				[nvarchar](150) 	NULL,
	[TelephoneNumber] 		INT 				NULL,
	[ImageRelativePath]		[nvarchar](256)		NULL,
	[IsActive] 				BIT					NOT NULL,
	[RegisterDate] 			[datetime] 			NULL,
	[CreatedBy] 			[nvarchar](80) 		NOT NULL,
	[LastModiticationDate] 	[datetime] 			NULL,
	[ModifiedBy] [nvarchar](80) 				NULL,
	CONSTRAINT Fk_RoleUser FOREIGN KEY  (IdRole) REFERENCES [Security].[Role](Id)
	)
GO

ALTER TABLE [Security].[User] ADD  CONSTRAINT [DF_User_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--USER TABLE 
--*******************************************************************
CREATE TABLE [Security].[Page](
	[Id] 				[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Title] 			[nvarchar](50) 		NOT NULL,
	[MenuItem] 			[nvarchar](200)		NOT NULL,
	[ParentId] 			[int]	 			NULL,
	[Icon] 				[nvarchar](80) 		NULL,
	[Order] 			[int]	 			NULL,
	[RegisterDate] 		[datetime] 			NULL)
GO

ALTER TABLE [Security].[Page] ADD  CONSTRAINT [DF_Page_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--PAGEPERMISSIONBYROLE TABLE 
--*******************************************************************
CREATE TABLE [Security].[PagePermissionByRole](
	[IdPage] 			[int] 		NOT NULL,
	[IdRole] 			[int] 		NOT NULL,
	[IsDefault]			BIT 		NOT NULL,
	[IsVisible]			BIT 		NOT NULL,
	[CanEdit] 			BIT 		NOT NULL,
	[CanUpdate] 		BIT			NOT NULL,
	[CanSelect] 		BIT			NOT NULL,
	[CanDelete] 		BIT			NOT NULL,
	CONSTRAINT Pk_PagePermissionByRole PRIMARY KEY ([IdPage], [IdRole]),
	CONSTRAINT Fk_RolePagePermission FOREIGN KEY  ([IdRole]) REFERENCES [Security].[Role](Id),
	CONSTRAINT Fk_PagePermission FOREIGN KEY  ([IdPage]) REFERENCES [Security].[Page](Id)
);
GO

--*******************************************************************
--INTEGRATION SCHEMA
--*******************************************************************
--*******************************************************************
--CAREER TABLE 
--*******************************************************************
CREATE TABLE [Integration].[Career](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Code]						INT					NOT NULL,
	[Name]						[nvarchar](250)		NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [Integration].[Career] ADD  CONSTRAINT [DF_Career_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--FRINGE TABLE 
--*******************************************************************
CREATE TABLE [Integration].[Fringe](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Name]						[nvarchar](250)		NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [Integration].[Fringe] ADD  CONSTRAINT [DF_Fringe_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--STUDENT TABLE 
--*******************************************************************
CREATE TABLE [Integration].[Student](
	[DocumentNumber]			INT					PRIMARY KEY NOT NULL,
	[Code]						INT					NOT NULL,
	[Name] 						[nvarchar](150) 	NULL,
	[LastName] 					[nvarchar](150) 	NULL,
	[Email] 					[nvarchar](150) 	NULL,
	[TelephoneNumber] 			INT 				NULL,
	[Address] 					[nvarchar](250) 	NULL,
	[ImageRelativePath]			[nvarchar](256)		NULL,
	[IdCareer]					INT					NOT NULL,
	[IdFringe]					INT					NOT NULL, --NOT SURE IF WE PUT THIS HERE
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_Student_IdCareer FOREIGN KEY  (IdCareer) REFERENCES [Integration].[Career](Id),
	CONSTRAINT Fk_Student_IdFringe FOREIGN KEY  (IdFringe) REFERENCES [Integration].[Fringe](Id)
);
GO

ALTER TABLE  [Integration].[Student] ADD  CONSTRAINT [DF_Student_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--TEACHER TABLE 
--*******************************************************************
CREATE TABLE [Integration].[Teacher](
	[DocumentNumber]			INT					PRIMARY KEY NOT NULL,
	[Code]						INT					NOT NULL,
	[Name] 						[nvarchar](150) 	NULL,
	[LastName] 					[nvarchar](150) 	NULL,
	[Email] 					[nvarchar](150) 	NULL,
	[TelephoneNumber] 			INT 				NULL,
	[Address] 					[nvarchar](250) 	NULL,
	[ImageRelativePath]			[nvarchar](256)		NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [Integration].[Teacher] ADD  CONSTRAINT [DF_Teacher_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--COURSE TABLE 
--*******************************************************************
CREATE TABLE [Integration].[Course](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Code]						INT					NOT NULL,
	[Name]						[nvarchar](250)		NOT NULL,
	[NumberOfCredits]			INT					NOT NULL,
	[Semester]			INT					NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [Integration].[Course] ADD  CONSTRAINT [DF_Course_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--SPACETYPE TABLE 
--*******************************************************************
CREATE TABLE [Integration].[SpaceType](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Type]						[nvarchar](250)		NOT NULL,
	[Description]				[nvarchar](250)		NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [Integration].[SpaceType] ADD  CONSTRAINT [DF_SpaceType_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--SPACETYPE TABLE 
--*******************************************************************
CREATE TABLE [Integration].[Space](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Name]						[nvarchar](250)		NOT NULL,
	[IdSpaceType]				[int]				NOT NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_Space_IdSpaceType FOREIGN KEY  (IdSpaceType) REFERENCES [Integration].[SpaceType](Id)
);
GO

ALTER TABLE  [Integration].[Space] ADD  CONSTRAINT [DF_Space_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--ACADEMICPERIOD TABLE 
--*******************************************************************
CREATE TABLE [Integration].[AcademicPeriod](
	[Id]						INT			PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Period]					INT			NOT NULL,
	[Semester]					INT			NOT NULL,
	[StartDate]					DATETIME	NOT NULL,
	[EndDate]					DATETIME	NOT NULL,
	[RegisterDate] 				[datetime] 	NULL
);
GO

ALTER TABLE  [Integration].[AcademicPeriod] ADD  CONSTRAINT [DF_AcademicPeriod_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--SCHEDULE TABLE 
--*******************************************************************
CREATE TABLE [Integration].[Schedule](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[TeacherDocumentNumber]		INT					NOT NULL,
	[IdCourse]					INT					NOT NULL,
	[IdAcademicPeriod]			INT					NOT NULL,
	[Description]				[NVARCHAR](100)		NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_Schedule_TeacherDocumentNumber FOREIGN KEY  (TeacherDocumentNumber) REFERENCES [Integration].[Teacher](DocumentNumber),
	CONSTRAINT Fk_Schedule_IdCourse FOREIGN KEY  (IdCourse) REFERENCES [Integration].[Course](Id),
	CONSTRAINT Fk_Schedule_IdAcademicPeriod FOREIGN KEY  (IdAcademicPeriod) REFERENCES [Integration].[AcademicPeriod](Id)
);
GO

ALTER TABLE  [Integration].[Schedule] ADD  CONSTRAINT [DF_Schedule_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO


--*******************************************************************
--SCHEDULEDETAIL TABLE 
--*******************************************************************
CREATE TABLE [Integration].[ScheduleDetail](
	[Id]						INT			PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[IdSchedule]				INT			NOT NULL,
	[IdSpace]					INT			NOT NULL,
	[DayOfTheWeek]				INT			NOT NULL,
	[StartTime]					TIME		NOT NULL,
	[EndTime]					TIME		NOT NULL,
	[RegisterDate] 				[datetime] 	NULL,
	CONSTRAINT Fk_Schedule_IdSchedule FOREIGN KEY  (IdSchedule) REFERENCES [Integration].[Schedule](Id),
	CONSTRAINT Fk_Schedule_IdSpaceType FOREIGN KEY  (IdSpace) REFERENCES [Integration].[Space](Id)
);
GO

ALTER TABLE  [Integration].[ScheduleDetail] ADD  CONSTRAINT [DF_ScheduleDetail_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--SCHEDULEDETAIL TABLE 
--*******************************************************************
CREATE TABLE [Integration].[EnrollmentStatus](
	[Id] 			[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] 			[nvarchar](80) 		NOT NULL,
	[Observation]	[nvarchar](250)		NULL,
	[RegisterDate] 	[datetime] 			NULL);
GO

ALTER TABLE [Integration].[EnrollmentStatus] ADD  CONSTRAINT [DF_EnrollmentStatus_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--ENROLLMENT TABLE 
--*******************************************************************
CREATE TABLE [Integration].[Enrollment](
	[Id]						INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[StudentDocumentNumber]		INT			NOT NULL,
	[IdEnrollmentStatus]		INT			NOT NULL,
	[IdAcademicPeriod]			INT			NOT NULL,
	[RegisterDate]				[DATETIME]	NOT NULL,
	CONSTRAINT Fk_Enrollment_IdStudent FOREIGN KEY  (StudentDocumentNumber) REFERENCES [Integration].[Student](DocumentNumber),
	CONSTRAINT Fk_Enrollment_IdEnrollmentStatus FOREIGN KEY  (IdEnrollmentStatus) REFERENCES [Integration].[EnrollmentStatus](Id),
	CONSTRAINT Fk_Enrollment_IdAcademicPeriod FOREIGN KEY  (IdAcademicPeriod) REFERENCES [Integration].[AcademicPeriod](Id)
);
GO

ALTER TABLE [Integration].[Enrollment] ADD  CONSTRAINT [DF_Enrollment_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--ENROLLMENTDETAIL TABLE 
--*******************************************************************
CREATE TABLE [Integration].[EnrollmentDetail](
	[Id]				[int]			IDENTITY(1,1) NOT NULL,
	[IdEnrollment]		[int]			NOT NULL,
	[IdSchedule]		[int]			NOT NULL,
	[RegisterDate]		[datetime]		NOT NULL,
	CONSTRAINT Fk_EnrollmentDetail_IdEnrollment FOREIGN KEY  (IdEnrollment) REFERENCES [Integration].[Enrollment](Id),
	CONSTRAINT Fk_EnrollmentDetail_IdSchedule FOREIGN KEY  (IdSchedule) REFERENCES [Integration].[Schedule](Id)
);
GO

ALTER TABLE [Integration].[EnrollmentDetail] ADD  CONSTRAINT [DF_EnrollmentDetail_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--HOLIDAY TABLE 
--*******************************************************************
CREATE TABLE [Integration].[HolidayException](
	[Id]						INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ExceptionDate]				[DATETIME] NOT NULL
);
GO

--*******************************************************************
--ATTENDANCE SCHEMA
--*******************************************************************
--MOVEMENT TABLE 
--*******************************************************************
CREATE TABLE [Attendance].[Movement](
	[Id] 						[int]			IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[IdSpace]					[int]			NOT NULL,
	[DocumentNumber] 			[int]			NOT NULL,
	[RegisterDate] 				[datetime] 		NULL,
	CONSTRAINT Fk_Movement_IdSpace FOREIGN KEY  ([IdSpace]) REFERENCES [Integration].[Space](Id)
);
GO

ALTER TABLE  [Attendance].[Movement] ADD  CONSTRAINT [DF_Movement_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO
--*******************************************************************
--*******************************************************************
--NOONATTENDANCE TABLE 
--*******************************************************************
--*******************************************************************
--STATUS TABLE 
--*******************************************************************
CREATE TABLE [NonAttendance].[Status](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Status]					[nvarchar](150) 	NULL,
	[IsLast]					[bit]				NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [NonAttendance].[Status] ADD  CONSTRAINT [DF_Status_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--STATUSBYROLE TABLE 
--*******************************************************************
CREATE TABLE [NonAttendance].[StatusByRole](
	[IdStatus]					INT 				NOT NULL,
	[IdRole] 					INT 				NOT NULL,
	[IsVisible] 				BIT 				NOT NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Pk_StatusByRole PRIMARY KEY ([IdStatus], [IdRole]),
	CONSTRAINT Fk_StatusByRole_IdStatus FOREIGN KEY  (IdStatus) REFERENCES [NonAttendance].[Status](Id),
	CONSTRAINT Fk_StatusByRole_IdRole FOREIGN KEY  (IdRole) REFERENCES [Security].[Role](Id),
);
GO

ALTER TABLE  [NonAttendance].[StatusByRole] ADD  CONSTRAINT [DF_StatusByRole_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--CLASSIFICATION TABLE 
--*******************************************************************
CREATE TABLE [NonAttendance].[Classification](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Classification]			[nvarchar](150) 	NULL,
	[IsRequiredDescription]		[bit]				NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [NonAttendance].[Classification] ADD  CONSTRAINT [DF_ExcuseClassification_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--CLASSIFICATIONBYROLE TABLE 
--*******************************************************************
CREATE TABLE [NonAttendance].[ClassificationByRole](
	[IdClassification]			INT 				NOT NULL,
	[IdRole] 					INT 				NOT NULL,
	[IsVisible] 				BIT 				NOT NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Pk_ClassificationByRole PRIMARY KEY ([IdClassification], [IdRole]),
	CONSTRAINT Fk_ClassificationByRole_IdStatus FOREIGN KEY  (IdClassification) REFERENCES [NonAttendance].[Classification](Id),
	CONSTRAINT Fk_ClassificationByRole_IdRole FOREIGN KEY  (IdRole) REFERENCES [Security].[Role](Id),
);
GO

ALTER TABLE  [NonAttendance].[ClassificationByRole] ADD  CONSTRAINT [DF_ClassificationByRole_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--NONATTENDANCE TABLE 
--*******************************************************************
CREATE TABLE [NonAttendance].[NonAttendance](
	[Id] 							[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[DocumentNumber]				[int]				NOT NULL,
	[IdRole]						[int]				NOT NULL,
	[IdCourse]						[int]				NOT NULL,
	[IdSpace]						[int]				NOT NULL,
	[DayOfTheWeek]					[int]				NOT NULL,
	[StartTime]						[time]				NOT NULL,
	[EndTime]						[time]				NOT NULL,
	[NonAttendanceDate]				[date]				NOT NULL,
	[HasExcuse]						[bit]				NOT NULL,
	[RegisterDate]					[datetime]			NULL,
	CONSTRAINT Fk_NonAttendance_IdRole FOREIGN KEY  (IdRole) REFERENCES [Security].[Role](Id),
	CONSTRAINT Fk_NonAttendance_IdCourse FOREIGN KEY  (IdCourse) REFERENCES [Integration].[Course](Id),
	CONSTRAINT Fk_NonAttendance_IdSpace FOREIGN KEY  (IdSpace) REFERENCES [Integration].[Space](Id),
)
GO

ALTER TABLE  [NonAttendance].[NonAttendance] ADD  CONSTRAINT [DF_NonAttendance_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--EXCUSE TABLE 
--*******************************************************************
CREATE TABLE [NonAttendance].[Excuse](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[IdNonAttendance]			[int]				NOT NULL,
	[DocumentNumber]			[int]				NOT NULL,
	[IdRole]					[int]				NOT NULL,
	[IdStatus]					[int]				NOT NULL,
	[IdClassification]			[int]				NOT NULL,
	[Justification]				[nvarchar](MAX) 	NULL,
	[Observation]				[nvarchar](MAX) 	NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_Excuse_IdRole FOREIGN KEY  (IdRole) REFERENCES [Security].[Role](Id),
	CONSTRAINT Fk_Excuse_IdNonAttendance FOREIGN KEY  (IdNonAttendance) REFERENCES [NonAttendance].[NonAttendance](Id),
	CONSTRAINT Fk_Excuse_IdStatus FOREIGN KEY  (IdStatus) REFERENCES [NonAttendance].[Status](Id),
	CONSTRAINT Fk_Excuse_IdClassification FOREIGN KEY  (IdClassification) REFERENCES [NonAttendance].[Classification](Id)
);
GO

ALTER TABLE  [NonAttendance].[Excuse] ADD  CONSTRAINT [DF_NonAttendanceExcuse_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--EXCUSEAPPROVAL TABLE 
--*******************************************************************
CREATE TABLE [NonAttendance].[ExcuseApproval](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[IdExcuse]					[int]				NOT NULL,
	[IdStatus]					[int]				NOT NULL,
	[Approver]					[int]				NOT NULL,
	[IdRole]					[int]				NOT NULL,
	[Observation]				[nvarchar](MAX) 	NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_ExcuseApproval_IdRole FOREIGN KEY  (IdRole) REFERENCES [Security].[Role](Id),
	CONSTRAINT Fk_ExcuseApproval_IdExcuse FOREIGN KEY  (IdExcuse) REFERENCES [NonAttendance].[Excuse](Id),
	CONSTRAINT Fk_ExcuseApproval_IdState FOREIGN KEY  (IdStatus) REFERENCES [NonAttendance].[Status](Id)
)
GO

ALTER TABLE  [NonAttendance].[ExcuseApproval] ADD  CONSTRAINT [DF_ExcuseApproval_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************
--ATTACHMENT TABLE 
--*******************************************************************
CREATE TABLE [NonAttendance].[Attachment](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[IdExcuse]					[int]				NOT NULL,
	[Path]						[nvarchar](150) 	NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_AttachmentIdExcuse FOREIGN KEY  (IdExcuse) REFERENCES [NonAttendance].[Excuse](Id)
)
GO

ALTER TABLE  [NonAttendance].[Attachment] ADD  CONSTRAINT [DF_ExcuseAttachment_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************