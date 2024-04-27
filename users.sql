USE [rvdrehearsal]
GO

CREATE USER [rvd_app_dev] FOR LOGIN [rvd_app_dev] WITH DEFAULT_SCHEMA=[dbo]
GO

USE [rvd]
GO

CREATE USER [rvd_app_prod] FOR LOGIN [rvd_app_prod] WITH DEFAULT_SCHEMA=[dbo]
GO



CREATE USER [hpr_reporting_dev] FOR LOGIN [hpr_reporting_dev] WITH DEFAULT_SCHEMA=[rpt]
GO
