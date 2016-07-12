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

INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Administrator', 'Administrador')
INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Director', 'Director')
INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Teacher', 'Profesor')
INSERT INTO [Security].[Role]([Name], [Alias]) VALUES('Student', 'Estudiante')


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

INSERT INTO [Security].[User]([Username], [Password], [IdRole], [IsActive], [CreatedBy]) 
	VALUES ('admin', 'NXo/ao4xL5ix30tACkl6jg==', 1, 1, 'admin') 


CREATE TABLE [Security].[Page](
	[Id] 				[int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Title] 			[nvarchar](15) 		NOT NULL,
	[MenuItem] 			[nvarchar](80) 		NOT NULL,
	[ParentId] 			[int]	 			NULL,
	[Icon] 				[nvarchar](80) 		NULL,
	[Order] 			[int]	 			NULL,
	[RegisterDate] 		[datetime] 			NULL)
GO


ALTER TABLE [Security].[Page] ADD  CONSTRAINT [DF_Page_Register_Date]  DEFAULT (getdate()) FOR [RegisterDate]
GO

CREATE TABLE [Security].[PagePermissionByRol](
	[IdPage] 			[int] 		NOT NULL,
	[IdRole] 			[int] 		NOT NULL,
	[CanEdit] 			BIT 		NOT NULL,
	[CanUpdate] 		BIT			NOT NULL,
	[CanSelect] 		BIT			NOT NULL,
	[CanDelete] 		BIT			NOT NULL,
	CONSTRAINT Pk_PagePermissionByRol PRIMARY KEY ([IdPage], [IdRole]),
	CONSTRAINT Fk_RolePagePermission FOREIGN KEY  ([IdRole]) REFERENCES [Security].[Role](Id),
	CONSTRAINT Fk_PagePermission FOREIGN KEY  ([IdPage]) REFERENCES [Security].[Page](Id)
	 )
GO