CREATE DATABASE [UAS]
GO

ALTER DATABASE [UAS] SET ENABLE_BROKER 
ALTER DATABASE [UAS] SET ALLOW_SNAPSHOT_ISOLATION ON
ALTER DATABASE [UAS] SET READ_COMMITTED_SNAPSHOT ON
ALTER DATABASE [UAS] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [UAS] COLLATE SQL_Latin1_General_CP1_CS_AS
ALTER DATABASE [UAS] SET MULTI_USER

GO
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
CREATE SCHEMA Security
GO

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

SELECT * FROM [Security].[User]
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('gbecerra','NXo/ao4xL5ix30tACkl6jg==',3,'Gonzalo','Becerra','gonzalo.becerra@unilibrecali.edu.co',311001113,1,'admin',1130677677,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('msinisterra','NXo/ao4xL5ix30tACkl6jg==',3,'María Mercedes','Sinisterra','maria.mercedes.sinisterra@unilibrecali.edu.co',311001114,1,'admin',1130677678,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('ccano','NXo/ao4xL5ix30tACkl6jg==',3,'Carlos Arturo','Cano','carlos.arturo.cano@unilibrecali.edu.co',311001115,1,'admin',1130677679,'~/Images/a5.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('dmarin','NXo/ao4xL5ix30tACkl6jg==',3,'Diego Fernando','Marín','diego.fernando.marin@unilibrecali.edu.co',311001116,1,'admin',1130677680,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('wmagana','NXo/ao4xL5ix30tACkl6jg==',3,'Walter','Magaña','walter.magana@unilibrecali.edu.co',311001117,1,'admin',1130677681,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('mdawood','NXo/ao4xL5ix30tACkl6jg==',3,'Muhammed','Dawood','muhammed.dawood@unilibrecali.edu.co',311001118,1,'admin',1130677682,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('ggonzalez','NXo/ao4xL5ix30tACkl6jg==',3,'Geremías','Gonzalez','geremias.gonzalez@unilibrecali.edu.co',311001119,1,'admin',1130677683,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('fvelez','NXo/ao4xL5ix30tACkl6jg==',3,'Fernando','Velez','fernando.velez@unilibrecali.edu.co',311001120,1,'admin',1130677684,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('flondono','NXo/ao4xL5ix30tACkl6jg==',3,'Fredy Wilson','Londoño','fredy.wilson.londono@unilibrecali.edu.co',311001121,1,'admin',1130677685,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('pchacon','NXo/ao4xL5ix30tACkl6jg==',3,'Pablo','Chacón','pablo.chacon@unilibrecali.edu.co',311001122,1,'admin',1130677686,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('jcruz','NXo/ao4xL5ix30tACkl6jg==',3,'Juan Carlos','Cruz','juan.carlos.cruz@unilibrecali.edu.co',311001123,1,'admin',1130677687,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('eecheverri','NXo/ao4xL5ix30tACkl6jg==',3,'Enrique','Echeverri','enrique.echeverri@unilibrecali.edu.co',311001124,1,'admin',1130677688,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('lrancruel','NXo/ao4xL5ix30tACkl6jg==',3,'Liliana','Rancruel','liliana.rancruel@unilibrecali.edu.co',311001125,1,'admin',1130677689,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('gcordoba','NXo/ao4xL5ix30tACkl6jg==',3,'Germán','Cordoba','german.cordoba@unilibrecali.edu.co',311001126,1,'admin',1130677690,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('rmoreno','NXo/ao4xL5ix30tACkl6jg==',3,'Rafael','Moreno','rafael.moreno@unilibrecali.edu.co',311001127,1,'admin',1130677691,'~/Images/a7.jpg')
INSERT INTO [Security].[User]([Username],[Password],[IdRole],[Name],[LastName],[Email],[TelephoneNumber], [IsActive], [CreatedBy],[DocumentNumber], [ImageRelativePath]) VALUES ('fcastillo','NXo/ao4xL5ix30tACkl6jg==',3,'Fabian','Castillo','fabian.castillo@unilibrecali.edu.co',311001128,1,'admin',1130677692,'~/Images/a7.jpg')



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
INSERT INTO [Security].[Page]([Title], [MenuItem], [ParentId])  VALUES('Crear Excusa', '#', 5 )
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
);
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

INSERT INTO [Security].[PagePermissionByRole] VALUES(1,2,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(2,2,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(4,2,1,1,1,1,1,1)
GO

--*******************************************************************
CREATE SCHEMA Attendance
GO

--DROP TABLE [Attendance].[Movement]
--The foreign key was not create because the movement could be from a no registered user
CREATE TABLE [Attendance].[Movement](
	[Id] 						[int]			IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[DocumentNumber] 			[int]			NOT NULL,
	[RegisterDate] 				[datetime] 		NULL
);
GO

ALTER TABLE  [Attendance].[Movement] ADD  CONSTRAINT [DF_Movement_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--*******************************************************************

CREATE SCHEMA NonAttendance
GO

CREATE TABLE [NonAttendance].[Status](
	[Id] 						[int]				IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Status]					[nvarchar](150) 	NULL,
	[IsLast]					[bit]				NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

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
);
GO


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
);
GO

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
);
GO

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
CREATE SCHEMA Integration;
GO

--Career
--=> Name
CREATE TABLE [Integration].[Career](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Code]						INT					NOT NULL,
	[Name]						[nvarchar](250)		NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

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
	[ImageRelativePath]			[nvarchar](256)		NULL,
	[IdCareer]					INT					NOT NULL,
	[IdFringe]					INT					NOT NULL, --NOT SURE IF WE PUT THIS HERE
	[RegisterDate] 				[datetime] 			NULL,
	CONSTRAINT Fk_Student_IdCareer FOREIGN KEY  (IdCareer) REFERENCES [Integration].[Career](Id),
	CONSTRAINT Fk_Student_IdFringe FOREIGN KEY  (IdFringe) REFERENCES [Integration].[Fringe](Id)
);
GO

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
	[ImageRelativePath]			[nvarchar](256)		NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO


ALTER TABLE  [Integration].[Teacher] ADD  CONSTRAINT [DF_Teacher_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677677,101100,'Gonzalo','Becerra','gonzalo.becerra@unilibrecali.edu.co',311001113,'Cra. 37a #3-29','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677678,101101,'María Mercedes','Sinisterra','maria.mercedes.sinisterra@unilibrecali.edu.co',311001114,'Cra. 37a #3-30','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677679,101102,'Carlos Arturo','Cano','carlos.arturo.cano@unilibrecali.edu.co',311001115,'Cra. 37a #3-31','~/Images/a5.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677680,101103,'Diego Fernando','Marín','diego.fernando.marin@unilibrecali.edu.co',311001116,'Cra. 37a #3-32','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677681,101104,'Walter','Magaña','walter.magana@unilibrecali.edu.co',311001117,'Cra. 37a #3-33','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677682,101105,'Muhammed','Dawood','muhammed.dawood@unilibrecali.edu.co',311001118,'Cra. 37a #3-34','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677683,101106,'Geremías','Gonzalez','geremias.gonzalez@unilibrecali.edu.co',311001119,'Cra. 37a #3-35','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677684,101107,'Fernando','Velez','fernando.velez@unilibrecali.edu.co',311001120,'Cra. 37a #3-36','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677685,101108,'Fredy Wilson','Londoño','fredy.wilson.londono@unilibrecali.edu.co',311001121,'Cra. 37a #3-37','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677686,101109,'Pablo','Chacón','pablo.chacon@unilibrecali.edu.co',311001122,'Cra. 37a #3-38','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677687,101110,'Juan Carlos','Cruz','juan.carlos.cruz@unilibrecali.edu.co',311001123,'Cra. 37a #3-39','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677688,101111,'Enrique','Echeverri','enrique.echeverri@unilibrecali.edu.co',311001124,'Cra. 37a #3-40','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677689,101112,'Liliana','Rancruel','liliana.rancruel@unilibrecali.edu.co',311001125,'Cra. 37a #3-41','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677690,101113,'Germán','Cordoba','german.cordoba@unilibrecali.edu.co',311001126,'Cra. 37a #3-42','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677691,101114,'Rafael','Moreno','rafael.moreno@unilibrecali.edu.co',311001127,'Cra. 37a #3-43','~/Images/a7.jpg')
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677692,101115,'Fabian','Castillo','fabian.castillo@unilibrecali.edu.co',311001128,'Cra. 37a #3-43','~/Images/a7.jpg')



--Course
--=> Name, CreditsNumber
CREATE TABLE [Integration].[Course](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Code]						INT					NOT NULL,
	[Name]						[nvarchar](250)		NOT NULL,
	[NumberOfCredits]			INT					NOT NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [Integration].[Course] ADD  CONSTRAINT [DF_Course_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--DBCC CHECKIDENT ('Integration.Course', RESEED, 0);  

INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(1,10000,'Álgebra y Trigonometría',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(2,10001,'Introdución a la Ingeniería',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(3,10002,'Geometría Descriptiva',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(4,10003,'Lógica y Algoritmos',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(5,10004,'Aprendizaje Autónomo',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(6,10005,'Inglés I',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(7,10006,'Cátedra Unilibrista',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(8,10007,'Instituciones Colombianas',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(9,10008,'Calculo Diferencial',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(10,10009,'Física Mecánica y Laboratorio',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(11,10010,'Lógica Matemática',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(12,10011,'Estructura de Lenguajes',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(13,10012,'Lenguaje y Comunicación',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(14,10013,'Inglés II',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(15,10014,'Calculo Integral',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(16,10015,'Física Térmica y Laboratorio',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(17,10016,'Arquitectura de Computadores',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(18,10017,'Pensamiento Sistémico',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(19,10018,'Estructura de Datos',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(20,10019,'Inglés III',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(21,10020,'Calculo Multivariado-Vectorial',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(22,10021,'Electricidad y Magnetismo y Laboratorio',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(23,10022,'Sistemas Operativos',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(24,10023,'Análisis y Diseño de Sistemas',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(25,10024,'Programación Orientada a Objetos',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(26,10025,'Inglés IV',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(27,10026,'Introducción a la Investigación',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(28,10027,'Ecuaciones Diferenciales',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(29,10028,'Circuitos Digitales',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(30,10029,'Redes de Computadores',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(31,10030,'Bases de Datos',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(32,10031,'Inglés V',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(33,10032,'Metodología de la Investigación',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(34,10033,'Arquitectura de Software',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(35,10034,'Química General y Laboratorio',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(36,10035,'Estadística Descriptiva',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(37,10036,'Métodos Numéricos',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(38,10037,'Sistemas Distribuidos',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(39,10038,'Electiva de Formación Integral I',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(40,10039,'Investigación Aplicada I',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(41,10040,'Estadística Inferencial',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(42,10041,'Programación Lineal',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(43,10042,'Fundamentos de la Economía',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(44,10043,'Ética',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(45,10044,'Electiva de Formación Integral II',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(46,10045,'Investigación Aplicada II',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(47,10046,'Electiva Profesional I',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(48,10047,'Sistemas de Información',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(49,10048,'Sistemas Multimedia',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(50,10049,'Investigación de Operaciones',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(51,10050,'Ingeniería Económica',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(52,10051,'Aplicaciones en Internet',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(53,10052,'Electiva de Formación Integral III',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(54,10053,'Investigación Aplicada III',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(55,10054,'Electiva Profesional II',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(56,10055,'Proyección Social',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(57,10056,'Dinámica de Sistemas',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(58,10057,'Métricas de Software',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(59,10058,'Formulación y Evaluación de Proyectos',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(60,10059,'Investigación Aplicada IV',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(61,10060,'Electiva Profesional III',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(62,10061,'Práctica Empresarial',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(63,10062,'Gestión de Tecnología',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(64,10063,'Gestión y Control de Calidad',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(65,10064,'Investigación Aplicada V',1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(66,10065,'Electiva Profesional IV',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(67,10066,'Administración Empresarial',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(68,10067,'Fundamentos de Informática',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(69,10068,'Electiva de Informática Aplicada I',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(70,10069,'Dibujo Asistido',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(71,10070,'Electiva de Informática Aplicada II',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(72,10071,'Química Industrial y Laboratorio',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(73,10072,'Procesos Industriales',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(74,10073,'Contabilidad y Presupuesto',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(75,10074,'Fundamentos de Administración',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(76,10075,'Costos de Producción',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(77,10076,'Mercadeo Básico',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(78,10077,'Ingenieria de Métodos',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(79,10078,'Planeación y Organización de la Producción',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(80,10079,'Control Estadístico de Calidad',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(81,10080,'Mercadeo Estratégico',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(82,10081,'Legislación Empresarial y Laboral',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(83,10082,'Modelos Matemáticos de Producción',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(84,10083,'Gestion Financiera',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(85,10084,'Control de ProducciónEmpresarial y Laboral',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(86,10085,'Diseño de Plantas',3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(87,10086,'Psicología Empresarial',2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits]) VALUES(88,10087,'Gerencia de Talento Humano',3);


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
GO

ALTER TABLE  [Integration].[Schedule] ADD  CONSTRAINT [DF_Schedule_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(980034765, 4, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(980034765, 5, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(980034765, 6, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(1263229, 8, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(1263229, 9, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(1263229, 10, 2);
INSERT INTO [Integration].[Schedule]([TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(1130677692, 17, 2);


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
GO

ALTER TABLE  [Integration].[ScheduleDetail] ADD  CONSTRAINT [DF_ScheduleDetail_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(1,1,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(1,5,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(2,2,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(3,2,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(7,4,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(4,1,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(5,3,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(6,5,'18:30:00', '21:30:00');
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(7,6,'7:30:00', '9:30:00');

CREATE TABLE [Integration].[EnrollmentStatus](
	[Id] 			[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] 			[nvarchar](80) 		NOT NULL,
	[Observation]	[nvarchar](250)		NULL,
	[RegisterDate] 	[datetime] 			NULL);
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
GO

	
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
--DROP TABLE [Integration].[HolidayException]
CREATE TABLE [Integration].[HolidayException](
	[Id]						INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ExceptionDate]				[DATETIME] NOT NULL
);
GO

INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-08-15');
INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-10-17');
INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-11-07');
INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-11-14');



INSERT INTO [Attendance].[Movement]([DocumentNumber]) VALUES(1130419934)
INSERT INTO [Attendance].[Movement]([DocumentNumber]) VALUES(1144402939)
INSERT INTO [Attendance].[Movement]([DocumentNumber]) VALUES(980034765)
--*******************************************************************


SELECT * FROM [Security].[User]
SELECT * FROM [Security].[Role]
SELECT * FROM [Security].[Page]
SELECT * FROM [Security].[PagePermissionByRole]

--SELECT * FROM [Attendance].[Trace]
SELECT * FROM [Attendance].[Movement]
SELECT * FROM [Integration].[Course]
SELECT * FROM [Integration].[Schedule]
SELECT * FROM [Integration].[Enrollment]
SELECT * FROM [NonAttendance].[Status]
SELECT * FROM [NonAttendance].[StatusApproverByRole]

--SELECT * FROM [Integration].[ScheduleDetailView]
--SELECT * FROM [Integration].[EnrollmentDetailView]

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
		, [MOV].[RegisterDate]							AS MovementDateTime
		, CONVERT(DATE, [MOV].[RegisterDate])			AS MovementDate
		, CONVERT(TIME, [MOV].[RegisterDate])			AS MovementTime
FROM		[Attendance].[Movement]				[MOV]
INNER JOIN	[Integration].[Student]				[STU] ON [STU].[DocumentNumber] = [MOV].[DocumentNumber]


CREATE VIEW [Attendance].[TeacherMovementView] AS
SELECT	 [MOV].[DocumentNumber]							AS DocumentNumber
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
		, [MOV].[RegisterDate]							AS MovementDateTime
		, CONVERT(DATE, [MOV].[RegisterDate])			AS MovementDate
		, CONVERT(TIME, [MOV].[RegisterDate])			AS MovementTime
FROM		[Attendance].[Movement]				[MOV]
INNER JOIN	[Integration].[Teacher]				[TEA] ON [TEA].[DocumentNumber] = [MOV].[DocumentNumber]
GO

--SELECT * FROM [Attendance].[MovementView] 
CREATE VIEW [Attendance].[MovementView] AS
SELECT	*
FROM	[Attendance].[StudentMovementView]
UNION
SELECT	*
FROM	[Attendance].[TeacherMovementView]

--SELECT * FROM [Integration].[ScheduleDetailView] 
CREATE VIEW [Integration].[ScheduleDetailView] AS
SELECT	 [SCH].[Id]										AS ScheduleId
		, [TEA].[DocumentNumber]						AS TeacherDocumentNumber
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
FROM		[Integration].[Schedule]			[SCH] 
LEFT JOIN	[Integration].[ScheduleDetail]		[SCD] ON [SCD].[IdSchedule]		= [SCH].[Id]
LEFT JOIN	[Integration].[Teacher]				[TEA] ON [TEA].[DocumentNumber] = [SCH].[TeacherDocumentNumber]
LEFT JOIN	[Integration].[Course]				[COU] ON [COU].[Id]				= [SCH].[IdCourse]	
LEFT JOIN	[Integration].[AcademicPeriod]		[ACA] ON [ACA].[Id]				= [SCH].[IdAcademicPeriod]
	

--SELECT * FROM [Integration].[EnrollmentDetailView]
CREATE VIEW [Integration].[EnrollmentDetailView] AS
SELECT	[ENR].[Id]										AS EnrollmentId
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



--SELECT * FROM [Integration].[StudentEnrollmentView]
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
LEFT JOIN	[Integration].[EnrollmentStatus]	[ENS] ON [ENS].[Id]				= [ENR].[IdEnrollmentStatus]


--

USE [UAS]
GO

/****** Object:  StoredProcedure [Attendance].[GetAllStudentMovementsByTeacherDocumentNumber]    Script Date: 25/07/2016 12:52:14 ******/
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
--[Attendance].[GetAllStudentMovementsByTeacherDocumentNumber] 980034765
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

	--Apply refactoring make a function
	IF( DATEPART(MONTH, GETDATE()) > 6)
	BEGIN
		SET @CurrentSemester = 2;
	END
	ELSE
		SET @CurrentSemester = 1;

	SET @CurrentDayOfTheWeek = DATEPART(WEEKDAY, GETDATE());

	--==================================================
	--Apply refactoring make a function or openquery
	SELECT		 @CourseStartTime = [SCD].[StartTime]
				, @CourseEndTime = [SCD].[EndTime]
				, @CourseId = [COU].[Id]
	FROM		[Integration].[Schedule]			[SCH] WITH(NOLOCK)
	INNER JOIN	[Integration].[ScheduleDetail]		[SCD] WITH(NOLOCK) ON [SCD].[IdSchedule]		= [SCH].[Id]
	INNER JOIN	[Integration].[AcademicPeriod]		[ACA] ON [ACA].[Id]								= [SCH].[IdAcademicPeriod]	
	INNER JOIN	[Integration].[Course]				[COU] WITH(NOLOCK) ON [COU].[Id]				= [SCH].[IdCourse] 
	WHERE	[ACA].[Semester]				= @CurrentSemester AND
			--@TODO: Enable this after tests
			--[SCD].[DayOfTheWeek]			= @CurrentDayOfTheWeek AND 
			[SCH].[TeacherDocumentNumber]	= @TeacherDocumentNumber


	--Get the movements of the current day
	DECLARE MovementsCursor CURSOR FOR
		SELECT	DISTINCT [MOV].[DocumentNumber]
				, CONVERT(DATE, MIN( [MOV].[RegisterDate] ))
				, CONVERT(TIME, MIN( [MOV].[RegisterDate] ))
		FROM	[Attendance].[Movement] [MOV] WITH(NOLOCK)
		WHERE	CONVERT(DATE, [MOV].[RegisterDate]) = CONVERT(DATE, GETDATE())
		GROUP BY [MOV].[DocumentNumber];
	
	OPEN MovementsCursor;
	
	FETCH NEXT FROM MovementsCursor   
	INTO @CurrentDocumentNumberOfTheMovement, @CurrentDateOfTheMovement, @CurrentTimeOfTheMovement;

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
				[SEV].[StudentDocumentNumber]	= @CurrentDocumentNumberOfTheMovement;   
		
		FETCH NEXT FROM MovementsCursor INTO @CurrentDocumentNumberOfTheMovement, @CurrentDateOfTheMovement, @CurrentTimeOfTheMovement;
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




--

USE [UAS]
GO

/****** Object:  StoredProcedure [Attendance].[GetAllStudentMovementsByTeacherDocumentNumber]    Script Date: 25/07/2016 12:52:14 ******/
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
--[Integration].[GetCurrentCourseByTeacherDocumentNumber] 980034765
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
			[SDV].[DayOfTheWeek] = DATEPART(WEEKDAY, GETDATE())	AND -- Course for today
			( [SDV].[EndTime] >= CONVERT(TIME, GETDATE()) AND  [SDV].[StartTime] <=  CONVERT(TIME, GETDATE())) AND-- Current course
			[SDV].[TeacherDocumentNumber] = @TeacherDocumentNumber 
	ORDER BY [SDV].[StartTime] DESC
END
GO


USE [UAS]
GO

/****** Object:  StoredProcedure [Attendance].[GetAllStudentMovementsByTeacherDocumentNumberAndCourseId]    Script Date: 26/07/2016 21:33:40 ******/
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
 --[Attendance].[GetAllStudentMovementsByTeacherDocumentNumberAndCourseId]  980034765, 6
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

	--Apply refactoring make a function
	IF( DATEPART(MONTH, GETDATE()) > 6)
	BEGIN
		SET @CurrentSemester = 2;
	END
	ELSE
		SET @CurrentSemester = 1;

	SET @CurrentDayOfTheWeek = DATEPART(WEEKDAY, GETDATE());

	--==================================================
	
	SELECT  TOP 1 @CourseStartTime		= [EDV].[StartTime]
				, @CourseEndTime	= [EDV].[EndTime]
				, @CourseId			= [EDV].[CourseId] 
	FROM	[Integration].[EnrollmentDetailView] [EDV]
	WHERE	( [EDV].EndDate >= GETDATE() AND 
			[EDV].StartDate <= GETDATE() ) AND-- Materias del semestre
			[EDV].DayOfTheWeek = DATEPART(WEEKDAY, GETDATE()) AND -- Materias de hoy
			( [EDV].EndTime >= CONVERT(TIME, GETDATE()) AND 
			[EDV].StartTime <=  CONVERT(TIME, GETDATE() ))-- Materias en curso
	ORDER BY [EDV].[StartTime] DESC

	--Get the movements of the current day
	DECLARE MovementsCursor CURSOR FOR
		SELECT	DISTINCT [MOV].[DocumentNumber]
		FROM	[Attendance].[Movement] [MOV] WITH(NOLOCK)
		WHERE	CONVERT(DATE, [MOV].[RegisterDate]) = CONVERT(DATE, GETDATE())
		GROUP BY [MOV].[DocumentNumber];
	
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
				[SEV].[StudentDocumentNumber]	= @CurrentDocumentNumberOfTheMovement;   
		
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


