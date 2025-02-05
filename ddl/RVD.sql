/*******************************************************************
**							TABLES
*******************************************************************/

use rvdrehearsal
go


if object_id('dbo.App_Attribute', 'U') is not null
	drop table dbo.App_Attribute
go  
create table dbo.App_Attribute(
	App_Attribute_Key 		integer identity(1,1)	not null constraint app_attribute_pk primary key,
	Attribute_ID 			nvarchar(255) 			not null,
	Attribute_Name			nvarchar(255)			not null,
	Active_Flag 			nvarchar(1) 			not null constraint df_app_attribute_active_flag default 'Y',
	Load_Date 				datetime 				not null constraint df_app_attribute_load_date default getdate(),
	Update_Date 			datetime 				not null constraint df_app_attribute_update_date default getdate() )
go


if object_id('dbo.App_Data_Validation', 'U') is not null
	drop table dbo.App_Data_Validation
go  

create table dbo.App_Data_Validation(
	App_Data_Validation_Key integer identity(1,1)	not null constraint app_data_validation_pk primary key,
	Table_Name	 			nvarchar(255) 			not null,
	Test_Name				nvarchar(255)			not null,
	Status_Code				nvarchar(1)				not null,
	Active_Flag 			nvarchar(1) 			not null constraint df_app_data_validation_active_flag default 'Y',
	Load_Date 				datetime 				not null constraint df_app_data_validation_load_date default getdate(),
	Update_Date 			datetime 				not null constraint df_app_data_validation_update_date default getdate() )
go

if object_id('dbo.App_Metadata', 'U') is not null
	drop table dbo.App_Metadata
go  

create table dbo.App_Metadata(
	App_Metadata_Key 		integer identity(1,1)	not null constraint app_metadata_pk primary key,
	App_Metadata_Type_Code 	nvarchar(255) 			not null,
	Attribute_Name 			nvarchar(255) 			not null,
	Attribute_Value 		nvarchar(255) 			not null,
	Active_Flag 			nvarchar(1) 			not null constraint df_app_metadata_active_flag default 'Y',
	Load_Date 				datetime 				not null constraint df_app_metadata_load_date default getdate(),
	Update_Date 			datetime 				not null constraint df_app_metadata_update_date default getdate() )
go


if object_id('dbo.App_Status', 'U') is not null
	drop table dbo.App_Status
go  
create table dbo.App_Status(
	App_Status_Key 			integer identity(1,1) 	not null constraint app_status_pk primary key,
	App_Status_Code 		nvarchar(10)			not null,
	App_Status 				nvarchar(150)			not null,
	Active_Flag 			nvarchar(1) 			not null constraint df_app_status_active_flag default 'Y',
	Load_Date 				datetime 				not null constraint df_app_status_load_date default getdate(),
	Update_Date 			datetime 				not null constraint df_app_status_update_date default getdate() )
go


if object_id('dbo.App_Type', 'U') is not null
	drop table dbo.App_Type
go  
create table dbo.App_Type(
	App_Type_Key 			integer identity(1,1) 	not null constraint app_type_pk primary key,
	App_Type_Code 			nvarchar(30) 			not null,
	App_Type_Name 			nvarchar(100) 			not null,
	HUB_App_Type_ID			integer					not null constraint app_type_ak unique,	
	Active_Flag 			nvarchar(1) 			not null constraint df_app_type_active_flag default 'Y',
	Load_Date 				datetime 				not null constraint df_app_type_load_date default getdate(),
	Update_Date 			datetime 				not null constraint df_app_type_update_date default getdate() )
go 


if object_id('dbo.App_Version', 'U') is not null
	drop table dbo.App_Version
go 
create table dbo.App_Version(
	App_Version_Key 		integer identity(1,1) 	not null constraint app_version_pk primary key,
	App_Version_Number 		decimal(5,2)			not null constraint app_version_ak unique,
	App_Version_Name 		nvarchar(255) 			not null,
	Notes 					nvarchar(255),
	Active_Flag 			nvarchar(1) 			not null constraint df_app_version_active_flag default 'Y',
	Load_Date 				datetime 				not null constraint df_app_version_load_date default getdate(),
	Update_Date 			datetime 				not null constraint df_app_version_update_date default getdate() )
go


if object_id('dbo.Attribute_Data_Type', 'U') is not null
	drop table dbo.Attribute_Data_Type
go 
create table dbo.Attribute_Data_Type(
	Attribute_Data_Type_Key 	integer identity(1,1) 	not null constraint attribute_data_type_pk primary key,
	Attribute_Data_Type 		nvarchar(30) 			not null constraint attribute_data_type_ak unique,
	Data_Format 				nvarchar(30),
	Attribute_Data_Type_Desc 	nvarchar(255),
	Active_Flag 				nvarchar(1) 			not null constraint df_attribute_data_type_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_attribute_data_type_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_attribute_data_type_update_date default getdate() )
go


if object_id('dbo.Attribute_LOV', 'U') is not null
	drop table dbo.Attribute_LOV
go 
create table dbo.Attribute_LOV(
	Attribute_LOV_Key 			integer identity(1,1) 	not null constraint attribute_lov_pk primary key,
	Attribute_LOV 				nvarchar(150) 			not null constraint attribute_lov_ak unique,
	Attribute_LOV_Value 		nvarchar(255),
	Active_Flag 				nvarchar(1) 			not null constraint df_attribute_lov_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_attribute_lov_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_attribute_lov_update_date default getdate() )
go


if object_id('dbo.BA_Event_Volunteer_Invite', 'U') is not null
	drop table dbo.BA_Event_Volunteer_Invite
go 
create table dbo.BA_Event_Volunteer_Invite(
	BA_Event_Volunteer_Invite_Key	integer identity(1,1) 	not null constraint ba_event_volunteer_attendance_pk primary key,
	Event_ID 						bigint					not null,
	Volunteer_ID					bigint					not null,
	Person_GUID						uniqueidentifier		not null,
	Event_Name 						nvarchar(255)			not null,
	Link							nvarchar(1000),
	Start_Date						datetime,
	Event_Length 					integer,
	Maximum_Confirmations 			integer,
	Status_Day_1 					nvarchar(50), 
	Status_Day_2 					nvarchar(50),
	Status_Day_3 					nvarchar(50), 
	Status_Day_4 					nvarchar(50), 
	Status_Day_5 					nvarchar(50), 
	Status_Day_6 					nvarchar(50), 
	Status_Day_7 					nvarchar(50), 
	Comments 						nvarchar(max),
	Manager_Comments 				nvarchar(max),
	Active_Flag 					nvarchar(1) 			not null constraint df_ba_event_volunteer_invite_active_flag default 'Y',
	Load_Date 						datetime 				not null constraint df_ba_event_volunteer_invite_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_ba_event_volunteer_invite_update_date default getdate(),
	constraint ba_event_volunteer_invite_ak unique ( event_id, volunteer_id ) )
go

alter table dbo.ba_event_volunteer_invite add constraint ba_event_volunteer_invite_fk_volunteer foreign key ( volunteer_id ) references dbo.volunteer( ba_volunteer_id )
go


if object_id('dbo.BA_Project', 'U') is not null
	drop table dbo.BA_Project
go 
create table dbo.BA_Project(
	BA_Project_Key	 			integer identity(1,1) 	not null constraint ba_project_pk primary key,
	Project_ID 					bigint 					not null constraint ba_project_ak unique,
	Project_Number 				nvarchar(200),
	Project_Desc 				nvarchar(4000),
	Project_Type 				nvarchar(200),
	Project_Status 				nvarchar(200),
	Active_Flag 				nvarchar(1) 			not null constraint df_ba_project_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_ba_project_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_ba_project_update_date default getdate() )
go


if object_id('dbo.BA_Project_Group', 'U') is not null
	drop table dbo.BA_Project_Group
go 
create table dbo.BA_Project_Group(
	BA_Project_Group_Key	 	integer identity(1,1) 	not null constraint ba_project_group_pk primary key,
	Project_ID 					bigint 					not null,
	Project_Number 				nvarchar(200),
	Project_Name 				nvarchar(200),	
	Group_ID					bigint					not null,
	Group_Name 					nvarchar(200),	
	Zone						integer,
	Private_Flag				nvarchar(1)				not null constraint df_ba_project_group_private_flag default 'Y',
	Active_Flag 				nvarchar(1) 			not null constraint df_ba_project_group_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_ba_project_group_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_ba_project_group_update_date default getdate(),
	constraint ba_project_group_ak unique ( project_id, group_id ) )
go

alter table dbo.ba_project_group add constraint ba_project_group_fk_ba_project foreign key ( project_id ) references dbo.ba_project( project_id )
go


if object_id('dbo.BA_Project_Group_Volunteer', 'U') is not null
	drop table dbo.BA_Project_Group_Volunteer
go 
create table dbo.BA_Project_Group_Volunteer(
	BA_Project_Group_Volunteer_Key	integer identity(1,1) 	not null constraint ba_project_group_volunteer_pk primary key,
	BA_Project_Group_Key			integer					not null,
	Volunteer_Key					integer					not null,
	Project_ID 						bigint 					not null,
	Group_ID						bigint					not null,
	Person_GUID						uniqueidentifier		not null,	
	Active_Flag 					nvarchar(1) 			not null constraint df_ba_project_group_volunteer_active_flag default 'Y',
	Load_Date 						datetime 				not null constraint df_ba_project_group_volunteer_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_ba_project_group_volunteer_update_date default getdate(),
	constraint ba_project_group_volunteer_ak unique ( project_id, group_id, person_guid ) )
go

alter table dbo.ba_project_group_volunteer add constraint ba_project_group_volunteer_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go

alter table dbo.ba_project_group_volunteer add constraint ba_project_group_volunteer_fk_ba_project foreign key ( project_id ) references dbo.ba_project( project_id )
go


if object_id('dbo.BA_Project_Volunteer', 'U') is not null
	drop table dbo.BA_Project_Volunteer
go 
create table dbo.BA_Project_Volunteer(
	BA_Project_Volunteer_Key	integer identity(1,1) 	not null constraint ba_project_volunteer_pk primary key,
	Project_ID 					bigint 					not null,
	Volunteer_ID				bigint					not null,
	Person_GUID					uniqueidentifier		not null,
	Invited_Flag				nvarchar(1)				not null,
	Accepted_Flag				nvarchar(1)				not null,
	Attended_Flag				nvarchar(1)				not null,
	Active_Flag 				nvarchar(1) 			not null constraint df_ba_project_volunteer_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_ba_project_volunteer_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_ba_project_volunteer_update_date default getdate(),
	constraint ba_project_volunteer_ak unique ( project_id, volunteer_id ) )
go

alter table dbo.ba_project_volunteer add constraint ba_project_volunteer_fk_ba_project foreign key ( project_id ) references dbo.ba_project( project_id )
go


if object_id('dbo.BA_Project_Volunteer_Attendance', 'U') is not null
	drop table dbo.BA_Project_Volunteer_Attendance
go 
create table dbo.BA_Project_Volunteer_Attendance(
	BA_Project_Volunteer_Attendance_Key	integer identity(1,1) 	not null constraint ba_project_volunteer_attendance_pk primary key,
	Project_ID 							bigint 					not null,
	Volunteer_ID						bigint					not null,
	Person_GUID							uniqueidentifier		not null,
	Check_In_Date 						datetime,
	Event_ID 							bigint,
	Event_Name 							nvarchar(255),
	Status 								nvarchar(50), 	
	Active_Flag 						nvarchar(1) 			not null constraint df_ba_project_volunteer_attendance_active_flag default 'Y',
	Load_Date 							datetime 				not null constraint df_ba_project_volunteer_attendance_load_date default getdate(),
	Update_Date 						datetime 				not null constraint df_ba_project_volunteer_attendance_update_date default getdate(),
	constraint ba_project_volunteer_attendance_ak unique ( project_id, volunteer_id, event_id, check_in_date ) )
go


alter table dbo.ba_project_volunteer_attendance add constraint ba_project_volunteer_attendance_fk_ba_project foreign key ( project_id ) references dbo.ba_project( project_id )
go


