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
CREATE SCHEMA Attendance
GO
CREATE SCHEMA NonAttendance
GO
CREATE SCHEMA Integration;
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


INSERT INTO [Security].[PagePermissionByRole] VALUES(1,3,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(2,3,1,1,1,1,1,1)
INSERT INTO [Security].[PagePermissionByRole] VALUES(3,3,1,1,1,1,1,1)

GO


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

INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(52006066,117201,'PAOLA ANDREA','LOPEZ SANCHEZ','plopez@hotmail.com',3732948,'CARRERA 81 #26-48',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(98545750,117202,'JAIME','CUBILLOS ANZOLA','jcubillo@hotmail.com',3548830,'CALLE 103 #113-132',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16612361,117203,'GUSTAVO','AMBUILA ORTEGA','gambuila@corfipac.zonaempresarial.com',2541236,'AV OESTE 3 155 T7 A1106',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(91255729,117204,'CARLOS EDMUNDO','LOAIZA ARIAS','cloaiza@aulamagna.net',7386251,'AV 111A #57A-73 APTO 601',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(19114792,117205,'HAROLD DIDIER','VALENCIA BENITEZ','hvalenci@bancounion.com.co',7284486,'AV. 36BIS #118-126 BIS',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16466918,117206,'IVAN FERNANDO','GOMEZ LOMBANA','igomez@col3.telecom.com.co',2541236,'CLL 83 #31-150',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(21066034,117207,'AMPARO','ARBOLEDA MARIN','aarboled@banacol.com.co',2541236,'CRA 34A #159-83 IN5 APT102',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(70128486,117208,'HECTOR AMADO','ARCILA RESTREPO','harcila@mapasydatos.com',2861144,'CARR 41 #11-157',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(19480220,117209,'JOSE IGNACIO','MANRIQUE VENEGAS','jmanriqu@playnet.net.co',6891302,'CALLE 75 #101-161',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(70552943,117210,'ARGEMIRO','GONZALEZ CORREA','agonzale@hotmail.com',2925248,'CRA 81A NO.57 6 33 SUR',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79314107,117211,'HERNANDO','PRADA VARGAS','hprada@usbbog.edu.co',4771176,'CALLE 52 #109-137',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79429445,117212,'JUAN PABLO','SUAREZ QUIGUA','jsuarez@cdav.com.co',3308095,'TRANS 106 #63-183',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(52126838,117213,'NELLY','SANCHEZ DE CHICA','nsanchez@acnielsen.com',6239368,'NAVICAI CASA #8',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(6049873,117214,'MARCO ANTONIO','GOMEZ CASAS','mgomez@comercio.senacauca.edu.co',2541236,'CLL 100 # 35-67 BL.3 APT.212',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(17131081,117215,'EDUARDO SANTIAGO','GAVILAN GUEVARA','egavilan@cdav.com.co',2541236,'TRANS 44 #68-164',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(13952331,117216,'JOSE ARMANDO','ARCE ESLAVA','jarce@hotmail.com',7346250,'AV 16A #46A-80 APART 302',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(8290036,117217,'FABIAN','GIRALDO CARDONA','fgiraldo@coolechera.com',3644616,'TRANS 70 #27-43',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(12186300,117218,'ANDRES FELIPE','GALVIS NAVIA','agalvis@altavista.net',6442408,'AV. 71 #70-229',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(6438827,117219,'GABRIEL FERNANDO','LLANOS HURTADO','gllanos@hotmail.com',3357740,'CLL 63 #36-126',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(13934212,117220,'RODOLFO','POSADA MURCIA','rposada@starmedia.com',4289950,'CLL 43 #84-38',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16727302,117221,'JAVIER','MESA SARMIENTO','jmesa@hotmail.com',2851143,'DIAG 87 #110-123',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(31837481,117222,'FRANCIA VIVIANA','GUERRERO DE BERRIO','fguerrer@hotmail.com',2541236,'CRA 54B NO.99A-49',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79307624,117223,'RAFAEL JULIO','RIVADENEIRA ROJAS','rrivaden@mafalda.univalle.edu.co',3382553,'CLL 143A NO. 42-32',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(71749735,117224,'JAIME ORLANDO','MARTINEZ LOPEZ','jmartine@hotmail.com',7303137,'TRV 90 #94-164',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(91222842,117225,'CARLOS JULIO','OLAVE ACOSTA','colave@starmedia.com',4286759,'TRV 78 #72-198',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16585811,117226,'GIANCARLO','NAVIA PARRA','gnavia@yahoo.com',3409557,'KR. 95 #75-130',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(14950108,117227,'ALVARO AUGUSTO','TRUJILLO REINA','atrujill@heinsohn.com.co',7084828,'KR. 46 #121-43',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(41788656,117228,'PAOLA ANDREA','GARIBELLO DE URREA','pgaribel@yahoo.com',2851499,'CARRERA 57 #63-42',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(51985238,117229,'GLORIA AIDE','UMANA SUAREZ','gumana@bancoldex.com',7715920,'CLL 105 #103-105',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(2990147,117230,'HAROLD','VESGA JURADO','hvesga@tia.com.co',5031301,'TRANS 73 #122-45',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(125799,117231,'ROBERT ALBERTO','CAMPO ROLDAN','rcampo@zeus.uniandes.edu.co',4391497,'CLL 91 #67-70',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(52270469,117232,'ADALID','ACEVEDO DE PRIETO','aacevedo@yahoo.com',6368670,'AV 5 #20-95 AP801 EL TIROL VER',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(41465111,117233,'SONIA MARIA','ARANGO ESQUIVEL','sarango@contraloriacali.gov.co',4451267,'AV. 58 #72-180',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79056706,117234,'ELBERT','CLAROS CORONEL','eclaros@bsab.com',7031647,'AV. 31B #126-95 SUR',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(6199650,117235,'RODRIGO','PLATA FRANCO','rplata@multinet2.emcali.net.co',2975982,'TRV 18 #105-202',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79138395,117236,'LUIS EDUARDO','PINEDA PALENCIA','lpineda@hotmail.com',6276888,'CARRERA 36 #39-197',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(18107765,117237,'EDUARDO','PLATA NOVOA','eplata@yahoo.com',6417251,'CL 152 #42-15 INT.8 AP 132',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(36978707,117238,'MARTHA CECILIA','ARCE ESCOBAR','marce@hotmail.com',2541236,'CRR 81 #57-213',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(11250871,117239,'JHON JAIRO','VELEZ CHAVEZ','jvelez@starmedia.com',6261715,'KR. 28 #127-92',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(10073561,117240,'ALIRIO','VALDIVIESO PLAZA','avaldivi@solinfo.com.co',6513472,'AV.42 # 18-41 PISO 2',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(70108613,117241,'NORMAN ALEXANDER','TRUJILLO MONGUI','ntrujill@ucentral.edu.co',3631545,'CLL 73 # 73A-27',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(3316559,117242,'CARLOS HERNAN','NUNEZ CAMACHO','cnunez@bancodebogota.com.co',6493107,'CLL 91 #57-196',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79512066,117243,'VICTOR RENAN','ZUNIGA REINA','vzuniga@hotmail.com',5881355,'TRV 50 #52-135',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(52123414,117244,'MARTHA CECILIA','ECHEVERRI CARVAJAL','mechever@latinmail.com',7578009,'AVE 85 #85-126',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(31176719,117245,'MARTHA LISBETH','DUQUE CORDOBA','mduque@co.ibm.com',8268410,'KR. 30 #108-224',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16832909,117246,'ANDRES FELIPE','RODRIGUEZ PINTO','arodrigu@codiesel.com',8647021,'AVE 84 #61-71',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(3375318,117247,'JAIRO ORLANDO','GOMEZ ACOSTA','jgomez@usa.net',7884525,'CALLE 15 #101-77',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(51683539,117248,'MONICA','GOMEZ RUIZ','mgomez@yahoo.com',6127931,'CLL 66 #19-121',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(51569518,117249,'MARIA EUGENIA','MARIN BELTRAN','mmarin@starmedia.com',2541236,'CLL 21 #121-171',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(10118774,117250,'JAIRO DE JESUS','MARTINEZ GARCES','jmartine@navegante.com.co',3594606,'AV 25A #126B-163 APTO 610',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(5807824,117251,'ANDRES FELIPE','DIAZ TUNJANO','adiaz@javercol.javeriana.edu.co',7082116,'KR. 114 #81-124',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16263147,117252,'LUIS ERNESTO','GOMEZ OCHOA','lgomez@cgiar.org',5859719,'CARRERA 27 #71-67',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(13364547,117253,'CARLOS DARIO','RESTREPO GALVIZ','crestrep@sergioarboleda.zzn.com',8376290,'CARR 64 #56-87',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(3709986,117254,'HANS','REALPE LARRAHONDO','hrealpe@att.net',5833072,'TRV 48 #68-117',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(39566167,117255,'MARTHA INES','DAZA GIL','mdaza@hotelesroyal.com',3942268,'CARRERA 81 #63-197',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(3494001,117256,'ENRIQUE','GONZALEZ MENDOZA','egonzale@co.xaco.xerox.com',7226579,'KR. 53 #78-70',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(41602245,117257,'LINA MARIA','GALLARDO TORRES','lgallard@linuxmail.org',7622473,'CLL 36 #125-119',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(13806057,117258,'HUGO EMILIO','GUZMAN GUTIERREZ','hguzman@bansantander.com.co',2541236,'DIAG 65 #116-142',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(8362347,117259,'JUAN DAVID','GUTIERREZ HINCAPIE','jgutierr@yahoo.com',8141484,'CALLE 98 #128-176',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(51646381,117260,'ANGELA MARIA','OSPINA TAMAYO','aospina@usb.edu.co',2992211,'AV 88A #82A-217 APART 301',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79382169,117261,'JHON JAIRO','MARIN ARROYAVE','jmarin@uninca.edu.co',7192015,'KR. 63 #34-75',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(87562613,117262,'GUSTAVO ADOLFO','LOPEZ QUINTANILLA','glopez@hotmail.com',3628120,'CRA 45 # 68-39 PISO 1',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(94399731,117263,'ALEXANDER','DUMAR SALCEDO','adumar@cali.eficext.com.co',2541236,'CARRERA 96 #35-115',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16769180,117264,'FRANCISCO JAVIER','VELEZ POSSO','fvelez@col.net.co',7444497,'CALLE 44 #26-209',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(17105223,117265,'HERNANDO ALFONSO','LANDAZABAL PENA','hlandaza@banacol.com.co',2912895,'CR 77 #74-31 B.31 EN.1-2 A.102',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(13855644,117266,'ALEJANDRA MARI','CALDERON GOMEZ','acaldero@comfama.com.co',7689094,'CARRERA 80 #82-94',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(17087341,117267,'JORGE ALBERTO','ARISTIZABAL TULANDE','jaristiz@sistecorp.com',2961864,'CL 164 #35-67 AP 320 BL 5',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(3381990,117268,'MAURICIO','RODRIGUEZ VILLABONA','mrodrigu@politecjic.edu.co',5216122,'KR. 103 #63-55',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(65496315,117269,'BEATRIZ ELENA','PEREZ VIVAS','bperez@multi.net.co',5551213,'DIAG 106 #107-95',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79253284,117270,'JORGE ENRIQUE','GARCIA ARGUELLO','jgarcia@politecjic.edu.co',3719910,'CRR 26 #34-189',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79639720,117271,'CELSO FREDY','TIJO OSORIO','ctijo@patprimo.com.co',2881403,'KR. 18 #37-227',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(80506032,117272,'JOSE MAURICIO','HALTRICH SERNA','jhaltric@colinagro.com.co',5347529,'AVE 88 #117-114',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79555865,117273,'CAMILO','GOMEZ HUERTAS','cgomez@burmancastrol.com',7882853,'KR. 103 #19-68',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16829828,117274,'JAIRO','PINEDA QUIROGA','jpineda@usb.edu.co',7536254,'KR. 58 #83-145',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(31962167,117275,'LUZ CARIME','RODRIGUEZ AGREDO','lrodrigu@cali.telecom.com.co',4363335,'TRANS 21 #26-187',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(19122556,117276,'LUIS ALEJANDRO','STERLING CASTILLO','lsterlin@starmedia.com',3851806,'KR. 44 #74-179',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16616386,117277,'HECTOR GUILLERMO','GONGORA GONGORA','hgongora@avantel.net',7539813,'KR 82 #27-214',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79529849,117278,'CARLOS ANDRES','DURAN RAMIREZ','cduran@icesi.edu.co',7703171,'CLL 55 #90-194',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16685069,117279,'IVAN DARIO','GARCIA PATERMINA','igarcia@hotmail.com',2977388,'CALLE 24 #73-230',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(91439565,117280,'WILLIAM DE JESUS','PLAZAS ANGEL','wplazas@co.sika.com',3158447,'CARRERA 40 #51-166',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(19363835,117281,'CARLOS ANDRES','ROCHA TORRES','crocha@co.nestle.com',5359315,'KR 106 #115-41',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(8294837,117282,'HERNANDO','GOMEZ ECHEVERRI','hgomez@banacol.com.co',6777963,'AV. 79 #105-177',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(31945419,117283,'MARIA LUCIA','TORRES SOLER','mtorres@polcola.com.co',2541236,'CARRERA 23 #82-182',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(94225700,117284,'HUGO ALEXANDER','LOSADA MORA','hlosada@intergrupo.com',7409452,'CALLE 113 #70-127',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(6788165,117285,'JORGE ELIECER','SANCHEZ BOLANOS','jsanchez@confitecol.com',2541236,'CRA 15 #0-09 SAN RAFAEL',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(8308021,117286,'ROOSEVELT','GUEVARA OCAMPO','rguevara@colmenaseguros.com.co',2541236,'AV. 25 #122-74',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(98582162,117287,'GUSTAVO ADOLFO','COLLAZOS VALERO','gcollazo@aldato.com.co',4732652,'CL 114 #9-01 T.A P.6 ED.TELEPO',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(70079848,117288,'JORGE ENRIQUE','ALBARRACIN ROSAS','jalbarra@yahoo.com',4155001,'TRANS 52 #94-64',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(20448011,117289,'GIOVANNA','LOPEZ DE ALVAREZ','glopez@alfatecnica.com.co',2541236,'CL 50 A # 8A-122 PAT 304 BL 10',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16704846,117290,'BERNARDO','SILVA GOMEZ','bsilva@ascom.com.co',3359888,'AV 62A #94-101 OFIC 1004',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(23604366,117291,'MARIANELLA','DAGUA RAMIREZ','mdagua@att.net',6747265,'CLLE 27A SUR #47-50 AP.401',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(71787111,117292,'VICTOR MAURICIO','ESCOBAR BARONA','vescobar@publicar.com',6911641,'CLL 153 #35-04',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(3316800,117293,'EDGAR ALBERTO','MARTINEZ RODAS','emartine@hotmail.com',5911358,'A.A. 5858',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(76316238,117294,'JORGE HUMBERTO','SEGURA GAMBA','jsegura@yahoo.com',3142541,'KR. 100 #94-164',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79327920,117295,'JUAN FELIPE','ROJAS MINOTA','jrojas@sergioarboleda.zzn.com',2541236,'AVENIDA 55 #50-96',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16643172,117296,'ALFREDO','CAMPO PAEZ','acampo@hotmail.com',2541236,'CRA 41 # 133-83 APTO 404',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(79234879,117297,'JUAN CARLOS','ALARCON RAGA','jalarcon@medellin.impsat.net.co',2541236,'CARRERA 73 #102-223',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(16249469,117298,'AURELIANO','AGUINO ROMERO','aaguino@yahoo.com',3052213,'CRA 4 #32-93 MACARENA',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(18109738,117299,'IAMEL ANTONIO','CALCETERO QUICENO','icalcete@poligran.edu.co',4193656,'CARR 63 #34-52',1,2,'~/Images/a7.jpg')
INSERT INTO [Integration].[Student]([DocumentNumber], [Code], [Name], [LastName], [Email],[TelephoneNumber],[Address],[IdCareer], [IdFringe] ,[ImageRelativePath]) VALUES(10190789,117300,'SERGIO MIGUEL','MINA CADAVID','smina@usb.edu.co',8145552,'KR. 52 #121-200',1,2,'~/Images/a7.jpg')


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
INSERT INTO [Integration].[Teacher]([DocumentNumber], [Code], [Name], [LastName], [Email], [TelephoneNumber], [Address], [ImageRelativePath]) VALUES(1130677693,101115,'Luis','Echeverri','luis.echeverri@unilibrecali.edu.co',311001129,'Cra. 37a #3-44','~/Images/a7.jpg')




--Course
--=> Name, CreditsNumber
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

--DBCC CHECKIDENT ('Integration.Course', RESEED, 0);  
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(1,10000,'Álgebra y Trigonometría',3,1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(2,10001,'Introdución a la Ingeniería',2,1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(3,10002,'Geometría Descriptiva',2,1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(4,10003,'Lógica y Algoritmos',3,1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(5,10004,'Aprendizaje Autónomo',2,1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(6,10005,'Inglés I',1,1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(7,10006,'Cátedra Unilibrista',1,1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(8,10007,'Instituciones Colombianas',1,1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(9,10008,'Calculo Diferencial',3,2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(10,10009,'Física Mecánica y Laboratorio',3,2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(11,10010,'Lógica Matemática',3,2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(12,10011,'Estructura de Lenguajes',3,2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(13,10012,'Lenguaje y Comunicación',2,2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(14,10013,'Inglés II',1,2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(15,10014,'Calculo Integral',3,3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(16,10015,'Física Térmica y Laboratorio',3,3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(17,10016,'Arquitectura de Computadores',3,3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(18,10017,'Pensamiento Sistémico',3,3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(19,10018,'Estructura de Datos',3,3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(20,10019,'Inglés III',1,3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(21,10020,'Calculo Multivariado-Vectorial',3,4);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(22,10021,'Electricidad y Magnetismo y Laboratorio',3,4);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(23,10022,'Sistemas Operativos',3,4);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(24,10023,'Análisis y Diseño de Sistemas',3,4);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(25,10024,'Programación Orientada a Objetos',3,4);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(26,10025,'Inglés IV',1,4);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(27,10026,'Introducción a la Investigación',2,4);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(28,10027,'Ecuaciones Diferenciales',3,5);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(29,10028,'Circuitos Digitales',3,5);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(30,10029,'Redes de Computadores',3,5);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(31,10030,'Bases de Datos',3,5);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(32,10031,'Inglés V',1,5);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(33,10032,'Metodología de la Investigación',2,5);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(34,10033,'Arquitectura de Software',3,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(35,10034,'Química General y Laboratorio',3,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(36,10035,'Estadística Descriptiva',3,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(37,10036,'Métodos Numéricos',2,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(38,10037,'Sistemas Distribuidos',2,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(39,10038,'Electiva de Formación Integral I',2,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(40,10039,'Investigación Aplicada I',1,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(41,10040,'Estadística Inferencial',3,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(42,10041,'Programación Lineal',3,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(43,10042,'Fundamentos de la Economía',3,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(44,10043,'Ética',1,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(45,10044,'Electiva de Formación Integral II',2,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(46,10045,'Investigación Aplicada II',1,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(47,10046,'Electiva Profesional I',3,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(48,10047,'Sistemas de Información',2,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(49,10048,'Sistemas Multimedia',2,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(50,10049,'Investigación de Operaciones',3,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(51,10050,'Ingeniería Económica',3,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(52,10051,'Aplicaciones en Internet',3,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(53,10052,'Electiva de Formación Integral III',2,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(54,10053,'Investigación Aplicada III',1,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(55,10054,'Electiva Profesional II',3,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(56,10055,'Proyección Social',1,9);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(57,10056,'Dinámica de Sistemas',3,9);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(58,10057,'Métricas de Software',3,9);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(59,10058,'Formulación y Evaluación de Proyectos',3,9);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(60,10059,'Investigación Aplicada IV',1,9);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(61,10060,'Electiva Profesional III',3,9);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(62,10061,'Práctica Empresarial',3,10);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(63,10062,'Gestión de Tecnología',3,10);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(64,10063,'Gestión y Control de Calidad',3,10);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(65,10064,'Investigación Aplicada V',1,10);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(66,10065,'Electiva Profesional IV',3,10);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(67,10066,'Administración Empresarial',3,10);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(68,10067,'Fundamentos de Informática',3,1);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(69,10068,'Electiva de Informática Aplicada I',3,2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(70,10069,'Dibujo Asistido',2,2);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(71,10070,'Electiva de Informática Aplicada II',3,3);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(72,10071,'Química Industrial y Laboratorio',3,4);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(73,10072,'Procesos Industriales',3,5);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(74,10073,'Contabilidad y Presupuesto',2,5);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(75,10074,'Fundamentos de Administración',3,5);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(76,10075,'Costos de Producción',3,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(77,10076,'Mercadeo Básico',3,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(78,10077,'Ingenieria de Métodos',3,6);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(79,10078,'Planeación y Organización de la Producción',3,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(80,10079,'Control Estadístico de Calidad',2,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(81,10080,'Mercadeo Estratégico',3,7);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(82,10081,'Legislación Empresarial y Laboral',3,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(83,10082,'Modelos Matemáticos de Producción',3,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(84,10083,'Gestion Financiera',3,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(85,10084,'Control de ProducciónEmpresarial y Laboral',3,8);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(86,10085,'Diseño de Plantas',3,9);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(87,10086,'Psicología Empresarial',2,9);
INSERT INTO [Integration].[Course]([Id], [Code], [Name], [NumberOfCredits], [Semester]) VALUES(88,10087,'Gerencia de Talento Humano',3,9);



--ClassRoom
--=> Name, CreditsNumber
CREATE TABLE [Integration].[SpaceType](
	[Id]						INT					PRIMARY KEY NOT NULL,
	[Type]						[nvarchar](250)		NOT NULL,
	[Description]				[nvarchar](250)		NULL,
	[RegisterDate] 				[datetime] 			NULL
);
GO

ALTER TABLE  [Integration].[SpaceType] ADD  CONSTRAINT [DF_SpaceType_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

INSERT INTO [Integration].[SpaceType]([Id], [Type], [Description]) VALUES(1, 'Oficina Decanatura', 'Oficina Facultad de Ingeniería');
INSERT INTO [Integration].[SpaceType]([Id], [Type], [Description]) VALUES(2, 'Salón', 'Salón de Clase');
INSERT INTO [Integration].[SpaceType]([Id], [Type], [Description]) VALUES(3, 'Sala', 'Sala de Sistemas');
INSERT INTO [Integration].[SpaceType]([Id], [Type], [Description]) VALUES(4, 'Laboratorio', 'Laboratorio');

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

INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10000, 2,'301');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10001, 2,'302');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10002, 2,'303');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10003, 2,'304');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10004, 2,'401');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10005, 2,'402');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10006, 2,'403');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10007, 3,'501');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10008, 3,'502');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10009, 3,'503');
INSERT INTO [Integration].[Space]([Id],[IdSpaceType],[Name]) VALUES(10010, 3,'504');


--*******************************************************************
--DROP TABLE [Attendance].[Movement]
--The foreign key was not create because the movement could be from a no registered user
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

INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(1,1130677693,1,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(2,1130677685,2,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(3,1130677687,3,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(4,1130677691,4,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(5,1130677685,5,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(6,1130677682,6,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(7,1130677692,7,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(8,1130677692,8,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(9,1130677681,9,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(10,1130677677,10,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(11,1130677687,11,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(12,1130677691,12,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(13,1130677685,13,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(14,1130677682,14,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(15,1130677681,15,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(16,1130677677,16,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(17,1130677680,17,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(18,1130677685,18,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(19,1130677680,19,2)
INSERT INTO [Integration].[Schedule]([Id], [TeacherDocumentNumber], [IdCourse], [IdAcademicPeriod]) VALUES(20,1130677682,20,2)


--ScheduleDetail
-->IdSchedule, WeekDay, StartTime, EndTime
--DROP TABLE [Integration].[ScheduleDetail]
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


INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(1,10005,5,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(2,10006,3,'18:30:00','20:00:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(3,10004,4,'18:30:00','20:00:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(4,10010,1,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(5,10005,2,'18:30:00','20:00:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(6,10005,6,'07:30:00','09:00:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(7,10002,1,'20:45:00','21:30:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(8,10002,2,'20:00:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(9,10001,4,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(10,10000,3,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(11,10005,1,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(12,10010,2,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(13,10001,5,'18:30:00','20:00:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(14,10005,6,'09:15:00','10:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(15,10001,3,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(16,10000,2,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(17,10009,5,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(18,10004,1,'18:30:00','20:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(19,10008,6,'07:30:00','09:45:00')
INSERT INTO [Integration].[ScheduleDetail]([IdSchedule], [IdSpace], [DayOfTheWeek], [StartTime], [EndTime]) VALUES(20,10005,6,'14:00:00','15:30:00')


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

INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(52006066,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(98545750,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16612361,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(91255729,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(19114792,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16466918,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(21066034,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(70128486,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(19480220,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(70552943,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79314107,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79429445,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(52126838,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(6049873,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(17131081,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(13952331,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(8290036,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(12186300,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(6438827,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(13934212,3,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16727302,3,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(31837481,3,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79307624,3,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(71749735,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(91222842,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16585811,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(14950108,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(41788656,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(51985238,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(2990147,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(125799,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(52270469,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(41465111,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79056706,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(6199650,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79138395,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(18107765,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(36978707,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(11250871,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(10073561,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(70108613,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(3316559,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79512066,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(52123414,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(31176719,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16832909,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(3375318,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(51683539,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(51569518,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(10118774,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(5807824,2,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16263147,2,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(13364547,2,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(3709986,2,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(39566167,2,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(3494001,2,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(41602245,2,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(13806057,2,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(8362347,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(51646381,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79382169,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(87562613,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(94399731,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16769180,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(17105223,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(13855644,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(17087341,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(3381990,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(65496315,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79253284,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79639720,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(80506032,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79555865,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16829828,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(31962167,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(19122556,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16616386,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79529849,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16685069,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(91439565,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(19363835,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(8294837,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(31945419,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(94225700,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(6788165,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(8308021,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(98582162,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(70079848,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(20448011,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16704846,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(23604366,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(71787111,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(3316800,3,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(76316238,3,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79327920,2,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16643172,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(79234879,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(16249469,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(18109738,1,2)
INSERT INTO [Integration].[Enrollment]([StudentDocumentNumber], [IdEnrollmentStatus], [IdAcademicPeriod]) VALUES(10190789,1,2)


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

INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,1)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,1)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,1)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,1)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,1)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,1)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,1)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,1)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,2)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,2)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,2)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,2)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,2)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,2)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,2)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,2)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,3)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,3)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,3)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,3)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,3)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,3)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,3)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,3)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,4)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,4)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,4)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,4)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,4)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,4)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,4)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,4)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,5)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,5)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,5)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,5)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,5)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,5)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,5)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,5)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,6)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,6)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,6)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,6)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,6)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,6)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,6)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,6)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,7)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,7)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,7)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,7)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,7)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,7)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,7)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,7)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,8)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,8)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,8)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,8)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,8)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,8)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,8)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,8)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,9)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,9)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,9)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,9)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,9)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,9)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,9)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,9)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,10)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,10)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,10)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,10)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,10)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,10)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,10)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,10)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,11)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,11)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,11)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,11)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,11)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,11)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,11)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,11)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,12)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,12)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,12)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,12)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,12)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,12)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,12)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,12)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,13)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,13)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,13)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,13)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,13)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,13)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,13)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,14)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,14)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,14)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,14)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,14)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,14)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,14)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,14)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,15)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,15)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,15)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,15)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,15)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,15)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,15)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,15)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,15)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,16)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,16)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,16)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,16)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,16)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,16)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,16)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,16)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,17)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,17)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,17)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,17)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,17)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,17)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,17)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,17)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,18)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,18)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,18)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,18)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,18)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,18)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,18)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,18)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,19)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,19)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,19)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,19)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,19)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,19)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,19)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,19)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,20)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,20)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,20)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,20)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,20)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,20)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,20)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,20)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,21)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,21)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,21)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,21)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,21)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,21)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,21)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,21)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,22)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,22)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,22)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,22)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,22)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,22)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,22)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,22)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,23)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,23)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,23)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,23)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,23)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,23)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,23)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,23)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,24)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,24)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,24)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,24)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,24)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,24)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,24)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,24)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,25)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,25)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,25)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,25)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,25)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,25)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,25)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,25)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,26)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,26)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,26)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,26)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,26)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,26)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,26)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,26)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,27)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,27)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,27)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,27)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,27)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,27)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,27)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,27)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,28)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,28)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,28)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,28)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,28)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,28)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,28)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,28)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,29)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,29)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,29)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,29)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,29)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,29)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,29)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,29)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(1,30)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(2,30)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(3,30)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(4,30)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(5,30)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(6,30)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(7,30)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(8,30)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,31)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,31)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,31)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,31)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,31)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,31)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,32)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,32)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,32)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,32)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,32)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,32)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,33)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,33)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,33)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,33)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,33)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,33)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,34)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,34)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,34)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,34)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,34)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,34)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,35)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,35)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,35)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,35)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,35)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,35)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,36)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,36)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,36)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,36)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,36)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,36)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,37)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,37)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,37)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,37)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,37)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,37)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,38)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,38)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,38)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,38)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,38)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,38)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,39)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,39)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,39)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,39)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,39)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,39)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,40)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,40)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,40)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,40)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,40)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,40)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,41)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,41)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,41)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,41)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,41)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,41)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,42)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,42)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,42)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,42)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,42)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,42)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,43)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,43)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,43)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,43)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,43)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,43)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,44)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,44)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,44)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,44)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,44)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,44)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,45)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,45)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,45)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,45)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,45)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,45)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,46)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,46)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,46)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,46)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,46)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,46)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,47)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,47)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,47)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,47)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,47)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,47)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,48)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,48)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,48)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,48)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,48)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,48)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,49)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,49)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,49)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,49)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,49)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,49)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,50)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,50)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,50)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,50)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,50)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,50)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,51)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,51)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,51)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,51)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,51)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,51)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,52)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,52)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,52)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,52)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,52)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,52)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,53)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,53)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,53)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,53)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,53)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,53)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,54)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,54)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,54)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,54)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,54)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,54)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,55)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,55)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,55)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,55)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,55)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,55)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,56)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,56)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,56)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,56)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,56)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,56)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,57)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,57)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,57)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,57)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,57)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,57)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,58)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,58)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,58)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,58)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,58)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,58)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,59)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,59)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,59)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,59)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,59)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,59)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(9,60)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(10,60)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(11,60)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(12,60)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(13,60)
INSERT INTO [Integration].[EnrollmentDetail]([IdSchedule], [IdEnrollment]) VALUES(14,60)


--HolidayException
--Id, Date
--DROP TABLE [Integration].[HolidayException]
CREATE TABLE [Integration].[HolidayException](
	[Id]						INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ExceptionDate]				[DATETIME] NOT NULL
);
GO

INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-15-08');
INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-17-10');
INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-07-11');
INSERT INTO [Integration].[HolidayException]([ExceptionDate]) VALUES('2016-14-11');



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
INNER JOIN	[Integration].[SpaceType]			[SPT] ON [SPT].[Id]				= [SPA].[IdSpaceType]

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
INNER JOIN	[Integration].[SpaceType]			[SPT] ON [SPT].[Id]				= [SPA].[IdSpaceType]



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


