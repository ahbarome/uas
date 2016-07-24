CREATE DATABASE [UAS]
GO

ALTER DATABASE [UAS] SET ENABLE_BROKER 
GO
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
CREATE SCHEMA Security

CREATE TABLE [Security].[Role](
	[Id] 			[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] 			[nvarchar](80) 		NOT NULL,
	[Alias] 		[nvarchar](150) 	NULL,
	[RegisterDate] 	[datetime] 			NULL)
GO

ALTER TABLE [Security].[Role] ADD  CONSTRAINT [DF_Role_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Administrator', 'Administrador')
INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Director', 'Director')
INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Teacher', 'Profesor')
INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Student', 'Estudiante')


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

INSERT INTO [Security].[User]([DocumentNumber],[Username], [Password], [IdRole], [IsActive], [CreatedBy]) VALUES (1130677677, 'admin', 'NXo/ao4xL5ix30tACkl6jg==', 1, 1, 'admin') 
INSERT INTO [Security].[User]([DocumentNumber],[Username], [Password], [IdRole], [IsActive], [CreatedBy]) VALUES (980034765, 'dmarin', 'NXo/ao4xL5ix30tACkl6jg==', 1, 1, 'admin') 


--DROP TABLE [Security].[Page]
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

INSERT INTO [Security].[Page]([Title], [MenuItem], [Icon])  VALUES('Dashboard', '~/Home', 'fa fa-th-large' )
INSERT INTO [Security].[Page]([Title], [MenuItem], [Icon])  VALUES('Asistencia', '#', 'fa fa-th-large' )
INSERT INTO [Security].[Page]([Title], [MenuItem], [ParentId])  VALUES('Aula Virtual', '~/Attendance/VirtualStudentsClassRoom', 2 )
INSERT INTO [Security].[Page]([Title], [MenuItem], [ParentId])  VALUES('Salón de Docentes', '~/Attendance/VirtualTeachersClassRoom', 2 )
INSERT INTO [Security].[Page]([Title], [MenuItem], [Icon])  VALUES('Ausentismo', '#', 'fa fa-th-large' )
INSERT INTO [Security].[Page]([Title], [MenuItem], [ParentId])  VALUES('Creacar Excusa', '#', 5 )
INSERT INTO [Security].[Page]([Title], [MenuItem], [ParentId])  VALUES('Administrar Excusas', '#', 5 )
INSERT INTO [Security].[Page]([Title], [MenuItem], [Icon])  VALUES('Reportes', '#', 'fa fa-th-large' )
INSERT INTO [Security].[Page]([Title], [MenuItem], [ParentId])  VALUES('Asistencia', '#', 8 )
INSERT INTO [Security].[Page]([Title], [MenuItem], [ParentId])  VALUES('Ausentismo', '#', 8 )

--DROP TABLE [Security].[PagePermissionByRole]
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
	 )
GO

