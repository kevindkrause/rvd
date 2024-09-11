use rvd
go

if object_id('stg.stg_App', 'U') is not null
	drop table stg.stg_app
go  
create table stg.stg_App(
	Applicant_ID 						integer 			not null, 
	Person_GUID 						uniqueidentifier 	not null, 
	Person_ID 							integer 			not null, 
	App_Type_ID 						integer, 
	App_Date 							datetime, 
	App_Expiry_Date 					datetime, 
	App_Status 							nvarchar(100), 
	App_Status_Notes				 	nvarchar(1000), 
	App_Notes 							nvarchar(1000), 
	App_Review_Status_Submitted_Date	datetime, 
	App_Review_Stage_Elders_Date 		datetime, 
	App_Review_Stage_CO_Date 			datetime,
	Load_Date							datetime 			not null default getdate() )
go


if object_id('stg.stg.App_Invitation_History ', 'U') is not null
       drop table stg.stg_App_Invitation_History
go 
create table stg.stg_App_Invitation_History (
	Person_GUID   	uniqueidentifier    not null,
	Person_ID     	integer       		not null,
	Applicant_ID  	integer 			not null,
	Enrollment    	nvarchar(5)   		not null, 
	Site_Code     	nvarchar(10),
	Department    	nvarchar(100),
	Invited_From  	datetime,
	Invited_To    	datetime,
	Invitation_Sent bit,
	Notes         	nvarchar(max),
    Load_Date     	datetime 			not null default getdate() )    
go


if object_id('stg.stg_App_Type', 'U') is not null
	drop table stg.stg_App_Type
go 
create table stg.stg_App_Type(
	App_Type_ID 		integer 		not null, 
	App_Type 			nvarchar(100)	not null, 
	Active_Flag 		bit, 
	Load_Date			datetime 		not null default getdate() )	
go


if object_id('stg.stg_App_Attribute', 'U') is not null
	drop table stg.stg_App_Attribute
go 
create table stg.stg_App_Attribute(
   Applicant_ID               integer             not null, 
   Attribute                  nvarchar(50)        not null,
   Attribute_Value            nvarchar(255),
   App_Date                   datetime, 
   Load_Date                  datetime            not null default getdate(),
   Applicant_Attribute_ID     integer,
   Attribute_ID               integer )     
go   


if object_id('stg.stg_App_Congregation_History', 'U') is not null
	drop table stg.stg_App_Congregation_History
go 
create table stg.stg_App_Congregation_History(
       person_guid 			uniqueidentifier not null,
       person_id 			int not null,
       congregation_number 	int not null,
       congregation_name 	nvarchar(100) null,
       start_date 			datetime not null,
       end_date 			datetime null,
       city_name 			nvarchar(50) not null,
       state_code 			nvarchar(10) not null,
       state_name 			nvarchar(50) not null,
       load_date 			datetime not null
)
go


if object_id('stg.stg_bethel_member_availability', 'u') is not null
	drop table stg.stg_bethel_member_availability
go 

create table stg.stg_bethel_member_availability (
       personid 					int not null,
       personguid 					uniqueidentifier not null,
       volunteernumber 				int null,
       enrollmentcode 				nvarchar(5) not null,
       tentativeenddate 			datetime null,
       parent_department_id		 	int null,
       department_id 				int null,
       department_name 				nvarchar(200) null,
       primaryyesno 				bit not null,
       temporaryyesno 				bit not null,
       startdate 					datetime not null,
       enddate 						datetime null,
       daysperweekbitwise_sun_am 	int not null,
       daysperweekbitwise_sun_pm 	int not null,
       daysperweekbitwise_mon_am 	int not null,
       daysperweekbitwise_mon_pm 	int not null,
       daysperweekbitwise_tue_am 	int not null,
       daysperweekbitwise_tue_pm 	int not null,
       daysperweekbitwise_wed_am 	int not null,
       daysperweekbitwise_wed_pm 	int not null,
       daysperweekbitwise_thu_am 	int not null,
       daysperweekbitwise_thu_pm 	int not null,
       daysperweekbitwise_fri_am 	int not null,
       daysperweekbitwise_fri_pm 	int not null,
       daysperweekbitwise_sat_am 	int not null,
       daysperweekbitwise_sat_pm 	int not null
)
go


if object_id('stg.stg_Cong', 'U') is not null
	drop table stg.stg_Cong
