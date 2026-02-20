-- DAILY HIGH-LEVEL VALIDATION
select * from dbo.App_Metadata
select * from dbo.App_Data_Validation_curr_v 

-- DETAILS OF THE ETL RUN IF ISSUES ARE IDENTIFIED
select * from dbo.ETL_Table_Run_Curr_v order by start_time
select *, datediff( s, start_time, end_time ) as runtime_sec from dbo.ETL_Table_Run where etl_table = 'Dept Role and Dept Role Volunteer' /*and datediff( s, start_time, end_time ) >= 600*/ order by start_time desc
select avg( datediff( s, start_time, end_time ) ) as avg_runtime_sec, count(*) from dbo.ETL_Table_Run where etl_table = 'PRP' and datediff( s, start_time, end_time ) < 600 --37, 1423

-- SOURCE SYSTEM DATA
select top 10 * from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Volunteer_Attendance
select top 10 * from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.ba_load_Status
select min( load_date ) from stg.stg_person
select BA_Load_Status_Date from stg.stg_ba_load_status

-- SYSTEM ACTIVITY
exec master.dbo.sp_whoisactive  

-- JW USERNAME
select volunteer_key, v.jw_username, v.full_name, p.person_id, v.birth_date, v.baptism_date, v.email, v.mobile_phone, v.load_date from dbo.volunteer v 
left join stg.stg_person p
	on v.hub_person_id = p.person_id
where JW_Username in (select jw_username from dbo.Volunteer where jw_username is not null group by jw_username having count(*) > 1) order by v.jw_username

update dbo.volunteer set JW_Username = null where volunteer_key in ( 926925 )

delete from dbo.volunteer where volunteer_key in ( 653628 )

-- BA_VOLUNTEER_ID
select volunteer_key, v.ba_volunteer_id, v.full_name, p.person_id, v.ba_volunteer_num, ba.Volunteer_BANumber, v.HUB_Person_GUID, ba.Person_GUID, v.Mobile_Phone, v.load_date,* from dbo.volunteer v 
left join stg.stg_person p
	on v.hub_person_id = p.person_id
left join stg.stg_ba_volunteer ba
	on v.BA_Volunteer_ID = ba.Volunteer_ID
where ba_volunteer_id in (select ba_volunteer_id from dbo.Volunteer where ba_volunteer_id is not null group by ba_volunteer_id having count(*) > 1) order by v.ba_volunteer_id

update dbo.volunteer set ba_volunteer_id = null where volunteer_key in ( 676468 )

delete from dbo.volunteer where volunteer_key in ( 692509 )

-- BA VOLUNTEER NUMBER 
select volunteer_key, v.ba_volunteer_num, ba.Volunteer_BANumber, v.full_name, p.person_id, v.load_date,v.HUB_Person_GUID, ba.Person_GUID,* from dbo.volunteer v 
left join stg.stg_person p
	on v.hub_person_id = p.person_id
left join stg.stg_ba_volunteer ba
	on v.BA_Volunteer_ID = ba.Volunteer_ID
where ba_volunteer_num in (select ba_volunteer_num from dbo.Volunteer where ba_volunteer_num is not null group by ba_volunteer_num having count(*) > 1) order by v.ba_volunteer_num

update dbo.volunteer set ba_volunteer_num = null where volunteer_key in ( -655743 ) or ba_volunteer_num = 0

delete from dbo.volunteer where volunteer_key in ( 242014 )

-- DEPT
select person_id, volunteer_key, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code from dbo.Volunteer_dept group by volunteer_key, person_id, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code 
having count(*) > 1 order by 1, 2

select * from stg.stg_person_dept_history where person_id = 760803 order by start_date desc, parent_department_name, department_name

select * from dbo.volunteer_dept_v where volunteer_key = 848311 order by start_date desc, parent_dept_name, dept_name

delete from volunteer_dept where volunteer_dept_key in ( 101932514 )

select person_Id, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code from dbo.Volunteer_dept group by person_Id, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code 
having count(*) > 1

-- ACTIVE ENROLLMENT
select volunteer_key, enrollment_key from dbo.Volunteer_Enrollment where active_flag = 'Y' and enrollment_key not in ( 137, 138 ,122) group by volunteer_key, enrollment_key having count(*) > 1

select * from dbo.volunteer_enrollment where volunteer_key = 999678 order by start_date desc

select ve.*, v.full_name, v.hub_person_id, e.enrollment_code from dbo.Volunteer_Enrollment ve inner join dbo.volunteer v on ve.volunteer_key = v.volunteer_key inner join dbo.enrollment e on ve.enrollment_key = e.enrollment_key
where ve.active_flag = 'Y' and ve.enrollment_key not in ( 137, 138 ) and ve.volunteer_key = 753946 order by start_date desc 

select * from stg.stg_person_enrollment where person_id = 641174 and enrollment_code <> 'TMP' order by start_date desc
select * from stg.stg_person where person_id = 641174
select * from dbo.volunteer where volunteer_key = 745818
update dbo.Volunteer_Enrollment set active_flag = 'N', end_date = '2024-01-23' where volunteer_enrollment_key = 8380372

