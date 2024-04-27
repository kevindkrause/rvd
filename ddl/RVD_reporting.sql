/*******************************************************************
**							VIEWS
*******************************************************************/
use rvdrehearsal
go

if object_id('rpt.Arrival_Departure_v', 'V') is not null
	drop view rpt.Arrival_Departure_v
go 
create view rpt.Arrival_Departure_v
as
select distinct
	 hub_volunteer_num
	,first_name
	,last_name
	,address
	,city
	,state_code
	,postal_code
	,gender_code
	,marital_status_code
	,home_phone
	,mobile_phone
	,bethel_email
	,jwpub_email
	,personal_email
	,parent_dept_name
	,dept_name
	,case 
		when charindex( ' - ', dept_name ) = 0 then dept_name
		else right( dept_name, charindex( ' - ', reverse( dept_name ) ) - 1 )
	 end as sub_dept_name
	,enrollment_code
	,enrollment_start_date
	,enrollment_end_date
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email
	,volunteer_key
	,case 
		when enrollment_start_date > cast( getdate() as date ) then 'Invited'
		when enrollment_end_date < cast( getdate() as date ) then 'Departed'
		else 'Arrived'
	 end as enrollment_status
from rpt.Volunteer_v

union all

select distinct
	 hub_volunteer_num
	,first_name
	,last_name
	,address
	,city
	,state_code
	,postal_code
	,gender_code
	,marital_status_code
	,home_phone
	,mobile_phone
	,bethel_email
	,jwpub_email
	,personal_email	
	,parent_dept_name
	,dept_name
	,case 
		when charindex( ' - ', dept_name ) = 0 then dept_name
		else right( dept_name, charindex( ' - ', reverse( dept_name ) ) - 1 )
	 end as sub_dept_name	
	,enrollment_code
	,enrollment_start_date
	,enrollment_end_date
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email
	,volunteer_key
	,case 
		when enrollment_start_date > cast( getdate() as date ) then 'Invited'
		when enrollment_end_date < cast( getdate() as date ) then 'Departed'
		else 'Arrived'
	 end as enrollment_status
from rpt.Volunteer_Departure_v
go


if object_id('rpt.BA_Elevated_Permissions_v', 'V') is not null
	drop view rpt.BA_Elevated_Permissions_v
go 
create view rpt.BA_Elevated_Permissions_v
as
select 
	 volunteer_name
	,cast( ba_volunteer_num as varchar(10) ) as ba_volunteer_num
	,case when b.DomainPerm = 1 then 'Y' else 'N' end as domain_perm_flag
	,case when b.ProjectPerm = 1 then 'Y' else 'N' end as project_perm_flag
	,parent_dept_name
	,dept_name
	,enrollment_code
	,enrollment_start_date	
	,volunteer_key
	,b.load_date
from rpt.volunteer_v v
inner join stg.stg_BA_Volunteer b
	on v.hub_person_guid = b.person_guid
where b.DomainPerm = 1 or b.ProjectPerm = 1
go


if object_id('rpt.BA_Event_v', 'V') is not null
	drop view rpt.BA_Event_v
go 
create view rpt.BA_Event_v
as
select 
	 volunteer_name
	,ba_volunteer_num
	,event_name
	,event_id
	,start_date
	,start_dow
	,num_days
	,dateadd( day, num_days - 1, start_date ) as end_date
	,case 
		when start_dow = 'Mon' and status_day_1 = 'C' then 'Y'
		when start_dow = 'Sun' and status_day_2 = 'C' then 'Y'
		when start_dow = 'Sat' and status_day_3 = 'C' then 'Y'
		when start_dow = 'Fri' and status_day_4 = 'C' then 'Y'
		when start_dow = 'Thu' and status_day_5 = 'C' then 'Y'
		when start_dow = 'Wed' and status_day_6 = 'C' then 'Y'
		when start_dow = 'Tue' and status_day_7 = 'C' then 'Y'
		else '' 
	 end as mon
	,case 
		when start_dow = 'Tue' and status_day_1 = 'C' then 'Y'
		when start_dow = 'Mon' and status_day_2 = 'C' then 'Y'
		when start_dow = 'Sun' and status_day_3 = 'C' then 'Y'
		when start_dow = 'Sat' and status_day_4 = 'C' then 'Y'
		when start_dow = 'Fri' and status_day_5 = 'C' then 'Y'
		when start_dow = 'Thu' and status_day_6 = 'C' then 'Y'
		when start_dow = 'Wed' and status_day_7 = 'C' then 'Y'
		else '' 
	 end as tue
	,case 
		when start_dow = 'Wed' and status_day_1 = 'C' then 'Y'
		when start_dow = 'Tue' and status_day_2 = 'C' then 'Y'
		when start_dow = 'Mon' and status_day_3 = 'C' then 'Y'
		when start_dow = 'Sun' and status_day_4 = 'C' then 'Y'
		when start_dow = 'Sat' and status_day_5 = 'C' then 'Y'
		when start_dow = 'Fri' and status_day_6 = 'C' then 'Y'
		when start_dow = 'Thu' and status_day_7 = 'C' then 'Y'
		else '' 
	 end as wed
	,case 
		when start_dow = 'Thu' and status_day_1 = 'C' then 'Y'
		when start_dow = 'Wed' and status_day_2 = 'C' then 'Y'
		when start_dow = 'Tue' and status_day_3 = 'C' then 'Y'
		when start_dow = 'Mon' and status_day_4 = 'C' then 'Y'
		when start_dow = 'Sun' and status_day_5 = 'C' then 'Y'
		when start_dow = 'Sat' and status_day_6 = 'C' then 'Y'
		when start_dow = 'Fri' and status_day_7 = 'C' then 'Y'
		else '' 
	 end as thu
	,case 
		when start_dow = 'Fri' and status_day_1 = 'C' then 'Y'
		when start_dow = 'Thu' and status_day_2 = 'C' then 'Y'
		when start_dow = 'Wed' and status_day_3 = 'C' then 'Y'
		when start_dow = 'Tue' and status_day_4 = 'C' then 'Y'
		when start_dow = 'Mon' and status_day_5 = 'C' then 'Y'
		when start_dow = 'Sun' and status_day_6 = 'C' then 'Y'
		when start_dow = 'Sat' and status_day_7 = 'C' then 'Y'
		else '' 
	 end as fri
	,case 
		when start_dow = 'Sat' and status_day_1 = 'C' then 'Y'
		when start_dow = 'Fri' and status_day_2 = 'C' then 'Y'
		when start_dow = 'Thu' and status_day_3 = 'C' then 'Y'
		when start_dow = 'Wed' and status_day_4 = 'C' then 'Y'
		when start_dow = 'Tue' and status_day_5 = 'C' then 'Y'
		when start_dow = 'Mon' and status_day_6 = 'C' then 'Y'
		when start_dow = 'Sun' and status_day_7 = 'C' then 'Y'
		else '' 
	 end as sat
	,case 
		when start_dow = 'Sun' and status_day_1 = 'C' then 'Y'
		when start_dow = 'Sat' and status_day_2 = 'C' then 'Y'
		when start_dow = 'Fri' and status_day_3 = 'C' then 'Y'
		when start_dow = 'Thu' and status_day_4 = 'C' then 'Y'
		when start_dow = 'Wed' and status_day_5 = 'C' then 'Y'
		when start_dow = 'Tue' and status_day_6 = 'C' then 'Y'
		when start_dow = 'Mon' and status_day_7 = 'C' then 'Y'
		else '' 
	 end as sun
	--,status_day_1,status_day_2, status_day_3, status_day_4,status_day_5, status_day_6, status_day_7
	,comments
from 
	( select 
		 v.full_Name as volunteer_name
		,v.ba_volunteer_num
		,ba.event_name
		,ba.event_id
		,convert( date, ba.start_date ) as start_date
		,format( ba.start_date, 'ddd' ) as start_dow
		,( case when ba.status_day_1 = '-' then 0 else 1 end +
		   case when ba.status_day_2 = '-' then 0 else 1 end +
		   case when ba.status_day_3 = '-' then 0 else 1 end +
		   case when ba.status_day_4 = '-' then 0 else 1 end +
		   case when ba.status_day_5 = '-' then 0 else 1 end +
		   case when ba.status_day_6 = '-' then 0 else 1 end +
		   case when ba.status_day_7 = '-' then 0 else 1 end ) as num_days
		,ba.status_day_1
		,ba.status_day_2
		,ba.status_day_3
		,ba.status_day_4
		,ba.status_day_5
		,ba.status_day_6
		,ba.status_day_7
		,ba.comments
	  from dbo.ba_event_volunteer_invite ba
	  inner join dbo.volunteer v
		on ba.person_guid = v.hub_person_guid
	  where 1=1
		and start_date >= 1 + dateadd( week, datediff( week, 0, getdate() ), -42 )	  
		--and (    start_date = 1 + dateadd( week, datediff( week, 0, getdate() ), -1 ) -- CURRENT WK
		--	  or start_date = 1 + dateadd( week, datediff( week, 0, getdate() ), -8 ) -- PRIOR WK
		--	  or start_date >= dateadd( week, datediff( week, 0, getdate() ), 7 ) 	  -- NEXT WK		  
		--	)
		and (
				 event_name like 'HPR - %'
			  or event_name like 'HPR – %' -- long dash				 
			  or event_name like 'HPR-%'			 
			  or event_name like 'Tuxedo %'
			  or event_name like 'Ramapo %'		  
			)
		--and active_flag = 'Y'
		and (
				 ba.status_day_1 = 'C'
			  or ba.status_day_2 = 'C'
			  or ba.status_day_3 = 'C'
			  or ba.status_day_4 = 'C'
			  or ba.status_day_5 = 'C'
			  or ba.status_day_6 = 'C'
			  or ba.status_day_7 = 'C'
			)	
	) x