go 
create table stg.stg_Cong(
	Cong_Number 			integer 			not null,
	Cong_Name 				nvarchar(100),
	Cong_Fullname 			nvarchar(200), 
	Cong_City 				nvarchar(50),
	Cong_State_Code 		nvarchar(10),
	Cong_Country_Code 		nvarchar(10),
	Circuit 				nvarchar(100),
	Language_Code 			nvarchar(10),
	KH_Address1 			nvarchar(50),
	KH_Address2 			nvarchar(50),
	KH_City 				nvarchar(50),
	KH_State_Code 			nvarchar(10),
	KH_Postal_Code 			nvarchar(30),
	KH_Country_Code 		nvarchar(10),
	COBE_Person_GUID 		uniqueidentifier,
	COBE_Person_ID 			integer,
	COBE_JWPub_Email 		nvarchar(50), 
	COBE_Mobile_Phone 		nvarchar(100), 
	Sec_Person_GUID 		uniqueidentifier,
	Sec_Person_ID 			integer,
	Sec_JWPub_Email 		nvarchar(50), 
	Sec_Mobile_Phone 		nvarchar(100), 
	CO_Person_GUID 			uniqueidentifier,
	CO_Person_ID 			integer,
	CO_JWPub_Email 			nvarchar(50), 
	Dissolved_Date 			datetime,
	Active_Flag 			bit,
	Load_Date				datetime 			not null default getdate() )	
go


if object_id('stg.stg_Department_Hierarchy', 'U') is not null
    drop table stg.stg_Department_Hierarchy
go  
create table stg.stg_Department_Hierarchy(
    Department_ID                       integer      	not null, 
    Department_Code                     nvarchar(60)    not null, 
    Department_Name                     nvarchar(200)   not null, 
    Parent_Department_ID                integer, 
    Overseer_Person_ID                  integer,
    Assistant_Overseer_PersonID         integer,
    Load_Date                           datetime   		not null default getdate(),
    Work_Group_Coordinator_PersonID		int )
go



if object_id('stg.stg_Person', 'U') is not null
	drop table stg.stg_Person
go 
create table stg.stg_Person(
	Person_GUID 			uniqueidentifier 	not null, 
	Person_ID				integer				not null,
	Volunteer_Number 		integer,
	First_Name 				nvarchar(50),
	Last_Name 				nvarchar(50), 
	Middle_Name 			nvarchar(50), 
	Preferred_Name 			nvarchar(200), 
	Suffix 					nvarchar(30), 
	Maiden_Name 			nvarchar(50), 
	Address1 				nvarchar(50), 
	Address2 				nvarchar(50), 
	City 					nvarchar(50), 
	Postal_Code 			nvarchar(30), 
	State_Code 				nvarchar(10), 
	Country_Code 			nvarchar(10), 
	Birth_Date 				datetime,
	Baptism_Date 			datetime,
	Gender_Code 			nvarchar(800),
	Marital_Status 			nvarchar(800),
	Cong_Servant_Code 		nvarchar(10),
	Pioneer_Status 			bit, 
	Home_Phone 				nvarchar(100), 
	Mobile_Phone 			nvarchar(100), 
	Bethel_Email 			nvarchar(100), 
	External_Email 			nvarchar(100), 
	JWPub_Email 			nvarchar(50), 
	Cong_Number 			integer, 
	Mate_Person_GUID 		uniqueidentifier,
	Mate_Person_ID 			integer,
	Picture_URL				nvarchar(4000), 
	Load_Date				datetime 			not null default getdate(),
	Volunteer_ID            integer,
	WhatsApp                bit,
	Text_Message            bit,
	Deceased_Date 			datetime null )
go


if object_id('stg.stg_Person_Availability', 'U') is not null
	drop table stg.stg_Person_Availability
