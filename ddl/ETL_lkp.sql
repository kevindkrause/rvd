use rvdrehearsal
go

/***********************************************************
**						APP_TYPE
***********************************************************/
if object_id('dbo.ETL_App_Type_proc') is null
    exec( 'create procedure dbo.ETL_App_Type_proc as set nocount on;' )
go

alter procedure dbo.ETL_App_Type_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'App_Type', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- INSERT
		insert into dbo.app_type( app_type_code, app_type_name, hub_app_type_id )		
		select 
			case 
				when app_type like '%Gilead' then 'GILEAD'
				when app_type like '%Evangelizers%' then 'SKE'
				else substring( app_type, 1, 4 )
			 end as app_type_code
			,app_type as app_type_name
			,app_type_id as hub_app_type_id
		from stg.stg_app_type
		where app_type_id not in ( select hub_app_type_id from dbo.app_type )

		set @Ins = @@rowcount
	
		-- UPDATE
		update dbo.app_type
		set 
			active_flag = case when src.active_flag = 1 then 'Y' else 'N' end,
			app_type_name = src.app_type,
			update_date = getdate()
		from dbo.app_type tgt
		inner join stg.stg_app_type src
			on tgt.hub_app_type_id = src.app_type_id
		where tgt.active_flag <> case when src.active_flag = 1 then 'Y' else 'N' end
			or tgt.app_type_name <> src.app_type

		set @Upd = @@rowcount

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
**						BA PROJECT
***********************************************************/
if object_id('dbo.ETL_BA_Project_proc') is null
    exec( 'create procedure dbo.ETL_BA_Project_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Project_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'BA_Project', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
	
	begin try
		-- INSERT
		insert into dbo.ba_project( project_id, project_number, project_desc, project_type, project_status, active_flag )		
		select project_id, project_number, project_desc, project_type, project_status
			,case when project_status = 'Active' then 'Y' else 'N' end as active_flag
		from stg.stg_ba_project
		where project_id not in ( select project_id from dbo.ba_project )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.ba_project
		set 
			project_number = src.project_number,
			project_desc = src.project_desc,
			project_type = src.project_type,
			project_status = src.project_status,
			active_flag = case when src.project_status = 'Active' then 'Y' else 'N' end,
			update_date = getdate()
		from dbo.ba_project tgt
		inner join stg.stg_ba_project src
			on tgt.project_id = src.project_id
		where tgt.project_number <> src.project_number
			or tgt.project_desc <> src.project_desc
			or tgt.project_type <> src.project_type
			or tgt.project_status <> src.project_status

		set @Upd = @@rowcount

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
**					BA PROJECT GROUP
***********************************************************/
if object_id('dbo.ETL_BA_Project_Group_proc') is null
    exec( 'create procedure dbo.ETL_BA_Project_Group_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Project_Group_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'BA_Project_Group', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.ba_project_group( project_id, project_number, project_name, group_id, group_name, zone, private_flag )		
		select project_id, project_number, project_name, group_id, group_name, zone
			,case when private = 1 then 'Y' else 'N' end as private_flag
		from stg.stg_ba_volunteer_group vg
		where not exists
			( select 1 from dbo.ba_project_group pg where pg.project_id = vg.project_id and pg.group_id = vg.group_id )
		group by project_id, project_number, project_name, group_id, group_name, zone, case when private = 1 then 'Y' else 'N' end

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.ba_project_group
		set 
			project_number = src.project_number,
			project_name = src.project_name,
			group_name = src.group_name,
			zone = src.zone,
			private_flag = case when src.private = 1 then 'Y' else 'N' end,
			update_date = getdate()
		from dbo.ba_project_group tgt
		inner join stg.stg_ba_volunteer_group src
			on tgt.project_id = src.project_id
			and tgt.group_id = src.group_id
		where tgt.project_number <> src.project_number
			or tgt.project_name <> src.project_name
			or tgt.group_name <> src.group_name
			or tgt.zone <> src.zone
			or tgt.private_flag <> case when src.private = 1 then 'Y' else 'N' end

		set @Upd = @@rowcount

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
**						CONG
***********************************************************/
if object_id('dbo.ETL_Cong_proc') is null
    exec( 'create procedure dbo.ETL_Cong_proc as set nocount on;' )
go

alter procedure dbo.ETL_Cong_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Cong', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.cong( 		 
			 cong_number
			,cong
			,cong_fullname
			,city
			,state_key
			,postal_code_key
			,country_key
			,circuit
			,language_code
			,kh_address1
			,kh_address2
			,kh_city
			,kh_state_code
			,kh_postal_code
			,kh_country_code
			,cobe_volunteer_key
			,cobe_person_id
			,cobe_first_name
			,cobe_last_name
			,cobe_email
			,cobe_mobile_phone
			,sec_volunteer_key
			,sec_person_id
			,sec_first_name
			,sec_last_name
			,sec_email
			,sec_mobile_phone
			,co_volunteer_key
			,co_person_id
			,co_first_name
			,co_last_name
			,co_email
			,co_mobile_phone
			,driving_distance_flag
			,dissolved_date
			,active_flag )		
		select 
			 cong_number
			,cong_name as cong
			,cong_fullname
			,cong_city
			,s.state_key
			,pc.postal_code_key
			,cntry.country_key
			,circuit
			,language_code
			,kh_address1
			,kh_address2
			,kh_city
			,kh_state_code
			,kh_postal_code
			,kh_country_code
			,cobe.volunteer_key as cobe_volunteer_key
			,cobe_person_id as cobe_person_id
			,cobe.first_name as cobe_first_name
			,cobe.last_name as cobe_last_name
			,cobe_jwpub_email as cobe_email
			,cobe_mobile_phone
			,sec.volunteer_key as sec_volunteer_key
			,sec_person_id as sec_person_id
			,sec.first_name as sec_first_name
			,sec.last_name as sec_last_name
			,cobe_jwpub_email as sec_email
			,sec_mobile_phone
			,co.volunteer_key as co_volunteer_key
			,co_person_id as co_person_id
			,co.first_name as co_first_name
			,co.last_name as co_last_name
			,cobe_jwpub_email as co_email
			,sec_mobile_phone
			,coalesce( pc.driving_distance_flag, 'N' ) as driving_distance_flag
			,dissolved_date
			,case when c.active_flag = 1 then 'Y' else 'N' end as active_flag
		from stg.stg_cong c
		left join dbo.country cntry
			on c.cong_country_code = cntry.country_code
		left join dbo.state s
			on c.cong_state_code = s.state_code
			and s.country_key = cntry.country_key	
		left join dbo.postal_code pc
			on c.kh_postal_code = pc.postal_code
		left join dbo.volunteer cobe
			on c.cobe_person_id = cobe.hub_person_id
		left join dbo.volunteer sec
			on c.cobe_person_id = sec.hub_person_id	
		left join dbo.volunteer co
			on c.cobe_person_id = co.hub_person_id			
		where cong_number not in ( select cong_number from dbo.cong )

		set @Ins = @@rowcount

		-- UPDATE (ALL EXCEPT STATE & POSTAL KEYS)
		update dbo.cong
		set 
			cong = src.cong_name,
			cong_fullname = src.cong_fullname,
			city = src.cong_city,
			circuit = src.circuit,
			language_code = src.language_code,
			kh_address1 = src.kh_address1,
			kh_address2 = src.kh_address2,
			kh_city = src.kh_city,
			kh_state_code = src.kh_state_code,
			kh_postal_code = src.kh_postal_code,
			kh_country_code = src.kh_country_code,
			dissolved_date = src.dissolved_date,
			update_date = getdate()
		from dbo.cong tgt
		inner join stg.stg_cong src
			on tgt.cong_number = src.cong_number
		left join dbo.country cntry
			on src.cong_country_code = cntry.country_code
		left join dbo.state s
			on src.cong_state_code = s.state_code
			and s.country_key = cntry.country_key
		left join dbo.postal_code lkp
			on src.kh_postal_code = lkp.postal_code
		where tgt.cong <> src.cong_name
			or tgt.cong_fullname <> src.cong_fullname
			or tgt.city <> src.cong_city
			or tgt.circuit <> src.circuit
			or tgt.language_code <> src.language_code
			or coalesce( tgt.kh_address1, '' ) <> coalesce( src.kh_address1, '' )
			or coalesce( tgt.kh_address2, '' ) <> coalesce( src.kh_address2, '' )
			or coalesce( tgt.kh_city, '' ) <> coalesce( src.kh_city, '' )
			or coalesce( tgt.kh_state_code, '' ) <> coalesce( src.kh_state_code, '' )
			or coalesce( tgt.kh_postal_code, '' ) <> coalesce( src.kh_postal_code, '' )
			or coalesce( tgt.kh_country_code, '' ) <> coalesce( src.kh_country_code, '' )
			or coalesce( tgt.dissolved_date, '1900-01-01' ) <> coalesce( src.dissolved_date, '1900-01-01' )

		set @Upd = @@rowcount

		-- UPDATE - STATE + POSTAL_CODE_KEY
		update dbo.cong
		set
			postal_code_key = lkp.postal_code_key,
			state_key = st.state_key,
			update_date = getdate()
		from dbo.cong tgt
		inner join stg.stg_cong src
			on tgt.cong_number = src.cong_number
		inner join dbo.country cntry
			on src.cong_country_code = cntry.country_code		
		inner join dbo.postal_code lkp
			on src.kh_postal_code = lkp.postal_code
		inner join dbo.state st
			on src.cong_state_code = st.state_code
			and st.country_key = cntry.country_key
		where coalesce( tgt.postal_code_key, 0 ) <> lkp.postal_code_key
			or coalesce( tgt.state_key, 0 ) <> st.state_key

		set @Upd = @Upd + @@rowcount

		-- UPDATE - COBE
		update dbo.Cong
		set
			cobe_volunteer_key = lkp.volunteer_key,
			cobe_person_id = src.cobe_person_id,
			cobe_first_name = lkp.first_name,
			cobe_last_name = lkp.last_name,
			cobe_email = src.cobe_jwpub_email,
			cobe_mobile_phone = src.cobe_mobile_phone,
			update_date = getdate()
		from dbo.Cong tgt
		inner join stg.stg_cong src
			on tgt.cong_number = src.cong_number
		inner join dbo.Volunteer lkp
			on src.cobe_person_id = lkp.hub_person_id
		where coalesce( tgt.cobe_volunteer_key, 0 ) <> lkp.volunteer_key

		set @Upd = @Upd + @@rowcount

		-- UPDATE - SECRETARY
		update dbo.Cong
		set
			sec_volunteer_key = lkp.volunteer_key,
			sec_person_id = src.sec_person_id,
			sec_first_name = lkp.first_name,
			sec_last_name = lkp.last_name,
			sec_email = src.sec_jwpub_email,
			sec_mobile_phone = src.sec_mobile_phone,		
			update_date = getdate()
		from dbo.Cong tgt
		inner join stg.stg_cong src
			on tgt.cong_number = src.cong_number
		inner join dbo.Volunteer lkp
			on src.sec_person_id = lkp.hub_person_id
		where coalesce( tgt.sec_volunteer_key, 0 ) <> lkp.volunteer_key

		set @Upd = @Upd + @@rowcount

		-- UPDATE - CO
		update dbo.Cong
		set
			co_volunteer_key = lkp.volunteer_key,
			co_person_id = src.co_person_id,
			co_first_name = lkp.first_name,
			co_last_name = lkp.last_name,
			co_email = src.co_jwpub_email,
			co_mobile_phone = lkp.mobile_phone,			
			update_date = getdate()
		from dbo.Cong tgt
		inner join stg.stg_cong src
			on tgt.cong_number = src.cong_number
		inner join dbo.Volunteer lkp
			on src.co_person_id = lkp.hub_person_id
		where coalesce( tgt.co_volunteer_key, 0 ) <> lkp.volunteer_key

		set @Upd = @Upd + @@rowcount	

		-- UPDATE - NO LONGER ACTIVE IN HUB
		update dbo.cong
		set 
			active_flag = 'N',
			update_date = getdate()
		where active_flag = 'Y'
			and cong_number not in ( select cong_number from stg.stg_cong )

		set @Upd = @Upd + @@rowcount	

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
**						HPR DEPT
***********************************************************/
if object_id('dbo.ETL_HPR_Dept_proc') is null
    exec( 'create procedure dbo.ETL_HPR_Dept_proc as set nocount on;' )
go

alter procedure dbo.ETL_HPR_Dept_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'HPR_Dept', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- UPDATE PC_CODE
		update dbo.hpr_dept
		set 
			pc_code = src.department_code,
			update_date = getdate()
		from dbo.hpr_dept tgt
		inner join stg.stg_department_hierarchy src
			on tgt.hub_dept_id = src.department_id
		where coalesce( tgt.pc_code, '' ) <> coalesce( src.department_code, '' )
		
		-- UPDATE OVERSIGHT
		update dbo.hpr_dept
		set 
			dept_ovsr_person_id = src.overseer_person_id,
			dept_asst_ovsr_person_id = src.assistant_overseer_personid,
			update_date = getdate()
		from dbo.hpr_dept tgt
		inner join stg.stg_department_hierarchy src
			on tgt.hub_dept_id = src.department_id
		where tgt.level_03 is null
			and (    coalesce( tgt.dept_ovsr_person_id, -1 ) <> coalesce( src.overseer_person_id, -1 )
				  or coalesce( tgt.dept_asst_ovsr_person_id, -1 ) <> coalesce( src.assistant_overseer_personid, -1 ) )

		set @Upd = @@rowcount

		update dbo.hpr_dept
		set 
			work_group_ovsr_person_id = src.overseer_person_id,
			work_group_asst_ovsr_person_id = src.assistant_overseer_personid,
			work_group_coor_person_id = src.work_group_coordinator_personid,
			update_date = getdate()
		from dbo.hpr_dept tgt
		inner join stg.stg_department_hierarchy src
			on tgt.hub_dept_id = src.department_id
		where tgt.level_03 is not null
			and (    coalesce( tgt.work_group_ovsr_person_id, -1 ) <> coalesce( src.overseer_person_id, -1 )
				  or coalesce( tgt.work_group_asst_ovsr_person_id, -1 ) <> coalesce( src.assistant_overseer_personid, -1 )
				  or coalesce( tgt.work_group_coor_person_id, -1 ) <> coalesce( src.work_group_coordinator_personid, -1 ) )

		set @Upd = @Upd + @@rowcount
		
		-- UPDATE OVERSIGHT DETAILS
		update dbo.hpr_dept
		set 
			dept_ovsr = src.full_name,
			dept_ovsr_email = src.alt_email,
			update_date = getdate()
		from dbo.hpr_dept tgt
		inner join dbo.volunteer src
			on tgt.dept_ovsr_person_id = src.hub_person_id
			
		set @Upd = @Upd + @@rowcount

		update dbo.hpr_dept
		set 
			dept_asst_ovsr = src.full_name,
			dept_asst_ovsr_email = src.alt_email,
			update_date = getdate()
		from dbo.hpr_dept tgt
		inner join dbo.volunteer src
			on tgt.dept_asst_ovsr_person_id = src.hub_person_id
			
		set @Upd = @Upd + @@rowcount

		update dbo.hpr_dept
		set 
			work_group_ovsr = src.full_name,
			work_group_ovsr_email = src.alt_email,
			update_date = getdate()
		from dbo.hpr_dept tgt
		left join dbo.volunteer src
			on tgt.work_group_ovsr_person_id = src.hub_person_id
			
		set @Upd = @Upd + @@rowcount

		update dbo.hpr_dept
		set 
			work_group_asst_ovsr = src.full_name,
			work_group_asst_ovsr_email = src.alt_email,
			update_date = getdate()
		from dbo.hpr_dept tgt
		left join dbo.volunteer src
			on tgt.work_group_asst_ovsr_person_id = src.hub_person_id
			
		set @Upd = @Upd + @@rowcount

		update dbo.hpr_dept
		set 
			work_group_coor = src.full_name,
			work_group_coor_email = src.alt_email,
			update_date = getdate()
		from dbo.hpr_dept tgt
		left join dbo.volunteer src
			on tgt.work_group_coor_person_id = src.hub_person_id
			
		set @Upd = @Upd + @@rowcount

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
**						SKILL
***********************************************************/
if object_id('dbo.ETL_Skill_proc') is null
    exec( 'create procedure dbo.ETL_Skill_proc as set nocount on;' )
go

alter procedure dbo.ETL_Skill_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Skill', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.skill( skill, hub_flag, hub_skill_id)		
		select distinct skill, 'Y' as hub_flag, skill_id as hub_skill_id
		from stg.stg_skill
		where skill_id not in ( select hub_skill_id from dbo.skill )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.skill
		set 
			skill = src.skill,
			update_date = getdate()
		from dbo.skill tgt
		inner join stg.stg_skill src
			on tgt.hub_skill_id = src.skill_id
		where tgt.skill <> src.skill

		set @Upd = @@rowcount

		-- UPDATE - NO LONGER ACTIVE IN HUB
		update dbo.skill
		set 
			hub_skill_id = 0,
			active_flag = 'N',
			update_date = getdate()
		where hub_flag = 'Y'
			and active_flag = 'Y'
			and hub_skill_id not in ( select skill_id from stg.stg_skill )

		set @Upd = @Upd + @@rowcount

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
**						SKILL_SPECIALITY
***********************************************************/
if object_id('dbo.ETL_Skill_Speciality_proc') is null
    exec( 'create procedure dbo.ETL_Skill_Speciality_proc as set nocount on;' )
go

alter procedure dbo.ETL_Skill_Speciality_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Skill_Speciality', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.skill_speciality( skill_speciality, hub_flag, hub_skill_speciality_id, skill_key, HUB_Skill_Subskill_ID, Skill_Subskill )		
		select coalesce( stg.skill_speciality, '' ), 'Y' as hub_flag, coalesce( stg.skill_speciality_id, 0 ) as hub_skill_speciality_id, lkp.Skill_Key, stg.Skill_Subskill_ID, stg.Skill_Subskill
		from stg.stg_skill stg
		inner join dbo.Skill lkp
			on stg.Skill_ID = lkp.HUB_Skill_ID
		where stg.skill_subskill_id not in ( select hub_skill_subskill_id from dbo.skill_speciality )
			or stg.skill_speciality_id not in ( select hub_skill_speciality_id from dbo.skill_speciality )
/*			
		insert into dbo.skill_speciality( skill_speciality, hub_flag, hub_skill_speciality_id, skill_key, HUB_Skill_Subskill_ID, Skill_Subskill )		
		select distinct '', 'Y' as hub_flag, 0 as hub_skill_speciality_id, lkp.Skill_Key, stg.Skill_Subskill_ID, stg.Skill_Subskill
		from stg.stg_skill stg
		inner join dbo.Skill lkp
			on stg.Skill_ID = lkp.HUB_Skill_ID
		where Skill_id = 10
			and Skill_Speciality_ID is not null			
*/			

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.skill_speciality
		set 
			skill_subskill = coalesce( src.skill_subskill, '' ),
			skill_speciality = coalesce( src.skill_speciality, '' ),
			update_date = getdate()
		from dbo.skill_speciality tgt
		inner join stg.stg_skill src
			on tgt.hub_skill_subskill_id = src.skill_subskill_id
			and tgt.hub_skill_speciality_id = coalesce( src.skill_speciality_id, 0 )
			and tgt.hub_flag = 'Y'
			and tgt.active_flag = 'Y'
		where tgt.skill_subskill <> src.skill_subskill
			or tgt.skill_speciality <> coalesce( src.skill_speciality, '' )

		set @Upd = @@rowcount

		-- UPDATE - NO LONGER ACTIVE IN HUB
		update dbo.skill_speciality
		set 
			active_flag = 'N',
			update_date = getdate()
		where hub_flag = 'Y'
			and active_flag = 'Y'
			and (
				   hub_skill_subskill_id not in ( select skill_subskill_id from stg.stg_skill )
				or hub_skill_speciality_id not in ( select skill_speciality_id from stg.stg_skill ) )

		set @Upd = @Upd + @@rowcount

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
**				PARENT - LOOKUP TABLES
***********************************************************/
if object_id('dbo.ETL_lkp_proc') is null
    exec( 'create procedure dbo.ETL_lkp_proc as set nocount on;' )
go

alter procedure dbo.ETL_lkp_proc
as
begin
	exec dbo.ETL_App_Type_proc
	exec dbo.ETL_BA_Project_proc
	exec dbo.ETL_BA_Project_Group_proc
	exec dbo.ETL_Cong_proc
	exec dbo.ETL_HPR_Dept_proc
	exec dbo.ETL_Skill_proc
	exec dbo.ETL_Skill_Speciality_proc
end
go