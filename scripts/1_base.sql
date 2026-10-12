vol key 238580
vol num 8014892
ba num 8014892  02057339
ba id 30046
person id 30567
person guid 86DDE060-7C21-458F-A4CB-E17B179029FE
vol id 20488

select * from dbo.App_Metadata
select * from dbo.App_Data_Validation_curr_v 
select * from dbo.ETL_Table_Run_Curr_v order by start_time
select *, datediff( s, start_time, end_time ) as runtime_sec from dbo.ETL_Table_Run where etl_table = 'Volunteer' and datediff( s, start_time, end_time ) >= 600 order by start_time desc
select avg( datediff( s, start_time, end_time ) ) as avg_runtime_sec, count(*) from dbo.ETL_Table_Run where etl_table = 'PRP' and datediff( s, start_time, end_time ) < 600 --37, 1423
select top 10 * from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.Volunteer_Attendance
select top 10 * from [rvd-ussqlext019.bethel.jw.org].RVD_Export.dbo.ba_load_Status
select min( load_date ) from stg.stg_person
select BA_Load_Status_Date from stg.stg_ba_load_status

-- JW USERNAME
select volunteer_key, v.jw_username, v.full_name, p.person_id, v.birth_date, v.baptism_date, v.email, v.mobile_phone, v.load_date from dbo.volunteer v 
left join stg.stg_person p
	on v.hub_person_id = p.person_id
where JW_Username in (select jw_username from dbo.Volunteer where jw_username is not null group by jw_username having count(*) > 1) order by v.jw_username

update dbo.volunteer set JW_Username = null where volunteer_key in ( 595450 )

delete from dbo.volunteer where volunteer_key in (1051609)

-- BA_VOLUNTEER_ID
select volunteer_key, v.ba_volunteer_id, v.full_name, p.person_id, v.ba_volunteer_num, ba.Volunteer_BANumber, v.HUB_Person_GUID, ba.Person_GUID, v.Mobile_Phone, v.load_date,* from dbo.volunteer v 
left join stg.stg_person p
	on v.hub_person_id = p.person_id
left join stg.stg_ba_volunteer ba
	on v.BA_Volunteer_ID = ba.Volunteer_ID
where ba_volunteer_id in (select ba_volunteer_id from dbo.Volunteer where ba_volunteer_id is not null group by ba_volunteer_id having count(*) > 1) order by v.ba_volunteer_id

update dbo.volunteer set ba_volunteer_id = null where volunteer_key in ( 944378 )

delete from dbo.volunteer where volunteer_key in ( 900094 )

-- BA VOLUNTEER NUMBER 
select volunteer_key, v.ba_volunteer_num, ba.Volunteer_BANumber, v.full_name, p.person_id, v.load_date,v.HUB_Person_GUID, ba.Person_GUID,* from dbo.volunteer v 
left join stg.stg_person p
	on v.hub_person_id = p.person_id
left join stg.stg_ba_volunteer ba
	on v.BA_Volunteer_ID = ba.Volunteer_ID
where ba_volunteer_num in (select ba_volunteer_num from dbo.Volunteer where ba_volunteer_num is not null group by ba_volunteer_num having count(*) > 1) order by v.ba_volunteer_num

update dbo.volunteer set ba_volunteer_num = null where volunteer_key in ( -874209 ) or ba_volunteer_num = 0

delete from dbo.volunteer where volunteer_key in ( 699649 )

-- DEPT
select person_id, volunteer_key, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code from dbo.Volunteer_dept group by volunteer_key, person_id, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code 
having count(*) > 1 order by 1, 2

select * from stg.stg_person_dept_history where person_id = 714210 order by start_date desc, parent_department_name, department_name

select * from dbo.volunteer_dept_v where volunteer_key = 807928 order by start_date desc, parent_dept_name, dept_name

delete from volunteer_dept where volunteer_dept_key in ( 102193302 )

select person_Id, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code from dbo.Volunteer_dept group by person_Id, Parent_Dept_Name, dept_name, dept_role, notes, start_date, end_date, temp_flag, Primary_Flag, Enrollment_Code 
having count(*) > 1