if object_id('dbo.Cal_Dim', 'U') is not null
	drop table dbo.Cal_Dim
go 
create table dbo.Cal_Dim(
	cal_dt 				date 			not null constraint cal_dim_pk primary key,
	day_nm 				nvarchar(30),
	day_of_wk 			int,
	day_of_mth 			int,
	day_nm_suffix 		char(2),
	day_of_wk_in_mth 	tinyint,
	day_in_yr 			int,
	wknd_ind 			int 			not null,
	wk 					int,
	wk_start_dt 		date,
	wk_end_dt 			date,
	wk_in_mth 			tinyint,
	mth 				int,
	mth_nm 				nvarchar(30),
	mth_start_dt 		date,
	mth_end_dt 			date,
	next_mth_start_dt 	date,
	next_mth_end_dt 	date,
	qtr 				int,
	qtr_start_dt 		date,
	qtr_end_dt 			date,
	yr 					int,
	yr_start_dt 		date,
	yr_end_dt 			date,
	leap_yr_ind 		bit,
	yr_53_wk_ind 		int not null )
go


if object_id('dbo.Cong', 'U') is not null
	drop table dbo.Cong
go 
create table dbo.Cong(
	Cong_Key 					integer identity(1,1) 	not null constraint cong_pk primary key,
	Cong_Number 				integer 				not null constraint cong_ak unique,
	Cong 						nvarchar(100),
	Cong_Fullname 				nvarchar(200),
	City 						nvarchar(50),
	State_Key 					integer,
	Postal_Code_Key				integer,
	Country_Key					integer,
	Circuit 					nvarchar(100),
	Language_Code 				nvarchar(10),
	KH_Address1 				nvarchar(50),
	KH_Address2 				nvarchar(50),
	KH_City 					nvarchar(50),
	KH_State_Code 				nvarchar(10),
	KH_Postal_Code				nvarchar(30),
	KH_Country_Code				nvarchar(10),
	COBE_Volunteer_Key			integer,
	COBE_Person_ID				integer,
	COBE_First_Name 			nvarchar(50),
	COBE_Last_Name 				nvarchar(50),
	COBE_Email 					nvarchar(150),
	COBE_Mobile_Phone			nvarchar(100),
	Sec_Volunteer_Key			integer,
	Sec_Person_ID				integer,
	Sec_First_Name 				nvarchar(50),
	Sec_Last_Name 				nvarchar(50),
	Sec_Email 					nvarchar(150),
	Sec_Mobile_Phone			nvarchar(100),	
	CO_Volunteer_Key			integer,
	CO_Person_ID				integer,
	CO_First_Name 				nvarchar(50),
	CO_Last_Name 				nvarchar(50),
	CO_Email 					nvarchar(150),	
	CO_Mobile_Phone				nvarchar(100),	
	Driving_Distance_Flag 		nvarchar(1)				not null constraint df_cong_driving_distance_flag default 'N',
	Dissolved_Date 				date,
	Active_Flag 				nvarchar(1) 			not null constraint df_cong_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_cong_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_cong_update_date default getdate() )
go	

alter table dbo.cong add constraint cong_fk_postal_code foreign key ( postal_code_key ) references dbo.postal_code( postal_code_key )
go

alter table dbo.cong add constraint cong_fk_state foreign key ( state_key ) references dbo.state( state_key )
go

alter table dbo.cong add constraint cong_fk_country foreign key ( country_key ) references dbo.country( country_key )
go


if object_id('dbo.Cong_Activity', 'U') is not null
	drop table dbo.Cong_Activity
go 
create table dbo.Cong_Activity(
	Cong_Activity_Key			integer identity(1,1) 	not null constraint cong_activity_pk primary key,
	Cong_Key					integer					not null,
	Cong_Number 				integer 				not null,
	Activity_Code				nvarchar(50)			not null,
	Activity_Desc				nvarchar(500)			not null,
	Start_Date					date,
	End_Date					date,
	Load_Date 					datetime 				not null constraint df_cong_activity_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_cong_activity_update_date default getdate() )
go


if object_id('dbo.Country', 'U') is not null
	drop table dbo.Country
go 
create table dbo.Country(
	Country_Key 				integer identity(1,1) 	not null constraint country_pk primary key,
	Country_Code 				nvarchar(3) 			not null constraint country_ak unique,
	Country 					nvarchar(150) 			not null,
	Country_VID 				integer,
	Active_Flag 				nvarchar(1) 			not null constraint df_country_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_country_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_country_update_date default getdate() )
go


if object_id('dbo.DC_52_Data', 'U') is not null
	drop table dbo.DC_52_Data
go 
create table dbo.DC_52_Data(
	id 							int identity(1,1) 	not null constraint PK_DC_52_Data primary key,
	sp_id 						int 				not null,
	full_name 					nvarchar(255),
	branch_project 				nvarchar(255),
	vol_id 						int 				not null,
	dept 						nvarchar(255),
	co_status 					nvarchar(30),
	to_status 					nvarchar(30),
	vd_status 					nvarchar(30),
	end_date 					date,
	start_date 					date,
	vd_date 					date,
	assignment 					nvarchar(255),
	CMS_Test1 					nvarchar(255),
	1_clear_thinking 			nvarchar(10),
	1_displays_fruit_spirit 	nvarchar(10),
	10_ability_lead 			nvarchar(10),
	11_ability_train 			nvarchar(10),
	12_quality_concscious 		nvarchar(10),
	2_dependability 			nvarchar(10),
	2_display_humility 			nvarchar(10),
	3_eager_learn 				nvarchar(10),
	3_proper_dress 				nvarchar(10),
	4_comm_effectively 			nvarchar(10),
	4_support_theo_direction 	nvarchar(10),
	5_cooperates 				nvarchar(10),
	5_org_ability 				nvarchar(10),
	6_attends_cong_mtg 			nvarchar(10),
	6_work_well_others 			nvarchar(10),
	7_share_ministry 			nvarchar(10),
	7_problem_solving			nvarchar(10),
	8_good_health 				nvarchar(10),
	8_productivity 				nvarchar(10),
	9_safety_conscious 			nvarchar(10),
	assistant 					nvarchar(255),
	co_reviewed 				nvarchar(255),
	overseer 					nvarchar(255),
	potential_detail_1 			nvarchar(1000),
	potential_detail_2 			nvarchar(1000),
	potential_detail_3 			nvarchar(1000),
	potential_oversight_1 		nvarchar(1000),
	potential_oversight_2 		nvarchar(1000),
	potential_oversight_3 		nvarchar(1000),
	potential_role_1 			nvarchar(255),
	potential_role_2 			nvarchar(255),
	potential_role_3 			nvarchar(255),
	future_assignments 			nvarchar(10),
	title 						nvarchar(255),
	to_reviewed 				nvarchar(30),
	trade_skill_1 				nvarchar(255),
	trade_skill_1_details 		nvarchar(1000),
	trade_skill_1_level 		nvarchar(255),
	trade_skill_2 				nvarchar(255),
	trade_skill_2_details 		nvarchar(1000),
	trade_skill_2_level 		nvarchar(255),
	trade_skill_3 				nvarchar(255),
	trade_skill_3_details 		nvarchar(1000),
	trade_skill_3_level 		nvarchar(255),
	volunteer_desk 				nvarchar(1000),
	counsel_given 				nvarchar(1000),
	summary_comments 			nvarchar(3000),
	load_date 					datetime 			not null,
	update_date 				datetime 			not null )
go

alter table dbo.dc_52_data add  constraint df_dc_52_data_load_date  default (getdate()) for load_date
go

alter table dbo.dc_52_data add  constraint df_dc_52_data_update_date  default (getdate()) for update_date
go


if object_id('dbo.DC52_To_Review', 'U') is not null
	drop table dbo.DC52_To_Review
go 
create table dbo.DC52_To_Review(
	volunteer_name 			nvarchar(255) 		not null,
	volunteer_key 			int,
	hub_volunteer_num 		int 				not null,
	hub_person_id 			int,
	parent_dept_name 		nvarchar(255),
	dept_name 				nvarchar(255),
	enrollment_start_date 	date,
	enrollment_end_date 	date,
	ovsr_name 				nvarchar(255),
	ovsr_email 				nvarchar(255),
	asst_name 				nvarchar(255),
	asst_email 				nvarchar(255),
	enrollment_code 		nvarchar(30),
	processed_to_sp 		nvarchar(1),
	load_date 				datetime 			not null,
	update_date 			datetime 			not null,
	id 						int identity(1,1) 	not null constraint pk_dc52_to_review primary key
)
go

alter table dbo.dc52_to_review add  constraint df_dc52_to_review_load_date  default (getdate()) for load_date
go

alter table dbo.dc52_to_review add  constraint df_dc52_to_review_update_date  default (getdate()) for update_date
go


if object_id('dbo.Dept_Asgn', 'U') is not null
	drop table dbo.Dept_Asgn
