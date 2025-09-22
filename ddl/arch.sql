PRINT ''
PRINT '-------------------------'
PRINT 'Begin update rvd with Role Based objects...'
PRINT ''
PRINT 'Create table [arch].[Dept_Role]...'

-- Table: [arch].[Dept_Role]
CREATE TABLE [arch].[Dept_Role](
	[arch_DR_Key] [int] IDENTITY(1,1) NOT NULL,
	[Dept_Role_Key] [int] NULL,
	[HPR_Dept_Key] [int] NOT NULL,
	[HPR_Crew_Key] [int] NOT NULL,
	[HPR_Dept_Role_Key] [int] NOT NULL,
	[Enrollment_Key] [int] NULL,
	[Skill_Level] [nvarchar](255) NULL,
	[Role_Start_Date] [date] NULL,
	[Role_End_Date] [date] NULL,
	[Notes] [nvarchar](4000) NULL,
	[Dept_Volunteer_Name] [nvarchar](255) NULL,
	[Dept_Asgn_Status_Key] [int] NULL,
	[Priority_Key] [int] NOT NULL,
	[VTC_Meeting_Code] [nvarchar](10) NOT NULL,
	[Marital_Status_Key] [int] NULL,
	[Cong_Servant_Code] [nvarchar](3) NULL,
	[PS_Notes] [nvarchar](4000) NULL,
	[Job_Description] [nvarchar](255) NULL,
	[Until_Not_Needed] [nvarchar](1) NULL,
	[Short_Term_OK] [nvarchar](1) NULL,
	[Trade_To_Qualify] [nvarchar](1) NULL,
	[Possible_Sister] [nvarchar](1) NULL,
	[Dept_Asgn_Key] [int] NULL,
	[Current_Sync_Status] [nvarchar](50) NULL,
	[Update_Source] [nvarchar](25) NULL,
	[Update_Type] [nvarchar](200) NULL,
	[UpdateDate_Source] [datetime] NULL,
	[Update_ReviewedByUser] [nvarchar](1) NULL,
	[Update_AddLink1] [int] NULL,
	[Update_AddLink2] [int] NULL,
	[Active_Flag] [nvarchar](1) NOT NULL,
	[Load_Date] [datetime] NOT NULL,
	[Update_Date] [datetime] NOT NULL,
	[Snapshot_Date] [datetime] NOT NULL,
 CONSTRAINT [dept_role_pk] PRIMARY KEY CLUSTERED 
(
	[arch_DR_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

PRINT ''
PRINT '-------------------------'
PRINT ''
PRINT 'Create table [arch].[Dept_Role_Volunteer]...'

-- Table: [arch].[Dept_Role]
CREATE TABLE [arch].[Dept_Role_Volunteer](
	[arch_DRV_Key] [int] IDENTITY(1,1) NOT NULL,
	[Dept_Role_Vol_Key] [int] NULL,
	[Dept_Role_Key] [int] NOT NULL,
	[Dept_Asgn_Key] [int] NULL,
	[Volunteer_Type] [int] NULL,
	[Vol_Enrollment_Key] [int] NULL,
	[Bed_Type] [nvarchar](255) NULL,
	[Vol_Start_Date] [date] NULL,
	[Vol_End_Date] [date] NULL,
	[Notes] [nvarchar](4000) NULL,
	[Dept_Asgn_Status_Key] [int] NULL,
	[Candidate_Next_Step] [nvarchar](50) NULL,
	[Volunteer_Key] [int] NOT NULL,
	[PS_Notes] [nvarchar](4000) NULL,
	[Invite_Chart_Comments] [nvarchar](4000) NULL,
	[Until_Not_Needed] [nvarchar](1) NULL,
	[HuBIncidentURL] [nvarchar](255) NULL,
	[Update_Source] [nvarchar](25) NULL,
	[Update_Type] [nvarchar](200) NULL,
	[UpdateDate_Source] [datetime] NULL,
	[Update_ReviewedByUser] [nvarchar](1) NULL,
	[Ext_Orig_PS_End_Date] [date] NULL,
	[Ext_Orig_Enrollment_Key] [int] NULL,
	[Ext_Orig_Dept_Asgn_Status_Key] [int] NULL,
	[Ext_Last_Start_Date] [date] NULL,
	[Extension_Flag] [nvarchar](1) NOT NULL,
	[Extension_Flag_UpdateDate] [datetime] NULL,
	[Active_Flag] [nvarchar](1) NOT NULL,
	[Load_Date] [datetime] NOT NULL,
	[Update_Date] [datetime] NOT NULL,
	[Snapshot_Date] [datetime] NOT NULL,
 CONSTRAINT [archDRV_pk] PRIMARY KEY CLUSTERED 
(
	[arch_DRV_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE arch.ETL_Status_Audit
([ETLStatAud_Key] [int] IDENTITY(1,1) NOT NULL,
[Volunteer_Key] int NULL,
[Volunteer_Name] nvarchar(75) NULL,
[Vol_Enrollment_Key] int NULL,
[Vol_Enrollment_Code] nvarchar(30),
[Dept_Role_Key] int NULL,
[Dept_Role_Vol_Key] int NULL,
[ActionTaken] nvarchar(50) NULL,
[NewRecordAdded] nvarchar(1) NULL,
[ORIG_Dept_Asgn_Status] nvarchar(30) NULL,
[ORIG_Vol_Start_Date] date NULL,
[ORIG_Vol_End_Date] date NULL,
[UPDATED_Dept_Asgn_Status] nvarchar(30) NULL,
[UPDATED_Vol_Start_Date] date NULL,
[UPDATED_Vol_End_Date] date NULL,
[RecordDate] date NOT NULL,
 CONSTRAINT [arch_ETLStatAud_Key] PRIMARY KEY CLUSTERED 
(
	[ETLStatAud_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