-- ACTIVE ENROLLMENT
select volunteer_key, enrollment_key from dbo.Volunteer_Enrollment where active_flag = 'Y' and enrollment_key not in ( 137, 138 ,122) group by volunteer_key, enrollment_key having count(*) > 1

select * from dbo.volunteer_enrollment where volunteer_key = 848007 order by start_date desc

select ve.*, v.full_name, v.hub_person_id, e.enrollment_code from dbo.Volunteer_Enrollment ve inner join dbo.volunteer v on ve.volunteer_key = v.volunteer_key inner join dbo.enrollment e on ve.enrollment_key = e.enrollment_key
where ve.active_flag = 'Y' and ve.enrollment_key not in ( 137, 138 ) and ve.volunteer_key = 753946 order by start_date desc 

select * from stg.stg_person_enrollment where person_id = 641174 and enrollment_code <> 'TMP' order by start_date desc
select * from stg.stg_person where person_id = 641174
select * from dbo.volunteer where volunteer_key = 745818
update dbo.Volunteer_Enrollment set active_flag = 'N', end_date = '2024-01-23' where volunteer_enrollment_key = 8380372

delete from dbo.volunteer_enrollment where volunteer_enrollment_key = 8403133

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

select * from rpt.volunteer_all_v where volunteer_key = 571432

select * from rpt.volunteer_rpt_v where volunteer_key = 238580

select * from dbo.volunteer_dept_v where volunteer_key = 238580 order by start_date desc
delete from dbo.volunteer_dept where volunteer_dept_key in ( 102246675, 102246114 )
update dbo.volunteer_dept set end_date = null where volunteer_dept_key = 102246113

select * from dbo.Volunteer_Enrollment_v where volunteer_key = 248177 order by start_date desc
delete from dbo.volunteer_enrollment where volunteer_enrollment_key = 10700047

select * from rpt.Volunteer_v where volunteer_key = 1068012

-- VOL DESK USER KEY
select * from dbo.volunteer where vol_desk_user_key is null
update dbo.volunteer set vol_desk_user_Key = 1 where vol_desk_user_key is null

delete from dbo.volunteer_role where volunteer_key in ( 339857,262295,6197549 )

select * from dbo.volunteer where tracking_status_key is null
update dbo.volunteer set tracking_status_key = 1 where tracking_status_key is null

-- DEPT RPT
exec dbo.ETL_Volunteer_Dept_Rpt_Proc

exec dbo.ETL_Reporting_Snapshots_proc

-- PRP
exec dbo.ETL_PRP_Data_proc

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

-- SESSIONS
SELECT s.session_id, DB_NAME(r.database_id) AS database_name, s.login_name, s.host_name, s.program_name, r.status,
	r.cpu_time, r.total_elapsed_time / 1000 AS elapsed_seconds, r.reads, r.writes, r.blocking_session_id, t.text as running_statement
FROM sys.dm_exec_sessions s
LEFT JOIN sys.dm_exec_requests r
    ON s.session_id = r.session_id
left join sys.dm_exec_connections c
	on s.session_id = c.session_id
CROSS APPLY sys.dm_exec_sql_text(c.most_recent_sql_handle) AS t
WHERE 1=1
	and s.login_name <> 'sqloikonomon'
	and r.status is not null
ORDER BY r.cpu_time DESC;



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

select * from dbo.PRP_Actuals_Level_02_snp

update dbo.app_metadata set attribute_value = '08/12/2026' where attribute_name = 'PRP_Update_Date'

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
select * from sys.dm_exec_sessions where status = 'sleeping' session_id = 90
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



last name + dob + bap
last name + dob + bap same month

1) add BA Num to HuB = 246K
	19-35 = 64K
	36-45 = 48K
	46-55 = 45K
	56-65 = 46K
	
	M = 112K
	F = 91K
	
	E = 36K
	MS = 26K
	
2) add WRK survey data to Hub = 117K
	19-35 = 28K
	36-45 = 24K
	46-55 = 23K
	56-65 = 24K		
	
	M = 65K
	F = 53K
	
	E = 33K
	MS = 16K
	