go 
create table dbo.Dept_Asgn(
	Dept_Asgn_Key 				integer identity(1,1) 	not null constraint dept_asgn_pk primary key,
	HPR_Dept_Key 				integer 			 	not null,
	HPR_Dept_Sharepoint_Key		nvarchar(255),
	HPR_Crew_Key				integer 				not null constraint df_dept_asgn_crew default 0,
	HPR_Crew_Sharepoint_Key		nvarchar(255),
	HPR_Dept_Role_Key			integer 				not null constraint df_dept_asgn_role default 0,
	HPR_Dept_Role_Sharepoint_Key nvarchar(255),
	Enrollment_Key				integer,
	Skill_Level					nvarchar(255),
	Dept_Start_Date				date,
	Dept_End_Date				date,
	Notes						nvarchar(4000),
	Dept_First_Name				nvarchar(255),
	Dept_Last_Name				nvarchar(255),
	Dept_Asgn_Status_Key		integer,
	Priority_Key				integer					not null constraint df_dept_asgn_priority default 3,
	Candidate_1_Name			nvarchar(255),
	Candidate_1_Profile			nvarchar(255),
	Candidate_2_Name			nvarchar(255),
	Candidate_2_Profile			nvarchar(255),
	Candidate_3_Name			nvarchar(255),
	Candidate_3_Profile			nvarchar(255),
	VTC_Meeting_Code			nvarchar(10)			not null constraint df_dept_asgn_vtc_mt_code default 'N',
	Volunteer_Key				integer,
	PS_Start_Date		 		date,
	PS_End_Date					date,
	Marital_Status_Key			integer,
	Cong_Servant_Code			nvarchar(3),
	PS_Notes					nvarchar(4000),
	Job_Description				nvarchar(255),
	Invite_Chart_Comments		nvarchar(4000),
	ID_SP						integer,
	Active_Flag 				nvarchar(1) 			not null constraint df_dept_asgn_active_flag default 'Y',
	Test_Data_Flag 				nvarchar(1) 			not null constraint df_dept_asgn_test_data_flag default 'N',
	Sync_Data_Flag				nvarchar(50),
	Current_Sync_Status			nvarchar(50),
	Num_Weeks					int,
	Num_Months					int,
	Until_Not_Needed			nvarchar(1),
	Short_Term_OK				nvarchar(1),
	Trade_To_Qualify			nvarchar(1),
	Candidate_1_Vol_key			int,
	Candidate_2_Vol_key			int,
	Candidate_3_Vol_key			int,
	Quantity_To_Replicate		int,
	Multiple_Record_Number		nvarchar(50),	
	Num_Weeks 					int,		
	Num_Months 					int,		
	Until_Not_Needed 			nvarchar(1),
	Short_Term_OK 				nvarchar(1),
	Trade_To_Qualify 			nvarchar(1),
	Candidate_1_Vol_key 		int,
	Candidate_2_Vol_key 		int,
	Candidate_3_Vol_key 		int,
	Quantity_To_Replicate 		int,
	Multiple_Record_Number 		nvarchar(50),
	Candidate_1_Next_Step 		nvarchar(50),
	Candidate_2_Next_Step 		nvarchar(50),
	Candidate_3_Next_Step 		nvarchar(50),
	Possible_Sister 			nvarchar(1),
	HuBIncidentURL 				nvarchar(255),
 	Ext_Orig_PS_End_Date 		date,
	Ext_Orig_Enrollment_Key 	int,
	Ext_Orig_Dept_Asgn_Status_Key int,
	Ext_Last_Start_Date date 	null,	
	Extension_Flag 				nvarchar(1				not null constraint df_dept_asgn_extension_flag default 'N',
	Extension_Flag_UpdateDate 	datetime,	
	Load_Date 					datetime 				not null constraint df_dept_asgn_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_dept_asgn_update_date default getdate() )
go

alter table dbo.dept_asgn add constraint dept_asgn_fk_dept_asgn_status foreign key ( dept_asgn_status_key ) references dbo.dept_asgn_status( dept_asgn_status_key )
go

alter table dbo.dept_asgn add constraint dept_asgn_fk_dept foreign key ( hpr_dept_key ) references dbo.hpr_dept( hpr_dept_key )
go

--alter table dbo.dept_asgn with nocheck add constraint dept_asgn_fk_crew foreign key ( hpr_crew_key ) references dbo.hpr_crew( hpr_crew_key )
--go

alter table dbo.dept_asgn with nocheck add constraint dept_asgn_fk_dept_role foreign key ( hpr_dept_role_key ) references dbo.hpr_dept_role( hpr_dept_role_key )
go

alter table dbo.dept_asgn add constraint dept_asgn_fk_priority foreign key ( priority_key ) references dbo.priority( priority_key )
go


create table dbo.Dept_Asgn_LeadTime(
	Dept_Asgn_LeadTime_Key 		int identity(1,1) 	not null,
	Enrollment_Key				int 				not null,
	New_No_Earlier				int,
	New_No_Later				int,
	Transfer_No_Earlier			int,
	Transfer_No_Later			int,
	Active_Flag					nvarchar(1),
	Load_Date					datetime 			not null,
	Update_Date					datetime 			not null )
go

alter table dbo.dept_asgn_leadtime add constraint df_dept_asgn_leadtime_load_date default (getdate()) for load_date
go

alter table dbo.dept_asgn_leadtime add constraint df_dept_asgn_leadtime_update_date default (getdate()) for update_date
go


if object_id('dbo.Dept_Asgn_Phase', 'U') is not null
	drop table dbo.Dept_Asgn_Phase
go 
create table dbo.Dept_Asgn_Phase(
	Dept_Asgn_Phase_Key			integer identity(1,1) 	not null constraint dept_asgn_phase_pk primary key,
	Dept_Asgn_Phase_Code		nvarchar(10) 			not null,
	Dept_Asgn_Phase				nvarchar(150) 			not null,
	Active_Flag 				nvarchar(1) 			not null constraint df_dept_asgn_phase_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_dept_asgn_phase_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_dept_asgn_phase_update_date default getdate() )
go


if object_id('dbo.Dept_Asgn_Status', 'U') is not null
	drop table dbo.Dept_Asgn_Status
go 
create table dbo.Dept_Asgn_Status(
	Dept_Asgn_Status_Key 		integer identity(1,1) 	not null constraint dept_asgn_status_pk primary key,
	Dept_Asgn_Status_Type		nvarchar(3)				not null, 		-- PS or CI or VOL (Volunteer)
	Dept_Asgn_Status_Code 		nvarchar(30) 			not null,
	Dept_Asgn_Status 			nvarchar(150) 			not null,
	Sort_Trade_Request			int,			
	Color_Trade_Request			nvarchar(15),
 	Color_Trade_Request_RGB		nvarchar(15),
	Active_Flag 				nvarchar(1) 			not null constraint df_dept_asgn_status_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_dept_asgn_status_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_dept_asgn_status_update_date default getdate() )
go

alter table dbo.dept_asgn_status add constraint dept_asgn_status_ak unique ( dept_asgn_status_type, dept_asgn_status_code )
go


if object_id('dbo.Dept_Asgn_Volunteer', 'U') is not null
	drop table dbo.Dept_Asgn_Volunteer
go 
create table dbo.Dept_Asgn_Volunteer(
	Dept_Asgn_Volunteer_Key 	integer identity(1,1) 	not null constraint dept_asgn_volunteer_pk primary key,
	Dept_Asgn_Key				integer					not null,
	Volunteer_Key				integer 				not null,
	Dept_Asgn_Phase_Key			integer 			 	not null,
	Dept_Asgn_Status_Key		integer					not null,
	Notes						nvarchar(4000),
	Active_Flag 				nvarchar(1) 			not null constraint df_dept_asgn_volunteer_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_dept_asgn_volunteer_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_dept_asgn_volunteer_update_date default getdate() )
go

alter table dbo.dept_role_volunteer add constraint dept_asgn_volunteer_ak unique ( dept_role_key, volunteer_key )
go

alter table dbo.dept_role_volunteer add constraint dept_asgn_volunteer_fk_dept_asgn foreign key ( dept_asgn_key ) references dbo.dept_asgn( dept_asgn_key )
go

alter table dbo.dept_role_volunteer add constraint dept_asgn_volunteer_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key )
go

alter table dbo.dept_role_volunteer add constraint dept_asgn_volunteer_fk_dept_asgn_phase foreign key ( dept_asgn_phase_key ) references dbo.dept_asgn_phase( dept_asgn_phase_key )
go

alter table dbo.dept_role_volunteer add constraint dept_asgn_volunteer_fk_dept_asgn_status foreign key ( dept_asgn_status_key ) references dbo.dept_asgn_status( dept_asgn_status_key )
go


if object_id('dbo.Enrollment', 'U') is not null
	drop table dbo.Enrollment
go 
create table dbo.Enrollment(
	Enrollment_Key 				integer identity(1,1) 	not null constraint enrollment_pk primary key,
	Enrollment_Code 			nvarchar(30) 			not null,
	Enrollment 					nvarchar(150) 			not null,
	Enrollment_Desc 			nvarchar(255),
	Rank_Num 					smallint,
	Primary_Flag 				nvarchar(1),
	FTS_Flag 					nvarchar(1),
	SFTS_Flag 					nvarchar(1),
	Bethel_Flag 				nvarchar(1),
	Bethel_Family_Flag 			nvarchar(1),
	Regular_Bethel_Flag 		nvarchar(1),
	Foreign_Service_Flag 		nvarchar(1),
	Transition_Flag 			nvarchar(1),
	Start_Date 					date,
	End_Date 					date,
	Enrollment_VID 				integer,
	Active_Flag 				nvarchar(1) 			not null constraint df_enrollment_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_enrollment_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_enrollment_update_date default getdate(),
	constraint enrollment_ak unique ( enrollment_code, end_date ) )
go


if object_id('dbo.ETL_Table_Run', 'U') is not null
	drop table dbo.ETL_Table_Run
go 
create table dbo.ETL_Table_Run(
	ETL_Table_Run_Key 			integer identity(1,1) 	not null constraint etl_table_run_pk primary key,
	ETL_Table 					nvarchar(150)			not null,
	Status_Code		 			nvarchar(30),
	Rows_Inserted				integer,
	Rows_Updated				integer,
	Rows_Deleted				integer,
	Start_Time 					datetime,
	End_Time 					datetime )
go


if object_id('dbo.Event', 'U') is not null
	drop table dbo.Event
go 
create table dbo.Event(
	Event_Key 					integer identity(1,1) 	not null constraint event_pk primary key,
	Event_Type_Key 				integer 				not null,
	Event_System_Key 			integer 				not null,
	Event 						nvarchar(150)			not null,
	Event_Description 			nvarchar(255),
	Tracking_Code 				nvarchar(255),
	Coor_User_Key 				integer,
	Start_Date 					date,
	End_Date 					date,
	Active_Flag 				nvarchar(1) 			not null constraint df_event_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_event_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_event_update_date default getdate() )
go

alter table dbo.event add constraint event_fk_event_type foreign key ( event_type_key ) references dbo.event_type( event_type_key )
go

alter table dbo.event add constraint event_fk_event_system foreign key ( event_system_key ) references dbo.event_system( event_system_key )
go

if object_id('dbo.Event_Attribute', 'U') is not null
	drop table dbo.Event_Attribute
go 
create table dbo.Event_Attribute(
	Event_Attribute_Key 		integer identity(1,1) 	not null constraint event_attribute_pk primary key,
	Event_Key 					integer 				not null,
	Event_Attribute 			nvarchar(4000)			not null,
	Event_Attribute_Group 		nvarchar(20),
	Crew_Key 					integer,
	Attribute_Data_Type_Key 	integer,
	Attribute_LOV_Key 			integer,
	Column_Number 				integer,
	TO_Profile_Active_Flag 		nvarchar(1) 			not null constraint df_event_attribute_to_profile_active_flag default 'N',
	WRK_Event_Attribute_Key		integer,
	Active_Flag 				nvarchar(1) 			not null constraint df_event_attribute_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_event_attribute_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_event_attribute_update_date default getdate() )
go

alter table dbo.event_attribute add constraint event_attribute_fk_event foreign key ( event_key ) references dbo.event( event_key )
go

alter table dbo.event_attribute add constraint event_attribute_fk_attribute_data_type foreign key ( attribute_data_type_key ) references dbo.attribute_data_type( attribute_data_type_key )
go

alter table dbo.event_attribute add constraint event_attribute_fk_attribute_lov foreign key ( attribute_lov_key ) references dbo.attribute_lov( attribute_lov_key )
go


if object_id('dbo.Event_System', 'U') is not null
	drop table dbo.Event_System
go 
create table dbo.Event_System(
	Event_System_Key 			integer identity(1,1) 	not null constraint event_system_pk primary key,
	Event_System 				nvarchar(150) 			not null constraint event_system_ak unique,
	Active_Flag 				nvarchar(1) 			not null constraint df_event_system_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_event_system_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_event_system_update_date default getdate() )
go


if object_id('dbo.Event_Type', 'U') is not null
	drop table dbo.Event_Type
go 
create table dbo.Event_Type(
	Event_Type_Key 				integer identity(1,1) 	not null constraint event_type_pk primary key,
	Event_Type 					nvarchar(150) 			not null constraint event_type_ak unique,
	Active_Flag 				nvarchar(1) 			not null constraint df_event_type_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_event_type_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_event_type_update_date default getdate() )
go


if object_id('dbo.HPR_Crew', 'U') is not null
	drop table dbo.HPR_Crew
go 
create table dbo.HPR_Crew(
	HPR_Crew_Key				integer identity(1,1) 	not null constraint hpr_crew_pk primary key,
	HPR_Crew_Sharepoint_Key		nvarchar(255),
	HPR_Dept_Key 				integer 			 	not null,
	HPR_Dept_Sharepoint_Key		nvarchar(255),	
	Crew_Name					nvarchar(255)			not null,			
	Crew_Ovsr					nvarchar(255)			not null,
	Crew_Ovsr_Person_ID			integer,
	Crew_Ovsr_Email				nvarchar(255)			not null,
	Start_Date					date,
	Active_Flag 				nvarchar(1) 			not null constraint df_hpr_crew_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_hpr_crew_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_hpr_crew_update_date default getdate(),
	constraint hpr_crew_ak unique ( hpr_dept_key, crew_name ) )
go	

alter table dbo.hpr_crew add constraint hpr_crew_fk_hpr_dept foreign key ( hpr_dept_key ) references dbo.hpr_dept( hpr_dept_key )
go		


if object_id('dbo.HPR_Dept', 'U') is not null
	drop table dbo.HPR_Dept