INSERT INTO [Security].[PagePermissionByRole] VALUES(1,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(2,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(3,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(4,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(5,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(6,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(7,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(8,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(9,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(10,1,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(11,1,1,1,1,1,1,1)

INSERT INTO [Security].[PagePermissionByRole] VALUES(1,2,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(2,2,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(4,2,1,1,1,1,1,1)

--*******************************************************************
CREATE SCHEMA Attendance

--DROP TABLE [Attendance].[Movement]
--The foreign key was not create because the movement could be from a no registered user
CREATE TABLE [Attendance].[Movement](
	[Id] 						[int]			IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[DocumentNumber] 			[int]			NOT NULL,
	[RegisterDate] 				[datetime] 		NULL
)

ALTER TABLE  [Attendance].[Movement] ADD  CONSTRAINT [DF_Movement_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************

CREATE SCHEMA NonAttendance

CREATE TABLE [NonAttendance].[Status](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Status]					[nvarchar](150) 	NULL,
	[IsLast]					[bit]				NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
)

ALTER TABLE  [NonAttendance].[Status] ADD  CONSTRAINT [DF_Status_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [NonAttendance].[Status]([Status],[IsLast]) VALUES('Pendiente', 0)
INSERT INTO [NonAttendance].[Status]([Status],[IsLast]) VALUES('Aceptada', 1)
INSERT INTO [NonAttendance].[Status]([Status],[IsLast]) VALUES('Para corrección', 0)
INSERT INTO [NonAttendance].[Status]([Status],[IsLast]) VALUES('Rechazada', 1)

--DROP TABLE [NonAttendance].[StatusApproverByRole]
CREATE TABLE [NonAttendance].[StatusApproverByRole](
	[IdStatus]					INT 				NOT NULL,
	[IdRole] 					INT 				NOT NULL,
	[IsVisible] 				BIT 				NOT NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Pk_StatusApproverByRole PRIMARY KEY ([IdStatus], [IdRole]),
	CONSTRAINT Fk_StatusApproverByRole_IdStatus FOREIGN KEY  (IdStatus) REFERENCES [NonAttendance].[Status](Id),
	CONSTRAINT Fk_StatusApproverByRole_IdRole FOREIGN KEY  (IdRole) REFERENCES [Security].[Role](Id),
)

ALTER TABLE  [NonAttendance].[StatusApproverByRole] ADD  CONSTRAINT [DF_StatusApproverByRole_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [NonAttendance].[StatusApproverByRole]([IdStatus],[IdRole],[IsVisible]) VALUES(1, 3, 1)
INSERT INTO [NonAttendance].[StatusApproverByRole]([IdStatus],[IdRole],[IsVisible]) VALUES(1, 4, 0)
INSERT INTO [NonAttendance].[StatusApproverByRole]([IdStatus],[IdRole],[IsVisible]) VALUES(2, 2, 1)
INSERT INTO [NonAttendance].[StatusApproverByRole]([IdStatus],[IdRole],[IsVisible]) VALUES(2, 3, 1)
INSERT INTO [NonAttendance].[StatusApproverByRole]([IdStatus],[IdRole],[IsVisible]) VALUES(3, 2, 1)
INSERT INTO [NonAttendance].[StatusApproverByRole]([IdStatus],[IdRole],[IsVisible]) VALUES(3, 3, 1)
INSERT INTO [NonAttendance].[StatusApproverByRole]([IdStatus],[IdRole],[IsVisible]) VALUES(3, 4, 0)
INSERT INTO [NonAttendance].[StatusApproverByRole]([IdStatus],[IdRole],[IsVisible]) VALUES(4, 2, 1)
INSERT INTO [NonAttendance].[StatusApproverByRole]([IdStatus],[IdRole],[IsVisible]) VALUES(4, 3, 1)


--DROP TABLE [NonAttendance].[Classification]
CREATE TABLE [NonAttendance].[Classification](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Classification]			[nvarchar](150) 	NULL,
	[IsRequiredDescription]		[bit]				NULL,
	[RegisterDate] 				[datetime] 			NULL
)

ALTER TABLE  [NonAttendance].[Classification] ADD  CONSTRAINT [DF_ExcuseClassification_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [NonAttendance].[Classification]([Classification],[IsRequiredDescription]) VALUES('Inconveniente médico', 0)
INSERT INTO [NonAttendance].[Classification]([Classification],[IsRequiredDescription]) VALUES('Inconveniente familiar', 0)
INSERT INTO [NonAttendance].[Classification]([Classification],[IsRequiredDescription]) VALUES('Inconveniente económico', 0)
INSERT INTO [NonAttendance].[Classification]([Classification],[IsRequiredDescription]) VALUES('Otro', 1)

--DROP TABLE [NonAttendance].[Excuse]
CREATE TABLE [NonAttendance].[Excuse](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[IdStatus]					[int]				NOT NULL,
	[IdClassification]			[int]				NOT NULL,
	[IdUserOwner]				[int]				NOT NULL,
	[Justification]				[nvarchar](MAX) 	NULL,
	[Observation]				[nvarchar](MAX) 	NULL,
	[CreatedBy] 				[nvarchar](80) 		NOT NULL,
	[RegisterDate] 				[datetime] 			NULL,
	[ModifiedBy] 				[nvarchar](80) 		NOT NULL,
	[LastModificationDate] 		[datetime] 			NULL,
	CONSTRAINT Fk_ExcuseStatus FOREIGN KEY  (IdStatus) REFERENCES [NonAttendance].[Status](Id),
	CONSTRAINT Fk_ExcuseClassification FOREIGN KEY  (IdClassification) REFERENCES [NonAttendance].[Classification](Id),
	CONSTRAINT Fk_ExcuseIdUserOwner FOREIGN KEY  (IdUserOwner) REFERENCES [Security].[User](Id)
)

ALTER TABLE  [NonAttendance].[Excuse] ADD  CONSTRAINT [DF_NonAttendanceExcuse_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--DROP TABLE [NonAttendance].[ExcuseDetail]
CREATE TABLE [NonAttendance].[ExcuseDetail](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[IdExcuse]					[int]				NOT NULL,
	[IdStatus]					[int]				NOT NULL,
	[IdUserApprover]			[int]				NOT NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_ExcuseIdExcuse FOREIGN KEY  (IdExcuse) REFERENCES [NonAttendance].[Excuse](Id),
	CONSTRAINT Fk_ExcuseDetailState FOREIGN KEY  (IdStatus) REFERENCES [NonAttendance].[Status](Id),
	CONSTRAINT Fk_ExcuseDetailIdUserApprover FOREIGN KEY  (IdUserApprover) REFERENCES [Security].[User](Id)
)
GO

ALTER TABLE  [NonAttendance].[ExcuseDetail] ADD  CONSTRAINT [DF_NonAttendanceExcuseDetail_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--DROP TABLE [NonAttendance].[Attachment]
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
CREATE SCHEMA Integration

--Career
--=> Name
CREATE TABLE [Integration].[Career](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Code]						INT					NOT NULL,
	[Name]						[nvarchar](250)		NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);

ALTER TABLE  [Integration].[Career] ADD  CONSTRAINT [DF_Career_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[Career]([Id], [Code], [Name]) VALUES(1, 3743, 'Ingeniería de Sistemas'); 
INSERT INTO [Integration].[Career]([Id], [Code], [Name]) VALUES(2, 3753, 'Ingeniería Industrial'); 


--Fringe (Franja: Diurno, Nocturno)
CREATE TABLE [Integration].[Fringe](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Name]						[nvarchar](250)		NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [Integration].[Fringe] ADD  CONSTRAINT [DF_Fringe_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[Fringe]([Id], [Name]) VALUES(1, 'Diurno');
INSERT INTO [Integration].[Fringe]([Id], [Name]) VALUES(2, 'Nocturno');


--Student
--=>DocumentNumber, Name, LastName, IdCareer, IdFringe
CREATE TABLE [Integration].[Student](
	[DocumentNumber]			INT					PRIMARY KEY NOT NULL,
	[Code]						INT					NOT NULL,
	[Name] 						[nvarchar](150) 	NULL,
	[LastName] 					[nvarchar](150) 	NULL,
	[Email] 					[nvarchar](150) 	NULL,
	[TelephoneNumber] 			INT 				NULL,
	[Address] 					[nvarchar](250) 	NULL,
	[IdCareer]					INT					NOT NULL,
	[IdFringe]					INT					NOT NULL, --NOT SURE IF WE PUT THIS HERE
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_Student_IdCareer FOREIGN KEY  (IdCareer) REFERENCES [Integration].[Career](Id),
	CONSTRAINT Fk_Student_IdFringe FOREIGN KEY  (IdFringe) REFERENCES [Integration].[Fringe](Id)
);

--ALTER TABLE [Integration].[Student] ADD [ImageRelativePath] NVARCHAR(256)

ALTER TABLE  [Integration].[Student] ADD  CONSTRAINT [DF_Student_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [IdCareer], [IdFringe] ) VALUES(1144402939, 117200, 'Pedro Alexis', 'Alegría', 1, 2);
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [IdCareer], [IdFringe] ) VALUES(1130402236, 117201, 'Ginna Alejandra', 'Chacón', 1, 2);
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [IdCareer], [IdFringe] ) VALUES(1130412231, 117202, 'Carlos Andrés', 'Aguirre', 1, 2);
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [IdCareer], [IdFringe] ) VALUES(98412031, 1172003, 'Mauricio Andrés', 'López', 1, 2);
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [IdCareer], [IdFringe] ) VALUES(30412234, 117204, 'Luis Alejandro', 'Parra Urrea', 1, 2);
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [IdCareer], [IdFringe] ) VALUES(1130419934, 117205, 'Yolany', 'Molina', 2, 2);


--Teacher
--=>DocumentNumber, Name, LastName
CREATE TABLE [Integration].[Teacher](
	[DocumentNumber]			INT					PRIMARY KEY NOT NULL,
	[Code]						INT					NOT NULL,
	[Name] 						[nvarchar](150) 	NULL,
	[LastName] 					[nvarchar](150) 	NULL,
	[Email] 					[nvarchar](150) 	NULL,
	[TelephoneNumber] 			INT 				NULL,
	[Address] 					[nvarchar](250) 	NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO


ALTER TABLE  [Integration].[Teacher] ADD  CONSTRAINT [DF_Teacher_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName]) VALUES(980034765, 101100, 'Diego Fernando', 'Marín');
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName]) VALUES(90394760, 101101, 'Carlos Arturo', 'Cano');
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName]) VALUES(31263799, 101102, 'María Mercedes', 'Sinisterra');
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName]) VALUES(1263229, 101103, 'Gonzalo', 'Becerra');

--Course
--=> Name, CreditsNumber
CREATE TABLE [Integration].[Course](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Name]						[nvarchar](250)		NOT NULL,
	[NumberOfCredits]			INT					NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [Integration].[Course] ADD  CONSTRAINT [DF_Course_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(1, 'Cálculo Diferencial', 3);
INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(2, 'Cálculo Integral', 3);
INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(3, 'Cálculo Multivariado', 3);
INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(4, 'Programación Orientada a Objetos', 3);
INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(5, 'Sistemas Operativos', 3);
INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(6, 'Base de Datos', 3);
INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(7, 'Investigación de Operaciones', 3);
INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(8, 'Fisica Mecánica y Laboratorio', 3);
INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(9, 'Fisica Térmica y Laboratorio', 3);
INSERT INTO [Integration].[Course]([Id], [Name], [NumberOfCredits]) VALUES(10, 'Fisica Eléctrica y Laboratorio', 3);

--AcademicPeriod
--=> Period
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

INSERT INTO [Integration].[AcademicPeriod]([Period], [Semester], [StartDate], [EndDate]) VALUES(2016, 1, '2016-01-02', '2016-01-06');
INSERT INTO [Integration].[AcademicPeriod]([Period], [Semester], [StartDate], [EndDate]) VALUES(2016, 2, '2016-01-08', '2016-01-12');

--Schedule
--=>Id, IdTeacher, IdCourse, IdAcademicPeriod, StartDate, EndDate 
--DROP TABLE [Integration].[Schedule]
CREATE TABLE [Integration].[Schedule](
	[Id]						INT					PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[TeacherDocumentNumber]		INT					NOT NULL,
	[IdCourse]					INT					NOT NULL,
	[IdAcademicPeriod]			INT					NOT NULL,
	[Description]				[NVARCHAR](100)		NULL,
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_Schedule_TeacherDocumentNumber FOREIGN KEY  (TeacherDocumentNumber) REFERENCES [Integration].[Teacher](DocumentNumber),
	CONSTRAINT Fk_Schedule_IdCourse FOREIGN KEY  (IdCourse) REFERENCES [Integration].[Course](Id),
	CONSTRAINT Fk_Schedule_IdAcademicPeriod FOREIGN KEY  (IdAcademicPeriod) REFERENCES [Integration].[AcademicPeriod](Id)
);

ALTER TABLE  [Integration].[Schedule] ADD  CONSTRAINT [DF_Schedule_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(980034765, 4, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(980034765, 5, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(980034765, 6, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(1263229, 8, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(1263229, 9, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(1263229, 10, 2);


--ScheduleDetail
-->IdSchedule, WeekDay, StartTime, EndTime
--DROP TABLE [Integration].[ScheduleDetail]
CREATE TABLE [Integration].[ScheduleDetail](
	[Id]						INT			PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[IdSchedule]				INT			NOT NULL,
	[DayOfTheWeek]				INT			NOT NULL,
	[StartTime]					TIME		NOT NULL,
	[EndTime]					TIME		NOT NULL,
	[RegisterDate] 				[datetime] 	NULL,
	CONSTRAINT Fk_Schedule_IdSchedule FOREIGN KEY  (IdSchedule) REFERENCES [Integration].[Schedule](Id)
);

ALTER TABLE  [Integration].[ScheduleDetail] ADD  CONSTRAINT [DF_ScheduleDetail_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(1,1,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(1,5,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(2,2,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(3,2,'18:30:00', '21:30:00');

CREATE TABLE [Integration].[EnrollmentStatus](
	[Id] 			[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] 			[nvarchar](80) 		NOT NULL,
	[Observation]	[nvarchar](250)		NULL,
	[RegisterDate] 	[datetime] 			NULL)
GO

ALTER TABLE [Integration].[EnrollmentStatus] ADD  CONSTRAINT [DF_EnrollmentStatus_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[EnrollmentStatus]([Name]) VALUES('Pendiente por pago');
INSERT INTO [Integration].[EnrollmentStatus]([Name]) VALUES('Activa');
INSERT INTO [Integration].[EnrollmentStatus]([Name]) VALUES('Cancelada');


--Enrollment (Matrícula)
--=> Id, IdStudent, IdEnrollmentStatus (Cancelada, Activa, Pendiente por pago), RegisterDate
--DROP TABLE [Integration].[Enrollment]
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

INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(1144402939, 2, 2);
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(1130402236, 2, 2);
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(1130412231, 2, 2);
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(1130419934, 2, 1);

--EnrollmentDetail (Matrícula)
--=> IdEnrollment, IdSchedule, RegisterDate 
--DROP TABLE [Integration].[EnrollmentDetail]
CREATE TABLE [Integration].[EnrollmentDetail](
	[Id]				[int]			IDENTITY(1,1) NOT NULL,
	[IdEnrollment]		[int]			NOT NULL,
	[IdSchedule]		[int]			NOT NULL,
	[RegisterDate]		[datetime]		NOT NULL,
	CONSTRAINT Fk_EnrollmentDetail_IdEnrollment FOREIGN KEY  (IdEnrollment) REFERENCES [Integration].[Enrollment](Id),
	CONSTRAINT Fk_EnrollmentDetail_IdSchedule FOREIGN KEY  (IdSchedule) REFERENCES [Integration].[Schedule](Id)
);

	
ALTER TABLE [Integration].[EnrollmentDetail] ADD  CONSTRAINT [DF_EnrollmentDetail_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[EnrollmentDetail]([IdEnrollment], [IdSchedule]) VALUES(1, 1);
INSERT INTO [Integration].[EnrollmentDetail]([IdEnrollment], [IdSchedule]) VALUES(1, 2);
INSERT INTO [Integration].[EnrollmentDetail]([IdEnrollment], [IdSchedule]) VALUES(1, 3);
INSERT INTO [Integration].[EnrollmentDetail]([IdEnrollment], [IdSchedule]) VALUES(2, 1);
INSERT INTO [Integration].[EnrollmentDetail]([IdEnrollment], [IdSchedule]) VALUES(2, 2);
INSERT INTO [Integration].[EnrollmentDetail]([IdEnrollment], [IdSchedule]) VALUES(2, 3);
INSERT INTO [Integration].[EnrollmentDetail]([IdEnrollment], [IdSchedule]) VALUES(3, 3);
INSERT INTO [Integration].[EnrollmentDetail]([IdEnrollment], [IdSchedule]) VALUES(4, 1);
--HolidayException
--Id, Date
CREATE TABLE [Integration].[HolidayException](
	[Id]						INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ExceptionDate]				[DATETIME] NOT NULL
);

INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-15-08');
INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-17-10');
INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-07-11');
INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-14-11');
--*******************************************************************


SELECT * FROM [Security].[User]
SELECT * FROM [Security].[Role]
SELECT * FROM [Security].[Page]
SELECT * FROM [Security].[PagePermissionByRole]

--SELECT * FROM [Attendance].[Trace]
SELECT * FROM [Attendance].[Movement]

SELECT * FROM [NonAttendance].[Status]
SELECT * FROM [NonAttendance].[StatusApproverByRole]

--*******************************************************************
SELECT * FROM [Integration].[StudentEnrollmentView]
CREATE VIEW [Integration].[StudentEnrollmentView] AS
SELECT	[STU].[DocumentNumber]							AS StudentDocumentNumber
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
		, CASE	WHEN [SCD].[DayOfTheWeek] = 1 THEN 'Lunes' 
				WHEN [SCD].[DayOfTheWeek] = 2 THEN 'Martes' 
				WHEN [SCD].[DayOfTheWeek] = 3 THEN 'Miércoles'
				WHEN [SCD].[DayOfTheWeek] = 4 THEN 'Jueves'
				WHEN [SCD].[DayOfTheWeek] = 5 THEN 'Viernes'
				WHEN [SCD].[DayOfTheWeek] = 6 THEN 'Sábado'
				END										AS DayOfTheWeekName
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
LEFT JOIN	[Integration].[EnrollmentStatus]	[ENS] ON [ENS].[Id]				= [ENR].[IdEnrollmentStatus]


