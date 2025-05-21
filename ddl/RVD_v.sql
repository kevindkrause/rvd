/*******************************************************************
**							VIEWS
*******************************************************************/
use rvdrehearsal
go


if object_id('dbo.App_Data_Validation_Curr_v', 'V') is not null
	drop view dbo.App_Data_Validation_Curr_v
go 
create view dbo.App_Data_Validation_Curr_v
as
select 
	  table_name
	 ,test_name
	 ,load_date
	 ,update_date
from dbo.App_Data_Validation
where active_flag = 'Y'
go


if object_id('dbo.BA_Event_v', 'V') is not null
	drop view dbo.BA_Event_v
go 
create view dbo.BA_Event_v
as
select event_name
from 
	( select event_name, min( start_date ) as min_dt, max( start_date ) as max_dt
	  from dbo.BA_Event_Volunteer_Invite
	  where active_flag = 'Y'
	  group by event_name ) core
where datediff( day, min_dt, max_dt ) >= 5
go


if object_id('dbo.Cal_Dim_v', 'V') is not null
	drop view dbo.Cal_Dim_v
go 
create view dbo.Cal_Dim_v
as
select *
from dbo.cal_dim
go


if object_id('dbo.Cong_v', 'V') is not null
	drop view dbo.Cong_v
go 
create view dbo.Cong_v
as
select 
	 c.cong_key
	,c.cong_number
	,c.cong
	,c.cong_fullname
	,c.city
	,s.state_code
	,pc.postal_code
	,cntry.country_code
	,c.state_key
	,c.Country_Key	
	,c.circuit
	,c.language_code
	,c.kh_address1
	,c.kh_address2
	,c.kh_city
	,c.kh_state_code
	,c.kh_postal_code
	,c.kh_country_code
	,c.cobe_volunteer_key
	,c.cobe_person_id
	,c.cobe_first_name
	,c.cobe_last_name
	,c.cobe_last_name + ', ' + c.cobe_first_name as cobe_fullname
	,c.cobe_email
	,c.cobe_mobile_phone
	,c.sec_volunteer_key
	,c.sec_person_id
	,c.sec_first_name
	,c.sec_last_name
	,c.sec_last_name + ', ' + c.sec_first_name as sec_fullname
	,c.sec_email
	,c.sec_mobile_phone
	,c.co_volunteer_key
	,c.co_person_id
	,c.co_first_name
	,c.co_last_name
	,c.co_last_name + ', ' + c.co_first_name as co_fullname
	,c.co_email
	,c.co_mobile_phone
	,c.driving_distance_flag
	,c.dissolved_date
	,c.active_flag
	,c.load_date
	,c.update_date
from dbo.cong c
left join dbo.postal_code pc
	on c.postal_code_key = pc.postal_code_key
left join dbo.state s
	on c.state_key = s.state_key
left join dbo.country cntry
	on c.country_key = cntry.country_key
where c.active_flag = 'Y'
go


if object_id('dbo.Dept_Asgn_v', 'V') is not null
	drop view dbo.Dept_Asgn_v
go 
create view dbo.Dept_Asgn_v
as
select 
	 da.dept_asgn_key
	,d.cpc_code
	,d.dept_name
	,d.work_group_name
	,d.level_02
	,d.level_03
	,d.level_04
	,d.level_05
	,d.level_06
	,case when d.work_group_name = '' then d.dept_name else d.dept_name + ' - ' +  d.work_group_name end as full_dept_name
	,c.crew_name
	,dr.dept_role
	,da.skill_level
	,da.dept_start_date
	,da.dept_end_date
	,e.enrollment_code as dept_enrollment_code
	,da.notes
	,da.dept_first_name
	,da.dept_last_name
	,das.dept_asgn_status
	,das.dept_asgn_status_code
	,da.priority_key
	,case 
		when da.priority_key = 1 then '!!'
		when da.priority_key = 2 then '!'
		when da.priority_key = 3 then '-'
		when da.priority_key = 4 then '_'
		else '.'
	 end as priority
	,da.candidate_1_vol_key
	,da.candidate_1_name
	,da.candidate_1_profile
	,da.candidate_1_next_step
	,case when isnull(da.candidate_1_name, 'Null') <> 'Null' then left(da.candidate_1_name, charindex(',', da.candidate_1_name) + 2) end as candidate_1_name_abbr
	,da.candidate_2_vol_key
	,da.candidate_2_name
	,da.candidate_2_profile
	,da.candidate_2_next_step
	,case when isnull(da.candidate_2_name, 'Null') <> 'Null' then left(da.candidate_2_name, charindex(',', da.candidate_2_name) + 2) end as candidate_2_name_abbr
	,da.candidate_3_vol_key
	,da.candidate_3_name
	,da.candidate_3_profile
	,da.candidate_3_next_step
	,case when isnull(da.candidate_3_name, 'Null') <> 'Null' then left(da.candidate_3_name, charindex(',', da.candidate_3_name) + 2) end as candidate_3_name_abbr
	,da.candidate_4_vol_key
	,da.candidate_4_name
	,da.candidate_4_profile
	,da.candidate_4_next_step
	,case when isnull(da.candidate_4_name, 'Null') <> 'Null' then left(da.candidate_4_name, charindex(',', da.candidate_4_name) + 2) end as candidate_4_name_abbr
	,da.candidate_5_vol_key
	,da.candidate_5_name
	,da.candidate_5_profile
	,da.candidate_5_next_step
	,case when isnull(da.candidate_5_name, 'Null') <> 'Null' then left(da.candidate_5_name, charindex(',', da.candidate_5_name) + 2) end as candidate_5_name_abbr
	,da.candidate_6_vol_key
	,da.candidate_6_name
	,da.candidate_6_profile
	,da.candidate_6_next_step
	,case when isnull(da.candidate_6_name, 'Null') <> 'Null' then left(da.candidate_6_name, charindex(',', da.candidate_6_name) + 2) end as candidate_6_name_abbr	
	,da.candidate_7_vol_key
	,da.candidate_7_name
	,da.candidate_7_profile
	,da.candidate_7_next_step
	,case when isnull(da.candidate_7_name, 'Null') <> 'Null' then left(da.candidate_7_name, charindex(',', da.candidate_7_name) + 2) end as candidate_7_name_abbr
	,da.candidate_8_vol_key
	,da.candidate_8_name
	,da.candidate_8_profile
	,da.candidate_8_next_step
	,case when isnull(da.candidate_8_name, 'Null') <> 'Null' then left(da.candidate_8_name, charindex(',', da.candidate_8_name) + 2) end as candidate_8_name_abbr		
	,v.Full_Name
	,v.last_name + ', ' + left( v.first_name, 1 ) + '.' as volunteer_name_short
	,e2.enrollment_code as ps_enrollment_code
	,da.ps_start_date
	,da.ps_end_date
	,datediff( month, ps_start_date, coalesce( ps_end_date, '2027-12-31' ) ) as duration_in_months
	,da.ps_notes
	,da.job_description
	,da.invite_chart_comments
	,ms.marital_status_code
	,v.cong_servant_code
	,v.room_site_code
	,v.room_bldg_code
	,da.vtc_meeting_code
	,da.active_flag
	,da.test_data_flag
	,da.sync_data_flag
	,da.load_date
	,da.update_date
	,da.hpr_dept_key
	,da.hpr_crew_key
	,da.hpr_dept_role_key
	,da.enrollment_key
	,da.dept_asgn_status_key	
	,da.volunteer_key
	,da.Num_Weeks
	,da.Num_Months
	,da.Until_Not_Needed
	,da.Short_Term_OK
	,da.Trade_To_Qualify
	,da.Quantity_To_Replicate
	,da.Multiple_Record_Number
	,da.Current_Sync_Status
	,da.HPR_Dept_Role_Sharepoint_Key
	,da.HPR_Dept_Sharepoint_Key
	,da.HPR_Crew_Sharepoint_Key
	,da.ID_SP
	,case when isnull(das.sort_trade_request, 999) = 999 then 999 else das.sort_trade_request end as Sort_Trade_Request
	,da.Possible_Sister
	,da.HuBIncidentURL
	,d.PC_Code	
	,v.HUB_Person_ID
	,v.HUB_Volunteer_ID
	,da.Update_Source
	,da.Update_Type
	,da.UpdateDate_Source
	,da.Update_ReviewedByUser
	,da.Ext_Orig_PS_End_Date
	,da.Ext_Orig_Enrollment_Key
	,da.Ext_Orig_Dept_Asgn_Status_Key
	,da.Ext_Last_Start_Date
	,da.Extension_Flag
	,da.Extension_Flag_UpdateDate