3) add current employment to HuB = 115K

4) add interviewer comments to HuB = 22K

https://usadminqa.bethel.jw.org/json/syncreply/PersonContactNumberSummariesRequest 

vol num > 10,000,000 bad recs
re-import file and search for all valid vol nums


Francois Louw
Sean Yi - works w/ Bill

in database you have 


01-jan-2001 07-jan-2001 


you are given as inputs: 


15-dec-2000 15-jan-2001 - wider then database 
15-dec-2000 04-jan-2001 - overlaps but not contained within 
04-jan-2001 15-jan-2001 - overlaps but not contained within 
02-jan-2001 04-jan-2001 - overlaps and contained within 


should all four return a "hit"? 

select * 
from t 
where ( c_beginning between p_beginning and p_ending -- rule 1 
OR c_ending between p_beginning and p_ending -- rule 2 
OR ( c_beginning < p_beginning and p_ending < c_ending ) ); -- rule 3 



WorkUnitText   Not Like "H *" And Not Like "F *"
bethelsitecode "WRK"


1) diff match in WVD
2)

Match
Not in Admin - Create new Person
TVD Record Deleted

Deleted by CR
Deleted by KK

4/1/2016 to 5/1/2016

coreusaadmin.bethel.jw.org - latest version of the code

need to tie apps to persons


1) set mailbox monitoring & corresp. module
2) create custom pdf
3) import proc

1) create incident
2) send fillable pdf
3) receive completed fillable pdf in inbox	
4) attach as correspondence
5) simply import as pdf or populate some fields in ADMIN?

how about new evaluation form?  like 3-mth


-- CONVERSION
can we remove the tvd role later?
tie some using the ID field?



dedication 
In (8022917,857330,8026955,465071,357251,858738,860137,839035,10546904,853361,856303)


IMPORT MATCHES FILE AND INSERT ANY MISSING TVD RECORDS

10235416 bolton, shenin
796565 tim
817317 sarah
10301695 iarussi, margaret

Project Start: 5/3/2012
Project End: 9/1/2016
Qualifying Enrollments: BBR, BBF, BBT, BBW, BCS, BCV, BCF, BBL, BCL
Work Unit: Begins with  H  or  F   (this will get Montgomery Warehouse, NCA & NCB people, e.g. the seniority marked in yellow below)
or
Bethel Site: WRK  (this will include people physically at Warwick that were working for departments at another site, e.g. M. Iarussi)
 
 
SELECT USBethelPersonsActive.PersonName, USBethelPersonsActive.VolunteerNum, USBethelPersonsActive.USBethelEnrollmentCode, USBethelPersonsActive.FunctionName, USBethelPersonsActive.DeptName, USBethelPersonsActive.WorkComplexCode, USBethelPersonsActive.WorkAsgmtTempYesNo, USBethelPersonsActive.RoomName, USBethelPersonsActive.RoomBldgCode
FROM VolAdminXD.dbo.USBethelPersonsActive USBethelPersonsActive
WHERE (USBethelPersonsActive.WorkComplexCode='FKL') AND (USBethelPersonsActive.WorkAsgmtTempYesNo=0) 


select * from dbo.volunteer where mobile_phone= '561-729-5605'



INSERT INTO [dbo].[User_List_Volunteer]
           ([User_List_Key]
           ,[Volunteer_Key]
           ,[Sort_Order]
           ,[User_List_Volunteer_Status_Key]
           ,[Status_Date]
           ,[Notes]
           ,[Last_Changed_User_Key]
           ,[Start_Date]
           ,[End_Date]
           ,[Active_Flag]
           ,[Load_Date]
           ,[Update_Date])
     select 
           205
           ,Volunteer_Key
           ,0
           ,1
           ,getdate()
           ,Full_Name
           ,2
           ,getdate()
           ,''
           ,'Y'
           ,getdate()
           ,getdate()