go 
create table stg.stg_Person_Availability(
	Person_GUID 						uniqueidentifier 	not null, 		
	Person_ID							integer				not null,
	Avail_As_Consultant 				bit, 
	Avail_As_Commuter 					bit, 
	Avail_As_Commuter_As_Needed 		bit, 	
	Avail_As_Commuter_Closest_Site 		nvarchar(100), 
	Avail_As_Commuter_Days_Per_Wk 		decimal(6,1),
	Avail_As_Commuter_Weekly 			bit, 
	Avail_As_Commuter_Notes 			nvarchar(100),
	Avail_As_Commuter_Sun_AM			integer, 
	Avail_As_Commuter_Sun_PM			integer,	
	Avail_As_Commuter_Mon_AM			integer,
	Avail_As_Commuter_Mon_PM			integer, 
	Avail_As_Commuter_Tue_AM			integer, 
	Avail_As_Commuter_Tue_PM			integer, 
	Avail_As_Commuter_Wed_AM			integer, 
	Avail_As_Commuter_Wed_PM			integer, 
	Avail_As_Commuter_Thu_AM			integer, 
	Avail_As_Commuter_Thu_PM			integer, 
	Avail_As_Commuter_Fri_AM			integer, 
	Avail_As_Commuter_Fri_PM			integer, 
	Avail_As_Commuter_Sat_AM			integer, 
	Avail_As_Commuter_Sat_PM			integer,
	Avail_As_Remote_Vol 				bit, 
	Avail_As_Remote_Vol_Days_Per_Wk 	decimal(6,1), 
	Avail_As_Remote_Vol_Notes 			nvarchar(100),
	Avail_As_Vol 						bit, 
	Avail_As_Vol_Anytime 				bit, 
	Avail_As_Vol_Start_Date 			datetime,
	Avail_As_Vol_End_Date 				datetime,
	Avail_As_Vol_Date_Notes 			nvarchar(500),
	Avail_As_Vol_Date_Short_Term_Days 	integer, 
	Avail_As_Vol_Long_Term 				bit, 
	Avail_As_Vol_Notes 					nvarchar(100),
	Load_Date							datetime 			not null default getdate(),
	Last_Update_Date 					datetime null )
go	


if object_id('stg.stg_Person_Dept_History', 'U') is not null
	drop table stg.stg_Person_Dept_History
go 
create table stg.stg_Person_Dept_History(
	Person_GUID 				uniqueidentifier 	not null,
	Person_ID					integer				not null,
	Parent_Department_Name 		nvarchar(100),
	Department_Name 			nvarchar(100) 		not null,
	Start_Date 					datetime,
	End_Date 					datetime,
	Temporary_Flag 				bit,
	Primary_Flag 				bit,
	Effective_Enrollment_Code 	nvarchar(5),
	Site_Code 					nvarchar(10),
	Notes 						nvarchar(1000),
	Load_Date					datetime 			not null default getdate(),
	Role                        nvarchar(200) )
go	


if object_id('stg.stg_Person_Education', 'U') is not null
	drop table stg.stg_Person_Education
go 
create table stg.stg_Person_Education(
	Person_GUID 						uniqueidentifier 	not null,
	Person_ID 							integer 			not null,
	Person_Education_GUID 				uniqueidentifier,
	Person_Education_ID 				integer,
	Education_Type_ID 					integer 			not null,
	Education_Type_Description 			nvarchar(200),
	Education_Type_Local_Description 	nvarchar(200),
	Training_Course 					nvarchar(300),
	Training_Course_Long_Description 	nvarchar(1000),
	Class_Number 						nvarchar(40),
	Completed_Date 						datetime,
	Host_Branch_Code 					nvarchar(20),
	Host_Branch_Name 					nvarchar(200),
	Class_Completion_Notes 				nvarchar(1000),
	Course_Objective 					nvarchar(600),
	Student_Met_Objective 				bit,
	Load_Date     						datetime 			not null default getdate(),
	Class_Name  						nvarchar(200),
	Started_Date 						datetime,
	Attendance_Status  					nvarchar(200),
	Student_Record_Last_Update 			datetime )
go


if object_id('stg.stg_Person_Enrollment', 'U') is not null
	drop table stg.stg_Person_Enrollment
go 
create table stg.stg_Person_Enrollment(
	Person_GUID 			uniqueidentifier 	not null,
	Person_ID				integer				not null,
	Enrollment_Code 		nvarchar(5)			not null,
	Start_Date 				datetime,
	End_Date 				datetime,
	Geo_Location 			nvarchar(50), 
	Site_Code 				nvarchar(10),
	Notes 					nvarchar(100),
	Load_Date				datetime 			not null default getdate() )	
go	


if object_id('stg.stg_Person_Role', 'U') is not null
       drop table stg.stg_person_role
go  
create table stg.stg_Person_Role(
       Person_GUID   uniqueidentifier		not null, 
       Person_ID     integer       			not null, 
       Role_Code     nvarchar(20), 
       Role_Data     nvarchar(100), 
       Start_Date    datetime, 
       End_Date      datetime, 
       Load_Date     datetime      			not null default getdate() )