from dbo.dept_asgn da
inner join dbo.hpr_dept d
	on da.hpr_dept_key = d.hpr_dept_key
left join dbo.Dept_Asgn_Status das
	on da.dept_asgn_status_key = das.dept_asgn_status_key
	and das.dept_asgn_status_type = 'DA'
left join dbo.hpr_crew c
	on da.hpr_crew_key = c.hpr_crew_key
left join dbo.hpr_dept_role  dr
	on da.hpr_dept_role_key = dr.hpr_dept_role_key
left join dbo.enrollment e
	on da.enrollment_key = e.enrollment_key
	and e.active_flag = 'Y'
left join dbo.volunteer v
	on da.volunteer_key = v.volunteer_key
left join dbo.marital_status ms 
	on v.marital_status_key = ms.marital_status_key
left join dbo.enrollment e2
	on v.current_enrollment_key = e2.enrollment_key
	and e2.active_flag = 'Y'
go



CREATE VIEW [dbo].[Dept_Asgn_LeadTime_v]
AS
SELECT        dbo.Dept_Asgn_LeadTime.Dept_Asgn_LeadTime_Key, dbo.Dept_Asgn_LeadTime.Enrollment_Key, dbo.Enrollment.Enrollment_Code, dbo.Dept_Asgn_LeadTime.New_No_Earlier, dbo.Dept_Asgn_LeadTime.New_No_Later, 
                         dbo.Dept_Asgn_LeadTime.Transfer_No_Earlier, dbo.Dept_Asgn_LeadTime.Transfer_No_Later, dbo.Dept_Asgn_LeadTime.Active_Flag
FROM            dbo.Dept_Asgn_LeadTime INNER JOIN
                         dbo.Enrollment ON dbo.Dept_Asgn_LeadTime.Enrollment_Key = dbo.Enrollment.Enrollment_Key
WHERE        (dbo.Enrollment.Active_Flag = N'Y') AND (dbo.Dept_Asgn_LeadTime.Active_Flag = N'Y')
GO

	
if object_id('dbo.Dept_Asgn_VTC_v', 'V') is not null
	drop view dbo.Dept_Asgn_VTC_v
go 
create view dbo.Dept_Asgn_VTC_v
as
select 
	 dr.dept_asgn_key
	,dr.hpr_dept_key
	,dr.cpc_code
	,dr.dept_name
	,dr.work_group_name
	,dr.level_02
	,dr.level_03
	,dr.level_04		
	,dr.hpr_crew_key
	,dr.hpr_dept_role_key
	,dr.enrollment_key
	,dr.skill_level
	,dr.dept_start_date
	,dr.dept_end_date
	,dr.notes
	,dr.dept_first_name
	,dr.dept_last_name
	,dr.dept_asgn_status_key
	,dr.priority_key
	,dr.priority	
	,dr.candidate_1_vol_key
	,dr.candidate_1_name
	,dr.candidate_1_profile
	,dr.candidate_1_next_step
	,dr.candidate_1_name_abbr
	,dr.candidate_2_vol_key
	,dr.candidate_2_name
	,dr.candidate_2_profile
	,dr.candidate_2_next_step
	,dr.candidate_2_name_abbr
	,dr.candidate_3_vol_key
	,dr.candidate_3_name
	,dr.candidate_3_profile
	,dr.candidate_3_next_step
	,dr.candidate_3_name_abbr
	,dr.candidate_4_vol_key
	,dr.candidate_4_name
	,dr.candidate_4_profile
	,dr.candidate_4_next_step
	,dr.candidate_4_name_abbr
	,dr.candidate_5_vol_key
	,dr.candidate_5_name
	,dr.candidate_5_profile
	,dr.candidate_5_next_step
	,dr.candidate_5_name_abbr
	,dr.candidate_6_vol_key
	,dr.candidate_6_name
	,dr.candidate_6_profile
	,dr.candidate_6_next_step
	,dr.candidate_6_name_abbr	
	,dr.candidate_7_vol_key
	,dr.candidate_7_name
	,dr.candidate_7_profile
	,dr.candidate_7_next_step
	,dr.candidate_7_name_abbr
	,dr.candidate_8_vol_key
	,dr.candidate_8_name
	,dr.candidate_8_profile
	,dr.candidate_8_next_step
	,dr.candidate_8_name_abbr
	,dr.vtc_meeting_code
	,dr.volunteer_key
	,dr.ps_start_date
	,dr.ps_end_date
	,dr.ps_notes
	,dr.job_description
	,dr.active_flag
	,dr.test_data_flag
	,dr.sync_data_flag
	,dr.load_date
	,dr.update_date
	,u.user_key
	,u.vtc_level_02	
	,u.VTC_Level_03	
	,dr.Full_Name
	,dr.marital_status_code
	,dr.cong_servant_code
	,dr.Num_Weeks
	,dr.Num_Months
	,dr.Until_Not_Needed
	,dr.Short_Term_OK
	,dr.Trade_To_Qualify
	,dr.Quantity_To_Replicate
	,dr.Multiple_Record_Number
	,case when isnull(dr.Sort_Trade_Request, 999) = 999 then 999 else dr.Sort_Trade_Request end AS Sort_Trade_Request
	,u.VTC_CPC_Code
	,dr.Possible_Sister
	,dr.Sort_Trade_Request AS Expr1
	,dr.PC_Code
	,dr.Current_Sync_Status
from dbo.Dept_asgn_v dr
inner join dbo.[User] u
	on dr.cpc_code = u.VTC_CPC_Code
	and coalesce( dr.Level_03, '' ) = case when u.VTC_Level_02 is not null then u.VTC_Level_02 else coalesce( dr.level_03, '' ) end
	and coalesce( dr.Level_04, '' ) = case when u.VTC_Level_03 is not null then u.VTC_Level_03 else coalesce( dr.Level_04, '' ) end	
go	


if object_id('dbo.ETL_Table_Run_v', 'V') is not null
	drop view dbo.ETL_Table_Run_v
go 
create view dbo.ETL_Table_Run_v
as
select 
	 etl_table
	,rows_inserted
	,rows_updated
	,rows_deleted
	,start_time
	,end_time
	,datediff( s, start_time, end_time ) as runtime_sec
	,round( datediff( s, start_time, end_time ) / 60, 1 ) as runtime_min
	,status_code
from dbo.etl_table_run
go


if object_id('dbo.ETL_Table_Run_Curr_v', 'V') is not null
	drop view dbo.ETL_Table_Run_Curr_v
go 
create view dbo.ETL_Table_Run_Curr_v
as
select 
	 etl_table
	,rows_inserted
	,rows_updated
	,rows_deleted
	,start_time
	,end_time
	,runtime_sec
	,runtime_min
	,status_code
from dbo.ETL_Table_Run_v
where start_time > cast(getdate() as date)
go


if object_id('dbo.HPR_Volunteer_Invites_Base_v', 'V') is not null
	drop view dbo.HPR_Volunteer_Invites_Base_v
