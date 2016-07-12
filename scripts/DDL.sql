CREATE DATABASE [UAS]
GO

ALTER DATABASE [UAS] SET ENABLE_BROKER 
GO

USE [UAS]
GO

CREATE SCHEMA Security

CREATE TABLE [Security].[Role](
	[Id] 			[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] 			[nvarchar](80) 		NOT NULL,
	[Alias] 		[nvarchar](150) 	NULL,
	[RegisterDate] 	[datetime] 			NULL)
GO

ALTER TABLE [Security].[Role] ADD  CONSTRAINT [DF_Role_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

--INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Administrator', 'Administrador')
--INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Director', 'Director')
--INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Teacher', 'Profesor')
--INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Student', 'Estudiante')


CREATE TABLE [Security].[User](
	[Id] 					[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
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

--INSERT INTO [Security].[User]([Username], [Password], [IdRole], [IsActive], [CreatedBy]) 
--	VALUES ('admin', 'NXo/ao4xL5ix30tACkl6jg==', 1, 1, 'admin') 


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

--INSERT INTO [Security].[Page]([Title], [MenuItem])  VALUES('Dashboard', '~/Home' )
--INSERT INTO [Security].[Page]([Title], [MenuItem])  VALUES('Asistencia', '#' )
--INSERT INTO [Security].[Page]([Title], [MenuItem], [ParentId])  VALUES('Aula Virtual', '~/Attendance/VirtualStudentsClassRoom', 2 )
--INSERT INTO [Security].[Page]([Title], [MenuItem], [ParentId])  VALUES('Salón de Docentes', '~/Attendance/VirtualTeachersClassRoom', 2 )

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

--INSERT INTO [Security].[PagePermissionByRole] VALUES(1,1,1,1,1,1,1,1)
--INSERT INTO [Security].[PagePermissionByRole] VALUES(2,1,1,1,1,1,1,1)
--INSERT INTO [Security].[PagePermissionByRole] VALUES(3,1,1,1,1,1,1,1)
--INSERT INTO [Security].[PagePermissionByRole] VALUES(4,1,1,1,1,1,1,1)

SELECT * FROM [Security].[User]
SELECT * FROM [Security].[Role]
SELECT * FROM [Security].[Page]
SELECT * FROM [Security].[PagePermissionByRole]




