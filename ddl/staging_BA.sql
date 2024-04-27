use rvdrehearsal
go

if object_id('stg.stg_BA_Load_Status', 'U') is not null
	drop table stg.stg_BA_Load_Status
go 
create table stg.stg_BA_Load_Status(
	BA_Load_Status_Date			date )
go
grant alter on stg.stg_BA_Load_Status to [BETHEL\USABAJobService]
go


if object_id('stg.stg_BA_Project', 'U') is not null
	drop table stg.stg_BA_Project
go  
create table stg.stg_BA_Project(
	Project_ID 			bigint			not null,
	Project_Number		nvarchar(200),
	Project_Desc 		nvarchar(max),
	Project_Type 		nvarchar(200),
	Project_Status 		nvarchar(200),
	Load_Date			datetime 		not null default getdate() )
go
grant alter on stg.stg_ba_project to [BETHEL\USABAJobService]
go


if object_id('stg.stg_BA_Project_Volunteer', 'U') is not null
	drop table stg.stg_BA_Project_Volunteer
go  
create table stg.stg_BA_Project_Volunteer(
	Project_ID 			bigint				not null,
	Volunteer_ID    	bigint 			not null,
	Person_GUID 		uniqueidentifier	not null,
	Invited 			int, 
	Accepted 			int, 
	Attended 			int, 
	Load_Date			datetime 			not null default getdate() )
go
grant alter on stg.stg_ba_project_volunteer to [BETHEL\USABAJobService]
go


if object_id('stg.stg_BA_Skill', 'U') is not null
	drop table stg.stg_BA_Skill
go 
create table stg.stg_BA_Skill(
	Skill_GUID					uniqueidentifier		not null,
	Skill_Desc 					nvarchar(200)			not null,
	Subskill_GUID				uniqueidentifier		not null,
	Subskill_Desc				nvarchar(200)			not null,
	Speciality_GUID				uniqueidentifier,
	Speciality_Desc				nvarchar(200),	
	Load_Date 					datetime 				not null default getdate() )
go
grant alter on stg.stg_ba_skill to [BETHEL\USABAJobService]
go


if object_id('stg.stg_BA_Volunteer', 'U') is not null
	drop table stg.stg_BA_Volunteer
go  
create table stg.stg_BA_Volunteer(
	Volunteer_ID 				bigint 				not null,
	Volunteer_BANumber      	nvarchar(10),
	Person_GUID 				uniqueidentifier 	not null,
	Preferred_Name 				nvarchar(200),
	Preferred_Phone_Number 		nvarchar(500),
	Preferred_Phone_Type 		nvarchar(100),
	Text_Msg_Opt_In 			int,
	Mate_Volunteer_ID 			bigint,
	Mate_Volunteer_BANumber     nvarchar(10),
	Mate_Person_GUID			uniqueidentifier,
	Interviewed_Date 			datetime,
	Safety_Orientation_Date 	date,
	Statement_Accepted_Date 	date,
	Special_Equip_Desc			nvarchar(max),
	Last_Login_Date 			datetimeoffset(7),
	Load_Date					datetime 			not null default getdate(),
	DomainPerm					smallint,
	ProjectPerm					smallint )
go
grant alter on stg.stg_ba_volunteer to [BETHEL\USABAJobService]
go


if object_id('stg.stg_BA_Volunteer_Attendance', 'U') is not null
	drop table stg.stg_BA_Volunteer_Attendance
go  
create table stg.stg_BA_Volunteer_Attendance(
	Volunteer_ID 			bigint 				not null,
	Person_GUID 			uniqueidentifier 	not null,
	Project_ID 				bigint				not null, 
	Checkin_Date 			datetime,
	Event_Name 				nvarchar(255),
	Status 					nvarchar(50), 
	Event_ID 				bigint,
	Load_Date				datetime 			not null default getdate() )
go
grant alter on stg.stg_ba_volunteer_attendance to [BETHEL\USABAJobService]
go


if object_id('stg.stg_BA_Volunteer_Group', 'U') is not null
	drop table stg.stg_BA_Volunteer_Group
go  
create table stg.stg_BA_Volunteer_Group(
	Volunteer_ID			bigint 				not null,
	Person_GUID 			uniqueidentifier 	not null,
	Group_ID				bigint				not null,
	Group_Name 				nvarchar(1000),
	Zone 					nvarchar(255), 
	Project_ID 				bigint				not null,
	Project_Number			nvarchar(200),
	Project_Name 			nvarchar(max),
	Private 				tinyint,
	Created_Date 			datetimeoffset(7),
	Load_Date				datetime 			not null default getdate() )
go
grant alter on stg.stg_ba_volunteer_group to [BETHEL\USABAJobService]
go


if object_id('stg.stg_BA_Volunteer_Invite', 'U') is not null
	drop table stg.stg_BA_Volunteer_Invite
go  
create table stg.stg_BA_Volunteer_Invite(
	Volunteer_ID			bigint 				not null,
	Person_GUID 			uniqueidentifier 	not null,
	Event_ID				bigint				not null,
	Event_Name 				nvarchar(255)		not null,
	Link 					nvarchar(1000), 
	Start_Date 				nvarchar(10),
	Event_Length 			integer,
	Maximum_Confirmations 	integer,
	Status_Day_1 			nvarchar(50), 
	Status_Day_2 			nvarchar(50),
	Status_Day_3 			nvarchar(50), 
	Status_Day_4 			nvarchar(50), 
	Status_Day_5 			nvarchar(50), 
	Status_Day_6 			nvarchar(50), 
	Status_Day_7 			nvarchar(50), 
	Comments 				nvarchar(max),
	Manager_Comments 		nvarchar(max),
	Load_Date				datetime 			not null default getdate() )
go
grant alter on stg.stg_ba_volunteer_invite to [BETHEL\USABAJobService]


if object_id('stg.stg_BA_Volunteer_Skill', 'U') is not null
	drop table stg.stg_BA_Volunteer_Skill
go  
create table stg.stg_BA_Volunteer_Skill(
	Volunteer_ID				bigint 				not null,
	Person_GUID 				uniqueidentifier 	not null,
	SubSkill_GUID 				uniqueidentifier 	not null,	
	Personal_Notes 				nvarchar(max), 
	Overseer_Assessment_Name 	nvarchar(200),
	Overseer_Assessment 		int,
	Overseer_Assessment_Notes	nvarchar(max),
	Overseer_Assessment_Date 	datetimeoffset(7),
	Assessed_Proficiency		int,
	Load_Date					datetime 			not null default getdate() )
go
grant alter on stg.stg_ba_volunteer_skill to [BETHEL\USABAJobService]


if object_id('stg.stg_BA_Volunteer_Training', 'U') is not null
	drop table stg.stg_BA_Volunteer_Training
go  
create table stg.stg_BA_Volunteer_Training(
	Volunteer_ID			bigint 				not null,
	Person_GUID 			uniqueidentifier 	not null,
	Course_Name 			nvarchar(255)		not null, 
	Course_Desc 			nvarchar(max), 
	Course_Type 			nvarchar(max), 
	Active_Flag 			tinyint, 
	Assign_Date 			datetimeoffset(7),
	Complete_Date 			date,
	Modified_Date 			datetimeoffset(7),
	Load_Date				datetime 			not null default getdate() )
go
grant alter on stg.stg_ba_volunteer_training to [BETHEL\USABAJobService]