go


if object_id('rpt.Cong_v', 'V') is not null
	drop view rpt.Cong_v
go 
create view rpt.Cong_v
as
select 
	 c.cong_key
	,c.cong_number
	,c.cong
	,c.cong_fullname
	,c.city
	,s.state_code
	,pc.postal_code
	,c.Country_Key
	,cntry.country_code
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
	,c.cobe_last_name + ', ' + c.cobe_first_name as cobe_full_name
	,c.cobe_email
	,c.cobe_mobile_phone
	,c.sec_volunteer_key
	,c.sec_person_id
	,c.sec_first_name
	,c.sec_last_name
	,c.sec_last_name + ', ' + c.sec_first_name as sec_full_name
	,c.sec_email
	,c.sec_mobile_phone
	,c.co_volunteer_key
	,c.co_person_id
	,c.co_first_name
	,c.co_last_name
	,c.co_last_name + ', ' + c.co_first_name as co_full_name
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


if object_id('rpt.CVC_v', 'V') is not null
	drop view rpt.CVC_v
go 
create view rpt.CVC_v
as
select 
	 da.cpc_code
	,da.level_02
	,da.level_03
	,da.level_04
	,da.full_dept_name
	,da.crew_name
	,da.dept_role
	,da.full_name as volunteer_name
	,c.cal_dt
	,coalesce( da.ps_start_date, da.dept_start_date ) as start_date
	,coalesce( da.ps_end_date, da.dept_end_date, '12/31/2027' ) as end_date
	,coalesce( da.ps_enrollment_code, da.dept_enrollment_code ) as enrollment_code
	,da.dept_asgn_status
	,case when coalesce( da.ps_enrollment_code, da.dept_enrollment_code ) in ( 'BBB', 'BBC', 'BBF', 'BBR', 'BCF', 'BCS', 'BCV' ) then 1 else 0 end as used_bed_cnt
	,da.dept_asgn_key
	,da.hpr_dept_key
	,enrollment_key
	,da.volunteer_key
from dbo.dept_asgn_v da
inner join dbo.cal_dim c
	on c.cal_dt between coalesce( da.ps_start_date, da.dept_start_date ) and coalesce( da.ps_end_date, da.dept_end_date, '12/31/2027' )
where 1=1
	and da.active_flag = 'Y'
	and da.test_data_flag = 'N'
go



if object_id('rpt.Dept_Crew_v', 'V') is not null
	drop view rpt.Dept_Crew_v
go 
create view rpt.Dept_Crew_v
as
select
	 d.hpr_dept_key
	,d.cpc_code
	,d.dept_name
	,d.work_group_name
	,c.crew_name
	,d.pc_code
	,d.pc_category
	,d.dept_ovsr
	,d.dept_ovsr_person_id
	,d.dept_ovsr_email
	,d.dept_asst_ovsr
	,d.dept_asst_ovsr_person_id
	,d.dept_asst_ovsr_email
	,d.work_group_ovsr
	,d.work_group_ovsr_person_id
	,d.work_group_ovsr_email
	,d.work_group_asst_ovsr
	,d.work_group_asst_ovsr_person_id
	,d.work_group_asst_ovsr_email
	,d.work_group_coor
	,d.work_group_coor_person_id
	,d.work_group_coor_email
	,c.crew_ovsr
	,c.crew_ovsr_person_id
	,c.crew_ovsr_email
	,d.vtc_contact
	,d.level_01
	,d.level_02
	,d.level_03
	,d.level_04
	,d.level_05
	,d.level_06
	,d.level_07
	,d.level_08
	,d.level_09
	,d.level_10
	,d.hub_flag
	,d.hub_dept_id
from dbo.hpr_dept d
left join dbo.hpr_crew c
	on d.hpr_dept_key = c.hpr_dept_key
	and c.active_flag = 'Y'
where 1=1
	and d.active_flag = 'Y' 
	and d.nyc_flag = 'N'
go


if object_id('rpt.Dept_v', 'V') is not null
	drop view rpt.Dept_v
go 
create view rpt.Dept_v
as
select 
	 hpr_dept_key
	,hub_dept_id
	,cpc_code
	,dept_name
	,work_group_name
	,pc_code
	,pc_category
	,dept_ovsr
	,dept_ovsr_person_id
	,dept_ovsr_email
	,dept_asst_ovsr
	,dept_asst_ovsr_person_id
	,dept_asst_ovsr_email
	,work_group_ovsr
	,work_group_ovsr_person_id
	,work_group_ovsr_email
	,work_group_asst_ovsr
	,work_group_asst_ovsr_person_id
	,work_group_asst_ovsr_email
	,work_group_coor
	,work_group_coor_person_id
	,work_group_coor_email	
	,vtc_contact
	,level_01
	,level_02
	,level_03
	,level_04
	,level_05
	,level_06
	,level_07
	,level_08
	,level_09
	,level_10	
	,active_flag
	,hub_flag
	,nyc_flag
	,case 
		when cpc_code = 'CO' then 1
		when cpc_code = 'DD' then 2
		when cpc_code = 'PCC' then 3
		when cpc_code = 'PS' then 4
		else 5
	 end as sort_order
from dbo.hpr_dept
where 1=1
	and active_flag = 'Y' 
	and nyc_flag = 'N'
go


if object_id('rpt.DC_52_v', 'V') is not null
	drop view rpt.DC_52_v
go 
create view rpt.DC_52_v
as
select 
	 volunteer_name
    ,hub_volunteer_num
    ,hub_person_id
    ,parent_dept_name
    ,dept_name
    ,enrollment_start_date
    ,enrollment_end_date
	-- FIND THE 2ND LOWEST LEVEL OVERSIGHT
	,case
		when work_group_asst_ovsr <> asst_name then work_group_asst_ovsr
		when work_group_ovsr <> asst_name then work_group_ovsr
		when dept_asst_ovsr <> asst_name then dept_asst_ovsr
		when dept_ovsr <> asst_name then dept_ovsr
	 end as ovsr_name
	,case
		when work_group_asst_ovsr <> asst_name then work_group_asst_ovsr_email
		when work_group_ovsr <> asst_name then work_group_ovsr_email
		when dept_asst_ovsr <> asst_name then dept_asst_ovsr_email
		when dept_ovsr <> asst_name then dept_ovsr_email
	 end as ovsr_email
	,asst_name
	,asst_email
from 
	( select 
		 volunteer_name
		,hub_volunteer_num
		,hub_person_id
		,v.parent_dept_name
		,v.dept_name
		,enrollment_start_date
		,'2999-12-31' as enrollment_end_date
		,d.dept_ovsr
		,d.dept_ovsr_email
		,d.dept_asst_ovsr
		,d.dept_asst_ovsr_email
		,d.work_group_ovsr
		,d.work_group_ovsr_email
		,d.work_group_asst_ovsr
		,d.work_group_asst_ovsr_email
		-- FIND THE LOWEST LEVEL OVERSIGHT
		,case 
			when /* crew_ovsr */ case when volunteer_key = 238580 then 'T. Bargeron' else null end is not null then /* crew_ovsr */ case when volunteer_key = 238580 then 'T. Bargeron' else null end 
			when work_group_asst_ovsr is not null then work_group_asst_ovsr
			when work_group_ovsr is not null then work_group_ovsr
			else 'x' 
		 end as asst_name
		,case 
			when /* crew_ovsr */ case when volunteer_key = 238580 then 'TBARGERON@bethel.jw.org' else null end is not null then /* crew_ovsr */ case when volunteer_key = 238580 then 'TBARGERON@bethel.jw.org' else null end 
			when work_group_asst_ovsr is not null then work_group_asst_ovsr_email
			when work_group_ovsr is not null then work_group_ovsr_email
			else 'x' 
		 end as asst_email
	  from rpt.volunteer_v v
	  inner join rpt.dept_v d
		on v.parent_dept_name = d.dept_name
		and v.dept_name = d.work_group_name
	  where volunteer_key in ( 238580, 623854, 488760 ) ) core
go


if object_id('rpt.Enrollment_v', 'V') is not null
	drop view rpt.Enrollment_v