from dbo.volunteer
where BA_Volunteer_Num in (
01012656  ,
06206482  ,
02134196  ,
05026354  ,
03054957  ,
08053020  ,
12070732  ,
06180355  ,
03130430  ,
04170048  ,
07224764  ,
04220085  ,
05030342  ,
11020328  ,
01160286  ,
12070733  ,
10192004  ,
07053723  ,
11102457  ,
11095980  ,
05207601  ,
10218358  ,
06137079  ,
03309043  ,
10197053  ,
04127061  ,
09262858  ,
12069618  ,
05075111  ,
07253211  ,
11170168  ,
09300222  ,
07052104  ,
08013780  ,
09068874  ,
01097567  ,
01316133  ,
06248046  ,
04106422  ,
12081491  
 )
order by full_name

delete from user_list_volunteer where user_list_key = 205
delete from user_list where user_list_key = 205


select v.full_name, past.person_id, past_end_dt, curr_start_dt
	,case when past_end_dt = curr_start_dt - 1 then 'OK' else 'gap' end as diff
	,datediff(d,past_end_dt, curr_start_dt) as diff_days
	,case when past_end_dt = curr_start_dt - 1 then null else curr_start_dt end as diff_dt
into stg.stg_Person_Cong_Hist_Gap
from 
	( select person_id, max(end_date) as past_end_dt
	  from stg.stg_Person_Cong_Hist_Full2
	  where end_date is not null
	  group by person_id ) past
inner join 	
	( select person_id, start_date as curr_start_dt
	  from stg.stg_Person_Cong_Hist_Full2
	  where end_date is null ) curr
	on past.person_id = curr.person_id
inner join dbo.volunteer v
	on past.person_id = v.hub_person_id
where 1=1
	--and past.person_id in ( 65485,12391)
	and past_end_dt < curr_start_dt - 61
order by 6

update dbo.volunteer
set cong_relocation_date = src.curr_start_dt
from dbo.volunteer v
inner join stg.stg_Person_Cong_Hist_Gap src
	on v.HUB_Person_ID = src.person_id


exec dbo.ETL_BA_Event_Volunteer_Invite_proc
exec dbo.ETL_BA_Project_Group_Volunteer_proc
exec dbo.ETL_BA_Project_Volunteer_proc
exec dbo.ETL_BA_Project_Volunteer_Attendance_proc
exec dbo.ETL_Volunteer_proc
exec dbo.ETL_Volunteer_App_proc
exec dbo.ETL_Volunteer_App_Collection_proc
exec dbo.ETL_Volunteer_Approval_Level_Hist_proc
exec dbo.ETL_Volunteer_Availability_proc
exec dbo.ETL_Volunteer_Dept_proc
exec dbo.ETL_Volunteer_Dept_Rpt_Proc
exec dbo.ETL_Volunteer_Enrollment_proc
exec dbo.ETL_Volunteer_Enrollment_Rpt_proc	
exec dbo.ETL_Volunteer_Role_proc
exec dbo.ETL_Volunteer_Search_proc
exec dbo.ETL_Volunteer_Skill_proc
exec dbo.ETL_Volunteer_Training_proc
exec dbo.ETL_RVD_Banner_proc
exec dbo.ETL_PRP_Data_proc
exec dbo.ETL_App_Attributes_Cleanup_proc



insert into dbo.[User](first_name, last_name, email, ad_user_name, User_Access_Level_Code,VTC_CPC_Code, VTC_Level_02, VTC_Level_03)
values
	( 'Jim','Evans','jmevans@bethel.jw.org','jmevans',99,'PCC',null, null ),
	( 'Josiah','Niemann','jniemann@bethel.jw.org','jniemann',99,'PCC',null, null ),
	( 'Jessie','de la Fuente','jdelafuente@bethel.jw.org','jdelafuente',99,'PS','Medical-RMP', null ),
	( 'Ricky','Leithiser','rtleithi@bethel.jw.org','rtleithi',99,'PS','Medical-RMP', null ),
	( 'Joshua','Portell','joportell@bethel.jw.org','joportell',99,'PS','Personnel Support Office', 'Lobby' ),
	( 'Benjamin','Moore','bmoore@bethel.jw.org','bmoore',99,'PS','Maintenance-RMP', null )