go 
create view dbo.HPR_Volunteer_Invites_Base_v
as
select 
	 v.volunteer_key
	,v.full_name
	,v.ba_volunteer_num
	,ve.dept_code
	,ve.dept_name
	,ve.start_date
	,ve.end_date
	,null as prior_date
	,null as profile_export_status_code
	,ve.notes
	,null as dvp_team
from dbo.volunteer_enrollment ve
inner join dbo.volunteer v
	on ve.volunteer_key = v.volunteer_key
where ve.end_date > getdate() 
	and ve.enrollment_key = 76  -- BCV, was BRD invites
go


if object_id('dbo.HPR_Volunteer_Invites_v', 'V') is not null
	drop view dbo.HPR_Volunteer_Invites_v
go 
create view dbo.HPR_Volunteer_Invites_v
as
select 
	 i.volunteer_key
	,i.full_name
	,i.ba_volunteer_num
	,i.dept_code
	,i.dept_name
	,i.start_date
	,i.end_date
	,i.profile_export_status_code
	,i.notes
	,i.prior_date
	,i.dvp_team
	,null as picture_exists_flag
from dbo.hpr_volunteer_invites_base_v i
left join volunteer v
	on i.volunteer_key = v.volunteer_key
where i.prior_date < ( getdate() - ( 7 + ( ( datepart( weekday, getdate() ) + @@datefirst + 6 - 1 ) % 7 ) ) )  -- WEEK START MONDAY
	or i.prior_date is null
go


if object_id('dbo.MW_Attendant_v', 'V') is not null
	drop view dbo.MW_Attendant_v
go 
create view dbo.MW_Attendant_v
as
select pcc.volunteer_name, pcc.hub_volunteer_num, v.cong_servant_code, pcc.enrollment_1_code as enrollment_code
from rpt.pcc_project_volunteer_v pcc
inner join dbo.volunteer v
	on pcc.volunteer_key = v.volunteer_key
where 1=1
	and v.gender_code = 'M'
	and pcc.enrollment_1_code in ( 'BBR', 'BBF', 'BCS', 'BCF', 'BCL', 'BCV' )
	and pcc.hpr_flag = 'Y'
	and pcc.dept_1_parent_dept_name in ( select DepartmentName from stg.stg_hpr_dept )
go


if object_id('dbo.Skills_v', 'V') is not null
	drop view dbo.Skills_v
go 
create view dbo.Skills_v
as
select 
	 s.skill
	,ss.skill_subskill
	,ss.skill_speciality
	,s.skill_key
	,ss.skill_speciality_key
from dbo.skill s
inner join dbo.skill_speciality ss
	on s.skill_key = ss.skill_key
where s.active_flag = 'Y'
	and ss.active_flag = 'Y'
go


if object_id('dbo.User_Activity_Summary_v', 'V') is not null
	drop view dbo.User_Activity_Summary_v
go 
create view dbo.User_Activity_Summary_v
as
select top 1000 last_name + ', ' + first_name as full_name, format( login_datetime, 'yyyy-MM-01' ) as mth, count(*) as cnt 
from dbo.User_Activity_v
where last_name not in ( 'Bargeron', 'Krause', 'Cassell' )
group by last_name + ', ' + first_name, format( login_datetime, 'yyyy-MM-01' )
order by 1, 2 desc
go


if object_id('dbo.User_Activity_v', 'V') is not null
	drop view dbo.User_Activity_v
go 
create view dbo.User_Activity_v
as
select 
	 ua.user_key
	,u.last_name
	,u.first_name
	,u.pc_name
	,ua.user_computer_name
	,ua.login_datetime
	,ua.logoff_datetime
	,datediff( mi, ua.login_datetime, coalesce( ua.logoff_datetime, getdate() ) ) as session_length_min
from dbo.user_activity ua
inner join dbo.[user] u
	on ua.user_key = u.user_key
go


if object_id('dbo.User_List_v', 'V') is not null
	drop view dbo.User_List_v
go 
create view dbo.User_List_v
as
select 
	 u.user_key
	,u.first_name
	,u.last_name
	,u.email
	,u.ad_user_name
	,u.vtc_flag	
	,ul.user_list_key
	,ul.user_list
	,ul.user_list_description
	,ul.dept_asgn_key
	,ul.pq_flag
	,ul.hpr_dept_key
	,d.vtc_1_user_key
	,d.vtc_2_user_key
	,d.vtc_3_user_key
	,d.vtc_4_user_key
	,d.vtc_5_user_key
	,d.vtc_6_user_key
	,d.vtc_7_user_key
	,d.vtc_8_user_key
	,ul.active_flag
from dbo.user_list ul
inner join dbo.[user] u 
	on ul.user_key = u.user_key
left join dbo.hpr_dept d
	on ul.hpr_dept_key = d.hpr_dept_key	
where ul.active_flag = 'Y'
go


if object_id('dbo.User_List_Volunteer_v', 'V') is not null
	drop view dbo.User_List_Volunteer_v
go 
create view dbo.User_List_Volunteer_v
as
select 
	 u.user_list_volunteer_key 		
	,u.user_list_key 					
	,u.volunteer_key 					
	,u.sort_order 						
	,u.user_list_volunteer_status_key	
	,u.status_date 					
	,u.notes 							
	,u.last_changed_user_key 			
	,u.start_date	 					
	,u.end_date 						
	,u.active_flag 					
	,u.load_date 						
	,u.update_date 
from dbo.user_list ul
inner join dbo.user_list_volunteer u
	on ul.user_list_key = u.user_list_key
where ul.active_flag = 'Y'
	and u.active_flag = 'Y'
go


if object_id('dbo.User_Task_v', 'V') is not null
	drop view dbo.User_Task_v
go 
create view dbo.User_Task_v
as
select ut.user_task_key
      ,ut.user_key
	  ,u.last_name + ', ' + u.first_name as user_nm
      ,ut.user_2_key
	  ,u2.last_name + ', ' + u2.first_name as user_2_nm
      ,ut.user_3_key
	  ,u3.last_name + ', ' + u3.first_name as user_3_nm
      ,ut.user_task
      ,ut.start_date
      ,ut.due_date
      ,ut.notes
      ,ut.user_task_status_key
	  ,uts.User_Task_Status
      ,ut.load_date
      ,ut.update_date
      ,ut.volunteer_key
      ,ut.person_name
      ,ut.priority_key
from dbo.user_task ut --531
inner join dbo.User_Task_Status uts
	on ut.User_Task_Status_Key = uts.User_Task_Status_Key
inner join dbo.[User] u
	on ut.user_key = u.user_key
left outer join dbo.[User] u2
	on ut.user_2_key = u.user_key
left outer join dbo.[User] u3
	on ut.user_3_key = u.user_key
go


if object_id('dbo.Volunteer_App_v', 'V') is not null
	drop view dbo.Volunteer_App_v
go 
create view dbo.Volunteer_App_v
as
select 
	 v.full_name
	,va.volunteer_app_key
	,va.volunteer_key
	,va.app_type_key
	,typ.app_type_code
	,va.app_status_key
	,sts.app_status_code
	,va.app_date
	,va.expiration_date
	,va.status_notes
	,va.app_notes
	,coalesce( status_notes, '' ) + coalesce( app_notes, '' ) as full_notes
	,va.review_status_submitted_date
	,va.review_stage_elders_date
	,va.review_stage_co_date
	,case
		when App_Status_Code in ( 'NEW', 'PND' ) and App_Type_Code = 'A-8' and Review_Status_Submitted_Date is null then 'Vol'
		when App_Status_Code in ( 'NEW', 'PND' ) and App_Type_Code = 'A-8' and Review_Stage_Elders_Date is null then 'Eld'
		when App_Status_Code in ( 'NEW', 'PND' ) and App_Type_Code = 'A-8' and Review_Stage_CO_Date is null then 'CO'
		when App_Status_Code in ( 'NEW', 'PND' ) and App_Type_Code in ( 'DC-50', 'A-19' ) and Review_Status_Submitted_Date is null then 'Vol'
		when App_Status_Code in ( 'NEW', 'PND' ) and App_Type_Code in ( 'DC-50', 'A-19' ) and Review_Stage_Elders_Date is null then 'Eld'
		else null
	 end as review_stage_holder
	,va.attrib_approval_level_app_attrib_id
	,va.attrib_approval_level_attrib_id
	,va.attrib_approval_level_val
	,va.attrib_pursued_by_app_attrib_id
	,va.attrib_pursued_by_attrib_id
	,va.attrib_pursued_by_val
	,va.attrib_contacted_app_attrib_id
	,va.attrib_contacted_attrib_id
	,va.attrib_contacted_val
	,va.attrib_ske_app_attrib_id
	,va.attrib_ske_attrib_id
	,va.attrib_ske_val
	,va.attrib_other_app_attrib_id
	,va.attrib_other_attrib_id
	,va.attrib_other_val
	,va.applicant_id
	,va.expired_flag
	,va.active_flag
	,va.load_date
	,va.update_date