go 
create view rpt.Enrollment_v
as
select 
	 enrollment_key
	,enrollment_code
	,enrollment
	,enrollment_desc
	,primary_flag
	,fts_flag
	,sfts_flag
	,bethel_flag
	,bethel_family_flag
	,regular_bethel_flag
	,foreign_service_flag
	,transition_flag
from dbo.enrollment
where 1=1
	and active_flag = 'Y'
go	


if object_id('rpt.PCC_Project_Volunteer_v', 'V') is not null
	drop view rpt.PCC_Project_Volunteer_v
go 
create view rpt.PCC_Project_Volunteer_v
as
select 
	 volunteer_name
	,hub_volunteer_num
	,bethel_email
	,enrollment_1_site_code
	,enrollment_1_code
	,enrollment_1_start_date
	,enrollment_2_site_code
	,enrollment_2_code
	,enrollment_2_start_date
	,dept_1_parent_dept_name
	,dept_1_dept_name
	,dept_1_ovsr_name
	,dept_1_temp_flag
	,dept_1_primary_flag
	,dept_1_split_allocation_pct
	,dept_1_start_date
	,dept_1_end_date
	,dept_2_parent_dept_name
	,dept_2_dept_name
	,dept_2_ovsr_name
	,dept_2_temp_flag
	,dept_2_primary_flag
	,dept_2_split_allocation_pct
	,dept_2_start_date
	,dept_2_end_date
	,room
	,hpr_flag
	,work_days
	,volunteer_key
	,m.attribute_value as refresh_date
from rpt.volunteer_all_v
full join dbo.app_metadata m
	on m.attribute_name = 'HUB_Update_Date'
where 1=1
	and enrollment_1_start_date <= dateadd( d, 6, dateadd( week, datediff( week, 0, getdate() ), 7 ) ) -- FUTURE JUST UPCOMING WEEK
go


if object_id('rpt.PRP_v', 'V') is not null
	drop view rpt.PRP_v
go 
create view rpt.PRP_v
as
select 
	 row_number() over ( order by c.cal_dt ) as prp_key
	,p.hpr_dept_key
	,c.cal_dt
	,p.bed_cnt
	,p.cpc_code
	,p.hub_dept_name
	,p.dept_name
	,p.work_group_name
	,p.pc_category
	,p.pc_code
	,p.prp_cnt
	,p.load_date
from dbo.PRP p
inner join dbo.cal_dim c
	on p.cal_dt = c.mth_start_dt
	and c.cal_dt = c.wk_start_dt
go


if object_id('rpt.PRP_Bed_Space_v', 'V') is not null
	drop view rpt.PRP_Bed_Space_v
go 
create view rpt.PRP_Bed_Space_v
as
select 
	 row_number() over ( order by c.cal_dt ) as prp_bed_space_key
	,c.cal_dt
	,p.rooming_category
	,p.rooming_detail
	,p.reporting_category
	,p.bed_cnt
	,p.load_date
from dbo.PRP_Bed_Space p
inner join dbo.cal_dim c
	on p.cal_dt = c.mth_start_dt
	and c.cal_dt = c.wk_start_dt
go
	

if object_id('rpt.User_Permissions_v', 'V') is not null
	drop view rpt.User_Permissions_v
go 
create view rpt.User_Permissions_v
as	
select 
	 last_name
	,first_name
	,ad_user_name
	,case
		when admin_flag = 'Y' then 'USA-HPR-APPRVDAdministrator'
		when user_access_level_code = 5 then 'USA-HPR-APPRVDUsers'
		when user_access_level_code = 25 then 'USA-HPR-APPRVDUsersBasic'
		else 'Unknown'
	 end as ad_group
from dbo.[User]
where 1=1
	and active_flag = 'Y'
	and user_key <> 1
go



if object_id('rpt.Volunteer_v', 'V') is not null
	drop view rpt.Volunteer_v
go 
create view rpt.Volunteer_v
as
select 
	 volunteer_key
 	,hub_volunteer_num
 	,hub_person_id
 	,hub_person_guid
	,cast( ba_volunteer_num as varchar(10) ) as ba_volunteer_num
	,first_name
	,last_name
	,volunteer_name
	,gender_code
	,marital_status_code
	,age
	,address
	,city
	,state_code
	,postal_code
	,home_phone
	,mobile_phone	
	,coalesce( enrollment_site_code, 'UNK' ) as enrollment_site_code
	,enrollment_code
	,case when enrollment_start_date < dept_start_date then enrollment_start_date else dept_start_date end as enrollment_start_date
	,enrollment_start_date as enrollment_start_date_raw
	,enrollment_end_date
	,hub_dept_id
	,case 
		when parent_dept_name like '%Committee' then dept_name
		else parent_dept_name
	 end as parent_dept_name
	,parent_dept_code
	,dept_name
	,temp_parent_dept_name + ' > ' + temp_dept_name as loan_dept_name
	,non_hpr_parent_dept_name
	,non_hpr_dept_name
	,dept_start_date
	,dept_end_date
	,pc_category
	,bethel_email
	,jwpub_email
	,personal_email	
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email	
	,primary_flag
	,temp_flag
	,split_asgn_flag
	,mon_flag
	,tue_flag
	,wed_flag
	,thu_flag
	,fri_flag
	,sat_flag
	,sun_flag
	,room_site_code
	,room_bldg
	,room_bldg_code
	,room
	,staffing_number_exception_flag