go 
create table dbo.HPR_Dept(
	HPR_Dept_Key 					integer identity(1,1) 	not null constraint hpr_dept_pk primary key,
	HPR_Dept_Sharepoint_Key			nvarchar(255),
	CPC_Code						nvarchar(10)			not null,
	Dept_Name						nvarchar(100) 			not null,
	Work_Group_Name					nvarchar(100)			not null,
	CVC_Sheet_Name					nvarchar(100),
	PC_Code							nvarchar(30),
	PC_Code_Full					nvarchar(100),
	PC_Category						nvarchar(100),
	Dept_Ovsr						nvarchar(255),
	Dept_Ovsr_Person_ID				integer,
	Dept_Ovsr_Email					nvarchar(255),
	Dept_Asst_Ovsr					nvarchar(255),
	Dept_Asst_Ovsr_Person_ID		integer,
	Dept_Asst_Ovsr_Email			nvarchar(255),	
	Work_Group_Ovsr					nvarchar(255),
	Work_Group_Ovsr_Person_ID		integer,
	Work_Group_Ovsr_Email			nvarchar(255),	
	Work_Group_Asst_Ovsr			nvarchar(255),
	Work_Group_Asst_Ovsr_Person_ID	integer,
	Work_Group_Asst_Ovsr_Email		nvarchar(255),
	Work_Group_Coor					nvarchar(255),
	Work_Group_Coor_Person_ID		integer,
	Work_Group_Coor_Email			nvarchar(255),
	VTC_Contact						nvarchar(255),
	VTC_1_User_Key					integer					not null default df_hpr_dept_vtc1 default 1,
	VTC_2_User_Key					integer					not null default df_hpr_dept_vtc2 default 1,
	VTC_3_User_Key					integer					not null default df_hpr_dept_vtc3 default 1,
	VTC_4_User_Key					integer					not null default df_hpr_dept_vtc4 default 1,
	VTC_5_User_Key					integer					not null default df_hpr_dept_vtc5 default 1,
	VTC_6_User_Key					integer					not null default df_hpr_dept_vtc6 default 1,
	VTC_7_User_Key					integer					not null default df_hpr_dept_vtc7 default 1,
	VTC_8_User_Key					integer					not null default df_hpr_dept_vtc8 default 1,
	Start_Date						date,
	HUB_Flag						nvarchar(1)				not null constraint df_hpr_dept_hub_flag default 'N',
	NYC_Flag						nvarchar(1)				not null constraint df_hpr_dept_nyc_flag default 'N',
	HUB_Dept_ID						integer,
	Level_01						nvarchar(100),
	Level_02						nvarchar(100),	
	Level_03						nvarchar(100),	
	Level_04						nvarchar(100),
	Level_05						nvarchar(100),
	Level_06						nvarchar(100),
	Level_07						nvarchar(100),
	Level_08						nvarchar(100),
	Level_09						nvarchar(100),	
	Level_10						nvarchar(100),	
	Parent_HPR_Dept_Key				integer,
	Active_Flag 					nvarchar(1) 			not null constraint df_hpr_dept_active_flag default 'Y',
	Load_Date 						datetime 				not null constraint df_hpr_dept_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_hpr_dept_update_date default getdate(),
	constraint hpr_dept_ak unique ( dept_name, work_group_name ) )
go


if object_id('dbo.HPR_Dept_Role', 'U') is not null
	drop table dbo.HPR_Dept_Role
go 
create table dbo.HPR_Dept_Role(
	HPR_Dept_Role_Key			integer identity(1,1) 	not null constraint hpr_dept_role_pk primary key,
	HPR_Dept_Role_Sharepoint_Key nvarchar(255),
	CPC_Code					nvarchar(10)			not null,
	Dept_Role					nvarchar(150) 			not null,
	Active_Flag 				nvarchar(1) 			not null constraint df_hpr_dept_role_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_hpr_dept_role_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_hpr_dept_role_update_date default getdate() )
go


if object_id('dbo.Marital_Status', 'U') is not null
	drop table dbo.Marital_Status
go 
create table dbo.Marital_Status(
	Marital_Status_Key 			integer identity(1,1) 	not null constraint marital_status_pk primary key,
	Marital_Status_Code 		nvarchar(30) 			not null constraint marital_status_ak unique,
	Marital_Status 				nvarchar(150) 			not null constraint marital_status_ak2 unique,
	Marital_Status_VID 			integer,
	Active_Flag 				nvarchar(1) 			not null constraint df_marital_status_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_marital_status_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_marital_status_update_date default getdate() )
go


if object_id('dbo.Postal_Code', 'U') is not null
	drop table dbo.Postal_Code
go 
create table dbo.Postal_Code(
	Postal_Code_Key 			integer identity(1,1) 	not null constraint postal_code_pk primary key,
	Postal_Code 				nvarchar(10) 			not null constraint postal_code_ak unique,
	City 						nvarchar(150),
	State_Key 					integer,
	HPR_Flag					nvarchar(1)				not null constraint df_postal_code_hpr_flag default 'N', 
	Local_Flag 					nvarchar(1) 			not null constraint df_postal_code_local_flag default 'N',
	Driving_Distance_Flag 		nvarchar(1) 			not null constraint df_postal_code_driving_distance_flag default 'N',
	PAT_Flag			 		nvarchar(1) 			not null constraint df_postal_code_pat_flag default 'N',
	Active_Flag 				nvarchar(1) 			not null constraint df_postal_code_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_postal_code_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_postal_code_update_date default getdate() )
go


if object_id('dbo.Priority', 'U') is not null
	drop table dbo.Priority
go 
create table dbo.Priority(
	Priority_Key				integer identity(1,1) 	not null constraint priority_pk primary key,
	Priority					nvarchar(30) 			not null,
	Sort_Order					integer 				not null,
	Active_Flag 				nvarchar(1) 			not null constraint df_priority_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_priority_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_priority_update_date default getdate() )
go


if object_id('dbo.PRP', 'U') is not null
	drop table dbo.PRP
go 
create table dbo.PRP(
	PRP_Key 				integer identity(1,1) 	not null constraint prp_pk primary key,
	HPR_Dept_Key			integer,
	Cal_Dt					date					not null,
	Bed_Cnt					integer					not null,
	CPC_Code				nvarchar(10),
	HuB_Dept_Name			nvarchar(500),
	Dept_Name				nvarchar(500),
	Work_Group_Name			nvarchar(500),
	PC_Category				nvarchar(50),
	PC_Code					nvarchar(50),
	PRP_Cnt					integer,
	Load_Date 				datetime 				not null constraint df_prp_load_date default getdate() )
go


if object_id('dbo.PRP_Actuals_Level_04', 'U') is not null
	drop table dbo.PRP_Actuals_Level_04
go 
create table dbo.PRP_Actuals_Level_04(
	cpc_code 			nvarchar(10) not null,
	level_03 			nvarchar(100) not null,
	level_04 			nvarchar(100) not null,
	wk_01_dt 			date,
	wk_01_budget 		int,
	wk_01_used 			int,
	wk_01_avail			int,
	wk_02_dt 			date,
	wk_02_budget 		int,
	wk_02_used 			int,
	wk_02_avail 		int,
	wk_03_dt 			date,
	wk_03_budget 		int,
	wk_03_used 			int,
	wk_03_avail 		int,
	wk_04_dt 			date,
	wk_04_budget 		int,
	wk_04_used 			int,
	wk_04_avail 		int,
	wk_05_dt 			date,
	wk_05_budget 		int,
	wk_05_used 			int,
	wk_05_avail 		int,
	wk_06_dt 			date,
	wk_06_budget 		int,
	wk_06_used 			int,
	wk_06_avail 		int,
	wk_07_dt 			date,
	wk_07_budget 		int,
	wk_07_used 			int,
	wk_07_avail 		int,
	wk_08_dt 			date,
	wk_08_budget 		int,
	wk_08_used 			int,
	wk_08_avail 		int,
	wk_09_dt 			date,
	wk_09_budget 		int,
	wk_09_used 			int,
	wk_09_avail 		int,
	wk_10_dt 			date,
	wk_10_budget 		int,
	wk_10_used 			int,
	wk_10_avail 		int,
	wk_11_dt 			date,
	wk_11_budget 		int,
	wk_11_used 			int,
	wk_11_avail 		int,
	wk_12_dt 			date,
	wk_12_budget 		int,
	wk_12_used 			int,
	wk_12_avail 		int,
	wk_13_dt 			date,
	wk_13_budget 		int,
	wk_13_used 			int,
	wk_13_avail 		int,
	wk_14_dt 			date,
	wk_14_budget 		int,
	wk_14_used 			int,
	wk_14_avail 		int,
	wk_15_dt 			date,
	wk_15_budget 		int,
	wk_15_used 			int,
	wk_15_avail 		int,
	wk_16_dt 			date,
	wk_16_budget 		int,
	wk_16_used 			int,
	wk_16_avail 		int,
	wk_17_dt 			date,
	wk_17_budget 		int,
	wk_17_used 			int,
	wk_17_avail 		int,
	wk_18_dt 			date,
	wk_18_budget 		int,
	wk_18_used 			int,
	wk_18_avail 		int,
	wk_19_dt 			date,
	wk_19_budget 		int,
	wk_19_used 			int,
	wk_19_avail 		int,
	wk_20_dt 			date,
	wk_20_budget 		int,
	wk_20_used 			int,
	wk_20_avail 		int,
	wk_21_dt 			date,
	wk_21_budget 		int,
	wk_21_used 			int,
	wk_21_avail 		int,
	wk_22_dt 			date,
	wk_22_budget 		int,
	wk_22_used 			int,
	wk_22_avail 		int,
	wk_23_dt 			date,
	wk_23_budget 		int,
	wk_23_used 			int,
	wk_23_avail 		int,
	wk_24_dt 			date,
	wk_24_budget 		int,
	wk_24_used 			int,
	wk_24_avail 		int,
	wk_25_dt 			date,
	wk_25_budget 		int,
	wk_25_used 			int,
	wk_25_avail 		int,
	wk_26_dt 			date,
	wk_26_budget 		int,
	wk_26_used 			int,
	wk_26_avail 		int,
	Load_Date 			datetime not null
) 
go

alter table dbo.prp_actuals_level_04 add  constraint df_prp_actuals_level_04_load_date  default (getdate()) for load_date
go


if object_id('dbo.PRP_Bed_Space', 'U') is not null
	drop table dbo.PRP_Bed_Space
go 
create table dbo.PRP_Bed_Space(
	PRP_Bed_Space_Key 		integer identity(1,1) 	not null constraint prp_bed_space_pk primary key,
	Cal_Dt					date					not null,
	Rooming_Category		nvarchar(200),
	Rooming_Detail			nvarchar(200),
	Reporting_Category		nvarchar(200),
	Bed_Cnt					integer					not null,
	Load_Date 				datetime 				not null constraint df_prp_bed_space_load_date default getdate() )
go


if object_id('dbo.PRP_CPC', 'U') is not null
	drop table dbo.PRP_CPC
go 
create table dbo.PRP_CPC(
	CPC_Code				nvarchar(10)			not null,
	Cal_Dt					date					not null,
	Bed_Cnt					integer					not null,
	PC_Code					nvarchar(50),
	Load_Date 				datetime 				not null constraint df_prp_cpc_load_date default getdate() )
go

alter table dbo.PRP_CPC add constraint prp_cpc_pk primary key ( cpc_code, cal_dt )
go


if object_id('dbo.Skill', 'U') is not null
	drop table dbo.Skill
go 
create table dbo.Skill(
	Skill_Key 					integer identity(1,1) 	not null constraint skill_pk primary key,
	Skill 						nvarchar(150) 			not null,
	HUB_Skill_ID				integer					not null constraint df_skill_hub_skill_id default 0,
	HUB_Flag 					nvarchar(1)				not null constraint df_skill_hub_flag default 'Y',
	BA_Skill_GUID				uniqueidentifier,
	BA_Flag						nvarchar(1)				not null constraint df_skill_ba_flag default 'Y',
	Active_Flag 				nvarchar(1) 			not null constraint df_skill_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_skill_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_skill_update_date default getdate(),
	constraint skill_ak unique ( Skill, Active_Flag ))
go


if object_id('dbo.Skill_Level', 'U') is not null
	drop table dbo.Skill_Level
go 
create table dbo.Skill_Level(
	Skill_Level_Key 			integer identity(1,1) 	not null constraint skill_level_pk primary key,
	Skill_Level_Code 			integer 				not null constraint skill_level_ak unique,
	Skill_Level 				nvarchar(150) 			not null,
	Skill_Level_Desc 			nvarchar(255),
	Active_Flag 				nvarchar(1) 			not null constraint df_skill_level_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_skill_level_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_skill_level_update_date default getdate() )