from dbo.volunteer v
inner join dbo.volunteer_app va
	on v.volunteer_key = va.volunteer_key
inner join dbo.app_type typ
	on va.app_type_key = typ.app_type_key
inner join dbo.app_status sts
	on va.app_status_key = sts.app_status_key
go


if object_id('dbo.Volunteer_Approval_Level_v', 'V') is not null
	drop view dbo.Volunteer_Approval_Level_v
go 
create view dbo.Volunteer_Approval_Level_v
as
select 
	 volunteer_key
	,case
		when seq_num = 1 then 'OK - All'
		when seq_num = 2 then 'OK - BCS'
		when seq_num = 3 then 'OK - BCS Exception'
		when seq_num = 4 then 'OK - BCV All'
		when seq_num = 5 then 'OK - Commute'
		when seq_num = 6 then 'OK - Short-Term'
		when seq_num = 7 then 'OK - BBO Limited'
		when seq_num = 8 then 'OK - Remote'
		when seq_num = 9 then 'OK - BCV Exception'
		else 'Unknown'
	 end as approval_level
	,seq_num
from (
	select 
		 va.volunteer_Key
		,min( case 
			when typ.App_Type_Code = 'A-8' and va.Attrib_Approval_Level_Val = 'OK - All' then 1
			when typ.App_Type_Code = 'A-8' and sts.app_status_code = 'APP' and coalesce( va.attrib_approval_level_val, '' ) = '' and 
				cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) < 36 then 1
			when typ.App_Type_Code = 'A-8' and va.Attrib_Approval_Level_Val = 'OK - BCS' then 2
			when typ.App_Type_Code = 'A-8' and sts.app_status_code = 'APP' and coalesce( va.attrib_approval_level_val, '' ) = '' and 
				cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) > 36 then 2
			when typ.App_Type_Code = 'A-8' and va.Attrib_Approval_Level_Val = 'OK - Exception' then 3
			when typ.App_Type_Code = 'A-19' and va.Attrib_Approval_Level_Val = 'OK - All' then 4
			when typ.App_Type_Code = 'A-19' and sts.app_status_code = 'APP' and coalesce( va.attrib_approval_level_val, '' ) = '' then 4
			when typ.App_Type_Code = 'A-19' and va.Attrib_Approval_Level_Val = 'OK - Commute' then 5
			when typ.App_Type_Code = 'A-19' and va.Attrib_Approval_Level_Val = 'OK - Short-Term' then 6
			when typ.App_Type_Code = 'A-19' and va.Attrib_Approval_Level_Val = 'OK - BBO Limited' then 7
			when typ.App_Type_Code = 'A-19' and va.Attrib_Approval_Level_Val = 'OK - Remote' then 8
			when typ.App_Type_Code = 'A-19' and va.Attrib_Approval_Level_Val = 'OK - Exception' then 9
			else 99
		 end ) as seq_num
	from dbo.Volunteer_App va
	inner join dbo.volunteer v
		on va.volunteer_key = v.volunteer_key
	inner join dbo.App_Type typ
		on va.App_type_Key = typ.App_type_Key
		and typ.active_flag = 'Y'
	inner join dbo.App_Status sts
		on va.app_status_key = sts.app_status_key
		and sts.active_flag = 'Y'
	where va.active_flag = 'Y'
	group by va.volunteer_key ) core
go	


if object_id('dbo.Volunteer_Availability_v', 'V') is not null
	drop view dbo.Volunteer_Availability_v
go 
create view dbo.Volunteer_Availability_v
as
select 
	 volunteer_availability_key
	,volunteer_key
	,avail_as_consultant_flag			
	,avail_as_commuter_flag 				
	,avail_as_commuter_as_needed_flag	
	,avail_as_commuter_closest_site 	
	,avail_as_commuter_days_per_wk 	
	,avail_as_commuter_weekly_flag	
	,avail_as_commuter_notes 		
	,avail_as_commuter_mon_am_flag	
	,avail_as_commuter_mon_pm_flag	
	,avail_as_commuter_tue_am_flag	
	,avail_as_commuter_tue_pm_flag	
	,avail_as_commuter_wed_am_flag	
	,avail_as_commuter_wed_pm_flag	
	,avail_as_commuter_thu_am_flag	
	,avail_as_commuter_thu_pm_flag	
	,avail_as_commuter_fri_am_flag	
	,avail_as_commuter_fri_pm_flag	
	,avail_as_commuter_sat_am_flag	
	,avail_as_commuter_sat_pm_flag	
	,avail_as_commuter_sun_am_flag	
	,avail_as_commuter_sun_pm_flag	
	,avail_as_remote_vol_flag		
	,avail_as_remote_vol_days_per_wk 	
	,avail_as_remote_vol_notes 		
	,avail_as_vol_flag 				
	,avail_as_vol_anytime_flag		
	,avail_as_vol_start_date 		
	,avail_as_vol_end_date 			
	,avail_as_vol_date_notes 		
	,avail_as_vol_date_short_term_days 	
	,avail_as_vol_long_term_flag 	
	,avail_as_vol_notes				
	,active_flag
	,load_date
	,update_date
	,last_update_date
from dbo.volunteer_availability
where active_flag = 'Y'
go


if object_id('dbo.Volunteer_Contact_Hist_Curr_v', 'V') is not null
	drop view dbo.Volunteer_Contact_Hist_Curr_v
go 
create view dbo.Volunteer_Contact_Hist_Curr_v
as
select
	 volunteer_contact_hist_key 	
	,volunteer_key 				
	,vtc_name					
	,contact_date				
	,contact_type				
	,contact_purpose				
	,contact_pending				
	,contact_notes				
	,contact_url					
	,attribute_value				
	,active_flag 				
	,load_date 					
	,update_date 	
from dbo.volunteer_contact_hist
where active_flag = 'Y'
go


if object_id('dbo.Volunteer_DC50_v', 'V') is not null
	drop view dbo.Volunteer_DC50_v
go 
create view dbo.Volunteer_DC50_v
as
select
 	 va.volunteer_app_key
	,va.volunteer_key
	,va.app_type_key
	,at.app_type_code
	,at.app_type_name
	,va.app_status_key
	,sts.app_status_code
	,sts.app_status
	,sts.active_flag
	,va.app_date
from dbo.volunteer_app va
inner join dbo.app_type at
	on va.app_type_key = at.app_type_key 
inner join dbo.app_status sts 
	on va.app_status_key = sts.app_status_key
where at.app_type_key = 7
	and va.app_date in ( select max( app_date ) from dbo.volunteer_app va2 where va2.volunteer_key = va.volunteer_key and va2.app_type_key = 7 )
go


if object_id('dbo.Volunteer_Dept_v', 'V') is not null
	drop view dbo.Volunteer_Dept_v