go


if object_id('stg.stg_Person_Skill', 'U') is not null
	drop table stg.stg_Person_Skill
go 
create table stg.stg_Person_Skill(
	Person_GUID 				uniqueidentifier 	not null,
	Person_ID					integer				not null,
	Skill_Speciality_ID 		integer,
	Licensed 					bit,
	Yrs_Exp 					decimal(28,2),
	Yrs_Schooling 				decimal(28,2),
	Skill_Speciality_Notes 		nvarchar(1000),
	Skill_Proficiency 			integer,
	Load_Date              		datetime 			not null default getdate(),
	Skill_Subskill_ID       	integer  			not null,
	Skill_Proficiency_Publisher	integer,
	Office_Notes               	nvarchar(2000),
	Update_Date                	datetime )    
	) 	
go		


if object_id('stg.stg_Person_Tracking', 'U') is not null
	drop table stg.stg_Person_Tracking
go 
create table stg.stg_Person_Tracking(
	Person_GUID 			uniqueidentifier 	not null,
	Person_ID				integer				not null,
	Load_Date				datetime 			not null default getdate() )	
go


if object_id('stg.stg_Rooming', 'U') is not null
	drop table stg.stg_Rooming
go 
create table stg.stg_Rooming(
       Type 					nvarchar(100) not null,
       Person_ID 				int,
       Volunteer_Number 		int,
       Volunteer_Name 			nvarchar(200),
       Room_Number 				nvarchar(20) not null,
       Room_Building_Code 		nvarchar(10),
       Room_Building_Name 		nvarchar(100),
       Room_Site_Code 			nvarchar(10),
       Room_Site 				nvarchar(100),
       Room_Usage 				nvarchar(50),
       Room_Type 				nvarchar(50),
       Overnight_Guest_Category nvarchar(100),
       First_Night 				datetime,
       Last_Night 				datetime,
       Guest_Info 				nvarchar(500),
       Load_Date 				datetime not null )
go


if object_id('stg.stg_Skill', 'U') is not null
	drop table stg.stg_Skill
go 
create table stg.stg_Skill(
	Skill_ID 				integer 			not null,
	Skill 					nvarchar(100),
	Skill_Speciality_ID 	integer, 
	Skill_Speciality 		nvarchar(100),
	Load_Date				datetime 			not null default getdate(),
	Skill_Subskill_ID       integer             not null,
	Skill_Subskill          nvarchar(200) )	
go			


use rvd

grant alter, select, insert, update, delete on stg.stg_App to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_App_Attribute to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_App_invitation_history to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_App_Type to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Cong to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Availability to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Dept_History to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Enrollment to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Role to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Skill to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Tracking to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Skill to [BETHEL\USAADMINSERVICE];

grant alter, select, insert, update, delete on stg.stg_App to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_App_Attribute to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_App_invitation_history to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_App_Type to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_Cong to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_Person to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_Person_Availability to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_Person_Dept_History to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_Person_Enrollment to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_Person_Role to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_Person_Skill to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_Person_Tracking to [BETHEL\USAHuBDeliver];
grant alter, select, insert, update, delete on stg.stg_Skill to [BETHEL\USAHuBDeliver];


grant alter, select, insert, update, delete on schema :: stg to [BETHEL\USAHuBDeliver];

use rvdrehearsal

grant alter, select, insert, update, delete on stg.stg_App to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_App_Attribute to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_App_invitation_history to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_App_Type to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Cong to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Availability to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Dept_History to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Enrollment to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Role to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Skill to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Person_Tracking to [BETHEL\USAADMINSERVICE];
grant alter, select, insert, update, delete on stg.stg_Skill to [BETHEL\USAADMINSERVICE];

grant alter, select, insert, update, delete on stg.stg_App to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_App_Attribute to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_App_invitation_history to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_App_Type to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_Cong to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_Person to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_Person_Availability to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_Person_Dept_History to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_Person_Enrollment to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_Person_Role to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_Person_Skill to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_Person_Tracking to [BETHEL\USAHuBRehearse];
grant alter, select, insert, update, delete on stg.stg_Skill to [BETHEL\USAHuBRehearse];

grant alter, select, insert, update, delete on schema :: stg to [BETHEL\USAHuBRehearse];