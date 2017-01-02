--*******************************************************************
-- Author:		Agustín Barona
-- Create date: 2016-07-29
-- Description: Query to clean the database
--*******************************************************************
USE [UAS]
GO
--*******************************************************************
TRUNCATE TABLE [Attendance].[Movement]
TRUNCATE TABLE [NonAttendance].[ExcuseApproval]
DELETE FROM [NonAttendance].[Excuse]
TRUNCATE TABLE [NonAttendance].[Attachment]
DELETE FROM [NonAttendance].[NonAttendance]