go 
create view dbo.Volunteer_Dept_v
as
select 
	 vd.volunteer_dept_key
    ,vd.volunteer_key
    ,vd.person_id
    ,v.full_name
	,case 
		when vd.enrollment_code in ( 'BAS', 'BCS', 'BCV', 'BSS' ) and site_code is null then 'Field'
		else vd.site_code
	 end as site_code
	,vd.site_code as site_code_orig
	,vd.parent_dept_name
	,vd.dept_name
	,vd.temp_flag
	,vd.primary_flag
	,vd.split_allocation_pct
	,vd.enrollment_code
	,vd.start_date
	,vd.end_date
	,vd.notes
	,vd.active_flag
	,vd.load_date
	,vd.update_date
	,vd.dept_role
	,vd.mon_am_flag
	,vd.mon_pm_flag
	,vd.tue_am_flag
	,vd.tue_pm_flag
	,vd.wed_am_flag
	,vd.wed_pm_flag
	,vd.thu_am_flag
	,vd.thu_pm_flag
	,vd.fri_am_flag
	,vd.fri_pm_flag
	,vd.sat_am_flag
	,vd.sat_pm_flag
	,vd.sun_am_flag
	,vd.sun_pm_flag
	,vd.wrk_crew
	,vd.wrk_role
	,vd.wrk_priv
  from dbo.volunteer_dept vd
  inner join dbo.volunteer v
  	on vd.volunteer_key = v.volunteer_key
go


if object_id('dbo.Volunteer_Dept_Orphaned_Records_v', 'V') is not null
	drop view dbo.Volunteer_Dept_Orphaned_Records_v
go 
create view dbo.Volunteer_Dept_Orphaned_Records_v
as
with rvd as (
	select full_name, dept_name, start_date, person_id, notes, temp_flag, primary_flag, site_code, volunteer_dept_key
	from dbo.Volunteer_Dept_v
	where active_flag = 'Y' ),

hub as (
	select person_id, department_name, start_date
	from stg.stg_Person_Dept_History
	where end_date is null or cast( end_date as date ) >= cast( getdate() as date ) )

select rvd.full_name, rvd.dept_name, rvd.start_date, rvd.person_id, notes, temp_flag, primary_flag, volunteer_dept_key 
from rvd
left join hub 
	on rvd.person_id = hub.person_id
	and rvd.Dept_Name = hub.Department_Name
	and rvd.Start_Date = hub.Start_Date
where hub.person_id is null
go


if object_id('dbo.Volunteer_Enrollment_v', 'V') is not null
	drop view dbo.Volunteer_Enrollment_v
go 
create view dbo.Volunteer_Enrollment_v
as
select
	 v.volunteer_key
	,v.full_name
	,e.enrollment_key
	,e.enrollment_code
	,e.rank_num
	,case 
		when e.enrollment_code in ( 'BAS', 'BCS', 'BCV', 'BSS' ) and site_code is null then 'Field'
		else ve.site_code
	 end as site_code
	,ve.site_code as site_code_orig	 
	,ve.notes
	,ve.applicant_id
	,v.hub_person_id
	,ve.start_date
	,ve.end_date
	,ve.active_flag
	,ve.volunteer_enrollment_key
from dbo.volunteer v 
inner join dbo.volunteer_enrollment ve
	on v.volunteer_key = ve.volunteer_key 
inner join dbo.enrollment e 
	on ve.enrollment_key = e.enrollment_key
go


if object_id('dbo.Volunteer_Enrollment_Orphaned_Records_v', 'V') is not null
	drop view dbo.Volunteer_Enrollment_Orphaned_Records_v
go 
create view dbo.Volunteer_Enrollment_Orphaned_Records_v
as
with rvd as (
	select full_name, enrollment_code, start_date, hub_person_id as person_id, site_code, volunteer_enrollment_key
	from dbo.Volunteer_enrollment_v
	where active_flag = 'Y' ),

hub as (
	select person_id, enrollment_code, start_date
	from stg.stg_Person_enrollment
	where end_date is null or cast( end_date as date ) >= cast( getdate() as date ) )

select rvd.full_name, rvd.enrollment_code, rvd.start_date, rvd.person_id, volunteer_enrollment_key 
from rvd
left join hub 
	on rvd.person_id = hub.person_id
	and rvd.enrollment_code = hub.enrollment_code
	and rvd.Start_Date = cast( hub.Start_Date as date )
where hub.person_id is null
	and rvd.enrollment_code not in ( 'HPR', 'BA' )
go
	

if object_id('dbo.Volunteer_Enrollment_Schools_v', 'V') is not null
	drop view dbo.Volunteer_Enrollment_Schools_v
go 
create view dbo.Volunteer_Enrollment_Schools_v
as
select distinct 
	 v.volunteer_key
	,v.full_name
	,e.enrollment_code
	,ve.start_date
	,ve.end_date
from dbo.volunteer v 
inner join dbo.volunteer_enrollment ve
	on v.volunteer_key = ve.volunteer_key 
inner join dbo.enrollment e 
	on ve.enrollment_key = e.enrollment_key
where e.enrollment_code in ( 'SKE', 'FGC', 'FGM' )
	and ve.start_date in ( select max( ve2.start_date ) 
						   from dbo.volunteer_enrollment ve2 
						   inner join dbo.enrollment e2 
							   on ve2.enrollment_key = e2.enrollment_key 
						   where ve2.volunteer_key = v.volunteer_key and e2.enrollment_code in ( 'SKE', 'FGC', 'FGM' ) )
go


if object_id('dbo.Volunteer_Event_Data_v', 'V') is not null
	drop view dbo.Volunteer_Event_Data_v
go 
create view dbo.Volunteer_Event_Data_v
as
select 
	 ve.volunteer_key
	,ve.event_key
	,case 
		when ea.event_attribute_group = 'Personal' then ' Personal'
		when ea.event_attribute_group = 'Secular' then ' Secular'
		else ea.event_attribute_group
	 end as event_attribute_group
	,ea.event_attribute
	,ved.event_data
	,ea.column_number
	,ea.event_attribute_key
	,e.event_system_key
	,ea.to_profile_active_flag
from dbo.volunteer_event ve 
inner join dbo.event e 
	on ve.event_key = e.event_key
inner join dbo.event_attribute ea
	on e.event_key = ea.event_key 
inner join dbo.volunteer_event_data ved
	on ve.volunteer_event_key = ved.volunteer_event_key	
	and ea.event_attribute_key = ved.event_attribute_key
where e.event_system_key = 1
	and ea.active_flag = 'Y'
go


if object_id('dbo.Volunteer_Export_v', 'V') is not null
	drop view dbo.Volunteer_Export_v