from (  
	-- CORE 
	select distinct 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code	
		,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,v.address
		,v.city
		,s.state_code
		,pc.Postal_Code
		,v.home_phone		
		,v.mobile_phone
		,v.HUB_Volunteer_Num
		,ve.Site_Code as enrollment_site_code
		,e.Enrollment_Code as enrollment_code
		,ve.Start_Date as enrollment_start_date
		,ve.end_date as enrollment_end_date
		,vd.hub_dept_id
		,vd.Parent_Dept_Name as parent_dept_name
		,d.cpc_code as parent_dept_code
		,vd.Dept_Name as dept_name
		,tmp.Parent_Dept_Name as temp_parent_dept_name
		,tmp.Dept_Name as temp_dept_name
		,non_hpr.parent_dept_name as non_hpr_parent_dept_name
		,non_hpr.dept_name as non_hpr_dept_name
		,v.alt_Email as bethel_email
		,v.jw_username + '@jwpub.org' as jwpub_email
		,v.Email as personal_email		
		,vd.Start_Date as dept_start_date
		,vd.end_date as dept_end_date
		,vd.Primary_Flag as primary_flag
		,vd.Temp_Flag as temp_flag		
		,case when vd.Primary_Flag = 'N' then 'Y' else 'N' end as split_asgn_flag
		,case when ( vd.Mon_AM_Flag = 'Y' or vd.Mon_PM_Flag = 'Y' ) then 'Y' else 'N' end as mon_flag
		,case when ( vd.tue_AM_Flag = 'Y' or vd.tue_PM_Flag = 'Y' ) then 'Y' else 'N' end as tue_flag
		,case when ( vd.wed_AM_Flag = 'Y' or vd.wed_PM_Flag = 'Y' ) then 'Y' else 'N' end as wed_flag
		,case when ( vd.thu_AM_Flag = 'Y' or vd.thu_PM_Flag = 'Y' ) then 'Y' else 'N' end as thu_flag
		,case when ( vd.fri_AM_Flag = 'Y' or vd.fri_PM_Flag = 'Y' ) then 'Y' else 'N' end as fri_flag
		,case when ( vd.sat_AM_Flag = 'Y' or vd.sat_PM_Flag = 'Y' ) then 'Y' else 'N' end as sat_flag
		,case when ( vd.sun_AM_Flag = 'Y' or vd.sun_PM_Flag = 'Y' ) then 'Y' else 'N' end as sun_flag
		,d.PC_Category as pc_category
		,v.volunteer_key
		,v.HUB_Person_ID
		,v.ba_volunteer_num
		,v.hub_person_guid
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
		,nullif( v.Room_Site_Code, '' ) as room_site_code
		,nullif( v.Room_Bldg, '' ) as room_bldg
		,nullif( v.Room_Bldg_Code, '' ) as room_bldg_code
		,nullif( v.Room, '' ) as room
		,v.Staffing_Number_Exception_Flag
	from dbo.volunteer v
	inner join dbo.marital_status ms 
		on v.marital_status_key = ms.marital_status_key	
	inner join dbo.state s
		on v.State_Key = s.State_Key
	inner join dbo.Postal_Code pc
		on v.Postal_Code_Key = pc.Postal_Code_Key
	inner join dbo.volunteer_enrollment ve
		on v.volunteer_key = ve.Volunteer_Key
		and ( ve.active_flag = 'Y' or ve.start_Date > getdate() )
		--and ve.Geo_Name = 'USA'
	inner join dbo.enrollment e
		on ve.Enrollment_Key = e.Enrollment_Key
		and ( e.Bethel_Flag = 'Y'
			or e.enrollment_code in ( 'BCC', 'BCF', 'BCL', 'BCS', 'BCV', 'BOC', 'BBO' ) )
	inner join dbo.volunteer_dept vd
		on v.volunteer_key = vd.Volunteer_Key
		--and vd.active_flag = 'Y'
		and ( vd.active_flag = 'Y' or vd.start_date > cast( getdate() as date ) )
		--and vd.Parent_Dept_Name like 'HPR%'
		--and vd.Enrollment_Code = e.Enrollment_Code   -- REMOVING FOR NOW, NEED TO RE-EVALUATE
	inner join dbo.HPR_Dept d
		on vd.hub_dept_id = d.hub_dept_id
		and d.Active_Flag = 'Y'
		and d.cpc_code in ( 'CO', 'DD', 'PCC', 'CI', 'PS' )
	inner join ( select volunteer_key, count(*) as cnt from dbo.volunteer_dept 
				 where hub_dept_id in ( select hub_dept_id from dbo.HPR_Dept where active_flag = 'Y' ) and ( end_date is null or end_date > getdate() ) group by volunteer_key ) multi
		on v.volunteer_key = multi.volunteer_key
		and 'Y' = case when multi.cnt = 1 then 'Y' else vd.primary_flag end
	left join dbo.volunteer_dept tmp
		on v.volunteer_key = tmp.Volunteer_Key
		and tmp.active_flag = 'Y'
		and tmp.Enrollment_Code = e.Enrollment_Code
		and tmp.Temp_Flag = 'Y'
	left join dbo.volunteer mate
		on v.mate_hub_person_id = mate.hub_person_id
	left join dbo.volunteer_dept non_hpr
		on v.volunteer_key = non_hpr.volunteer_key
		and non_hpr.start_date <= getdate()		
		and ( non_hpr.end_date is null or non_hpr.end_date > getdate() )
		--and non_hpr.Primary_Flag = 'Y'
		and non_hpr.hub_dept_id not in ( select hub_dept_id from dbo.HPR_Dept where active_flag = 'Y' and hub_dept_id is not null )			
	where 1=1
 
	union all

	-- EXCEPTIONS
	select distinct 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code	
		,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,v.address
		,v.city
		,s.state_code
		,pc.Postal_Code
		,v.home_phone
		,v.mobile_phone		
		,v.HUB_Volunteer_Num
		,ve.Site_Code as enrollment_site_code
		,e.Enrollment_Code as enrollment_code
		,ve.Start_Date as enrollment_start_date
		,ve.end_date as enrollment_end_date
		,vd.hub_dept_id
		,vd.Parent_Dept_Name as parent_dept_name
		,'EXT' as parent_dept_code
		,vd.Dept_Name as dept_name
		,null as temp_parent_dept_name
		,null as temp_dept_name
		,null as non_hpr_parent_dept_name
		,null as non_hpr_dept_name
		,v.alt_Email as bethel_email
		,v.jw_username + '@jwpub.org' as jwpub_email
		,v.Email as personal_email	
		,vd.Start_Date as dept_start_date
		,vd.end_date as dept_end_date		
		,vd.Primary_Flag as primary_flag
		,vd.Temp_Flag as temp_flag		
		,case when vd.Primary_Flag = 'N' then 'Y' else 'N' end as split_asgn_flag
		,case when ( vd.Mon_AM_Flag = 'Y' or vd.Mon_PM_Flag = 'Y' ) then 'Y' else 'N' end as mon_flag
		,case when ( vd.tue_AM_Flag = 'Y' or vd.tue_PM_Flag = 'Y' ) then 'Y' else 'N' end as tue_flag
		,case when ( vd.wed_AM_Flag = 'Y' or vd.wed_PM_Flag = 'Y' ) then 'Y' else 'N' end as wed_flag
		,case when ( vd.thu_AM_Flag = 'Y' or vd.thu_PM_Flag = 'Y' ) then 'Y' else 'N' end as thu_flag
		,case when ( vd.fri_AM_Flag = 'Y' or vd.fri_PM_Flag = 'Y' ) then 'Y' else 'N' end as fri_flag
		,case when ( vd.sat_AM_Flag = 'Y' or vd.sat_PM_Flag = 'Y' ) then 'Y' else 'N' end as sat_flag
		,case when ( vd.sun_AM_Flag = 'Y' or vd.sun_PM_Flag = 'Y' ) then 'Y' else 'N' end as sun_flag
		,'Support' as pc_category
		,v.volunteer_key
		,v.HUB_Person_ID
		,v.ba_volunteer_num
		,v.hub_person_guid
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
		,nullif( v.Room_Site_Code, '' ) as room_site_code
		,nullif( v.Room_Bldg, '' ) as room_bldg
		,nullif( v.Room_Bldg_Code, '' ) as room_bldg_code
		,nullif( v.Room, '' ) as room
		,v.Staffing_Number_Exception_Flag
	from dbo.volunteer v
	inner join dbo.marital_status ms 
		on v.marital_status_key = ms.marital_status_key
	inner join dbo.state s
		on v.State_Key = s.State_Key
	inner join dbo.Postal_Code pc
		on v.Postal_Code_Key = pc.Postal_Code_Key
	inner join dbo.volunteer_enrollment ve
		on v.volunteer_key = ve.Volunteer_Key
		and ve.active_flag = 'Y'
	   and ve.Geo_Name = 'USA'
	inner join dbo.enrollment e
		on ve.Enrollment_Key = e.Enrollment_Key
		and ( e.Bethel_Flag = 'Y'
			or e.enrollment_code in ( 'BCC', 'BCF', 'BCL', 'BCS', 'BCV', 'BOC', 'BBO' ) )
	inner join dbo.volunteer_dept vd
		on v.volunteer_key = vd.Volunteer_Key
		and vd.active_flag = 'Y'
		and vd.Enrollment_Code = e.Enrollment_Code
	inner join ( select volunteer_key, count(*) as cnt from dbo.volunteer_dept where  (end_date is null or end_date > getdate()) group by volunteer_key ) multi
		on v.volunteer_key = multi.volunteer_key
		and 'Y' = case when multi.cnt = 1 then 'Y' else vd.primary_flag end
	left join dbo.volunteer mate
		on v.mate_hub_person_id = mate.hub_person_id
	where v.hpr_volunteer_exception_flag = 'Y'

--	union all

--	-- NON-US BRANCH VOLUNTEERS
--	select 
--		 fb.last_name + ', ' + fb.first_name
--		,fb.first_name
--		,fb.last_name
--		,fb.gender
--		,fb.marital_status
--		,cast( round( ( datediff( day, fb.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
--		,'' as address
--		,'' as city
--		,'' as state_code
--		,'' as postal_code
--		,'' as home_phone
--		,'' as mobile_phone
--		,fb.volunteer_number as hub_volunteer_num
--		,fb.department_site
--		,fb.enrollment_code
--		,fb.enrollment_start_date
--		,fb.enrollment_end_date
--		,fb.hub_dept_id
--		,d.dept_name
--		,d.cpc_code as parent_department_code
--		,d.work_group_name
--		,null as temp_parent_dept_name
--		,null as temp_dept_name
--		,null as non_hpr_parent_dept_name
--		,null as non_hpr_dept_name		
--		,fb.internal_email
--		,'' as jwbpub
--		,'' as personal
--		,fb.department_start_date
--		,null as department_end_date
--		,'Y' as primary_flag
--		,'N' as temp_flag
--		,'N' as split
--		,'Y' as mon_flag
--		,'Y' as tue_flag
--		,'Y' as wed_flag
--		,'Y' as thu_flag
--		,'Y' as fri_flag
--		,'N' as sat_flag
--		,'N' as sun_flag
--		,d.PC_Category
--		,fb.volunteer_number * -1 as volunteer_key  -- ARTIFICIAL VOL KEY
--		,fb.person_id
--		,null as ba_volunteer_num
--		,null as hub_person_guid
--		,mate.hub_volunteer_num as spouse_hub_volunteer_num
--		,'' as spouse_bethel_email
--		,'' as spouse_jwpub_email
--		,null as Room_Site_Code
--		,null as Room_Bldg
--		,null as Room_Bldg_Code
--		,null as Room		
--	from stg.stg_foreign_branches fb
--	inner join dbo.HPR_Dept d
--		on fb.hub_dept_id = d.hub_dept_id
--	left join dbo.volunteer mate
--		on fb.spouse_person_id = mate.hub_person_id 
) core
go


if object_id('rpt.Volunteer_All_v', 'V') is not null
	drop view rpt.Volunteer_All_v
go 
create view rpt.volunteer_all_v
as
select 
	 volunteer_name
	,hub_volunteer_num
	,gender_code
	,marital_status_code
	,coalesce( cong_servant_code, '' ) as cong_servant_code
	,age	
	,enrollment_1_site_code
	,enrollment_1_code
	,enrollment_1_start_date
	,coalesce( enrollment_2_site_code, '' ) as enrollment_2_site_code
	,coalesce( enrollment_2_code, '' ) as enrollment_2_code
	,coalesce( convert( varchar, enrollment_2_start_date, 23 ), '' ) as enrollment_2_start_date
	,case 
		when dept_1_parent_dept_name like '%Committee' then dept_1_dept_name
		else dept_1_parent_dept_name
	 end as dept_1_parent_dept_name
	,dept_1_dept_name
	,dept_1_ovsr_name
	,dept_1_temp_flag
	,dept_1_primary_flag
	,coalesce( dept_1_split_allocation_pct, '' ) as dept_1_split_allocation_pct
	,dept_1_start_date
	,coalesce( convert( varchar, dept_1_end_date, 23 ), '' ) as dept_1_end_date
	,coalesce( dept_2_parent_dept_name, '' ) as dept_2_parent_dept_name
	,coalesce( dept_2_dept_name, '' ) as dept_2_dept_name
	,coalesce( dept_2_ovsr_name, '' ) as dept_2_ovsr_name
	,coalesce( dept_2_temp_flag, '' ) as dept_2_temp_flag
	,coalesce( dept_2_primary_flag, '' ) as dept_2_primary_flag
	,coalesce( dept_2_split_allocation_pct, '' ) as dept_2_split_allocation_pct
	,coalesce( convert( varchar, dept_2_start_date, 23 ), '' ) as dept_2_start_date
	,coalesce( convert( varchar, dept_2_end_date, 23 ), '' ) as dept_2_end_date
	,tentative_end_date
	,coalesce( room, '' ) as room
	,coalesce( bethel_email, '' ) as bethel_email
	,hpr_flag
	,case
		when work_days <> 5 and enrollment_1_code in ( 'BBB', 'BBC', 'BCV' ) then 5
		else work_days
	 end as work_days
	,volunteer_key
from (
	select
		 volunteer_name
		,hub_volunteer_num
		,gender_code
		,marital_status_code
		,cong_servant_code
		,age
		,enrollment_1_site_code
		,enrollment_1_code
		,enrollment_1_start_date
		,enrollment_2_site_code
		,enrollment_2_code
		,enrollment_2_start_date
		,dept_1_parent_dept_name
		,dept_1_dept_name
		,dept_1_ovsr_name
		,dept_1_temp_flag
		,dept_1_primary_flag
		,dept_1_split_allocation_pct
		,dept_1_start_date
		,dept_1_end_date
		,dept_2_parent_dept_name
		,dept_2_dept_name
		,dept_2_ovsr_name
		,dept_2_temp_flag
		,dept_2_primary_flag
		,dept_2_split_allocation_pct
		,dept_2_start_date
		,dept_2_end_date
		,tentative_end_date
		,room
		,bethel_email
		,'Y' as hpr_flag
		,( case when dept_1_mon_flag = 'Y' then 1 else 0 end ) + 
		 ( case when dept_1_tue_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_wed_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_thu_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_fri_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_sat_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_sun_flag = 'Y' then 1 else 0 end  ) as work_days	 
		,volunteer_key
	from rpt.volunteer_rpt_v
	where 1=1

	union all

	select 
		 v.full_name as volunteer_name
		,v.hub_volunteer_num
		,v.gender_code
		,ms.marital_status_code
		,v.cong_servant_code
		,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,ve1.enrollment_site_code as enrollment_1_site_code
		,ve1.Enrollment_Code as enrollment_1_code
		,ve1.Start_Date as enrollment_1_start_date
		,ve2.enrollment_site_code as enrollment_2_site_code
		,ve2.Enrollment_Code as enrollment_2_code
		,ve2.Start_Date as enrollment_2_start_date
		,vd1.Parent_Dept_Name as dept_1_parent_dept_name
		,vd1.Dept_Name as dept_1_dept_name
		,'' as dept_1_ovsr_name
		,vd1.temp_flag as dept_1_temp_flag
		,vd1.primary_flag as dept_1_primary_flag
		,vd1.split_allocation_pct as dept_1_split_allocation_pct
		,vd1.start_date as dept_1_start_date
		,vd1.end_date as dept_1_end_date
		,vd2.Parent_Dept_Name as dept_2_parent_dept_name
		,vd2.Dept_Name as dept_2_dept_name
		,'' as dept_1_ovsr_name		
		,vd2.temp_flag as dept_2_temp_flag
		,vd2.primary_flag as dept_2_primary_flag
		,vd2.split_allocation_pct as dept_2_split_allocation_pct
		,vd2.start_date as dept_2_start_date
		,vd2.end_date as dept_2_end_date
		,v.tentative_end_date
		,v.room
		,v.alt_Email as bethel_email
		,'N' as hpr_flag
		,5 as work_days
		,v.volunteer_key
	from dbo.volunteer v
	inner join dbo.marital_status ms 
		on v.marital_status_key = ms.marital_status_key	
	inner join dbo.volunteer_enrollment_rpt ve1
		on v.volunteer_key = ve1.volunteer_key
		and ve1.row_num = 1
	left join dbo.volunteer_enrollment_rpt ve2
		on v.volunteer_key = ve2.volunteer_key
		and ve2.row_num = 2
	inner join dbo.volunteer_dept_rpt vd1
		on v.volunteer_key = vd1.volunteer_key
		and vd1.Row_Num = 1
	left join dbo.volunteer_dept_rpt vd2
		on v.volunteer_key = vd2.volunteer_key
		and vd2.Row_Num = 2
	where 1=1
		and v.room_site_code = 'RMP'
		and v.volunteer_key not in ( select volunteer_key from rpt.volunteer_rpt_v )
		
--	union all
	
--	select 
--		 r.volunteer_name
--		,r.volunteer_number as hub_volunteer_num
--		,r.room_site_code as enrollment_1_site_code
--		,v.current_enrollment_code as enrollment_1_code
--		,null as enrollment_1_start_date
--		,null as enrollment_2_site_code
--		,null as enrollment_2_code
--		,null as enrollment_2_start_date
--		,r.Guest_Info + ' - Woodgrove Rooming' as dept_1_parent_dept_name
--		,null as dept_1_dept_name
--		,'' as dept_1_ovsr_name
--		,null as dept_1_temp_flag
--		,null as dept_1_primary_flag
--		,r.First_Night as dept_1_start_date
--		,r.Last_Night as dept_1_end_date
--		,null as dept_2_parent_dept_name
--		,null as dept_2_dept_name
--		,'' as dept_2_ovsr_name
--		,null as dept_2_temp_flag
--		,null as dept_2_primary_flag
--		,null as dept_2_start_date
--		,null as dept_2_end_date
--		,r.room_number as room
--		,v.alt_email as bethel_email
--		,'N' as hpr_flag
--		,5 as work_days		
--		,v.volunteer_key
--	from stg.stg_rooming r
--	left join dbo.volunteer_v v
--		on r.person_id = v.hub_person_id
--	where 1=1
--		and r.type = 'WoodgroveGuestRooming'
--		and not exists ( select 1 from stg.stg_rooming r2 where r2.type = 'Rooming' and r.person_id = r2.person_id )	
	) core
go


if object_id('rpt.Volunteer_Rpt_v', 'V') is not null
	drop view rpt.Volunteer_Rpt_v
go 
create view rpt.Volunteer_Rpt_v
as
select 
	 volunteer_key
 	,hub_volunteer_num
 	,hub_person_id
 	,hub_person_guid
	,cast( ba_volunteer_num as varchar(10) ) as ba_volunteer_num
	,first_name
	,last_name
	,volunteer_name
	,gender_code
	,marital_status_code
	,cong_servant_code
	,age
	,address
	,city
	,state_code
	,postal_code
	,home_phone
	,mobile_phone
	,bethel_email
	,jwpub_email
	,personal_email	
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email		
	,enrollment_1_code
	,coalesce( enrollment_1_site_code, 'UNK' ) as enrollment_1_site_code
	,enrollment_1_start_date
	,enrollment_1_end_date
	,enrollment_2_code
	,enrollment_2_site_code
	,enrollment_2_start_date
	,enrollment_2_end_date
	,dept_1_hub_dept_id
	,dept_1_cpc_code
	,dept_1_parent_dept_name
	,dept_1_dept_name
	,dept_1_ovsr_name
	,dept_1_start_date
	,dept_1_end_date
	,dept_1_temp_flag
	,dept_1_primary_flag
	,dept_1_split_allocation_pct
	,dept_1_hpr_flag
	,dept_1_pc_category
	,dept_1_mon_flag
	,dept_1_tue_flag
	,dept_1_wed_flag
	,dept_1_thu_flag
	,dept_1_fri_flag
	,dept_1_sat_flag
	,dept_1_sun_flag
	,dept_2_hub_dept_id
	,dept_2_cpc_code
	,dept_2_parent_dept_name
	,dept_2_dept_name
	,dept_2_ovsr_name
	,dept_2_start_date
	,dept_2_end_date
	,dept_2_temp_flag
	,dept_2_primary_flag
	,dept_2_split_allocation_pct
	,dept_2_hpr_flag
	,dept_2_pc_category
	,dept_2_mon_flag
	,dept_2_tue_flag
	,dept_2_wed_flag
	,dept_2_thu_flag
	,dept_2_fri_flag
	,dept_2_sat_flag
	,dept_2_sun_flag
	,tentative_end_date
	,room_site_code
	,room_bldg
	,room_bldg_code
	,room
	,staffing_number_exception_flag
from (  
	-- CORE 
	select  
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code
		,v.cong_servant_code
		,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,v.address
		,v.city
		,s.state_code
		,pc.Postal_Code
		,v.home_phone		
		,v.mobile_phone
		,v.HUB_Volunteer_Num
		,ve1.enrollment_site_code as enrollment_1_site_code
		,ve1.Enrollment_Code as enrollment_1_code
		,ve1.Start_Date as enrollment_1_start_date
		,ve1.end_date as enrollment_1_end_date
		,ve2.enrollment_site_code as enrollment_2_site_code
		,ve2.Enrollment_Code as enrollment_2_code
		,ve2.Start_Date as enrollment_2_start_date
		,ve2.end_date as enrollment_2_end_date
		,vd1.hub_dept_id as dept_1_hub_dept_id
		,d1.cpc_code as dept_1_cpc_code
		,vd1.Parent_Dept_Name as dept_1_parent_dept_name
		,vd1.Dept_Name as dept_1_dept_name
		,coalesce( d1.work_group_ovsr, d1.dept_ovsr ) as dept_1_ovsr_name		
		,vd1.start_date as dept_1_start_date
		,vd1.end_date as dept_1_end_date
		,vd1.temp_flag as dept_1_temp_flag
		,vd1.primary_flag as dept_1_primary_flag
		,vd1.split_allocation_pct as dept_1_split_allocation_pct
		,vd1.hpr_flag as dept_1_hpr_flag
		,d1.PC_Category as dept_1_pc_category
		,vd1.mon_flag as dept_1_mon_flag
		,vd1.tue_flag as dept_1_tue_flag
		,vd1.wed_flag as dept_1_wed_flag
		,vd1.thu_flag as dept_1_thu_flag
		,vd1.fri_flag as dept_1_fri_flag
		,vd1.sat_flag as dept_1_sat_flag
		,vd1.sun_flag as dept_1_sun_flag
		,vd2.hub_dept_id as dept_2_hub_dept_id
		,d2.cpc_code as dept_2_cpc_code
		,vd2.Parent_Dept_Name as dept_2_parent_dept_name
		,vd2.Dept_Name as dept_2_dept_name
		,coalesce( d2.work_group_ovsr, d2.dept_ovsr ) as dept_2_ovsr_name		
		,vd2.start_date as dept_2_start_date
		,vd2.end_date as dept_2_end_date
		,vd2.temp_flag as dept_2_temp_flag
		,vd2.primary_flag as dept_2_primary_flag
		,vd2.split_allocation_pct as dept_2_split_allocation_pct
		,vd2.hpr_flag as dept_2_hpr_flag
		,d2.PC_Category as dept_2_pc_category
		,vd2.mon_flag as dept_2_mon_flag
		,vd2.tue_flag as dept_2_tue_flag
		,vd2.wed_flag as dept_2_wed_flag
		,vd2.thu_flag as dept_2_thu_flag
		,vd2.fri_flag as dept_2_fri_flag
		,vd2.sat_flag as dept_2_sat_flag
		,vd2.sun_flag as dept_2_sun_flag
		,v.tentative_end_date
		,v.alt_Email as bethel_email
		,v.jw_username + '@jwpub.org' as jwpub_email
		,v.Email as personal_email
		,v.volunteer_key
		,v.HUB_Person_ID
		,v.ba_volunteer_num
		,v.hub_person_guid
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
		,nullif( v.Room_Site_Code, '' ) as room_site_code
		,nullif( v.Room_Bldg, '' ) as room_bldg
		,nullif( v.Room_Bldg_Code, '' ) as room_bldg_code
		,nullif( v.Room, '' ) as room
		,v.staffing_number_exception_flag
	from dbo.volunteer v
	inner join dbo.marital_status ms 
		on v.marital_status_key = ms.marital_status_key	
	inner join dbo.state s
		on v.State_Key = s.State_Key
	inner join dbo.Postal_Code pc
		on v.Postal_Code_Key = pc.Postal_Code_Key
	inner join ( select volunteer_key from dbo.volunteer_dept_rpt where hpr_flag = 'Y' group by volunteer_key ) hpr_vol
		on v.volunteer_key = hpr_vol.volunteer_key
	inner join dbo.volunteer_enrollment_rpt ve1
		on v.volunteer_key = ve1.volunteer_key
		and ve1.row_num = 1
	left join dbo.volunteer_enrollment_rpt ve2
		on v.volunteer_key = ve2.volunteer_key
		and ve2.row_num = 2
	inner join dbo.volunteer_dept_rpt vd1
		on v.volunteer_key = vd1.volunteer_key
		and vd1.Row_Num = ( select min( row_num ) from dbo.volunteer_dept_rpt x1 where x1.volunteer_key = vd1.volunteer_Key )
	left join dbo.HPR_Dept d1
		on vd1.hub_dept_id = d1.hub_dept_id
		and d1.Active_Flag = 'Y'
	left join dbo.volunteer_dept_rpt vd2  -- GET 2ND DEPT, IF EXISTS
		on v.volunteer_key = vd2.volunteer_key
		and vd2.row_num = ( select max( row_num ) from dbo.volunteer_dept_rpt x2 where x2.volunteer_key = vd2.volunteer_key )
		and vd2.volunteer_key in ( select volunteer_key from dbo.volunteer_dept_rpt group by volunteer_key having count(*) > 1 )
	left join dbo.HPR_Dept d2
		on vd2.hub_dept_id = d2.hub_dept_id
		and d2.Active_Flag = 'Y'
	left join dbo.volunteer mate
		on v.mate_hub_person_id = mate.hub_person_id
	where 1=1
		and v.hpr_volunteer_exception_flag = 'N'
		--and v.volunteer_key = 749028

	union all

	-- EXCEPTIONS
	select 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code
		,v.cong_servant_code
		,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,v.address
		,v.city
		,s.state_code
		,pc.Postal_Code
		,v.home_phone
		,v.mobile_phone		
		,v.HUB_Volunteer_Num
		,ve1.enrollment_site_code as enrollment_1_site_code
		,ve1.Enrollment_Code as enrollment_1_code
		,ve1.Start_Date as enrollment_1_start_date
		,ve1.end_date as enrollment_1_end_date
		,ve2.enrollment_site_code as enrollment_2_site_code
		,ve2.Enrollment_Code as enrollment_2_code
		,ve2.Start_Date as enrollment_2_start_date
		,ve2.end_date as enrollment_2_end_date
		,vd1.hub_dept_id as dept_1_hub_dept_id
		,d1.cpc_code as dept_1_cpc_code
		,vd1.Parent_Dept_Name as dept_1_parent_dept_name
		,vd1.Dept_Name as dept_1_dept_name
		,coalesce( d1.work_group_ovsr, d1.dept_ovsr ) as dept_1_ovsr_name		
		,vd1.start_date as dept_1_start_date
		,vd1.end_date as dept_1_end_date
		,vd1.temp_flag as dept_1_temp_flag
		,vd1.primary_flag as dept_1_primary_flag
		,vd1.split_allocation_pct as dept_1_split_allocation_pct
		,vd1.hpr_flag as dept_1_hpr_flag
		,d1.PC_Category as dept_1_pc_category
		,vd1.mon_flag as dept_1_mon_flag
		,vd1.tue_flag as dept_1_tue_flag
		,vd1.wed_flag as dept_1_wed_flag
		,vd1.thu_flag as dept_1_thu_flag
		,vd1.fri_flag as dept_1_fri_flag
		,vd1.sat_flag as dept_1_sat_flag
		,vd1.sun_flag as dept_1_sun_flag
		,vd2.hub_dept_id as dept_2_hub_dept_id
		,d2.cpc_code as dept_2_cpc_code
		,vd2.Parent_Dept_Name as dept_2_parent_dept_name
		,vd2.Dept_Name as dept_2_dept_name
		,coalesce( d2.work_group_ovsr, d2.dept_ovsr ) as dept_2_ovsr_name		
		,vd2.start_date as dept_2_start_date
		,vd2.end_date as dept_2_end_date
		,vd2.temp_flag as dept_2_temp_flag
		,vd2.primary_flag as dept_2_primary_flag
		,vd2.split_allocation_pct as dept_2_split_allocation_pct
		,vd2.hpr_flag as dept_2_hpr_flag
		,d2.PC_Category as dept_2_pc_category
		,vd2.mon_flag as dept_2_mon_flag
		,vd2.tue_flag as dept_2_tue_flag
		,vd2.wed_flag as dept_2_wed_flag
		,vd2.thu_flag as dept_2_thu_flag
		,vd2.fri_flag as dept_2_fri_flag
		,vd2.sat_flag as dept_2_sat_flag
		,vd2.sun_flag as dept_2_sun_flag
		,v.tentative_end_date		
		,v.alt_Email as bethel_email
		,v.jw_username + '@jwpub.org' as jwpub_email
		,v.Email as personal_email	
		,v.volunteer_key
		,v.HUB_Person_ID
		,v.ba_volunteer_num
		,v.hub_person_guid
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
		,nullif( v.Room_Site_Code, '' ) as room_site_code
		,nullif( v.Room_Bldg, '' ) as room_bldg
		,nullif( v.Room_Bldg_Code, '' ) as room_bldg_code
		,nullif( v.Room, '' ) as room
		,v.staffing_number_exception_flag
	from dbo.volunteer v
	inner join dbo.marital_status ms 
		on v.marital_status_key = ms.marital_status_key
	inner join dbo.state s
		on v.State_Key = s.State_Key
	inner join dbo.Postal_Code pc
		on v.Postal_Code_Key = pc.Postal_Code_Key
	inner join dbo.volunteer_enrollment_rpt ve1
		on v.volunteer_key = ve1.volunteer_key
		and ve1.row_num = 1
	left join dbo.volunteer_enrollment_rpt ve2
		on v.volunteer_key = ve2.volunteer_key
		and ve2.row_num = 2
	inner join dbo.volunteer_dept_rpt vd1
		on v.volunteer_key = vd1.volunteer_key
		and vd1.Row_Num = ( select min( row_num ) from dbo.volunteer_dept_rpt x1 where x1.volunteer_key = vd1.volunteer_Key )
	left join dbo.HPR_Dept d1
		on vd1.hub_dept_id = d1.hub_dept_id
		and d1.Active_Flag = 'Y'
	left join dbo.volunteer_dept_rpt vd2  -- GET 2ND DEPT, IF EXISTS
		on v.volunteer_key = vd2.volunteer_key
		and vd2.row_num = ( select max( row_num ) from dbo.volunteer_dept_rpt x2 where x2.volunteer_key = vd2.volunteer_key )
		and vd2.volunteer_key in ( select volunteer_key from dbo.volunteer_dept_rpt group by volunteer_key having count(*) > 1 )
	left join dbo.HPR_Dept d2
		on vd2.hub_dept_id = d2.hub_dept_id
		and d2.Active_Flag = 'Y'
	left join dbo.volunteer mate
		on v.mate_hub_person_id = mate.hub_person_id
	where v.hpr_volunteer_exception_flag = 'Y'
		--and v.volunteer_key = 908039
/*
	union all

	-- NON-US BRANCH VOLUNTEERS
	select 
		 fb.last_name + ', ' + fb.first_name
		,fb.first_name
		,fb.last_name
		,fb.gender
		,fb.marital_status
		,cast( round( ( datediff( day, fb.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,'' as address
		,'' as city
		,'' as state_code
		,'' as postal_code
		,'' as home_phone
		,'' as mobile_phone
		,fb.volunteer_number as hub_volunteer_num
		,fb.department_site as enrollment_1_site_code
		,fb.enrollment_code as enrollment_1_code
		,fb.enrollment_start_date as enrollment_1_start_date
		,fb.enrollment_end_date as enrollment_1_end_date
		,null as enrollment_2_site_code
		,null as enrollment_2_code
		,null as enrollment_2_start_date
		,null as enrollment_2_end_date		
		,fb.hub_dept_id as dept_1_hub_dept_id
		,d.cpc_code as dept_1_cpc_code
		,d.dept_name as dept_1_parent_dept_name
		,d.work_group_name as dept_1_dept_name
		,coalesce( d.work_group_ovsr, d.dept_ovsr ) as dept_1_ovsr_name
		,fb.department_start_date as dept_1_start_date
		,null as dept_1_end_date
		,'N' as dept_1_temp_flag
		,'Y' as dept_1_primary_flag
		,'Y' as dept_1_hpr_flag
		,d.PC_Category as dept_1_pc_category
		,'Y' as dept_1_mon_flag
		,'Y' as dept_1_tue_flag
		,'Y' as dept_1_wed_flag
		,'Y' as dept_1_thu_flag
		,'Y' as dept_1_fri_flag
		,'N' as dept_1_sat_flag
		,'N' as dept_1_sun_flag		
		,null as dept_2_hub_dept_id
		,null as dept_2_cpc_code
		,null as dept_2_parent_dept_name
		,null as dept_2_dept_name
		,null as dept_2_ovsr_name
		,null as dept_2_start_date
		,null as dept_2_end_date
		,null as dept_2_temp_flag
		,null as dept_2_primary_flag
		,null as dept_2_hpr_flag
		,null as dept_2_pc_category
		,null as dept_2_mon_flag
		,null as dept_2_tue_flag
		,null as dept_2_wed_flag
		,null as dept_2_thu_flag
		,null as dept_2_fri_flag
		,null as dept_2_sat_flag
		,null as dept_2_sun_flag
		,fb.internal_email
		,'' as jwbpub
		,'' as personal
		,fb.volunteer_number * -1 as volunteer_key  -- ARTIFICIAL VOL KEY
		,fb.person_id
		,null as ba_volunteer_num
		,null as hub_person_guid
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,'' as spouse_bethel_email
		,'' as spouse_jwpub_email
		,null as Room_Site_Code
		,null as Room_Bldg
		,null as Room_Bldg_Code
		,null as Room		
	from stg.stg_foreign_branches fb
	inner join dbo.HPR_Dept d
		on fb.hub_dept_id = d.hub_dept_id
	left join dbo.volunteer mate
		on fb.spouse_person_id = mate.hub_person_id 
*/		
  ) core
go


if object_id('rpt.Volunteer_Departure_v', 'V') is not null
	drop view rpt.Volunteer_Departure_v
go 
create view rpt.Volunteer_Departure_v
as
select 
	 volunteer_key
 	,hub_volunteer_num
 	,hub_person_id
 	,hub_person_guid
	,cast( ba_volunteer_num as varchar(10) ) as ba_volunteer_num
	,first_name
	,last_name
	,volunteer_name
	,gender_code
	,marital_status_code
	,age
	,address
	,city
	,state_code
	,postal_code
	,home_phone
	,mobile_phone	
	,coalesce( enrollment_site_code, 'UNK' ) as enrollment_site_code
	,enrollment_code
	,case when enrollment_start_date < dept_start_date then enrollment_start_date else dept_start_date end as enrollment_start_date
	,enrollment_end_date
	,parent_dept_name
	,parent_dept_code
	,dept_name
	,temp_parent_dept_name + ' > ' + temp_dept_name as loan_dept_name
	,pc_category
	,bethel_email
	,jwpub_email
	,personal_email
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email		
	,primary_flag
	,temp_flag
	,split_asgn_flag
	,mon_flag
	,tue_flag
	,wed_flag
	,thu_flag
	,fri_flag
	,sat_flag
	,sun_flag
from (  
	-- CORE 
	select distinct 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code	
		,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,v.address
		,v.city
		,s.state_code
		,pc.Postal_Code
		,v.home_phone		
		,v.mobile_phone
		,v.HUB_Volunteer_Num
		,ve.Site_Code as enrollment_site_code
		,e.Enrollment_Code as enrollment_code
		,ve.Start_Date as enrollment_start_date
		,ve.end_date as enrollment_end_date
		,vd.Parent_Dept_Name as parent_dept_name
		,d.cpc_code as parent_dept_code
		,vd.Dept_Name as dept_name
		,tmp.Parent_Dept_Name as temp_parent_dept_name
		,tmp.Dept_Name as temp_dept_name
		,v.alt_Email as bethel_email
		,v.jw_username + '@jwpub.org' as jwpub_email
		,v.Email as personal_email		
		,vd.Start_Date as dept_start_date
		,vd.Primary_Flag as primary_flag
		,vd.Temp_Flag as temp_flag		
		,case when vd.Primary_Flag = 'N' then 'Y' else 'N' end as split_asgn_flag
		,case when ( vd.Mon_AM_Flag = 'Y' or vd.Mon_PM_Flag = 'Y' ) then 'Y' else 'N' end as mon_flag
		,case when ( vd.tue_AM_Flag = 'Y' or vd.tue_PM_Flag = 'Y' ) then 'Y' else 'N' end as tue_flag
		,case when ( vd.wed_AM_Flag = 'Y' or vd.wed_PM_Flag = 'Y' ) then 'Y' else 'N' end as wed_flag
		,case when ( vd.thu_AM_Flag = 'Y' or vd.thu_PM_Flag = 'Y' ) then 'Y' else 'N' end as thu_flag
		,case when ( vd.fri_AM_Flag = 'Y' or vd.fri_PM_Flag = 'Y' ) then 'Y' else 'N' end as fri_flag
		,case when ( vd.sat_AM_Flag = 'Y' or vd.sat_PM_Flag = 'Y' ) then 'Y' else 'N' end as sat_flag
		,case when ( vd.sun_AM_Flag = 'Y' or vd.sun_PM_Flag = 'Y' ) then 'Y' else 'N' end as sun_flag
		,d.PC_Category as pc_category
		,v.volunteer_key
		,v.HUB_Person_ID
		,v.ba_volunteer_num
		,v.hub_person_guid
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email		
	from dbo.volunteer v
	inner join dbo.marital_status ms 
		on v.marital_status_key = ms.marital_status_key	
	inner join dbo.state s
		on v.State_Key = s.State_Key
	inner join dbo.Postal_Code pc
		on v.Postal_Code_Key = pc.Postal_Code_Key
	inner join dbo.volunteer_enrollment ve
		on v.volunteer_key = ve.Volunteer_Key
		and ve.active_flag = 'N' 
		and ve.start_Date < cast( getdate() as date )
		and ve.end_date >= cast( getdate() - 30 as date )
		--and ve.Geo_Name = 'USA'
	inner join dbo.enrollment e
		on ve.Enrollment_Key = e.Enrollment_Key
		and ( e.Bethel_Flag = 'Y'
			or e.enrollment_code in ( 'BCC', 'BCF', 'BCL', 'BCS', 'BCV', 'BOC', 'BBO' ) )
	inner join dbo.volunteer_dept vd
		on v.volunteer_key = vd.Volunteer_Key
		and vd.active_flag = 'N'
		and vd.start_Date < cast( getdate() as date )
		and vd.end_date >= cast( getdate() - 30 as date )
		--and vd.Parent_Dept_Name like 'HPR%'
		--and vd.Enrollment_Code = e.Enrollment_Code   -- REMOVING FOR NOW, NEED TO RE-EVALUATE
	inner join dbo.HPR_Dept d
		on vd.hub_dept_id = d.hub_dept_id
		and d.Active_Flag = 'Y'
	inner join ( select volunteer_key, count(*) as cnt from dbo.volunteer_dept 
				 where hub_dept_id in ( select hub_dept_id from dbo.HPR_Dept where active_flag = 'Y' ) and ( end_date is not null and end_date >= cast( getdate() - 30 as date ) ) group by volunteer_key ) multi	 
		on v.volunteer_key = multi.volunteer_key
		and 'Y' = case when multi.cnt = 1 then 'Y' else vd.primary_flag end
	left join dbo.volunteer_dept tmp
		on v.volunteer_key = tmp.Volunteer_Key
		and tmp.active_flag = 'N'
		and tmp.start_Date < cast( getdate() as date )
		and tmp.end_date >= cast( getdate() - 30 as date )
		and tmp.Enrollment_Code = e.Enrollment_Code
		and tmp.Temp_Flag = 'Y'
	left join dbo.volunteer mate
		on v.mate_hub_person_id = mate.hub_person_id
	where 1=1
		and v.volunteer_key not in ( select volunteer_key from rpt.Volunteer_v )
		
	union all 

	-- EXCEPTIONS
	select distinct 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code	
		,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,v.address
		,v.city
		,s.state_code
		,pc.Postal_Code
		,v.home_phone
		,v.mobile_phone		
		,v.HUB_Volunteer_Num
		,ve.Site_Code as enrollment_site_code
		,e.Enrollment_Code as enrollment_code
		,ve.Start_Date as enrollment_start_date
		,ve.end_date as enrollment_end_date
		,vd.Parent_Dept_Name as parent_dept_name
		,'PCC' as parent_dept_code
		,vd.Dept_Name as dept_name
		,null as temp_parent_dept_name
		,null as temp_dept_name
		,v.alt_Email as bethel_email
		,v.jw_username + '@jwpub.org' as jwpub_email
		,v.Email as personal_email	
		,vd.Start_Date as dept_start_date
		,vd.Primary_Flag as primary_flag
		,vd.Temp_Flag as temp_flag		
		,case when vd.Primary_Flag = 'N' then 'Y' else 'N' end as split_asgn_flag
		,case when ( vd.Mon_AM_Flag = 'Y' or vd.Mon_PM_Flag = 'Y' ) then 'Y' else 'N' end as mon_flag
		,case when ( vd.tue_AM_Flag = 'Y' or vd.tue_PM_Flag = 'Y' ) then 'Y' else 'N' end as tue_flag
		,case when ( vd.wed_AM_Flag = 'Y' or vd.wed_PM_Flag = 'Y' ) then 'Y' else 'N' end as wed_flag
		,case when ( vd.thu_AM_Flag = 'Y' or vd.thu_PM_Flag = 'Y' ) then 'Y' else 'N' end as thu_flag
		,case when ( vd.fri_AM_Flag = 'Y' or vd.fri_PM_Flag = 'Y' ) then 'Y' else 'N' end as fri_flag
		,case when ( vd.sat_AM_Flag = 'Y' or vd.sat_PM_Flag = 'Y' ) then 'Y' else 'N' end as sat_flag
		,case when ( vd.sun_AM_Flag = 'Y' or vd.sun_PM_Flag = 'Y' ) then 'Y' else 'N' end as sun_flag
		,'Support' as pc_category
		,v.volunteer_key
		,v.HUB_Person_ID
		,v.ba_volunteer_num
		,v.hub_person_guid
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
	from dbo.volunteer v
	inner join dbo.marital_status ms 
		on v.marital_status_key = ms.marital_status_key
	inner join dbo.state s
		on v.State_Key = s.State_Key
	inner join dbo.Postal_Code pc
		on v.Postal_Code_Key = pc.Postal_Code_Key
	inner join dbo.volunteer_enrollment ve
		on v.volunteer_key = ve.Volunteer_Key
		and ve.active_flag = 'N' 
		and ve.start_Date < cast( getdate() as date )
		and ve.end_date >= cast( getdate() - 30 as date )
		--and ve.Geo_Name = 'USA'
	inner join dbo.enrollment e
		on ve.Enrollment_Key = e.Enrollment_Key
		and ( e.Bethel_Flag = 'Y'
			or e.enrollment_code in ( 'BCC', 'BCF', 'BCL', 'BCS', 'BCV', 'BOC', 'BBO' ) )
	inner join dbo.volunteer_dept vd
		on v.volunteer_key = vd.Volunteer_Key
		and vd.active_flag = 'N'
		and vd.start_Date < cast( getdate() as date )
		and vd.end_date >= cast( getdate() - 30 as date )
		--and vd.Parent_Dept_Name like 'HPR%'
	inner join ( select volunteer_key, count(*) as cnt from dbo.volunteer_dept 
				 where ( end_date is not null and end_date >= cast( getdate() - 30 as date ) ) group by volunteer_key ) multi
		on v.volunteer_key = multi.volunteer_key
		and 'Y' = case when multi.cnt = 1 then 'Y' else vd.primary_flag end
	left join dbo.volunteer mate
		on v.mate_hub_person_id = mate.hub_person_id
	where v.hpr_volunteer_exception_flag = 'Y' ) core
go



if object_id('rpt.Volunteer_Training_v', 'V') is not null
	drop view rpt.Volunteer_Training_v
go 
create view rpt.Volunteer_Training_v
as
select  
	 volunteer_name
	,parent_dept_name
	,dept_name
	,t.course_type
	,t.course_name
	,t.course_desc
	,t.class_number
	,t.class_name	
	,t.host_branch_code	
	,t.assign_date
	,t.complete_date
	,t.attendance_status	
	,t.active_flag
	,v.volunteer_key
	,v.enrollment_code
from rpt.volunteer_v v
left join dbo.Volunteer_Training t
	on v.volunteer_key = t.volunteer_key
where 1=1
go


if object_id('rpt.Timecard_v', 'V') is not null
	drop view rpt.Timecard_v
go 
create view rpt.Timecard_v
as
select 
 	 hub_volunteer_num as volunteer_num
	,first_name
	,last_name 	 
	,enrollment_site_code
	,enrollment_code
	,enrollment_start_date
	,enrollment_end_date
	,parent_dept_name
	,dept_name
	,loan_dept_name
	,bethel_email
	,jwpub_email
	,personal_email
	,address
	,city
	,state_code
	,postal_code
	,mobile_phone
from rpt.volunteer_v
where pc_category <> 'Support'
	and enrollment_start_date <= getdate()
/*where volunteer_name in ( 
	'Brust, Nicholas',
	'Harbo, Reid',
	'Jacks, Joshua',
	'Janifer, Philip',
	'Kutch, Jeffrey',
	'Lee, Benjamin',
	'Pierce, Robert F.',
	'Pierce, Brianna',
	'Popish, Joel',
	'Thomas, Joanna',
	'Thomas, Nathan',
	'Tipton, Melissa',
	'Weber, Eric',
	'Weber, Heather',
	'Wilcox, Mark Patrick' 
)*/
go
