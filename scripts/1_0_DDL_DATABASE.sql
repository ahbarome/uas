--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description:	Database creation
--*******************************************************************
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