go


if object_id('dbo.Skill_Speciality', 'U') is not null
	drop table dbo.Skill_Speciality
go 
create table dbo.Skill_Speciality(
	Skill_Speciality_Key 		integer identity(1,1) 	not null constraint skill_speciality_pk primary key,
	Skill_Key 					integer 				not null,
	Skill_Speciality 			nvarchar(150) 			not null,
	HUB_Skill_Speciality_ID 	integer					not null constraint df_skill_speciality_hub_skill_speciality_id default 0,
	HUB_Flag 					nvarchar(1)				not null constraint df_skill_speciality_hub_flag default 'Y',
	BA_Subskill_GUID			uniqueidentifier,
	BA_Flag						nvarchar(1)				not null constraint df_skill_speciality_ba_flag default 'Y',	
	Active_Flag 				nvarchar(1) 			not null constraint df_skill_speciality_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_skill_speciality_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_skill_speciality_update_date default getdate()
	HUB_Skill_Subskill_ID		integer,
	Skill_Subskill				nvarchar(200),
	BA_Skill_Speciality_GUID	uniqueidentifier )
go

alter table dbo.skill_speciality add constraint skill_speciality_fk_skill foreign key ( skill_key ) references dbo.skill( skill_key )
go


if object_id('dbo.Source_System', 'U') is not null
	drop table dbo.Source_System
go 
create table dbo.Source_System(
	Source_System_Key 			integer identity(1,1) 	not null constraint source_system_pk primary key,
	Source_System_Code 			nvarchar(30) 			not null constraint source_system_ak unique,
	Source_System 				nvarchar(150) 			not null,
	Active_Flag 				nvarchar(1) 			not null constraint df_source_system_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_source_system_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_source_system_update_date default getdate() )
go


if object_id('dbo.Staffing_Matrix', 'U') is not null
	drop table dbo.Staffing_Matrix
go 
create table dbo.Staffing_Matrix(
	cal_dt 				date 			not null,
	cpc_code 			nvarchar(10) 	not null,
	level_02 			nvarchar(100),
	level_03 			nvarchar(100),
	level_04 			nvarchar(100),
	crew_name 			nvarchar(255),
	dept_role 			nvarchar(150),
	ps_start_date 		date,
	ps_end_date 		date,
	full_name 			nvarchar(255),
	ps_enrollment_code 	nvarchar(30),
	room_site_code 		nvarchar(30),
	room_bldg_code 		nvarchar(30),
	dept_asgn_status 	nvarchar(150),
	ps_notes 			nvarchar(4000),
	dept_asgn_key 		int 			not null,
	hpr_dept_key 		int 			not null
) 
go


if object_id('dbo.State', 'U') is not null
	drop table dbo.State
go 
create table dbo.State(
	State_Key 					integer identity(1,1) 	not null constraint state_pk primary key,
	State_Code 					nvarchar(30) 			not null,
	State 						nvarchar(255) 			not null,
	Country_Key 				integer					not null,
	State_VID 					integer,
	Active_Flag 				nvarchar(1) 			not null constraint df_state_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_state_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_state_update_date default getdate(),
	constraint state_ak unique ( state_code, country_key ) )
go

alter table dbo.state add constraint state_fk_country foreign key ( country_key ) references dbo.country( country_key )
go


if object_id('dbo.Tracking_Status', 'U') is not null
	drop table dbo.Tracking_Status
go 
create table dbo.Tracking_Status(
	Tracking_Status_Key 		integer identity(1,1) 	not null constraint tracking_status_pk primary key,
	Tracking_Status 			nvarchar(255) 			not null constraint tracking_statue_ak unique,
	Active_Flag 				nvarchar(1) 			not null constraint df_tracking_status_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_tracking_status_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_tracking_status_update_date default getdate() )
go


if object_id('dbo.[User]', 'U') is not null
	drop table dbo.[User]
go 
create table dbo.[User](
	User_Key 						integer identity(1,1) 	not null constraint user_pk primary key,
	First_Name 						nvarchar(150)			not null,
	Last_Name 						nvarchar(150)			not null,
	Email 							nvarchar(150),
	AD_User_Name 					nvarchar(150)			not null constraint user_ak unique,
	PC_Name 						nvarchar(25),
	User_Access_Level_Code 			tinyint 				not null constraint df_user_user_access_level_code_flag default 99,
	Refresh_Flag 					nvarchar(1)  			not null constraint df_user_refresh_flag default 'N',
	Admin_Flag 						nvarchar(1)  			not null constraint df_user_admin_flag default 'N',
	Beta_Flag 						nvarchar(1)  			not null constraint df_user_beta_flag default 'N',
	VTC_Flag						nvarchar(1)				not null constraint df_user_vtc_flag default 'N',
	VTC_CPC_Code					nvarchar(3),
	VTC_Level_02					nvarchar(100),
	VTC_Level_03					nvarchar(100),	
	Temp_Desk_Flag					nvarchar(1)				not null constraint df_user_temp_desk_flag default 'N',	
	User_Dashboard_Name				nvarchar(200),
	User_Dashboard_Notepad			nvarchar(max),
	User_Dashboard_Last_View_Date	datetime,	
	Active_Flag 					nvarchar(1) 			not null constraint df_user_active_flag default 'Y',
	Load_Date 						datetime 				not null constraint df_user_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_user_update_date default getdate() )
go

alter table dbo.[User] add constraint user_fk_user_access_level foreign key ( user_access_level_code ) references dbo.user_access_level( user_access_level_code )
go


if object_id('dbo.User_Access_Level', 'U') is not null
	drop table dbo.User_Access_Level
go 
create table dbo.User_Access_Level(
	User_Access_Level_Code 		tinyint 				not null constraint user_access_level_pk primary key,
	User_Access_Level 			nvarchar(255) 			not null constraint user_access_level_ak unique,
	Active_Flag 				nvarchar(1) 			not null constraint df_user_access_level_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_user_access_level_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_user_access_level_update_date default getdate() )
go


if object_id('dbo.User_Activity', 'U') is not null
	drop table dbo.User_Activity
go 
create table dbo.User_Activity(
	User_Activity_Key 			integer identity(1,1) 	not null constraint user_activity_pk primary key,
	User_Key 					integer 				not null,
	User_Computer_Name 			nvarchar(50),
	Login_Datetime 				datetime 				not null constraint df_user_activity_login default getdate(),
	Logoff_Datetime 			datetime )
go

alter table dbo.user_activity add constraint user_activity_fk_user foreign key ( user_key ) references dbo.[user]( user_key )
go


if object_id('dbo.User_List', 'U') is not null
	drop table dbo.User_List
go 
create table dbo.User_List(
	User_List_Key 				integer identity(1,1) 	not null constraint user_list_pk primary key,
	User_Key 					integer 				not null,
	User_List 					nvarchar(150)			not null,
	User_List_Description 		nvarchar(1000),
	Dept_Asgn_Key 				integer					not null constraint df_user_list_dept_asgn default 0,
	PQ_Flag 					nvarchar(1) 			not null constraint df_user_list_pq_flag default 'N',	
	HPR_Dept_Key				integer,
	Active_Flag 				nvarchar(1) 			not null constraint df_user_list_active_flag default 'Y',
	Load_Date 					datetime 				not null constraint df_user_list_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_user_list_update_date default getdate(),
	constraint user_list_ak unique ( user_key, user_list ) )
go

alter table dbo.user_list add constraint user_list_fk_user foreign key ( user_key ) references dbo.[User]( user_key )
go

alter table dbo.user_list with nocheck add constraint user_list_fk_dept_asgn foreign key ( dept_asgn_key ) references dbo.dept_asgn( dept_asgn_key )
go

alter table dbo.user_list nocheck constraint user_list_fk_dept_role
go

alter table dbo.user_list with nocheck add constraint user_list_fk_hpr_dept foreign key ( pq_hpr_dept_key ) references dbo.hpr_dept( hpr_dept_key )
go

alter table dbo.user_list nocheck constraint user_list_fk_hpr_dept
go


if object_id('dbo.User_List_Volunteer', 'U') is not null
	drop table dbo.User_List_Volunteer
go 
create table dbo.User_List_Volunteer(
	User_List_Volunteer_Key 		integer identity(1,1) 	not null constraint user_list_volunteer_pk primary key,
	User_List_Key 					integer					not null,
	Volunteer_Key 					integer					not null,
	Sort_Order 						smallint,
	User_List_Volunteer_Status_Key	integer					not null constraint df_user_list_volunteer_status_key default 1,
	Status_Date 					datetime,
	Notes 							nvarchar(255),
	Last_Changed_User_Key 			integer,
	Start_Date	 					datetime,
	End_Date 						datetime,
	Active_Flag 					nvarchar(1) 			not null constraint df_user_list_volunteer_active_flag default 'Y',
	Load_Date 						datetime 				not null constraint df_user_list_volunteer_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_user_list_volunteer_update_date default getdate(),
	constraint user_list_volunteer_ak unique ( user_list_key, volunteer_key ) )
go

alter table dbo.user_list_volunteer add constraint user_list_volunteer_fk_user_list foreign key ( user_list_key ) references dbo.user_list( user_list_key ) on delete cascade
go

alter table dbo.user_list_volunteer add constraint user_list_volunteer_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go

alter table dbo.user_list_volunteer add constraint user_list_volunteer_fk_user_list_volunteer_status foreign key ( user_list_volunteer_status_key ) references dbo.user_list_volunteer_status( user_list_volunteer_status_key )
go

alter table dbo.user_list_volunteer add constraint user_list_volunteer_fk_user foreign key ( last_changed_user_key ) references dbo.[User]( user_key )
go


if object_id('dbo.User_List_Volunteer_Status', 'U') is not null
	drop table dbo.User_List_Volunteer_Status
go 
create table dbo.User_List_Volunteer_Status(
	User_List_Volunteer_Status_Key 	integer identity(1,1) 	not null constraint user_list_volunteer_status_pk primary key,
	User_List_Volunteer_Status 		nvarchar(255) 			not null constraint user_list_volunteer_status_ak unique,
	Active_Flag 					nvarchar(1) 			not null constraint df_user_list_volunteer_status_active_flag default 'Y',
	Load_Date 						datetime 				not null constraint df_user_list_volunteer_status_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_user_list_volunteer_status_update_date default getdate() )
go


if object_id('dbo.User_Task', 'U') is not null
	drop table dbo.User_Task
go 
create table dbo.User_Task(
	User_Task_Key 			integer identity(1,1) 	not null constraint user_task_pk primary key,
	User_Key 				integer 				not null,
	User_2_Key				integer,
	User_3_Key				integer,
	Volunteer_Key			integer,
	Person_Name				nvarchar(1000),
	User_Task 				nvarchar(255) 			not null constraint df_user_task_task default ' ',
	Start_Date				date,
	Due_Date				date,
	Notes					nvarchar(4000),
	User_Task_Status_Key	integer					not null constraint df_user_task_user_task_status default 1,
	Priority_Key			integer					not null constraint df_user_task_priority default 3,
	Load_Date 				datetime 				not null constraint df_user_task_load_date default getdate(),
	Update_Date 			datetime 				not null constraint df_user_task_update_date default getdate() )
go

alter table dbo.user_task add constraint user_task_fk_user foreign key ( user_key ) references dbo.[User]( user_key )
go

alter table dbo.user_task add constraint user_task_fk_user_task_status foreign key ( user_task_status_key ) references dbo.user_task_status( user_task_status_key )
go

alter table dbo.user_task add constraint user_task_fk_priority foreign key ( priority_key ) references dbo.priority( priority_key )
go


if object_id('dbo.User_Task_Status', 'U') is not null
	drop table dbo.User_Task_Status
go 
create table dbo.User_Task_Status(
	User_Task_Status_Key 	integer identity(1,1) 	not null constraint user_task_status_pk primary key,
	User_Task_Status 		nvarchar(255) 			not null constraint user_task_status_ak unique,
	Active_Flag 			nvarchar(1) 			not null constraint df_user_task_status_flag default 'Y',
	Load_Date 				datetime 				not null constraint df_user_task_status_load_date default getdate(),
	Update_Date 			datetime 				not null constraint df_user_task_status_update_date default getdate() )
