/***********************************************************
**						ENV CHANGE
**	rvdrehearsal = [rvdrehearsal-ussqlext021.bethel.jw.org].RVDUNION_Export / USSQLext139.RVDUNION_Export
**	rvd 		 = [rvd-ussqlext019.bethel.jw.org].RVD_Export / USSQLEXT140.RVD_Export
***********************************************************/

use rvdrehearsal
go

/***********************************************************
**						BA PROJECT
***********************************************************/
if object_id('dbo.ETL_BA_Import_Project_proc') is null
    exec( 'create procedure dbo.ETL_BA_Import_Project_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Import_Project_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'stg_BA_Project', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- TRUNCATE
		set @Del = ( select count(*) from stg.stg_BA_Project )
		
		truncate table stg.stg_BA_Project
				
		-- INSERT
		insert into stg.stg_BA_Project( 
			 project_id
			,project_number
			,project_desc
			,project_type
			,project_status )		
		select 
			 project_id 		
			,project_number
			,project_description 
			,project_type 
			,project_status
		from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Project

		set @Ins = @@rowcount
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**					BA PROJECT VOLUNTEER
***********************************************************/
if object_id('dbo.ETL_BA_Import_Project_Volunteer_proc') is null
    exec( 'create procedure dbo.ETL_BA_Import_Project_Volunteer_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Import_Project_Volunteer_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'stg_BA_Project_Volunteer', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- TRUNCATE
		set @Del = ( select count(*) from stg.stg_BA_Project_Volunteer )
		
		truncate table stg.stg_BA_Project_Volunteer
				
		-- INSERT
		insert into stg.stg_BA_Project_Volunteer( 
			 project_id 	
			,volunteer_id
			,person_guid 
			,invited 	
			,accepted 	
			,attended )		
		select 
			 project_id 	
			,volunteer_id
			,person_guid 
			,invited 	
			,accepted 	
			,attended
		from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Project_Volunteer

		set @Ins = @@rowcount
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**					BA VOLUNTEER
***********************************************************/
if object_id('dbo.ETL_BA_Import_Volunteer_proc') is null
    exec( 'create procedure dbo.ETL_BA_Import_Volunteer_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Import_Volunteer_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'stg_BA_Volunteer', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- TRUNCATE
		set @Del = ( select count(*) from stg.stg_BA_Volunteer )
		
		truncate table stg.stg_BA_Volunteer
				
		-- INSERT
		insert into stg.stg_BA_Volunteer( 
			 volunteer_id 			
			,volunteer_banumber      
			,person_guid 			
			,preferred_name 			
			,preferred_phone_number 	
			,preferred_phone_type 	
			,text_msg_opt_in 		
			,mate_volunteer_id 		
			,mate_volunteer_banumber 
			,mate_person_guid		
			,interviewed_date 		
			,safety_orientation_date 
			,statement_accepted_date 
			,special_equip_desc		
			,last_login_date 		
			,domainperm				
			,projectperm )		
		select 
			 volunteer_id 			
			,volunteer_banumber      
			,person_guid 			
			,preferred_name 			
			,preferred_phone_number 	
			,preferred_phone_type 	
			,text_msg_opt_in 		
			,mate_volunteer_id 		
			,mate_volunteer_banumber 
			,mate_person_guid		
			,interviewed_date 		
			,safety_orientation_date 
			,statement_accepted_date 
			,special_equip_desc		
			,last_login_date 		
			,domainperm				
			,projectperm				
		from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Volunteer

		set @Ins = @@rowcount
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**					BA VOLUNTEER ATTENDANCE
***********************************************************/
if object_id('dbo.ETL_BA_Import_Volunteer_Attendance_proc') is null
    exec( 'create procedure dbo.ETL_BA_Import_Volunteer_Attendance_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Import_Volunteer_Attendance_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'stg_BA_Volunteer_Attendance', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- TRUNCATE
		set @Del = ( select count(*) from stg.stg_BA_Volunteer_Attendance )
		
		truncate table stg.stg_BA_Volunteer_Attendance
				
		-- INSERT
		insert into stg.stg_BA_Volunteer_Attendance( 
			 volunteer_id
			,person_guid 
			,project_id 	
			,checkin_date
			,event_name 	
			,status 		
			,event_id )		
		select 
			 volunteer_id
			,person_guid 
			,project_id 	
			,checkin_date
			,event_name 	
			,status 		
			,event_id 	
		from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Volunteer_Attendance

		set @Ins = @@rowcount
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**					BA VOLUNTEER GROUP
***********************************************************/
if object_id('dbo.ETL_BA_Import_Volunteer_Group_proc') is null
    exec( 'create procedure dbo.ETL_BA_Import_Volunteer_Group_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Import_Volunteer_Group_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'stg_BA_Volunteer_Group', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- TRUNCATE
		set @Del = ( select count(*) from stg.stg_BA_Volunteer_Group )
		
		truncate table stg.stg_BA_Volunteer_Group
				
		-- INSERT
		insert into stg.stg_BA_Volunteer_Group( 
			 volunteer_id	
			,person_guid 	
			,group_id		
			,group_name 		
			,zone 			
			,project_id 		
			,project_number	
			,project_name 	
			,private 		
			,created_date )		
		select 
			 volunteer_id	
			,person_guid 	
			,group_id		
			,group_name 		
			,zone 			
			,project_id 		
			,project_number	
			,project_name 	
			,private 		
			,created_date 
		from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Volunteer_Group

		set @Ins = @@rowcount
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**					BA VOLUNTEER INVITE
***********************************************************/
if object_id('dbo.ETL_BA_Import_Volunteer_Invite_proc') is null
    exec( 'create procedure dbo.ETL_BA_Import_Volunteer_Invite_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Import_Volunteer_Invite_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'stg_BA_Volunteer_Invite', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- TRUNCATE
		set @Del = ( select count(*) from stg.stg_BA_Volunteer_Invite )
		
		truncate table stg.stg_BA_Volunteer_Invite
				
		-- INSERT
		insert into stg.stg_BA_Volunteer_Invite( 
			 volunteer_id			
			,person_guid 			
			,event_id				
			,event_name 				
			,link 					
			,start_date 				
			,event_length 			
			,maximum_confirmations 	
			,status_day_1 			
			,status_day_2 			
			,status_day_3 			
			,status_day_4 			
			,status_day_5 			
			,status_day_6 			
			,status_day_7 			
			,comments 				
			,manager_comments )		
		select 
			 volunteer_id			
			,person_guid 			
			,event_id				
			,event_name 				
			,link 					
			,start_date 				
			,event_length 			
			,maximum_confirmations 	
			,status_day_1 			
			,status_day_2 			
			,status_day_3 			
			,status_day_4 			
			,status_day_5 			
			,status_day_6 			
			,status_day_7 			
			,comments 				
			,manager_comments 		
		from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Volunteer_Invite

		set @Ins = @@rowcount
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**					BA VOLUNTEER SKILL
***********************************************************/
if object_id('dbo.ETL_BA_Import_Volunteer_Skill_proc') is null
    exec( 'create procedure dbo.ETL_BA_Import_Volunteer_Skill_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Import_Volunteer_Skill_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'stg_BA_Volunteer_Skill', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- TRUNCATE
		set @Del = ( select count(*) from stg.stg_BA_Volunteer_Skill )
		
		truncate table stg.stg_BA_Volunteer_Skill
				
		-- INSERT
		insert into stg.stg_BA_Volunteer_Skill( 
			 volunteer_id			
			,person_guid 			
			,subskill_guid 
			,assessed_proficiency			
			,personal_notes 			
			,overseer_assessment_name 
			,overseer_assessment 	
			,overseer_assessment_notes
			,overseer_assessment_date )		
		select 
			 volunteer_id			
			,person_guid 			
			,subskill_guid 
			,assessed_profiency			
			,person_notes 			
			,overseer_assessment_name 
			,overseer_assessment 	
			,overseer_assessment_notes
			,overseer_assessment_date 
		from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Volunteer_Skill

		set @Ins = @@rowcount
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**					BA VOLUNTEER TRAINING
***********************************************************/
if object_id('dbo.ETL_BA_Import_Volunteer_Training_proc') is null
    exec( 'create procedure dbo.ETL_BA_Import_Volunteer_Training_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Import_Volunteer_Training_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'stg_BA_Volunteer_Training', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- TRUNCATE
		set @Del = ( select count(*) from stg.stg_BA_Volunteer_Training )
		
		truncate table stg.stg_BA_Volunteer_Training
				
		-- INSERT
		insert into stg.stg_BA_Volunteer_Training( 
			 volunteer_id			
			,person_guid 			
			,course_name 	
			,course_desc 	
			,course_type 	
			,active_flag 	
			,assign_date 	
			,complete_date 
			,modified_date )		
		select 
			 volunteer_id			
			,person_guid 			
			,course_name 	
			,course_desc 	
			,course_type 	
			,active_flag 	
			,assign_date 	
			,complete_date 
			,modified_date  
		from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Volunteer_Training

		set @Ins = @@rowcount
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**					BA LOAD STATUS
***********************************************************/
if object_id('dbo.ETL_BA_Import_Load_Status_proc') is null
    exec( 'create procedure dbo.ETL_BA_Import_Load_Status_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Import_Load_Status_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'stg_BA_Load_Status', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- TRUNCATE
		set @Del = ( select count(*) from stg.stg_BA_Load_Status )
		
		truncate table stg.stg_BA_Load_Status
				
		-- INSERT
		insert into stg.stg_BA_Load_Status( ba_load_status_date )		
		select load_date 
		from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.BA_Load_Status

		set @Ins = @@rowcount
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**				PARENT - BA IMPORT
***********************************************************/
if object_id('dbo.ETL_BA_import_proc') is null
    exec( 'create procedure dbo.ETL_BA_import_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_import_proc
as
begin
	exec dbo.ETL_BA_Import_Project_proc
	exec dbo.ETL_BA_Import_Project_Volunteer_proc
	exec dbo.ETL_BA_Import_Volunteer_proc
	exec dbo.ETL_BA_Import_Volunteer_Attendance_proc
	exec dbo.ETL_BA_Import_Volunteer_Group_proc
	exec dbo.ETL_BA_Import_Volunteer_Invite_proc
	exec dbo.ETL_BA_Import_Volunteer_Skill_proc
	exec dbo.ETL_BA_Import_Volunteer_Training_proc
	exec dbo.ETL_BA_Import_Load_Status_proc
end
go