delete from dbo.volunteer_enrollment where volunteer_enrollment_key = 10134101

-- ORPHANED WORK ASSIGNMENT
select o.*, v.volunteer_key from dbo.Volunteer_Dept_Orphaned_Records_v o inner join volunteer_dept v on o.volunteer_dept_key = v.volunteer_dept_key
update volunteer_dept set end_date = getdate(), active_flag = 'N' where volunteer_dept_key in ( select volunteer_dept_key from dbo.Volunteer_Dept_Orphaned_Records_v )
select * from volunteer_dept where volunteer_key = 254922 order by start_date desc
select * from stg.stg_person_dept_history where person_id = 863212

-- ORPHANED ENROLLMENT
select o.*, v.volunteer_key from dbo.Volunteer_enrollment_Orphaned_Records_v o inner join volunteer_enrollment_v v on o.volunteer_enrollment_key = v.volunteer_enrollment_key
delete from volunteer_enrollment where volunteer_enrollment_key in ( select volunteer_enrollment_key from dbo.Volunteer_enrollment_Orphaned_Records_v )

-- VOLUNTEER ALL V
select volunteer_key from rpt.volunteer_all_v group by volunteer_key having count(*) > 1

select * from rpt.volunteer_all_v where volunteer_key = 765566

select * from rpt.volunteer_rpt_v where volunteer_key = 765566

select * from dbo.Volunteer_v_snp where volunteer_key = 765566

select * from dbo.volunteer_dept_v where volunteer_key = 765566 order by start_date desc

select * from dbo.Volunteer_Enrollment_v where volunteer_key = 765566 order by start_date desc

select * from rpt.Volunteer_v where volunteer_key = 765566

select * from dbo.Volunteer_dept_rpt where volunteer_key = 765566

-- VOL DESK USER KEY
select * from dbo.volunteer where vol_desk_user_key is null
update dbo.volunteer set vol_desk_user_Key = 1 where vol_desk_user_key is null

delete from dbo.volunteer_role where volunteer_key in ( 653628 )

-- PRP
exec dbo.ETL_PRP_Data_proc

update dbo.app_metadata set attribute_value = '2/12/2026' where attribute_name = 'PRP_Update_Date'

select * from dbo.PRP_Actuals_Level_02_snp

select department, teamtrade, teamcode, ParentCode from stg.stg_prp_dept where teamtrade like '%site log%'
update stg.stg_prp_dept set teamcode = 'HPR CI BG SL MH' where teamtrade = 'Site Logistics - Telehandler'

SELECT department, teamtrade, teamcode, ParentCode, [jul-25] from stg.stg_PRP_Dept where teamtrade like '%site log%' or teamtrade like '%concrete%'

select department, teamtrade, replace( teamcode, ' ',  '-' ) as teamcode, parentcode
from stg.stg_PRP_Dept
where 1=1
	--and teamcode like 'HPR DD%'
	and ParentCode is not null 
	and teamtrade not like 'Total%'
	and ( teamtrade like '%site log%'  )

select pc_code, jul_25 from stg.stg_prp_dept_v where pc_code like 'HPR-CI-BG-SL%'

select d.hpr_dept_key, d.cpc_code, d.dept_name, d.work_group_name, d.pc_code_full, prp.pc_code, d.pc_code,  prp.jul_25 as jul_25
from dbo.hpr_dept d
left join stg.stg_prp_dept_v prp
	on d.pc_code_full = prp.pc_code
where 1=1
	and d.active_flag = 'Y'
	and d.NYC_Flag = 'N'
	AND d.cpc_code = 'CI'

select hpr_dept_key, cpc_code, dept_name, work_group_name, pc_code, jul_25 from stg.stg_prp_v where cpc_code = 'CI' and work_group_Name like '%batch%'

select * from dbo.prp where cal_dt = '2025-07-01' and cpc_code = 'CI' and pc_code like 'HPR-CI-BG-SL%'

select * from rpt.PRP_Actuals_Level_02_v

-- MISC
exec master.dbo.sp_whoisactive 
--@Help = 1
--@get_plans = 1
@get_additional_info=1
,@get_outer_command = 1
,@get_full_inner_text = 1 
,@find_block_leaders=1
,@show_sleeping_spids= 1
,@get_transaction_info =1
,@get_locks=1
,@delta_interval = 60
,@filter = 'usvm162'  -- session, program, database, login, host
,@filter_type = 'host' 
,@sort_order = '[blocked_session_count] DESC' -- can sort by any column

sp_who
sp_who2
SELECT * FROM sys.sysprocesses WHERE spid = 90 
select * from sys.dm_exec_sessions where session_id = 90
select * from sys.dm_exec_connections where session_id = 90
SELECT t.* FROM sys.dm_exec_requests AS r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
WHERE session_id = 107

select top 10 enrollment_code from stg.stg_person_enrollment where enrollment_code not in (select enrollment_code from dbo.enrollment where active_flag = 'Y')

select * from stg.stg_Person_Dept_History where end_date is null and person_id in ( 701491, 619676, 516662, 477404 )