go


if object_id('dbo.Volunteer', 'U') is not null
	drop table dbo.Volunteer
go 
create table dbo.Volunteer(
	Volunteer_Key 					integer identity(1,1) 	not null constraint volunteer_pk primary key,
	Full_Name 						nvarchar(255),
	Last_Name 						nvarchar(150),
	First_Name 						nvarchar(150),
	Middle_Name 					nvarchar(150),
	Preferred_Name 					nvarchar(150),
	Suffix 							nvarchar(30),
	Maiden_Name 					nvarchar(150),
	Address 						nvarchar(150),
	Address2 						nvarchar(150),
	City 							nvarchar(150),
	Postal_Code_Key 				integer,
	State_Key 						integer,
	Country_Key 					integer,
	Preferred_Phone 				nvarchar(20),
	Preferred_Phone_Type 			nvarchar(15),
	Preferred_Phone_Formatted 		nvarchar(30),
	Home_Phone 						nvarchar(100),
	Mobile_Phone 					nvarchar(100),
	Email 							nvarchar(150),
	Alt_Email 						nvarchar(150),
	Birth_Date 						date,
	Baptism_Date 					date,
	Gender_Code 					nvarchar(1),
	Marital_Status_Key 				integer,
	Race_Code						nvarchar(1),
	Cong_Servant_Code 				nvarchar(3),
	Pioneer_Flag 					nvarchar(1),
	Cong_Key 						integer,
	Trade_Contact_Group_Key 		integer,
	Crew_Key 						integer,
	Vol_Desk_User_Key 				integer,
	Tracking_Status_Key 			integer,
	Tracking_Status_Date 			datetime,
	TCG_Contact 					nvarchar(255),
	TCG_Contact_Notes 				nvarchar(4000),
	TCG_Contact_Status_Notes	 	nvarchar(255),
	TCG_Contact_Date 				datetime,
	Vol_Desk_Notes 					nvarchar(4000),
	Trade_Ovsr_Notes 				nvarchar(4000),
	Avail_Short_Notice_Flag 		nvarchar(1),
	Avail_Times_Yr 					integer,
	BA_Volunteer_ID					bigint,
	BA_Volunteer_Num 				integer,
	BA_Active_Flag 					nvarchar(1),
	BA_Profile_Created_Flag 		nvarchar(1),
	BA_Profile_Create_Date 			datetime,
	BA_Safety_Orientation_Date		date,
	HUB_Person_ID 					integer,
	HUB_Person_GUID					uniqueidentifier,
	HUB_Volunteer_Num				integer,
	HUB_Volunteer_ID				integer,
	HUB_Tracking_Flag				nvarchar(1)				not null constraint df_volunteer_tracking_flag default 'N',
	JW_User_Code 					nvarchar(255),
	JW_Username 					nvarchar(150),
	Mate_BA_Volunteer_ID			bigint,
	Mate_BA_Volunteer_Num 			integer,
	Mate_HUB_Person_ID 				integer,
	Mate_HUB_Person_GUID			uniqueidentifier,
	A8_Approved_Flag 				nvarchar(1)				not null constraint df_volunteer_a8_approved_flag default 'N',
	A8_App_Status_Key 				integer,
	A8_App_Date 					date,
	A19_Approved_Flag 				nvarchar(1)				not null constraint df_volunteer_a19_approved_flag default 'N',
	A19_App_Status_Key 				integer,
	A19_App_Date 					date,
	App_Request_Collection_Flag		nvarchar(1)				not null constraint df_volunteer_app_collection_flag default 'N',
	Person_Key_Roles_Flag			nvarchar(1)				not null constraint df_volunteer_person_key_roles_flag default 'N',	
	HPR_Volunteer_Exception_Flag	nvarchar(1)				not null constraint df_volunteer_hpr_volunteer_flag default 'N',
	Staffing_Number_Exception_Flag	nvarchar(1)				not null constraint df_volunteer_staffing_number_flag default '-',
	App_Pursued_By_Value			nvarchar(1000),
	Current_Enrollment_Key 			integer,
	Current_Enrollment_Start_Date	datetime,
	Current_Enrollment_End_Date 	datetime,
	Tentative_End_Date				date,
	RVD_Banner						nvarchar(1000),
	WhatsApp_Flag					nvarchar(1)				not null constraint df_volunteer_whatsapp_flag default 'N',
	SMS_Flag						nvarchar(1)				not null constraint df_volunteer_sms_flag default 'N',
	Cong_Relocation_Date			date,
	Cong_Relocation_Last_Updated_By	nvarchar(100),
	Room_Site_Code					nvarchar(30),
	Room_Bldg						nvarchar(100),
	Room_Bldg_Code					nvarchar(30),
	Room							nvarchar(30),	
	Load_Date 						datetime 				not null constraint df_volunteer_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_volunteer_update_date default getdate() )
go

alter table dbo.volunteer add constraint volunteer_fk_postal_code foreign key ( postal_code_key ) references dbo.postal_code( postal_code_key )
go

alter table dbo.volunteer add constraint volunteer_fk_state foreign key ( state_key ) references dbo.state( state_key )
go

alter table dbo.volunteer add constraint volunteer_fk_country foreign key ( country_key ) references dbo.country( country_key )
go

alter table dbo.volunteer add constraint volunteer_fk_marital_status foreign key ( marital_status_key ) references dbo.marital_status( marital_status_key )
go

alter table dbo.volunteer add constraint volunteer_fk_cong foreign key ( cong_key ) references dbo.cong( cong_key )
go

alter table dbo.volunteer add constraint volunteer_fk_user foreign key ( vol_desk_user_key ) references dbo.[User]( user_key )
go

alter table dbo.volunteer add constraint volunteer_fk_tracking_status foreign key ( tracking_status_key ) references dbo.tracking_status( tracking_status_key )
go


if object_id('dbo.Volunteer_App', 'U') is not null
	drop table dbo.Volunteer_App
go 
create table dbo.Volunteer_App(
	Volunteer_App_Key 					integer identity(1,1) 	not null constraint volunteer_app_pk primary key,
	Volunteer_Key 						integer					not null,
	App_Type_Key 						integer					not null,
	App_Status_Key 						integer					not null,
	App_Date 							date					not null,
	Expiration_Date 					date	 				not null,
	Status_Notes 						nvarchar(1000),
	App_Notes 							nvarchar(1000),
	Review_Status_Submitted_Date		datetime, 
	Review_Stage_Elders_Date 			datetime, 
	Review_Stage_CO_Date 				datetime,
	Attrib_Approval_Level_App_Attrib_ID	integer,	
	Attrib_Approval_Level_Attrib_ID		integer,
	Attrib_Approval_Level_Val			nvarchar(30),
	Attrib_Pursued_By_App_Attrib_ID		integer,	
	Attrib_Pursued_By_Attrib_ID			integer,	
	Attrib_Pursued_By_Val				nvarchar(255),
	Attrib_Contacted_App_Attrib_ID		integer,		
	Attrib_Contacted_Attrib_ID			integer,	
	Attrib_Contacted_Val				nvarchar(255),
	Attrib_SKE_App_Attrib_ID			integer,		
	Attrib_SKE_Attrib_ID				integer,	
	Attrib_SKE_Val						nvarchar(255),
	Attrib_Other_App_Attrib_ID			integer,	
	Attrib_Other_Attrib_ID				integer,
	Attrib_Other_Val					nvarchar(255),
	Applicant_ID 						integer					not null constraint volunteer_app_ak unique,
	Expired_Flag 						nvarchar(1),
	Active_Flag 						nvarchar(1) 			not null constraint df_volunteer_app_active_flag default 'Y',
	Load_Date 							datetime 				not null constraint df_volunteer_app_load_date default getdate(),
	Update_Date 						datetime 				not null constraint df_volunteer_app_update_date default getdate() )
go

alter table dbo.volunteer_app add constraint volunteer_app_fk_app_type foreign key ( app_type_key ) references dbo.app_type( app_type_key )
go

alter table dbo.volunteer_app add constraint volunteer_app_fk_app_status foreign key ( app_status_key ) references dbo.app_status( app_status_key )
go

alter table dbo.volunteer_app add constraint volunteer_app_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go


if object_id('dbo.Volunteer_Approval_Level_Hist', 'U') is not null
	drop table dbo.Volunteer_Approval_Level_Hist
go 
create table dbo.Volunteer_Approval_Level_Hist(
	Volunteer_Key 						integer					not null,
	Approval_Level						nvarchar(30)			not null,
	Start_Date 							date					not null,
	End_Date 							date,
	Active_Flag 						nvarchar(1) 			not null constraint df_volunteer_approval_level_hist_active_flag default 'Y',
	Load_Date 							datetime 				not null constraint df_volunteer_approval_level_hist_load_date default getdate(),
	Update_Date 						datetime 				not null constraint df_volunteer_approval_level_hist_update_date default getdate(),
	constraint volunteer_approval_level_hist_ak unique ( volunteer_key, approval_level, start_date ) )
go	

alter table dbo.volunteer_approval_level_hist add constraint volunteer_approval_level_hist_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go


if object_id('dbo.Volunteer_Availability', 'U') is not null
	drop table dbo.Volunteer_Availability
go 
create table dbo.Volunteer_Availability(
	Volunteer_Availability_Key 			integer identity(1,1) 	not null constraint volunteer_availability_pk primary key,
	Volunteer_Key 						integer					not null constraint volunteer_availability_ak unique,
	Avail_As_Consultant_Flag			nvarchar(1), 
	Avail_As_Commuter_Flag 				nvarchar(1), 
	Avail_As_Commuter_As_Needed_Flag	nvarchar(1), 
	Avail_As_Commuter_Closest_Site 		nvarchar(1000), 
	Avail_As_Commuter_Days_Per_Wk 		decimal(6,1), 
	Avail_As_Commuter_Weekly_Flag		nvarchar(1), 
	Avail_As_Commuter_Notes 			nvarchar(4000), 
	Avail_As_Commuter_Mon_AM_Flag		nvarchar(1),
	Avail_As_Commuter_Mon_PM_Flag		nvarchar(1),
	Avail_As_Commuter_Tue_AM_Flag		nvarchar(1),
	Avail_As_Commuter_Tue_PM_Flag		nvarchar(1),
	Avail_As_Commuter_Wed_AM_Flag		nvarchar(1),
	Avail_As_Commuter_Wed_PM_Flag		nvarchar(1),
	Avail_As_Commuter_Thu_AM_Flag		nvarchar(1),
	Avail_As_Commuter_Thu_PM_Flag		nvarchar(1),
	Avail_As_Commuter_Fri_AM_Flag		nvarchar(1),
	Avail_As_Commuter_Fri_PM_Flag		nvarchar(1),
	Avail_As_Commuter_Sat_AM_Flag		nvarchar(1),
	Avail_As_Commuter_Sat_PM_Flag		nvarchar(1),
	Avail_As_Commuter_Sun_AM_Flag		nvarchar(1),
	Avail_As_Commuter_Sun_PM_Flag		nvarchar(1),
	Avail_As_Remote_Vol_Flag			nvarchar(1), 
	Avail_As_Remote_Vol_Days_Per_Wk 	tinyint, 
	Avail_As_Remote_Vol_Notes 			nvarchar(4000),
	Avail_As_Vol_Flag 					nvarchar(1), 
	Avail_As_Vol_Anytime_Flag			nvarchar(1), 
	Avail_As_Vol_Start_Date 			date					not null,
	Avail_As_Vol_End_Date 				date,
	Avail_As_Vol_Date_Notes 			nvarchar(4000),
	Avail_As_Vol_Date_Short_Term_Days 	integer, 
	Avail_As_Vol_Long_Term_Flag 		nvarchar(1), 
	Avail_As_Vol_Notes					nvarchar(4000),
	Active_Flag 						nvarchar(1) 			not null constraint df_volunteer_availability_active_flag default 'Y',
	Load_Date 							datetime 				not null constraint df_volunteer_availability_load_date default getdate(),
	Update_Date 						datetime 				not null constraint df_volunteer_availability_update_date default getdate(),
	Last_Update_Date					datetime )
