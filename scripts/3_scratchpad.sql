select * from volunteer_v where 1=1 
and volunteer_key = 355401
and full_name like 'garcia, raul%' --997003
--and email = 'orodr030@gmail.com'
--and hub_volunteer_num = 1237046


update volunteer set HPR_Volunteer_Exception_Flag = 'N' where volunteer_key = 817485

select * from dept_asgn_v where volunteer_key = 1121010 and active_flag = 'Y' --and dept_asgn_status = 'Needs Handling' group by  dept_name, work_group_Name order by 1, 2

select * from dept_role_v where dept_role_key in (591, 602, 641, 714 )

select * from dept_role_volunteer_v where  volunteer_key = 1121010

select dept_asgn_key, candidate_1_name, Enrollment_Key, Dept_Start_Date, Dept_End_Date, ps_start_date, ps_end_date, update_type, SnapshotDate from arch.dept_asgn where volunteer_key = 476741 order by SnapshotDate desc

select * from volunteer_enrollment_v where volunteer_key = 968295 order by Start_Date desc

select * from Volunteer_Dept_v where volunteer_key = 238069 and active_flag ='y' order by start_date desc

select * from Volunteer_Dept_Rpt where volunteer_key = 238580

select d.volunteer_key, count(*) from Volunteer_Dept_v d inner join rpt.Volunteer_Rpt_v v on d.volunteer_key = v.volunteer_key 
where getdate() between start_date and coalesce(end_date,'9999-12-31') and primary_flag = 'Y' group by d.volunteer_key having count(*) > 1

select * from Volunteer_enrollment_Rpt where volunteer_key = 238580

select * from enrollment where enrollment_key in (91,92)

select * from dbo.Volunteer_v where volunteer_key in ( 571432 ) 

select record_type, count(*) from rpt.Volunteer_v group by record_type

select * from rpt.Volunteer_v where volunteer_key in ( 817485 ) 

select * from dbo.volunteer_dept_rpt where volunteer_key in ( 238069 )

select * from rpt.Arrival_Departure_v where volunteer_key in ( 968295 ) 

select * from rpt.Volunteer_Departure_v where volunteer_key in ( 968295 ) 

select * from dbo.Volunteer_v_snp where volunteer_key in ( 968295 ) 

select * from rpt.Volunteer_Rpt_v where volunteer_key in ( 817485 )

select * from rpt.Volunteer_All_v where volunteer_key = 817485

select hpr_flag, * from rpt.PCC_Project_Volunteer_v where volunteer_key in ( 817485 )

select * from rpt.Staffing_Tool_v where volunteer_key in ( 369548 )

select * from dbo.Volunteer_Fact_Actual where volunteer_key = 355401

select * from rpt.Volunteer_Projected_v where volunteer_key in ( 633688 )

select * from rpt.resource_plan_vol_daily_v where dept_asgn_key = 591 --volunteer_key = 641583 --2520645

select * from rpt.resource_plan_vol_v where dept_asgn_key in (591, 602, 641, 714 ) and cal_dt = '2025-10-30' --volunteer_key = 641583 

select * from rpt.CVC_v where dept_asgn_key in (591, 602, 641, 714 ) --volunteer_key = 378151

select enrollment_status, count(*) from rpt.staffing_tool_v group by enrollment_status

select * from hpr_dept where active_flag = 'Y' and Dept_Ovsr_Email is null

select * from stg.stg_person where person_id = 838474

select * from stg.stg_Person_Dept_History where person_id = 838474

select * from stg.stg_App_Invitation_History where person_id = 156366

select * from stg.stg_Bethel_Member_Availability where personid = 509594

update volunteer set hpr_volunteer_exception_flag = 'N' where volunteer_key = 908039

select * from stg.stg_department_hierarchy where department_name like '%Medical%'

select hpr_dept_key, parent_hpr_dept_key, cpc_code, Work_Group_Name, level_01, level_02, level_03, level_04, level_05, hub_dept_id, pc_code_full, pc_category, hub_flag, dept_ovsr, dept_ovsr_email, dept_asst_ovsr, dept_asst_ovsr_email, work_group_ovsr, work_group_ovsr_email, work_group_asst_ovsr, work_group_asst_ovsr_email
from HPR_Dept where 1=1 and active_flag = 'Y' --and hub_flag = 'Y'
	and cpc_code = 'CI' 
	and pc_code_full like 'HPR-CI-TG-FI%'
	--and work_group_name like '%cleaning%'
	--and hpr_dept_key in ( 616 )
order by level_02, level_03, level_04, level_05

update hpr_dept set HUB_Flag = 'Y' where HPR_Dept_Key = 141

select user_key, last_name, First_Name, ad_user_name, vtc_flag as vrt_flag, VTC_CPC_Code as cpc_level, VTC_Level_02, VTC_Level_03, User_Access_Level_Code 
from [User] where 1=1 and active_flag = 'Y' order by last_name

select * from [User] where user_key in (2,34)
insert into [User](first_name, last_name, email, AD_User_Name, User_Access_Level_Code, VTC_Flag, VTC_CPC_Code, VTC_Level_02, VTC_Level_03)
values('Shaun', 'Adkins', 'SAADKINS@bethel.jw.org', 'SAADKINS', 5, 'Y', 'PS', 'Maintenance-RMP', null )

update [User] set Refresh_Flag = 'N' , admin_flag = 'N' where user_key = 2

select * from cong where Midweek_Meeting_DOW is not null

select round(v.age,0), app_status_code, count(*) from volunteer_app_v va inner join volunteer_v v on va.volunteer_key = v.volunteer_key 
where app_type_key = 2 and app_date > '2025-01-01' and v.Gender_Code = 'M' and v.Birth_Date > '2004-01-01' 
group by round(v.age,0), app_status_code order by 1, 2

select * from volunteer_app_v where app_type_key = 2 and app_date > '2025-01-01' and app_status_code = 'APP'

select min(cal_dt),max(cal_dt) from prp

update dbo.[User] set VTC_Level_02 = 'Trade Group', VTC_Level_03 = 'Walls and Ceilings' where user_key in ( 67 )

select * from dbo.Volunteer_App_v where volunteer_key = 238580

select last_name, first_name, hub_volunteer_num,
	upper( left( first_name, 1 ) + 			substring( cast( hub_volunteer_num as varchar(30) ), 3, 1 ) + 			substring( first_name, 2, 1 ) + 			right( cast( hub_volunteer_num as varchar(30) ), 1 ) + 			right( last_name, 1 ) ) as base_helmet_id,
	base_helmet_id, rownum, helmet_id
from rpt.volunteer_all_v
where base_helmet_id = 'D9A7O'

select * from rpt.PC_Volunteer_Actuals_Daily_v
where cal_dt = '2025-05-21'

select * from [dbo].[PRP_Actuals_Level_04_snp] where level_04 = 'Electrical'

select * from rpt.cvc_v where level_04 = 'Electrical' and wk_05 like 'ott%'
select * from dbo.cvc_snp where level_04 = 'Electrical' and wk_05 like 'ott%'

select * from rpt.PRP_Actuals_Level_04_v


select * from [stg].[stg_Rooming] 
where  Overnight_Guest_Category is not null

select * from rpt.volunteer_v where hub_person_id=876798