select p.person_id, p.last_name, p.first_name, d.parent_department_name, d.department_name, d.start_date, d.end_date
from stg.stg_person p
inner join stg.stg_Person_Dept_History d
	on p.person_id = d.person_id
where 1=1
	and p.person_id = 701491
order by d.start_date desc

-- JOIN TO ENROLLMENT
select current_enrollment_code, pioneer_flag, p.pioneer_status as person_pio, case when enrl.person_id is not null then 'Y' else 'N' end as enrl_pio, count(*)
from volunteer_v v
inner join stg.stg_person p
	on v.hub_person_id = p.person_id
left join ( select person_id from stg.stg_person_enrollment where end_date is null and start_date <= getdate() and enrollment_code = 'FR' ) enrl
	on p.person_id = enrl.person_id
where 1=1
--	and p.person_id in ( 453741, 388759, 30567 )
	and current_enrollment_code is not null
	and case when enrl.person_id is not null then 1 else 0 end <> p.pioneer_status
group by current_enrollment_code, pioneer_flag, p.pioneer_status, case when enrl.person_id is not null then 'Y' else 'N' end order by 1, 2, 3

select p.*, x.attribute_value, x.attrib_pursued_by_val, x.active_flag from data_xchg.App_Attribute_Pending_Removal_v p
	inner join ( select a.applicant_id, ph.attribute_value, a.attrib_pursued_by_val, a.attrib_contacted_val, a.active_flag from dbo.Volunteer_Pursuit_Hist_v ph
		inner join dbo.volunteer_app_v a on ph.volunteer_key = a.volunteer_key ) x on p.applicant_Id = x.applicant_id order by full_name, load_date desc

update data_xchg.App_Attribute_Hist set status = 'Complete' where App_Attribute_Hist_Key in ( 10206,10950,10951 )
update dbo.volunteer_pursuit_hist set active_flag = 'N' where volunteer_pursuit_hist_key in ( 8723 )

select full_name, applicant_id, app_type_code, attribute, attrib_pursued_by_val, attribute_value, * from data_xchg.App_Attribute_Hist_v where load_date > cast( getdate() - 1 as date ) and status = 'Complete' order by 2 desc
select * from dbo.Volunteer_Pursuit_Hist where volunteer_key in ( select volunteer_key from dbo.volunteer_app_v where applicant_id in ( 553189 ) ) order by load_date desc
select v.full_name, ph.* from dbo.volunteer_pursuit_hist ph inner join dbo.volunteer v on ph.Volunteer_Key = v.volunteer_key where Volunteer_Pursuit_Cancel_Reason_Key is not null and ph.update_date > cast( getdate() - 5 as date )
update dbo.Volunteer_Pursuit_Hist set active_flag = 'N' where Volunteer_Pursuit_Hist_Key = 8012
update dbo.Volunteer_Pursuit_Hist set attribute_value = 'C. Dockett 03/23/23 for Crew Overseer, targeting 07/01/24' where Volunteer_Pursuit_Hist_Key = 8698
select * from dbo.Volunteer_Contact_Hist where volunteer_key in ( select volunteer_key from dbo.volunteer_app_v where applicant_id in ( 458650 ) ) and active_flag = 'Y' order by load_date desc
select * from dbo.Volunteer where full_Name like 'Grueneberg, Nicholas%'
select * from dbo.Volunteer_Pursuit_Hist where volunteer_key in ( select volunteer_key from dbo.volunteer_app_v where applicant_id in ( 436177 ) )
select * from dbo.volunteer_app_v where volunteer_key = 689742 --and applicant_id = 454850
select full_name, applicant_id, app_type_code, attribute, attrib_pursued_by_val, attribute_value, * from data_xchg.App_Attribute_Hist_v where volunteer_key = 836953 and applicant_id = 454850
select * from stg.stg_App_Attribute where applicant_id in ( 476993 )

select user_Key, last_name, first_name, case when user_access_level_code = 25 then 'USA-HPR-APPRVDUsersBasic' when admin_flag = 'Y' then 'USA-HPR-APPRVDAdministrator' else 'USA-HPR-APPRVDUsers' end as AD_role
from dbo.[User] 
where 1=1
	and active_flag = 'Y'
order by last_name, first_Name

%SystemRoot%\system32\dsa.msc
(Get-ADUser kkrause -Properties MemberOf).MemberOf
USA-HPR-APPPowerBIPSWorkspace

select site_code, dept_name, count(*) from dbo.Volunteer_Dept
where '2015-06-01' between start_date and end_date 
	and ( site_code = 'WRK' or dept_name like '%WRK' )
group by site_code, dept_name
order by 1, 2


select table_catalog, table_name
from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA='dbo'
order by table_name

select tbl.name, sum(part.rows) as rows
from sys.tables tbl
inner join sys.partitions part on tbl.object_id = part.object_id
inner join sys.indexes idx on part.object_id = idx.object_id
and part.index_id = idx.index_id
where 1=1
	and schema_id = 1
	--and tbl.name = @tablename
	and idx.index_id < 2
group by tbl.name
order by 1;