go

alter table dbo.volunteer_availability add constraint volunteer_availability_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go


if object_id('dbo.Volunteer_Contact_Hist', 'U') is not null
	drop table dbo.Volunteer_Contact_Hist
go 
create table dbo.Volunteer_Contact_Hist(
	Volunteer_Contact_Hist_Key 			integer identity(1,1) 	not null constraint volunteer_contact_hist_pk primary key,
	Volunteer_Key 						integer					not null,
	VTC_Name							nvarchar(100)			not null,
	Contact_Date						date,
	Contact_Type						nvarchar(100),
	Contact_Purpose						nvarchar(100),
	Contact_Pending						nvarchar(100),
	Contact_Notes						nvarchar(4000),
	Contact_URL							nvarchar(255),	
	Attribute_Value						nvarchar(255),	
	Active_Flag 						nvarchar(1) 			not null constraint df_volunteer_contact_hist_active_flag default 'Y',
	Load_Date 							datetime 				not null constraint df_volunteer_contact_hist_load_date default getdate(),
	Update_Date 						datetime 				not null constraint df_volunteer_contact_hist_update_date default getdate() )
go

alter table dbo.volunteer_contact_hist add constraint volunteer_contact_hist_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go


if object_id('dbo.Volunteer_Dept', 'U') is not null
	drop table dbo.Volunteer_Dept
go 
create table dbo.Volunteer_Dept(
	Volunteer_Dept_Key 				integer identity(1,1) 	not null constraint volunteer_dept_pk primary key,
	Volunteer_Key 					integer					not null,
	Person_ID						integer					not null,
	Site_Code 						nvarchar(10),
	Parent_Dept_Name				nvarchar(100),
	Dept_Name 						nvarchar(100)			not null,
	Temp_Flag 						nvarchar(1)				not null constraint df_volunteer_dept_temp_flag default 'N',
	Primary_Flag					nvarchar(1)				not null constraint df_volunteer_dept_primary_flag default 'Y',
	Split_Allocation_Pct			integer,
	Enrollment_Code 				nvarchar(5),
	Dept_Role						nvarchar(200),
	Start_Date 						date					not null,
	End_Date 						date,
	Notes							nvarchar(1000),
	Mon_AM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_mon_am_flag default 'N',
	Mon_PM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_mon_pm_flag default 'N',
	Tue_AM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_tue_am_flag default 'N',
	Tue_PM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_tue_pm_flag default 'N',
	Wed_AM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_wed_am_flag default 'N',
	Wed_PM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_wed_pm_flag default 'N',
	Thu_AM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_thu_am_flag default 'N',
	Thu_PM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_thu_pm_flag default 'N',
	Fri_AM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_fri_am_flag default 'N',
	Fri_PM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_fri_pm_flag default 'N',
	Sat_AM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_sat_am_flag default 'N',
	Sat_PM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_sat_pm_flag default 'N',
	Sun_AM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_sun_am_flag default 'N',
	Sun_PM_Flag						nvarchar(1) 			not null constraint df_volunteer_dept_sun_pm_flag default 'N',
	Active_Flag 					nvarchar(1) 			not null constraint df_volunteer_dept_active_flag default 'N',
	WRK_Crew						nvarchar(1000),
	WRK_Role						nvarchar(200),
	WRK_Priv 						nvarchar(30),
	HUB_Dept_ID						integer,	
	Load_Date 						datetime 				not null constraint df_volunteer_dept_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_volunteer_dept_update_date default getdate() )
go

alter table dbo.volunteer_dept add constraint volunteer_dept_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go


if object_id('dbo.Volunteer_Dept_Rpt', 'U') is not null
	drop table dbo.Volunteer_Dept_Rpt
go 
create table dbo.Volunteer_Dept_Rpt(
	Volunteer_Key 					integer					not null,
	Full_Name						nvarchar(1000),
	HUB_Dept_ID						integer,
	Parent_Dept_Name				nvarchar(100),
	Dept_Name 						nvarchar(100)			not null,
	Temp_Flag 						nvarchar(1)				not null constraint df_volunteer_dept_rpt_temp_flag default 'N',
	Primary_Flag					nvarchar(1)				not null constraint df_volunteer_dept_rpt_primary_flag default 'Y', 
	Split_Allocation_Pct			integer,
	Start_Date 						date					not null,
	End_Date						date,
	HPR_Flag						nvarchar(1)				not null,
	Mon_Flag						nvarchar(1) 			not null,
	Tue_Flag						nvarchar(1) 			not null,
	Wed_Flag						nvarchar(1) 			not null,
	Thu_Flag						nvarchar(1) 			not null,
	Fri_Flag						nvarchar(1) 			not null,
	Sat_Flag						nvarchar(1) 			not null,
	Sun_Flag						nvarchar(1) 			not null,	
	Row_Num							integer					not null )
go


if object_id('dbo.Volunteer_Enrollment', 'U') is not null
	drop table dbo.Volunteer_Enrollment
go 
create table dbo.Volunteer_Enrollment(
	Volunteer_Enrollment_Key 		integer identity(1,1) 	not null constraint volunteer_enrollment_pk primary key,
	Volunteer_Key 					integer					not null,
	Enrollment_Key 					integer					not null,
	Geo_Name 						nvarchar(50),
	Site_Code 						nvarchar(10),
	Dept_Code 						nvarchar(30),
	Dept_Name 						nvarchar(100),
	Notes 							nvarchar(max),
	Applicant_ID					integer,
	Start_Date 						date					not null,
	End_Date 						date,
	Active_Flag 					nvarchar(1) 			not null constraint df_volunteer_enrollment_active_flag default 'Y',
	Load_Date 						datetime 				not null constraint df_volunteer_enrollment_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_volunteer_enrollment_update_date default getdate() )
	--constraint volunteer_enrollment_ak unique ( volunteer_key, enrollment_key, start_date ) )
go

alter table dbo.volunteer_enrollment add constraint volunteer_enrollment_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go

alter table dbo.volunteer_enrollment add constraint volunteer_enrollment_fk_enrollment foreign key ( enrollment_key ) references dbo.enrollment( enrollment_key )
go

create index volunteer_enrollment_idx_geo_start_dt on dbo.volunteer_enrollment( geo_name, start_date )
	include( volunteer_key, enrollment_key, site_code, end_date, active_flag )
go


if object_id('dbo.Volunteer_Enrollment_Rpt', 'U') is not null
	drop table dbo.Volunteer_Enrollment_Rpt
go 
create table dbo.Volunteer_Enrollment_Rpt(
	Volunteer_Key 					integer					not null,
	Full_Name						nvarchar(1000),
	Enrollment_Key 					integer					not null,
	Enrollment_Code					nvarchar(30)			not null,
	Enrollment_Site_Code			nvarchar(10),
	Start_Date 						date					not null,
	End_Date 						date,
	Row_Num							integer					not null )
go


if object_id('dbo.Volunteer_Event', 'U') is not null
	drop table dbo.Volunteer_Event
go 
create table dbo.Volunteer_Event(
	Volunteer_Event_Key 			integer identity(1,1) 	not null constraint volunteer_event_pk primary key,
	Volunteer_Key 					integer					not null,
	Event_Key 						integer					not null,
	Vol_Desk_User_Key 				integer,
	Notes 							nvarchar(1000),
	File_URL 						nvarchar(255),
	Start_Date 						datetime 				not null constraint df_volunteer_event_start_date default getdate(),
	Response_Date 					datetime,
	WRK_Volunteer_Event_Key 		integer,
	Load_Date 						datetime 				not null constraint df_volunteer_event_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_volunteer_event_update_date default getdate() )	
go

alter table dbo.volunteer_event add constraint volunteer_event_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go

alter table dbo.volunteer_event add constraint volunteer_event_fk_event foreign key ( event_key ) references dbo.event( event_key )
go

alter table dbo.volunteer_event add constraint volunteer_event_fk_user foreign key ( vol_desk_user_key ) references dbo.[user]( user_key )
go


if object_id('dbo.Volunteer_Event_Data', 'U') is not null
	drop table dbo.Volunteer_Event_Data
go 
create table dbo.Volunteer_Event_Data(
	Volunteer_Event_Data_Key 		integer identity(1,1) 	not null constraint volunteer_event_data_pk primary key,
	Volunteer_Event_Key 			integer					not null,
	Event_Attribute_Key 			integer					not null,
	Event_Data 						nvarchar(4000) 			not null,
	Load_Date 						datetime 				not null constraint df_volunteer_event_data_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_volunteer_event_data_update_date default getdate(),
	constraint volunteer_event_data_ak unique ( volunteer_event_key, event_attribute_key ) )	
go

alter table dbo.volunteer_event_data add constraint volunteer_event_data_fk_volunteer_event foreign key ( volunteer_event_key ) references dbo.volunteer_event( volunteer_event_key ) on delete cascade
go

alter table dbo.volunteer_event_data add constraint volunteer_event_data_fk_event_attribute foreign key ( event_attribute_key ) references dbo.event_attribute( event_attribute_key )
go


if object_id('dbo.Volunteer_FTS', 'U') is not null
	drop table dbo.Volunteer_FTS
go 
create table dbo.Volunteer_FTS(
	Volunteer_Key				integer			not null constraint volunteer_fts_pk primary key,
	FTS							numeric(18,6),
	SFTS						numeric(18,6),
	Rounded_FTS					integer,
	Rounded_SFTS				integer )
go

alter table dbo.volunteer_fts add constraint volunteer_fts_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go


if object_id('dbo.Volunteer_Pursuit_Cancel_Reason', 'U') is not null
	drop table dbo.Volunteer_Pursuit_Cancel_Reason
go 
create table dbo.Volunteer_Pursuit_Cancel_Reason(
	Volunteer_Pursuit_Cancel_Reason_Key 	integer identity(1,1) 	not null constraint volunteer_pursuit_cancel_reason_pk primary key,
	Volunteer_Pursuit_Cancel_Reason_Code	nvarchar(100)			not null,
	Sort_Order								smallint,
	Active_Flag 							nvarchar(1) 			not null constraint df_volunteer_pursuit_cancel_reason_active_flag default 'Y',
	Load_Date 								datetime 				not null constraint df_volunteer_pursuit_cancel_reason_load_date default getdate(),
	Update_Date 							datetime 				not null constraint df_volunteer_pursuit_cancel_reason_update_date default getdate(),
	constraint volunteer_pursuit_cancel_reason_ak unique ( Volunteer_Pursuit_Cancel_Reason_Code ) )
go


if object_id('dbo.Volunteer_Pursuit_Hist', 'U') is not null
	drop table dbo.Volunteer_Pursuit_Hist
go 
create table dbo.Volunteer_Pursuit_Hist(
	Volunteer_Pursuit_Hist_Key 			integer identity(1,1) 	not null constraint volunteer_pursuit_hist_pk primary key,
	Volunteer_Key 						integer					not null,
	VTC_Name							nvarchar(100)			not null,
	HPR_Dept_Key						integer					not null,
	Start_Date							date,
	Target_Date							date,
	Role_Name							nvarchar(150),
	Role_Desc							nvarchar(4000),
	Attribute_Value						nvarchar(255),
	Requested_Flag						nvarchar(1)				not null constraint df_volunteer_pursuit_hist_requested_flag default 'N',
	Volunteer_Pursuit_Cancel_Reason_Key	integer,
	Request_Cancel_Reason				nvarchar(1000),
	Active_Flag 						nvarchar(1) 			not null constraint df_volunteer_pursuit_hist_active_flag default 'Y',
	Load_Date 							datetime 				not null constraint df_volunteer_pursuit_hist_load_date default getdate(),
	Update_Date 						datetime 				not null constraint df_volunteer_pursuit_hist_update_date default getdate(),
	constraint volunteer_pursuit_hist_ak unique ( volunteer_key, hpr_dept_key, start_date ) )
go

alter table dbo.volunteer_pursuit_hist add constraint volunteer_pursuit_hist_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key )
go

