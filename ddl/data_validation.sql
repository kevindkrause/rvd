use rvdrehearsal
go

/***********************************************************
**						DATA VALIDATION
***********************************************************/
if object_id('dbo.Data_Validation_proc') is null
    exec( 'create procedure dbo.Data_Validation_proc as set nocount on;' )
go

alter procedure dbo.Data_Validation_proc
as
begin
	set nocount on
	
	declare 
		@Table 	nvarchar(150) = 'X', 
		@Test  	nvarchar(255) = 'X',
		@Pass  	nvarchar(1) = 'P',
		@Fail	nvarchar(1) = 'F'

	begin try
		-- RESET ACTIVE FLAG IN TABLE
		update dbo.app_data_validation
		set 
			active_flag = 'N',
			update_date = getdate()
		where active_flag = 'Y'
		
		-- ETL RUN
		set @Table = 'ETL_Run'

		set @Test = 'ETL failure'
		if exists ( select etl_table from dbo.ETL_Table_Run_Curr_v where status_code = 'F' )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );		
		
		
		-- STAGING - BA TABLES
		set @Table = 'stg_BA_Project'

		set @Test = 'No Data - stg_BA_Project'
		if exists ( select count(*) from stg.stg_ba_project having count(*) < 8000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );		

		set @Table = 'stg_BA_Project_Volunteer'

		set @Test = 'No Data - stg_BA_Project_Volunteer'
		if exists ( select count(*) from stg.stg_ba_project_volunteer having count(*) < 400000 )
			insert into dbo.app_data_validation( table_name, test_name, status_code )
			values( @table, @test, @fail );		
			
		set @Table = 'stg_BA_Volunteer'

		set @Test = 'No Data - stg_BA_Volunteer'
		if exists ( select count(*) from stg.stg_ba_volunteer having count(*) < 130000 )
			insert into dbo.app_data_validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Table = 'stg_BA_Volunteer_Attendance'

		set @Test = 'No Data - stg_BA_Volunteer_Attendance'
		if exists ( select count(*) from stg.stg_ba_volunteer_attendance having count(*) < 10000 )
			insert into dbo.app_data_validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Table = 'stg_BA_Volunteer_Group'

		set @Test = 'No Data - stg_BA_Volunteer_Group'
		if exists ( select count(*) from stg.stg_ba_volunteer_group having count(*) < 200000 )
			insert into dbo.app_data_validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Table = 'stg_BA_Volunteer_Invite'

		set @Test = 'No Data - stg_BA_Volunteer_Invite'
		if exists ( select count(*) from stg.stg_ba_volunteer_invite having count(*) < 900 )
			insert into dbo.app_data_validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Table = 'stg_BA_Volunteer_Skill'

		set @Test = 'No Data - stg_BA_Volunteer_Skill'
		if exists ( select count(*) from stg.stg_ba_volunteer_skill having count(*) < 700000 )
			insert into dbo.app_data_validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Table = 'stg_BA_Volunteer_Training'

		set @Test = 'No Data - stg_BA_Volunteer_Training'
		if exists ( select count(*) from stg.stg_ba_volunteer_training having count(*) < 250000 )
			insert into dbo.app_data_validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			
		-- STAGING - HUB TABLES
		set @Table = 'stg_App'

		set @Test = 'No Data - stg_App'
		if exists ( select count(*) from stg.stg_app having count(*) < 10000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	
			
		set @Table = 'stg_App_Attribute'

		set @Test = 'No Data - stg_App_Attribute'
		if exists ( select count(*) from stg.stg_app_Attribute having count(*) < 1000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	

		set @Table = 'stg_Cong'

		set @Test = 'No Data - stg_Cong'
		if exists ( select count(*) from stg.stg_cong having count(*) < 10000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	
		
		set @Table = 'stg_Person'

		set @Test = 'No Data - stg_Person'
		if exists ( select count(*) from stg.stg_person having count(*) < 500000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );					

		set @Table = 'stg_Person_Availability'

		set @Test = 'No Data - stg_Person_Availability'
		if exists ( select count(*) from stg.stg_Person_Availability having count(*) < 10000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	

		set @Table = 'stg_Person_Dept_History'

		set @Test = 'No Data - stg_Person_Dept_History'
		if exists ( select count(*) from stg.stg_Person_Dept_History having count(*) < 10000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	
			
		set @Table = 'stg_Person_Enrollment'

		set @Test = 'No Data - stg_Person_Enrollment'
		if exists ( select count(*) from stg.stg_Person_Enrollment having count(*) < 100000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );				

		set @Table = 'stg_Person_Skill'

		set @Test = 'No Data - stg_Person_Skill'
		if exists ( select count(*) from stg.stg_Person_Skill having count(*) < 100000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );				
	
		set @Table = 'stg_Person_Tracking'

		set @Test = 'No Data - stg_Person_Tracking'
		if exists ( select count(*) from stg.stg_Person_Tracking having count(*) < 100000 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	
			
		-- APP STATUS
		set @Table = 'App_Status'

		set @Test = 'Dup - App_Status_Code'
		if exists ( select count(*) from dbo.app_status group by app_status_code having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			
		set @Test = 'Dup - App_Status'
		if exists ( select count(*) from dbo.app_status group by app_status having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			

		-- APP TYPE
		set @Table = 'App_Type'

		set @Test = 'Dup - App_Type_Code'
		if exists ( select count(*) from dbo.app_type where active_flag = 'Y' 
			 group by app_type_code having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	

		set @Test = 'Dup - App_Type_Name'
		if exists ( select count(*) from dbo.app_type where active_flag = 'Y' 
			 group by app_type_name having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			
		set @Test = 'Dup - HUB_App_Type_ID'
		if exists ( select count(*) from dbo.app_type group by hub_app_type_id having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	


		-- BA EVENT VOLUNTEER INVITE
		set @Table = 'BA_Event_Volunteer_Invite'

		set @Test = 'Dup - Event ID, Volunteer ID'
		if exists ( select count(*) from dbo.ba_event_volunteer_invite group by event_id, volunteer_id 
			 having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- BA PROJECT
		set @Table = 'BA_Project'

		set @Test = 'Dup - Project ID'
		if exists ( select count(*) from dbo.ba_project group by project_id having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	


		-- BA PROJECT GROUP
		set @Table = 'BA_Project_Group'

		set @Test = 'Dup - Project ID, Group ID'
		if exists ( select count(*) from dbo.ba_project_group group by project_id,group_id having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	


		-- BA PROJECT GROUP VOLUNTEER
		set @Table = 'BA_Project_Group_Volunteer'

		set @Test = 'Dup - BA Project Group Key, Volunteer Key'
		if exists ( select count(*) from dbo.ba_project_group_volunteer where active_flag = 'Y'  
			 group by ba_project_group_key, volunteer_key having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Test = 'Dup - Volunteer Key, Project ID, Group ID'
		if exists ( select count(*) from dbo.ba_project_group_volunteer where active_flag = 'Y'
			 group by volunteer_key, project_id, group_id having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- BA PROJECT VOLUNTEER
		set @Table = 'BA_Project_Volunteer'			

		set @Test = 'Dup - Volunteer ID, Project ID'
		if exists ( select count(*) from dbo.ba_project_volunteer group by volunteer_id, project_id
			 having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- BA PROJECT VOLUNTEER ATTENDANCE
		set @Table = 'BA_Project_Volunteer_Attendance'

		set @Test = 'Dup - Volunteer ID, Project ID, Event ID, Check In Date'
		if exists ( select count(*) from dbo.BA_Project_Volunteer_Attendance group by volunteer_id, project_id, event_id, Check_In_Date 
			 having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- CONG
		set @Table = 'Cong'

		set @Test = 'Dup - Cong Num'
		if exists ( select count(*) from dbo.cong group by cong_number having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- COUNTRY
		set @Table = 'Country'

		set @Test = 'Dup - Country Code'
		if exists ( select count(*) from dbo.country group by country_code having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Test = 'Dup - Country'
		if exists ( select count(*) from dbo.country group by country having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- ENROLLMENT
		set @Table = 'Enrollment'

		set @Test = 'Dup - Enrollment Code'
		if exists ( select count(*) from dbo.Enrollment where active_flag = 'Y' group by enrollment_code having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- POSTAL CODE
		set @Table = 'Postal_Code'

		set @Test = 'Dup - Postal Code'
		if exists ( select count(*) from dbo.Postal_Code group by postal_code having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- SKILL
		set @Table = 'Skill'

		set @Test = 'Dup - Skill'
		if exists ( select count(*) from dbo.skill where active_flag = 'Y' group by skill having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			
		set @Test = 'Dup - HUB Skill ID'
		if exists ( select count(*) from dbo.skill where hub_flag = 'Y' group by hub_skill_id having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	
			
		set @Test = 'Dup - BA Skill GUID'
		if exists ( select count(*) from dbo.skill where BA_Skill_GUID is not null and active_flag = 'Y' group by ba_skill_guid having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );				


		-- SKILL SPECIALITY
		set @Table = 'Skill_Speciality'

		set @Test = 'Dup - Skill Key, Skill_Subkill, Skill Speciality'
		if exists ( select skill_key, Skill_subskill, skill_speciality, count(*) from dbo.Skill_Speciality where hub_flag = 'Y' and active_flag = 'Y' group by skill_key, Skill_subskill, skill_speciality having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			
		set @Test = 'Dup - HUB Skill Subskill ID, HUB Skill Speciality ID'
		if exists ( select count(*) from dbo.Skill_Speciality where hub_flag = 'Y' and active_flag = 'Y' group by hub_skill_subskill_id, hub_skill_speciality_id having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	
			
		set @Test = 'Dup - BA SubSkill GUID'
		if exists ( select count(*) from dbo.Skill_Speciality where ba_subskill_guid is not null and active_flag = 'Y' group by ba_subskill_guid, coalesce( cast( BA_Skill_Speciality_GUID as varchar(50) ), '' ) having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );			


		-- STATE
		set @Table = 'State'

		set @Test = 'Dup - State, Country'
		if exists ( select count(*) from dbo.state group by state_code, country_key having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- USER LIST
		set @Table = 'User_List'

		set @Test = 'Dup - User, User List'
		if exists ( select count(*) from dbo.User_list group by user_Key, user_List having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- USER LIST VOLUNTEER
		set @Table = 'User_List_Volunteer'

		set @Test = 'Dup - User List, Volunteer'
		if exists ( select count(*) from dbo.User_List_Volunteer group by user_List_key, volunteer_key having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- VOLUNTEER
		set @Table = 'Volunteer'

		set @Test = 'Dup - HUB Person ID'
		if exists ( select count(*) from dbo.Volunteer where hub_person_id is not null group by hub_person_id having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Test = 'Dup - HUB Person GUID'
		if exists ( select count(*) from dbo.Volunteer where hub_person_guid is not null group by hub_person_guid having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Test = 'Dup - HUB Volunteer Num'
		if exists ( select count(*) from dbo.Volunteer where hub_volunteer_num is not null group by hub_volunteer_num having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			
		set @Test = 'Missing - HUB Volunteer Num'
		if exists ( select v.volunteer_key from dbo.volunteer v inner join stg.stg_person p	on v.hub_person_id = p.person_id where v.HUB_Volunteer_Num is null and p.Volunteer_Number is not null )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	
			
		set @Test = 'Missing - HUB Volunteer ID'
		if exists ( select v.volunteer_key from dbo.volunteer v inner join stg.stg_person p	on v.hub_person_id = p.person_id where v.HUB_Volunteer_ID is null and p.Volunteer_ID is not null )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );				

		set @Test = 'Dup - BA Volunteer ID'
		if exists ( select count(*) from dbo.Volunteer where ba_volunteer_id is not null group by ba_volunteer_id having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Test = 'Dup - BA Volunteer Num'
		if exists ( select count(*) from dbo.Volunteer where ba_volunteer_num is not null group by ba_volunteer_num having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Test = 'Dup - JW Username'
		if exists ( select count(*) from dbo.Volunteer where jw_username is not null group by jw_username having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Test = 'Null - Cong'
		if ( select count(*) from dbo.Volunteer where cong_key is null ) <> 0
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	
			
		set @Test = 'Null - Country'
		if ( select count(*) from dbo.Volunteer where country_key is null ) <> 0
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );				

		set @Test = 'Null - Marital Status Key'
		if ( select count(*) from dbo.Volunteer where marital_status_key is null ) <> 0
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	

		set @Test = 'Null - State Key'
		if ( select count(*) from dbo.Volunteer where state_key is null ) <> 0
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	

		set @Test = 'Null - Postal Code Key'
		if ( select count(*) from dbo.Volunteer where postal_code_key is null ) <> 0
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	
			
		set @Test = 'Null - Tracking Status Key'
		if ( select count(*) from dbo.Volunteer where tracking_status_key is null ) <> 0
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );				
			
		set @Test = 'Null - Vol Desk User Key'
		if ( select count(*) from dbo.Volunteer where vol_desk_user_key is null ) <> 0
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );			


		-- VOLUNTEER APP
		set @Table = 'Volunteer_App'

		set @Test = 'Dup - Applicant ID'
		if exists ( select count(*) from dbo.Volunteer_App group by applicant_id having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

		set @Test = 'Dup - Volunteer, App Type, Date'
		if exists ( select count(*) from dbo.Volunteer_App where active_flag = 'Y' group by volunteer_Key, app_type_key, app_date, active_flag having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- VOLUNTEER AVAILABILITY
		set @Table = 'Volunteer_Availability'

		set @Test = 'Dup - Volunteer'
		if exists ( select count(*) from dbo.Volunteer_Availability group by volunteer_key having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- VOLUNTEER DEPT
		set @Table = 'Volunteer_Dept'

		set @Test = 'Dup - Volunteer, Parent Dept, Dept, Role, Notes, Start Date, End Date, Temp, Primary, Enrollment'
		if exists ( select count(*) from dbo.Volunteer_dept group by volunteer_key, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code 
			 having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			
		set @Test = 'Dup - Person, Parent Dept, Dept, Role, Notes, Start Date, End Date, Temp, Primary, Enrollment'
		if exists ( select count(*) from dbo.Volunteer_dept group by person_Id, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code 
			 having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );			

		set @Test = 'Dup - Person, Primary'
		if exists ( select volunteer_key from dbo.Volunteer_dept where active_flag = 'Y' and Primary_Flag = 'Y' and temp_flag = 'N' and Parent_Dept_Name like 'HPR%' and volunteer_key not in (517639,252041)
					group by volunteer_key having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );	

		set @Test = 'Orphaned Work Assignment Record'
		if exists ( select * from dbo.Volunteer_Dept_Orphaned_Records_v )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );				

		-- VOLUNTEER ENROLLMENT
		set @Table = 'Volunteer_Enrollment'

		set @Test = 'Dup - Volunteer, Enrollment, Start Date'
		if exists ( select volunteer_key, enrollment_key, start_date from dbo.Volunteer_Enrollment where enrollment_key not in ( 137, 138 ) group by volunteer_key, enrollment_key, start_date having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			
		set @Test = 'Dup - Volunteer, Active Enrollment'
		if exists ( select count(*) from dbo.Volunteer_Enrollment where active_flag = 'Y' and enrollment_key not in ( 137, 138, 122 ) group by volunteer_key, enrollment_key having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );
			
		set @Test = 'Dup - Volunteer, Active Enrollment - Pioneering'
		if exists ( select count(*) from dbo.Volunteer_Enrollment where active_flag = 'Y' and enrollment_key in ( 122 ) group by volunteer_key, enrollment_key, geo_name having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );				
			
		set @Test = 'Missing Enrollment Code'
		if exists ( select count(*) from stg.stg_person_enrollment where enrollment_code not in ( select enrollment_code from dbo.enrollment where active_flag = 'Y' ) group by enrollment_code having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );			

		-- VOLUNTEER EVENT
		set @Table = 'Volunteer_Event'

		set @Test = 'Dup - Volunteer, Event, Start Date'
		if exists ( select count(*) from dbo.Volunteer_Event where start_date > '2014-10-09' 
			 group by volunteer_key, event_Key, start_date having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- VOLUNTEER EVENT DATA
		set @Table = 'Volunteer_Event_Data'

		set @Test = 'Dup - Volunteer Event, Event Attribute'
		if exists ( select count(*) from dbo.Volunteer_Event_data group by volunteer_event_key, event_attribute_key having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );


		-- VOLUNTEER ID XREF
		--set @Table = 'Volunteer_ID_Xref'

		--set @Test = 'Dup - Person ID'
		--if exists ( select count(*) from dbo.Volunteer_id_xref group by hub_person_id having count(*) > 1 )
		--	insert into dbo.App_Data_Validation( table_name, test_name, status_code )
		--	values( @table, @test, @fail );

		--set @Test = 'Dup - Volunteer Num'
		--if exists ( select count(*) from dbo.Volunteer_id_xref where hub_volunteer_num is not null group by HUB_Volunteer_Num having count(*) > 1 )
		--	insert into dbo.App_Data_Validation( table_name, test_name, status_code )
		--	values( @table, @test, @fail );

		--set @Test = 'Dup - VAX Volunteer VID'
		--if exists ( select count(*) from dbo.Volunteer_id_xref group by VAX_Volunteer_VID having count(*) > 1 )
		--	insert into dbo.App_Data_Validation( table_name, test_name, status_code )
		--	values( @table, @test, @fail );

	
		-- REPORTING
		set @Table = 'Volunteer_All_v'

		set @Test = 'Dup - Volunteer_All_v'
		if exists ( select volunteer_key from rpt.volunteer_all_v group by volunteer_key having count(*) > 1 )
			insert into dbo.App_Data_Validation( table_name, test_name, status_code )
			values( @table, @test, @fail );

	end try
		
	begin catch
	    select @Table as table_nm, @Test as test_nm, error_number() as error_num, error_message() as error_msg;
	end catch
end
go