go 
create view dbo.Volunteer_Export_v
as
select 
	 v.volunteer_key
	,v.full_name
	,v.last_name
	,v.first_name
	,v.middle_name
	,v.preferred_name
	,v.address
	,v.address2
	,v.city
	,pc.postal_code
	,c.country_code
	,mate.full_name as spouse_name
	,pc.local_flag
	,pc.driving_distance_flag
	,v.home_phone
	,v.mobile_phone
	,v.email
	,v.alt_email
	,v.birth_date
	,v.baptism_date
	,v.gender_code
	,ms.marital_status_code
	,v.pioneer_flag
	,v.cong_servant_code
	,v.vol_desk_user_key	
	,v.current_enrollment_key	
	,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
	,cast( round( ( datediff( day, v.baptism_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as yrs_bap	
	,v.trade_contact_group_key
	,case 
		when coalesce( v.vol_desk_user_key, 1 ) = 1 then 'Not Assigned' 
		else u.last_Name + ', ' + u.first_name 
	 end as assigned_to
	,case
		when len( cast( v.ba_volunteer_num as varchar(10) ) ) = 7
			then '0' + cast( v.ba_volunteer_num as varchar(10) )
		else cast( v.ba_volunteer_num as varchar(10) )
	 end as ba_vol_num
	,v.hub_volunteer_num	 
	,cast( v.hub_person_id as varchar(9) ) as hub_person_id
	,v.jw_username
	,ts.tracking_status
	,v.tracking_status_date
	,v.tcg_contact
	,v.tcg_contact_notes
	,v.vol_desk_notes
	,v.trade_ovsr_notes
	,cast( cong.cong_number as varchar(10) ) as cong_num
	,cong.cong
	,v.cong_key
	,v.cong_relocation_date
	,v.load_date
	,v.update_date
	,v.a8_approved_flag
	,a8.app_status_code as a8_app_status
	,v.a19_approved_flag
	,a19.app_status_code as a19_app_status
	,e.enrollment_code as current_enrollment_code	
from dbo.volunteer v
inner join dbo.[user] u
	on v.vol_desk_user_key = u.user_key
inner join dbo.postal_code pc
	on v.postal_code_key = pc.postal_code_key
inner join dbo.marital_status ms
	on v.marital_status_key = ms.marital_status_key
inner join dbo.country c
	on v.country_key = c.country_key
inner join dbo.tracking_status ts
	on v.tracking_status_key = ts.tracking_status_key
inner join dbo.cong 
	on v.cong_key = cong.cong_key
left join dbo.volunteer mate
	on v.mate_hub_person_id = mate.hub_person_id
left join dbo.app_status a8
	on v.a8_app_status_key = a8.app_status_key
left join dbo.app_status a19
	on v.a19_app_status_key = a19.app_status_key
left join dbo.enrollment e
	on v.current_enrollment_key = e.enrollment_key	
go


if object_id('dbo.Volunteer_FTS_v', 'V') is not null
	drop view dbo.Volunteer_FTS_v
go 
create view dbo.Volunteer_FTS_v
as
select 
	 volunteer_key
	,round( sum( fts_days ) / 365.25, 1 ) as fts
	,round( sum( sfts_days ) / 365.25, 1 ) as sfts
	,cast( round( sum( fts_days ) / 365.25, 0 ) as integer ) as rounded_fts
	,cast( round( sum( sfts_days ) / 365.25, 0 ) as integer ) as rounded_sfts
from 
	( select
		 volunteer_key
		,enrollment_code
		,start_date
		,end_date
		,datediff( day, start_date, end_date ) as enrl_days
		,case when fts_flag = 'Y' then datediff( day, start_date, end_date ) else 0 end as fts_days
		,case when sfts_flag = 'Y' then datediff( day, start_date, end_date ) else 0 end as sfts_days
	  from 
		( select 
			 ve.volunteer_key
			,e.enrollment_code
			,ve.start_date
			,coalesce( ve.end_date, cast( getdate() as date ) ) as end_date
			,e.fts_flag
			,e.sfts_flag
		  from dbo.volunteer_enrollment ve
		  inner join dbo.enrollment e
			on ve.enrollment_key = e.enrollment_key
		  where e.fts_flag = 'Y' or e.sfts_flag = 'Y' ) x
	) xx
group by volunteer_key
go


if object_id('dbo.Volunteer_Pursuit_Hist_v', 'V') is not null
	drop view dbo.Volunteer_Pursuit_Hist_v
go 
create view dbo.Volunteer_Pursuit_Hist_v
as
select 
	ph.volunteer_pursuit_hist_key, 	
	ph.volunteer_key,
	ph.vtc_name,	
	v.Full_Name,
	ph.hpr_dept_key,
	ph.start_date,	
	ph.target_date,
	ph.role_name,	
	ph.role_desc,	
	ph.attribute_value,
	ph.requested_flag,
	ph.volunteer_pursuit_cancel_reason_key,
	ph.request_cancel_reason,
	ph.active_flag, 
	ph.load_date, 	
	ph.update_date
from dbo.Volunteer_Pursuit_Hist ph
inner join dbo.volunteer v
	on ph.volunteer_key = v.volunteer_key
go


if object_id('dbo.Volunteer_Pursuit_Hist_Curr_v', 'V') is not null
	drop view dbo.Volunteer_Pursuit_Hist_Curr_v
go 
create view dbo.Volunteer_Pursuit_Hist_Curr_v
as
select 
	volunteer_pursuit_hist_key, 	
	volunteer_key,
	vtc_name,	
	hpr_dept_key,
	start_date,	
	target_date,
	role_name,	
	role_desc,	
	attribute_value,
	requested_flag,
	volunteer_pursuit_cancel_reason_key,
	request_cancel_reason,
	active_flag, 
	load_date, 	
	update_date
from dbo.Volunteer_Pursuit_Hist
where active_flag = 'Y'
go


if object_id('dbo.Volunteer_Search_Skills_v', 'V') is not null
	drop view dbo.Volunteer_Search_Skills_v
go 
create view dbo.Volunteer_Search_Skills_v
as
select 
	 vs.volunteer_key
	,s.skill_key
	,vs.skill_speciality_key
	,vs.skill_level_key
	,sl.skill_level_code
from dbo.skill s
inner join dbo.skill_speciality ss
	on s.skill_key = ss.skill_key
inner join dbo.volunteer_skill vs
	on ss.skill_speciality_key = vs.skill_speciality_key
inner join dbo.skill_level sl 
	on vs.skill_level_key = sl.skill_level_key
go


if object_id('dbo.Volunteer_Search_v', 'V') is not null
	drop view dbo.Volunteer_Search_v
go 
create view dbo.Volunteer_Search_v
as
select 
	 v.volunteer_key
	,v.full_name
	,v.first_name
	,v.last_name
	,v.address
	,v.address2
	,v.city
	,s.state_code
	,pc.postal_code
	,pc.hpr_flag
	,pc.pat_flag
	,pc.local_flag
	,pc.driving_distance_flag
	,v.cong_key
	,v.gender_code
	,ms.marital_status_code
	,v.home_phone
	,v.mobile_phone
	,v.pioneer_flag
	,v.a8_approved_flag
	,v.current_enrollment_key
	,e.enrollment_code as current_enrollment_code
	,a8.app_status_code as a8_app_status
	,v.a19_approved_flag
	,a19.app_status_code as a19_app_status
	,v.cong_servant_code
	,v.cong_relocation_date
	,v.vol_desk_user_key
	,case 
		when coalesce( v.vol_desk_user_key, 1 ) = 1 then 'Not Assigned' 
		else u.last_Name + ', ' + u.first_name 
	 end as vol_desk_user
	,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
	,v.avail_short_notice_flag
	,v.avail_times_yr
	,v.tracking_status_key
	,ts.tracking_status
	,v.tracking_status_date
	,v.ba_volunteer_num
	,v.ba_volunteer_id
	,v.hub_volunteer_num
	,v.trade_contact_group_key
	,v.tcg_contact_date
	,v.email
	,v.hub_tracking_flag
	,case 
		when v.ba_safety_orientation_date is not null and tmp.last_temp_asgn_date is null then dateadd( year, 1, v.ba_safety_orientation_date )
		when v.ba_safety_orientation_date is null and tmp.last_temp_asgn_date is not null then dateadd( year, 1, tmp.last_temp_asgn_date )
		when v.ba_safety_orientation_date > tmp.last_temp_asgn_date then dateadd( year, 1, v.ba_safety_orientation_date )
		else dateadd( year, 1, tmp.last_temp_asgn_date )
	 end as safety_orientation_exp_date		
from dbo.volunteer v
inner join dbo.marital_status ms
	on v.marital_status_key = ms.marital_status_key
inner join dbo.[user] u
	 on u.user_key = v.vol_desk_user_key
inner join dbo.postal_code pc
	on v.postal_code_key = pc.postal_code_key
inner join dbo.state s
	on v.state_key = s.state_key
inner join dbo.tracking_status ts
	on v.tracking_status_key = ts.tracking_status_key
left join dbo.enrollment e
	on v.current_enrollment_key = e.enrollment_key
left join dbo.app_status a8
	on v.a8_app_status_key = a8.app_status_key
left join dbo.app_status a19
	on v.a19_app_status_key = a19.app_status_key
left outer join
	( select v.volunteer_key, max( v.end_date ) as last_temp_asgn_date
	  from dbo.volunteer_enrollment v inner join dbo.enrollment e on v.Enrollment_Key = e.Enrollment_Key
	  where e.Enrollment_Code in ( 'BBC', 'BCV', 'BCS' ) and v.site_code is not null group by v.volunteer_key ) tmp
	on v.volunteer_key = tmp.volunteer_key		
go


if object_id('dbo.Volunteer_Skills_v', 'V') is not null
	drop view dbo.Volunteer_Skills_v
go 
create view dbo.Volunteer_Skills_v
as
select 
	 vs.volunteer_key
	,v.full_name as volunteer_name
	,s.skill_key
	,s.skill
	,ss.skill_speciality_key
	,ss.skill_subskill
	,ss.skill_speciality
	,vs.skill_description
	,vs.yrs_exp
	,case 
		when coalesce( abs( vs.yrs_exp ), 0 ) between 0 and 1 then '0-1'
		when vs.yrs_exp >1 and vs.yrs_exp <=5 then '1-5'
		when vs.yrs_exp >5 and vs.yrs_exp <=10 then '5-10'
		when vs.yrs_exp >10 and vs.yrs_exp <=15 then '10-15'
		when vs.yrs_exp >15 then '15+'
		else 'Undefined'
	 end as yrs_exp_range
	,sl.skill_level_key
	,sl.skill_level_code
	,sl.skill_level
	,bsl.skill_level_key as ba_ovsr_skill_level_key
	,bsl.skill_level_code as ba_ovsr_skill_level_code
	,bsl.skill_level as ba_ovsr_skill_level
	,src.source_system_key
	,src.source_system_code
	,src.source_system
	,vs.personal_notes
	,vs.office_notes
	,vs.ovsr_assessment_name
	,vs.ovsr_assessment_notes
	,vs.ovsr_assessment_date	
	,case 
		when src.source_system_code = 'BRCH' then sl.skill_level_key
		when bsl.skill_level_key <> 7 then bsl.skill_level_key
		else sl.skill_level_key
	 end as master_skill_level_key
	,case 
		when src.source_system_code = 'BRCH' then sl.skill_level_code
		when bsl.skill_level_key <> 7 then bsl.skill_level_code
		else sl.skill_level_code
	 end as master_skill_level_code
	,case 
		when src.source_system_code = 'BRCH' then sl.skill_level
		when bsl.skill_level_key <> 7 then bsl.skill_level
		else sl.skill_level
	 end as master_skill_level
	,case 
		when src.source_system_code = 'BRCH' then src.source_system_key
		when bsl.skill_level_key <> 7 then 4
		else src.source_system_key
	 end as master_source_system_key
	,case 
		when src.source_system_code = 'BRCH' then src.source_system_code
		when bsl.skill_level_key <> 7 then 'BA'
		else src.source_system_code
	 end as master_source_system_code
	,case 
		when src.source_system_code = 'BRCH' then src.source_system
		when bsl.skill_level_key <> 7 then 'BA'
		else src.source_system
	 end as master_source_system
	,vs.skill_update_date	 
from dbo.skill s
inner join dbo.skill_speciality ss
	on s.skill_key = ss.skill_key
inner join dbo.volunteer_skill vs
	on ss.skill_speciality_key = vs.skill_speciality_key
inner join dbo.skill_level sl 
	on vs.skill_level_key = sl.skill_level_key
inner join dbo.skill_level bsl 
	on coalesce( vs.ovsr_assessment_skill_level_key, 7 ) = bsl.skill_level_key	
inner join dbo.source_system src
	on vs.source_system_key = src.source_system_key
inner join dbo.volunteer v
	on vs.Volunteer_Key = v.Volunteer_Key	
where ss.active_flag = 'Y'
	and s.active_flag = 'Y'
	--and sl.active_flag = 'Y'
	and src.active_flag = 'Y'
go


if object_id('dbo.Volunteer_v', 'V') is not null
	drop view dbo.Volunteer_v
go 
create view dbo.Volunteer_v
as
select 
	 v.volunteer_key
	,v.full_name
	,v.last_name
	,v.first_name
	,v.middle_name
	,v.preferred_name
	,v.address
	,v.address2
	,v.city
	,v.state_key
	,s.state_code
	,v.postal_code_key
	,pc.postal_code
	,c.country_code
	,v.address + ' ' + v.city + ', ' + s.state_code + ' ' + pc.postal_code as full_addr
	,pc.hpr_flag
	,pc.local_flag as local_vol_flag
	,pc.driving_distance_flag
	,v.home_phone
	,v.mobile_phone
	,v.whatsapp_flag
	,v.sms_flag
	,v.email
	,v.alt_email
	,v.birth_date
	,v.baptism_date
	,v.gender_code
	,ms.marital_status_code
	,ms.marital_status
	,v.pioneer_flag
	,v.cong_servant_code
	,case
		when v.cong_servant_code = 'E' then 'Elder'
		when v.cong_servant_code = 'MS' then 'Ministerial Servant'
		else '-'
	 end as cong_servant
	,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
	,cast( round( ( datediff( day, v.baptism_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as yrs_bap	
	,case 
		when coalesce( v.vol_desk_user_key, 1 ) = 1 then 'Not Assigned' 
		else u.last_Name + ', ' + u.first_name 
	 end as assigned_to
	,cast( v.ba_volunteer_num as varchar(10) ) as ba_volunteer_num
	,v.ba_volunteer_id
	,v.ba_safety_orientation_date
	,tmp.last_temp_asgn_date
	,case 
		when v.ba_safety_orientation_date is not null and tmp.last_temp_asgn_date is null then dateadd( year, 1, v.ba_safety_orientation_date )
		when v.ba_safety_orientation_date is null and tmp.last_temp_asgn_date is not null then dateadd( year, 1, tmp.last_temp_asgn_date )
		when v.ba_safety_orientation_date > tmp.last_temp_asgn_date then dateadd( year, 1, v.ba_safety_orientation_date )
		else dateadd( year, 1, tmp.last_temp_asgn_date )
	 end as safety_orientation_exp_date	
	,v.hub_person_id
	,v.hub_volunteer_num	
	,v.hub_volunteer_id
	,v.hub_tracking_flag
	,v.jw_username
	,v.avail_short_notice_flag
	,v.avail_times_yr
	,v.tracking_status_key
	,ts.tracking_status
	,v.tracking_status_date
	,v.tcg_contact
	,v.tcg_contact_notes
	,v.vol_desk_notes
	,v.trade_ovsr_notes
	,cong.cong_key
	,cong.cong_number
	,cast( cong.cong_number as varchar(10) ) as cong_number_str
	,cong.cong_fullname as cong_name
	,v.cong_relocation_date
	,cong.circuit
	,v.a8_approved_flag
	,v.a8_app_status_key
	,v.a19_approved_flag
	,v.a19_app_status_key
	,v.app_request_collection_flag
	,v.hpr_volunteer_exception_flag
	,v.staffing_number_exception_flag	
	,v.person_key_roles_flag
	,v.App_Pursued_By_Value	
 	,dc50.App_Status_Code AS DC_50_App_Status
 	,al.approval_level
	,v.current_enrollment_key
	,e.Enrollment_code as current_enrollment_code
	,e.Enrollment as current_enrollment
	,v.tentative_end_date
	,v.rvd_banner
	,ve.Enrollment_Code AS school_enrollment
	,mate.full_name as spouse_name
	,mate.HUB_Volunteer_Num AS spouse_hub_vol_num
 	,mate.HUB_Person_ID AS spouse_hub_person_id	
	,v.load_date
	,v.update_date
from dbo.volunteer v
inner join dbo.state s
	on v.state_key = s.state_key
inner join dbo.postal_code pc
	on v.postal_code_key = pc.postal_code_key
inner join dbo.[user] u 
	on v.vol_desk_user_key = u.user_key
inner join dbo.marital_status ms 
	on v.marital_status_key = ms.marital_status_key
inner join dbo.cong
	on v.cong_key = cong.cong_key
left join dbo.Enrollment e
	on v.current_enrollment_key = e.Enrollment_Key	
inner join dbo.tracking_status ts
	on v.tracking_status_key = ts.tracking_status_key
inner join dbo.country c
	on v.country_key = c.country_key
left outer join dbo.Volunteer_Enrollment_Schools_v ve 
	on v.volunteer_key = ve.volunteer_key 	
left outer join
	( select v.volunteer_key, max( v.end_date ) as last_temp_asgn_date
	  from dbo.volunteer_enrollment v inner join dbo.enrollment e on v.Enrollment_Key = e.Enrollment_Key
	  where e.Enrollment_Code in ( 'BBC', 'BCV', 'BCS' ) and v.site_code is not null group by v.volunteer_key ) tmp
	on v.volunteer_key = tmp.volunteer_key	
left outer join dbo.volunteer_dc50_v dc50 
	on v.volunteer_key = dc50.volunteer_key	
left join dbo.volunteer mate
	on v.mate_hub_person_id = mate.hub_person_id
left join dbo.volunteer_approval_level_v al
	on v.volunteer_key = al.volunteer_key
go




/*  DYNAMIC VIEWS  */
select 'D. Soto' as ovsr, 165914 as person_id, 'DSoto@bethel.jw.org' as email 
	union all
	select 'G. Stradowski' as ovsr, 58599 as person_id, 'GSTRADOW@bethel.jw.org' as email 
	union all
	select 'K. Cady' as ovsr, 49403 as person_id, 'KCADY@bethel.jw.org' as email 
	union all
	select 'M. Mordecki' as ovsr, 398886 as person_id, 'MJMORDEC@bethel.jw.org' as email 
	union all
	select 'R. McRedmond' as ovsr, 617508 as person_id, 'rmcredmond@bethel.jw.org' as email 	
	union all
	select 'B. O''Bleness' as ovsr, 40217 as person_id, 'BKOBlene@bethel.jw.org' as email 	
	union all
	select 'C. Haynes' as ovsr, 90427 as person_id, 'CHAYNES@bethel.jw.org' as email 	
	union all
	select 'D. Dietrich' as ovsr, 526053 as person_id, 'DLDIETRI@bethel.jw.org' as email 	
	union all
	select 'D. Snyder' as ovsr, 30632 as person_id, 'DSNYDER@bethel.jw.org' as email 	
	union all
	select 'D. Willis' as ovsr, 876578 as person_id, 'DWILLIS@bethel.jw.org' as email 	
	union all
	select 'E. Hedefine' as ovsr, 49887 as person_id, 'EHEDEFIN@bethel.jw.org' as email 	
	union all
	select 'E. Weber' as ovsr, 41854 as person_id, 'ERWEBER@bethel.jw.org' as email 	
	union all
	select 'J. Estes' as ovsr, 444364 as person_id, 'JESTES@bethel.jw.org' as email 	
	union all
	select 'J. Jacks' as ovsr, 44402 as person_id, 'JJacks@bethel.jw.org' as email 	
	union all
	select 'J. Levan' as ovsr, 155837 as person_id, 'JLEVAN@bethel.jw.org' as email 	
	union all
	select 'J. Nichols' as ovsr, 456193 as person_id, 'JNICHOLS@bethel.jw.org' as email 	
	union all
	select 'J. Niemann' as ovsr, 28863 as person_id, 'JNiemann@bethel.jw.org' as email 	
	union all
	select 'J. White' as ovsr, 339343 as person_id, 'JWHITE@bethel.jw.org' as email 	
	union all
	select 'K. Mueller' as ovsr, 380131 as person_id, 'KMUELLER@bethel.jw.org' as email 	
	union all
	select 'M. Calloway' as ovsr, 348730 as person_id, 'MCALLOWAY@bethel.jw.org' as email 	
	union all
	select 'M. Hainstock' as ovsr, 785819 as person_id, 'MHainstock@bethel.jw.org' as email 	
	union all
	select 'M. Tidei' as ovsr, 808950 as person_id, 'MTIDEI@bethel.jw.org' as email 	
	union all
	select 'M. Wilcox' as ovsr, 28334 as person_id, 'MWILCOX@bethel.jw.org' as email 	
	union all
	select 'N. Tartaglia' as ovsr, 46429 as person_id, 'NWTartag@bethel.jw.org' as email 	
	union all
	select 'N. Thomas' as ovsr, 36184 as person_id, 'NAWTHOMAS@bethel.jw.org' as email 	
	union all
	select 'P. Cain' as ovsr, 185459 as person_id, 'PACAIN@bethel.jw.org' as email 	
	union all
	select 'R. Harbo' as ovsr, 109345 as person_id, 'RRHARBO@bethel.jw.org' as email 	
	union all
	select 'R. Leithiser' as ovsr, 408350 as person_id, 'RTLEITHI@bethel.jw.org' as email 	
	union all
	select 'R. Seydlitz' as ovsr, 29612 as person_id, 'rseydlit@bethel.jw.org' as email 	
	union all
	select 'S. Burckholter' as ovsr, 39753 as person_id, 'SBURCKHOLTER@bethel.jw.org' as email 	
	union all
	select 'T. Coriell' as ovsr, 52181 as person_id, 'TCORIELL@bethel.jw.org' as email 	
	union all
	select 'T. Stockwell' as ovsr, 43248 as person_id, 'TSTOCKWELL@bethel.jw.org' as email 	
	union all
	select 'W. Merchant' as ovsr, 48028 as person_id, 'WMERCHANT@bethel.jw.org' as email 	
	union all
	select 'D. Glover' as ovsr, 781119 as person_id, 'DGLOVER@bethel.jw.org' as email 
	union all
	select 'K. Page' as ovsr, 59612 as person_id, 'KPAGE@bethel.jw.org' as email
	union all
	select 'N. French' as ovsr, 781114 as person_id, 'nfrench@bethel.jw.org' as email
	union all
	select 'T. Robinson' as ovsr, 29930 as person_id, 'TGRobins@bethel.jw.org' as email
	union all
	select 'J. Metheny' as ovsr, 356627 as person_id, 'JMETHENY@bethel.jw.org' as email
	union all
	select 'N. Brust' as ovsr, 416691 as person_id, 'NBRUST@bethel.jw.org' as email
	union all
	select 'R. Pierce' as ovsr, 348469 as person_id, 'RPIERCE@bethel.jw.org' as email
	union all
	select 'T. Powell' as ovsr, 404868 as person_id, 'TDPOWELL@bethel.jw.org' as email
	-----------------------------------------------------------------------------------
	union all
	select 'R. Horne' as ovsr, 102057 as person_id, 'AHORNE@bethel.jw.org' as email
	union all
	select 'J. Barker' as ovsr, 741671 as person_id, 'JONBARKER@bethel.jw.org' as email
	union all
	select 'K. Flores' as ovsr, 347395 as person_id, 'KFLORES@bethel.jw.org' as email
	
	
	
	
insert into dbo.hpr_Crew (hpr_dept_key, crew_name, crew_ovsr, crew_ovsr_person_id, crew_ovsr_email )
values( 131, 'Volunteer Resourcing', 'R. Horne', 102057, 'AHORNE@bethel.jw.org' ), 
	( 131, 'Approval Processing', 'J. Barker', 741671, 'JONBARKER@bethel.jw.org' ),
	( 131, 'Special Handling', 'K. Flores', 347395, 'KFLORES@bethel.jw.org' );	