alter table dbo.volunteer_pursuit_hist add constraint volunteer_pursuit_hist_fk_hpr_dept foreign key ( hpr_dept_key ) references dbo.hpr_dept( hpr_dept_key )
go

alter table dbo.volunteer_pursuit_hist add constraint volunteer_pursuit_hist_fk_volunteer_pursuit_cancel_reason foreign key ( volunteer_pursuit_cancel_reason_key ) references dbo.volunteer_pursuit_cancel_reason( volunteer_pursuit_cancel_reason_key )
go


if object_id('dbo.Volunteer_Role', 'U') is not null
	drop table dbo.Volunteer_Role
go 
create table dbo.Volunteer_Role(
	Volunteer_Key 						integer					not null,
	Role								nvarchar(150)			not null,
	Role_Data							nvarchar(150),
	Start_Date 							date					not null,
	End_Date 							date,
	Active_Flag 						nvarchar(1) 			not null constraint df_volunteer_role_active_flag default 'Y',
	Load_Date 							datetime 				not null constraint df_volunteer_role_load_date default getdate(),
	Update_Date 						datetime 				not null constraint df_volunteer_role_update_date default getdate(),
	constraint volunteer_role_ak unique ( volunteer_key, role, start_date ) )
go	

alter table dbo.volunteer_role add constraint volunteer_role_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key )
go


if object_id('dbo.Volunteer_Rooming_Hist', 'U') is not null
	drop table dbo.Volunteer_Rooming_Hist
go 
create table dbo.Volunteer_Rooming_Hist(
	Volunteer_Key 					integer					not null,
	Cal_Dt							date					not null,
	Room_Site_Code					nvarchar(30),
	Room_Bldg						nvarchar(100),
	Room_Bldg_Code					nvarchar(30),
	Room_Bldg_Desc					nvarchar(30),	
	Room							nvarchar(30),	
	Load_Date 						datetime 				not null constraint df_volunteer_rooming_hist_load_date default getdate(),
	constraint volunteer_rooming_hist_ak unique ( volunteer_key, cal_dt ) )
go	

alter table dbo.volunteer_rooming_hist add constraint volunteer_rooming_hist_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key )
go


if object_id('dbo.Volunteer_Search_Phone', 'U') is not null
	drop table dbo.Volunteer_Search_Phone
go 
create table dbo.Volunteer_Search_Phone(
	Volunteer_Key 			integer 		not null,
	Phone_Num				nvarchar(100)	not null,
	Load_Date 								datetime 			not null constraint df_volunteer_search_phone_load_date default getdate()
	constraint volunteer_search_phone_pk primary key ( volunteer_key, phone_num ) )
go

alter table dbo.volunteer_search_phone add constraint volunteer_search_phone_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go


if object_id('dbo.Volunteer_Search_Save', 'U') is not null
	drop table dbo.Volunteer_Search_Save
go 
create table dbo.Volunteer_Search_Save(
	Volunteer_Search_Save_Key 		integer identity(1,1) 	not null constraint volunteer_search_save_pk primary key,
	User_Key 						integer					not null,
	Search_Time 					datetime 				not null,
	Description 					nvarchar(255) 			not null,
	cmbSkill_Key 					integer,
	cmbSkill_Speciality_Key 		integer,
	cmbSkill_Level_Key 				integer,
	cmbSkill_Key_2 					integer,
	cmbSkill_Speciality_Key_2 		integer,
	cmbSkill_Level_Key_2			integer,
	cmbSkill_Key_3 					integer,
	cmbSkill_Speciality_Key_3 		integer,
	cmbSkill_Level_Key_3			integer,
	cmbSkill_Key_4 					integer,
	cmbSkill_Speciality_Key_4 		integer,
	cmbSkill_Level_Key_4			integer,
	cmbSkill_Key_5 					integer,
	cmbSkill_Speciality_Key_5 		integer,
	cmbSkill_Level_Key_5			integer,
	txtAvailDate 					date,
	cmbGender 						nvarchar(1),
	cmbServant 						nvarchar(2),
	cmbMaritalStatus 				nvarchar(2),
	cmbPioneer 						nvarchar(2),
	cmbAgeFrom 						tinyint,
	cmbAgeTo 						tinyint,
	cmbLocal 						nvarchar(1),
	cmbDrivingDistance 				nvarchar(1),
	txtTCGDate 						date,
	cmbCurrEnrl 					integer,
	cmbVolDeskUser 					integer,
	cmbTracking_Status 				integer,
	txtTrackingDate 				date,
	cmbEvent 						integer,
	cmbList 						integer,
	cmbFormstackQuestion1 			integer,
	cmbFormstackResp1 				nvarchar(255),
	cmbFormstackQuestion2 			integer,
	cmbFormstackResp2 				nvarchar(255),
	cmbFormstackQuestion3 			integer,
	cmbFormstackResp3 				nvarchar(255),
	cmbFormstackQuestion4 			integer,
	cmbFormstackResp4 				nvarchar(255),
	cmbFormstackQuestion5 			integer,
	cmbFormstackResp5 				nvarchar(255),
	A8_Status 						nvarchar(255),
	A19_Status 						nvarchar(255),
	txtAppFrom 						date,
	txtAppThru 						date,
	Load_Date 						datetime 				not null constraint df_volunteer_search_save_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_volunteer_search_save_update_date default getdate(),
	cmbCong							integer,
	chkAvailVol						bit						not null constraint df_volunteer_search_save_avail_vol default 0,
	chkAvailVolAnytime				bit						not null constraint df_volunteer_search_save_avail_vol_anytime default 0,
	chkAvailLTTV					bit						not null constraint df_volunteer_search_save_avail_lttv default 0,
	chkAvailConsultant				bit						not null constraint df_volunteer_search_save_avail_cons default 0,
	chkAvailRemote					bit						not null constraint df_volunteer_search_save_avail_remote default 0,
	chkAvailCommuter				bit						not null constraint df_volunteer_search_save_avail_comm default 0,
	chkAvailCommuterAsNeeded		bit						not null constraint df_volunteer_search_save_avail_comm_as_need default 0,
	txtSTTVDays						integer,
	txtRemoteDays					integer,
	txtCommuteDays					integer,
	chkSafetyValid					bit						not null constraint df_volunteer_search_save_safety_valid default 0,
	cmbApprovalLevel				integer,
	cmbTrainingCourse				nvarchar(200),
    txtTrainingCompleteDate			date,
    CurrentEnrollment 				nvarchar(255),
	PastEnrollment 					nvarchar(255),
	PriorSite						nvarchar(255),
	PriorDate						date,
	AppType							nvarchar(255),
	cmbBA_Event						nvarchar(255),
	chkTrainingNotComplete			bit						not null constraint df_volunteer_search_save_train_not_complete default 0,
	txtDeptSite						nvarchar(255),
	txtDeptName						nvarchar(255),
	txtDeptDate						date,
	cmbSkill_Yr						nvarchar(255),
	cmbSkill_Yr_2					nvarchar(255),
	cmbSkill_Yr_3					nvarchar(255),
	txtFullText						nvarchar(255),
	txtFullText2					nvarchar(255),
	txtFullText3					nvarchar(255),
	cmbFullTextLogic				nvarchar(10),
	optgrpCurrEnrl					bit						not null constraint df_volunteer_search_save_opt_curr_enrl default 1,
	cmbWRKCrew						nvarchar(255),
	cmbWRKRole						nvarchar(255),
	txtCongDate						date,
	chkAvailMon						bit						not null constraint df_volunteer_search_save_avail_mon default 0,
	chkAvailTue						bit						not null constraint df_volunteer_search_save_avail_tue default 0,
	chkAvailWed						bit						not null constraint df_volunteer_search_save_avail_wed default 0,
	chkAvailThu						bit						not null constraint df_volunteer_search_save_avail_thu default 0,
	chkAvailFri						bit						not null constraint df_volunteer_search_save_avail_fri default 0,
	chkAvailSat						bit						not null constraint df_volunteer_search_save_avail_sat default 0,
	chkAvailSun						bit						not null constraint df_volunteer_search_save_avail_sun default 0,
	cmbComplex						nvarchar(3),
	txtFullTextNot					nvarchar(255),
	txtFullTextNot2					nvarchar(255),
	constraint volunteer_search_save_ak unique ( user_key, description ) )	
go

alter table dbo.volunteer_search_save add constraint volunteer_search_save_fk_user foreign key ( user_key ) references dbo.[user]( user_key )
go


if object_id('dbo.Volunteer_Skill', 'U') is not null
	drop table dbo.Volunteer_Skill
go 
create table dbo.Volunteer_Skill(
	Volunteer_Skill_Key 			integer identity(1,1) 	not null constraint volunteer_skill_pk primary key,
	Volunteer_Key 					integer 				not null,
	Skill_Speciality_Key 			integer					not null,
	Skill_Level_Key 				integer					not null,
	Source_System_Key 				integer					not null,
	Skill_Description 				nvarchar(4000),
	Yrs_Exp 						decimal(8,2),
	Personal_Notes 					nvarchar(max), 
	Office_Notes					nvarchar(max),
	Ovsr_Assessment_Name	 		nvarchar(200),
	Ovsr_Assessment_Skill_Level_Key	integer,
	Ovsr_Assessment_Notes			nvarchar(max),
	Ovsr_Assessment_Date 			date,
	Skill_Update_Date				date,
	Active_Flag 					nvarchar(1) 			not null constraint df_volunteer_skill_active_flag default 'Y',
	Load_Date 						datetime 				not null constraint df_volunteer_skill_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_volunteer_skill_update_date default getdate(),
	constraint volunteer_skill_ak unique ( volunteer_key, skill_speciality_key ) )
go

alter table dbo.volunteer_skill add constraint volunteer_skill_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go

alter table dbo.volunteer_skill add constraint volunteer_skill_fk_skill_speciality foreign key ( skill_speciality_key ) references dbo.skill_speciality( skill_speciality_key )
go

alter table dbo.volunteer_skill add constraint volunteer_skill_fk_skill_level foreign key ( skill_level_key ) references dbo.skill_level( skill_level_key )
go

alter table dbo.volunteer_skill add constraint volunteer_skill_fk_source_system foreign key ( source_system_key ) references dbo.source_system( source_system_key )
go

alter table dbo.volunteer_skill add constraint volunteer_skill_fk_ovsr_assessment_skill_level foreign key ( ovsr_assessment_skill_level_key ) references dbo.skill_level( skill_level_key )
go


if object_id('dbo.Volunteer_Training', 'U') is not null
	drop table dbo.Volunteer_Training
go 
create table dbo.Volunteer_Training(
	Volunteer_Training_Key 			integer identity(1,1) 	not null constraint volunteer_training_pk primary key,
	Volunteer_Key 					integer 				not null,
	Volunteer_ID					bigint,
	Person_GUID 					uniqueidentifier 		not null,
	Course_Name 					nvarchar(300)			not null,
	Person_Education_GUID 			uniqueidentifier,	
	Person_Education_ID 			int,
	Course_Desc 					nvarchar(max),
	Course_Type_ID 					int,
	Course_Type 					nvarchar(200),
	Course_Type_Desc 				nvarchar(200),
	Class_Number 					nvarchar(40),
	Class_Name 						nvarchar(200),
	Class_Completion_Notes 			nvarchar(1000),
	Course_Objective 				nvarchar(600),
	Student_Met_Objective 			bit,
	Attendance_Status 				nvarchar(200),
	Assign_Date 					datetime,	
	Start_Date 						datetime
	Complete_Date 					date,
	Modified_Date 					datetime,
	Host_Branch_Code				nvarchar(20),
	Active_Flag 					nvarchar(1) 			not null constraint df_volunteer_training_active_flag default 'Y',
	Load_Date 						datetime 				not null constraint df_volunteer_training_load_date default getdate(),
	Update_Date 					datetime 				not null constraint df_volunteer_training_update_date default getdate() )
go

alter table dbo.volunteer_training add constraint volunteer_training_fk_volunteer foreign key ( volunteer_key ) references dbo.volunteer( volunteer_key ) on delete cascade
go
