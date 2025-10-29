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
	,dept_1_cpc_code as cpc_code
	,dept_1_parent_dept_name as parent_dept_name
	,dept_1_dept_name as dept_name
	,case 
		when charindex( ' - ', dept_1_dept_name ) = 0 then dept_1_dept_name
		else right( dept_1_dept_name, charindex( ' - ', reverse( dept_1_dept_name ) ) - 1 )
	 end as sub_dept_name
	,enrollment_1_code as enrollment_code
	,enrollment_1_start_date as enrollment_start_date
	,enrollment_1_end_date as enrollment_end_date
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email
	,volunteer_key
	,case 
		when enrollment_1_start_date > cast( getdate() as date ) then 'Invited'
		when enrollment_1_end_date < cast( getdate() as date ) then 'Departed'
		else 'Arrived'
	 end as enrollment_status
from dbo.Volunteer_v_snp
where 1=1
	and dept_1_parent_dept_name not like '%WHQ Computer%'
	and dept_1_parent_dept_name not like '%Purchasing%'

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
	,parent_dept_code as cpc_code
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
where 1=1
	and parent_dept_name not like '%WHQ Computer%'
	and parent_dept_name not like '%Purchasing%'

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
	,dept_2_cpc_code as cpc_code
	,dept_2_parent_dept_name as parent_dept_name
	,dept_2_dept_name as dept_name
	,case 
		when charindex( ' - ', dept_2_dept_name ) = 0 then dept_2_dept_name
		else right( dept_2_dept_name, charindex( ' - ', reverse( dept_2_dept_name ) ) - 1 )
	 end as sub_dept_name
	,coalesce( enrollment_2_code, enrollment_1_code ) as enrollment_code
	,coalesce( enrollment_2_start_date, dept_2_start_date ) as enrollment_start_date
	,coalesce( enrollment_2_end_date, dept_2_end_date ) as enrollment_end_date
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email
	,volunteer_key
	,'Transfer' as enrollment_status
from rpt.Volunteer_Rpt_v
where 1=1
	and dept_2_parent_dept_name not like '%WHQ Computer%'
	and dept_2_parent_dept_name not like '%Purchasing%'
	and dept_1_cpc_code is null
	and dept_1_end_date is not null
	and dept_2_cpc_code is not null
	and dept_2_start_date > cast(getdate() as date)
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


if object_id('rpt.BA_Event_Invite_v', 'V') is not null
	drop view rpt.BA_Event_Invite_v
go 
create view rpt.BA_Event_Invite_v
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
	,comments
	,case
		when   status_day_1 = 'C'
			or status_day_2 = 'C'
			or status_day_3 = 'C'
			or status_day_4 = 'C'
			or status_day_5 = 'C'
			or status_day_6 = 'C'
			or status_day_7 = 'C' then 'Y' 
		else 'N' 
	 end as confirmed_flag
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
with dates as (
	select top 26 cal_dt, rank() over (order by cal_dt ) as wk_num
	from dbo.cal_dim 
	where 1=1
		and day_of_wk = 2
		and cal_dt between cast(getdate()-6 as date) and getdate() + 200 
),

vol as (
	select 
		 d.cpc_code
		,d.level_02
		,d.level_03
		,d.level_04
		,d.level_05
		,d.level_06
		,v.crew_name
		,v.dept_role
		,case
			when v.volunteer_name_short is not null then v.volunteer_name_short
			else v.enrollment_code
		 end as volunteer_name
		,c.cal_dt
		,v.enrollment_code
		,v.dept_asgn_status_code as dept_asgn_status
		,bed_cnt as used_bed_cnt
		,v.dept_asgn_key
		,v.hpr_dept_key
		,v.volunteer_key
		,c.wk_num
	from dates c 
	left join rpt.Resource_Plan_vol_v v
		on c.cal_dt = v.cal_dt
	inner join dbo.hpr_dept d
		on v.hpr_dept_key = d.HPR_Dept_Key
)

select
	 cpc_code
	,level_03
	,level_04
	,level_05
	,level_06
	,coalesce( level_06, level_05, level_04, level_03 ) as dept_lowest_level
	,crew_name
	,dept_role
	,enrollment_code
	,used_bed_cnt
	,dept_asgn_status
	,dept_asgn_key
	,volunteer_key
	,max( case when wk_num = 1 then volunteer_name else null end ) as wk_01
	,max( case when wk_num = 2 then volunteer_name else null end ) as wk_02
	,max( case when wk_num = 3 then volunteer_name else null end ) as wk_03
	,max( case when wk_num = 4 then volunteer_name else null end ) as wk_04
	,max( case when wk_num = 5 then volunteer_name else null end ) as wk_05
	,max( case when wk_num = 6 then volunteer_name else null end ) as wk_06
	,max( case when wk_num = 7 then volunteer_name else null end ) as wk_07
	,max( case when wk_num = 8 then volunteer_name else null end ) as wk_08
	,max( case when wk_num = 9 then volunteer_name else null end ) as wk_09
	,max( case when wk_num = 10 then volunteer_name else null end ) as wk_10
	,max( case when wk_num = 11 then volunteer_name else null end ) as wk_11
	,max( case when wk_num = 12 then volunteer_name else null end ) as wk_12
	,max( case when wk_num = 13 then volunteer_name else null end ) as wk_13
	,max( case when wk_num = 14 then volunteer_name else null end ) as wk_14
	,max( case when wk_num = 15 then volunteer_name else null end ) as wk_15
	,max( case when wk_num = 16 then volunteer_name else null end ) as wk_16
	,max( case when wk_num = 17 then volunteer_name else null end ) as wk_17
	,max( case when wk_num = 18 then volunteer_name else null end ) as wk_18
	,max( case when wk_num = 19 then volunteer_name else null end ) as wk_19
	,max( case when wk_num = 20 then volunteer_name else null end ) as wk_20
	,max( case when wk_num = 21 then volunteer_name else null end ) as wk_21
	,max( case when wk_num = 22 then volunteer_name else null end ) as wk_22
	,max( case when wk_num = 23 then volunteer_name else null end ) as wk_23
	,max( case when wk_num = 24 then volunteer_name else null end ) as wk_24
	,max( case when wk_num = 25 then volunteer_name else null end ) as wk_25
	,max( case when wk_num = 26 then volunteer_name else null end ) as wk_26
from vol
where 1=1
	--and cpc_code = 'CI'
	--and level_03 = 'Trade Group'
	--and level_04 = 'Siteworks'
	--and used_bed_cnt = 1
	--and volunteer_key = 242862
group by 
	 cpc_code
	,level_03
	,level_04
	,level_05
	,level_06
	,crew_name
	,dept_role
	,enrollment_code
	,used_bed_cnt
	,dept_asgn_status
	,dept_asgn_key
	,volunteer_key
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
		when cpc_code = 'VD' then 5
		else 6
	 end as sort_order
from dbo.hpr_dept
where 1=1
	and active_flag = 'Y' 
	and nyc_flag = 'N'
	and cpc_code in ( 'CO', 'DD', 'PCC', 'PS', 'CI', 'VD' ) 
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


if object_id('rpt.Onsite_Report_v', 'V') is not null
	drop view rpt.Onsite_Report_v
go 
create view rpt.Onsite_Report_v
as
with dt as (
	select cal_dt, day_of_wk, day_nm
	from dbo.cal_dim
	where cal_dt between dateadd( week, datediff( week, 0, getdate() ), 0 ) and
		dateadd( week, datediff( week, 0, getdate() ), 0 ) + 27 )

select 
	 dt.cal_dt
	,dt.day_nm
	,case when d.cpc_code = 'CI' then 'On-site' else 'Tuxedo' end as location
	,sum( case when v.onsite_flag = 'Y' then 1 else 0 end ) as onsite_cnt
from rpt.Resource_Plan_Vol_Daily_v v
inner join dbo.hpr_dept d
	on v.hpr_dept_key = d.hpr_dept_key
inner join dt 
	on dt.cal_dt = v.cal_dt
where v.record_type <> 'PROJECTED'
group by 
	 dt.cal_dt
	,dt.day_nm
	,case when d.cpc_code = 'CI' then 'On-site' else 'Tuxedo' end
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
	,enrollment_1_end_date
	,enrollment_2_site_code
	,enrollment_2_code
	,enrollment_2_start_date
	,enrollment_2_end_date
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


if object_id('rpt.PC_Volunteer_Actuals_v', 'V') is not null
	drop view rpt.PC_Volunteer_Actuals_v
go 
create view rpt.PC_Volunteer_Actuals_v
as
select
	 d.pc_code
	,d.pc_category
	,d.cpc_code
	,d.level_02
	,d.level_03
	,d.level_04
	,d.level_05
	,d.level_06 
	,v.cal_dt
	,v.enrollment_code
	,v.room_site_code as site_code
	,v.room_bldg as site_bldg
	,v.room_bldg_code as site_bldg_code
	,sum( v.bed_cnt ) as bed_cnt
	,sum( case when v.bed_cnt = 0 then 1 else 0 end ) as no_bed_cnt
	,sum( v.fte ) as fte
from rpt.Resource_Plan_Vol_v v
inner join dbo.hpr_dept d
	on v.hpr_dept_key = d.HPR_Dept_Key
inner join dbo.cal_dim c
	on v.cal_dt = c.cal_dt 
	and c.day_of_mth = 1	
where 1=1
	and v.record_type <> 'PROJECTED'
	--and v.cal_dt between '2025-07-01' and '2025-07-07'
	--and d.level_03 = 'Trade Group'
	--and d.level_04 = 'Siteworks'
	--and PC_Category = 'Tools'
group by 
	 d.pc_code
	,d.pc_category
	,d.cpc_code
	,d.level_02
	,d.level_03
	,d.level_04
	,d.level_05
	,d.level_06 
	,v.cal_dt
	,v.enrollment_code
	,v.room_site_code
	,v.room_bldg
	,v.room_bldg_code 
--order by 1, 2, 3, 4, 5, 6, 7, 8, 9
go


if object_id('rpt.PC_Volunteer_Actuals_Daily_v', 'V') is not null
	drop view rpt.PC_Volunteer_Actuals_Daily_v
go 
create view rpt.PC_Volunteer_Actuals_Daily_v
as
select
	 d.pc_code
	,d.pc_category
	,d.cpc_code
	,d.level_02
	,d.level_03
	,d.level_04
	,d.level_05
	,d.level_06 
	,v.cal_dt
	,v.enrollment_code
	,v.room_site_code 												as site_code
	,v.room_bldg 													as site_bldg
	,v.room_bldg_code 												as site_bldg_code
	,case when v.record_type = 'PROJECTED' then 'Y' else 'N' end 	as projected_flag
	,sum( v.bed_cnt ) 												as bed_cnt
	,sum( case when v.bed_cnt = 0 then 1 else 0 end ) 				as no_bed_cnt
	,sum( v.fte ) 													as fte_cnt
	,sum( case when v.onsite_flag = 'Y' then 1 else 0 end ) 		as onsite_cnt
	,max( d.hpr_dept_key ) 											as hpr_dept_key
from rpt.Resource_Plan_Vol_Daily_v v
inner join dbo.hpr_dept d
	on v.hpr_dept_key = d.HPR_Dept_Key
inner join dbo.cal_dim c
	on v.cal_dt = c.cal_dt 
	--and c.day_of_mth = 1	
where 1=1
	--and v.record_type <> 'PROJECTED'
	--and v.cal_dt between '2025-07-01' and '2025-07-07'
	--and d.level_03 = 'Trade Group'
	--and d.level_04 = 'Siteworks'
	--and PC_Category = 'Tools'
	--and enrollment_code = 'BRS'
group by 
	 d.pc_code
	,d.pc_category
	,d.cpc_code
	,d.level_02
	,d.level_03
	,d.level_04
	,d.level_05
	,d.level_06 
	,v.cal_dt
	,v.enrollment_code
	,v.room_site_code
	,v.room_bldg
	,v.room_bldg_code 
	,case when v.record_type = 'PROJECTED' then 'Y' else 'N' end
go


if object_id('rpt.PRP_Actuals_Level_02_v', 'V') is not null
	drop view rpt.PRP_Actuals_Level_02_v
go 
create view rpt.PRP_Actuals_Level_02_v
as
select 
	 cpc_code
	,max( wk_01_dt ) as wk_01_dt
	,sum( wk_01_budget ) as wk_01_budget
	,sum( wk_01_used ) as wk_01_used
	,sum( wk_01_avail ) as wk_01_avail
	,max( wk_02_dt ) as wk_02_dt
	,sum( wk_02_budget ) as wk_02_budget
	,sum( wk_02_used ) as wk_02_used
	,sum( wk_02_avail ) as wk_02_avail
	,max( wk_03_dt ) as wk_03_dt
	,sum( wk_03_budget ) as wk_03_budget
	,sum( wk_03_used ) as wk_03_used
	,sum( wk_03_avail ) as wk_03_avail
	,max( wk_04_dt ) as wk_04_dt
	,sum( wk_04_budget ) as wk_04_budget
	,sum( wk_04_used ) as wk_04_used
	,sum( wk_04_avail ) as wk_04_avail
	,max( wk_05_dt ) as wk_05_dt
	,sum( wk_05_budget ) as wk_05_budget
	,sum( wk_05_used ) as wk_05_used
	,sum( wk_05_avail ) as wk_05_avail
	,max( wk_06_dt ) as wk_06_dt
	,sum( wk_06_budget ) as wk_06_budget
	,sum( wk_06_used ) as wk_06_used
	,sum( wk_06_avail ) as wk_06_avail
	,max( wk_07_dt ) as wk_07_dt
	,sum( wk_07_budget ) as wk_07_budget
	,sum( wk_07_used ) as wk_07_used
	,sum( wk_07_avail ) as wk_07_avail
	,max( wk_08_dt ) as wk_08_dt
	,sum( wk_08_budget ) as wk_08_budget
	,sum( wk_08_used ) as wk_08_used
	,sum( wk_08_avail ) as wk_08_avail
	,max( wk_09_dt ) as wk_09_dt
	,sum( wk_09_budget ) as wk_09_budget
	,sum( wk_09_used ) as wk_09_used
	,sum( wk_09_avail ) as wk_09_avail
	,max( wk_10_dt ) as wk_10_dt
	,sum( wk_10_budget ) as wk_10_budget
	,sum( wk_10_used ) as wk_10_used
	,sum( wk_10_avail ) as wk_10_avail
	,max( wk_11_dt ) as wk_11_dt
	,sum( wk_11_budget ) as wk_11_budget
	,sum( wk_11_used ) as wk_11_used
	,sum( wk_11_avail ) as wk_11_avail
	,max( wk_12_dt ) as wk_12_dt
	,sum( wk_12_budget ) as wk_12_budget
	,sum( wk_12_used ) as wk_12_used
	,sum( wk_12_avail ) as wk_12_avail
	,max( wk_13_dt ) as wk_13_dt
	,sum( wk_13_budget ) as wk_13_budget
	,sum( wk_13_used ) as wk_13_used
	,sum( wk_13_avail ) as wk_13_avail
	,max( wk_14_dt ) as wk_14_dt
	,sum( wk_14_budget ) as wk_14_budget
	,sum( wk_14_used ) as wk_14_used
	,sum( wk_14_avail ) as wk_14_avail
	,max( wk_15_dt ) as wk_15_dt
	,sum( wk_15_budget ) as wk_15_budget
	,sum( wk_15_used ) as wk_15_used
	,sum( wk_15_avail ) as wk_15_avail
	,max( wk_16_dt ) as wk_16_dt
	,sum( wk_16_budget ) as wk_16_budget
	,sum( wk_16_used ) as wk_16_used
	,sum( wk_16_avail ) as wk_16_avail
	,max( wk_17_dt ) as wk_17_dt
	,sum( wk_17_budget ) as wk_17_budget
	,sum( wk_17_used ) as wk_17_used
	,sum( wk_17_avail ) as wk_17_avail
	,max( wk_18_dt ) as wk_18_dt
	,sum( wk_18_budget ) as wk_18_budget
	,sum( wk_18_used ) as wk_18_used
	,sum( wk_18_avail ) as wk_18_avail
	,max( wk_19_dt ) as wk_19_dt
	,sum( wk_19_budget ) as wk_19_budget
	,sum( wk_19_used ) as wk_19_used
	,sum( wk_19_avail ) as wk_19_avail
	,max( wk_20_dt ) as wk_20_dt
	,sum( wk_20_budget ) as wk_20_budget
	,sum( wk_20_used ) as wk_20_used
	,sum( wk_20_avail ) as wk_20_avail
	,max( wk_21_dt ) as wk_21_dt
	,sum( wk_21_budget ) as wk_21_budget
	,sum( wk_21_used ) as wk_21_used
	,sum( wk_21_avail ) as wk_21_avail
	,max( wk_22_dt ) as wk_22_dt
	,sum( wk_22_budget ) as wk_22_budget
	,sum( wk_22_used ) as wk_22_used
	,sum( wk_22_avail ) as wk_22_avail
	,max( wk_23_dt ) as wk_23_dt
	,sum( wk_23_budget ) as wk_23_budget
	,sum( wk_23_used ) as wk_23_used
	,sum( wk_23_avail ) as wk_23_avail
	,max( wk_24_dt ) as wk_24_dt
	,sum( wk_24_budget ) as wk_24_budget
	,sum( wk_24_used ) as wk_24_used
	,sum( wk_24_avail ) as wk_24_avail
	,max( wk_25_dt ) as wk_25_dt
	,sum( wk_25_budget ) as wk_25_budget
	,sum( wk_25_used ) as wk_25_used
	,sum( wk_25_avail ) as wk_25_avail
	,max( wk_26_dt ) as wk_26_dt
	,sum( wk_26_budget ) as wk_26_budget
	,sum( wk_26_used ) as wk_26_used
	,sum( wk_26_avail ) as wk_26_avail
from rpt.PRP_Actuals_Level_04_v
group by cpc_code
go
	

if object_id('rpt.PRP_Actuals_Level_03_v', 'V') is not null
	drop view rpt.PRP_Actuals_Level_03_v
go 
create view rpt.PRP_Actuals_Level_03_v
as
select 
	 cpc_code
	,level_03
	,max( wk_01_dt ) as wk_01_dt
	,sum( wk_01_budget ) as wk_01_budget
	,sum( wk_01_used ) as wk_01_used
	,sum( wk_01_avail ) as wk_01_avail
	,max( wk_02_dt ) as wk_02_dt
	,sum( wk_02_budget ) as wk_02_budget
	,sum( wk_02_used ) as wk_02_used
	,sum( wk_02_avail ) as wk_02_avail
	,max( wk_03_dt ) as wk_03_dt
	,sum( wk_03_budget ) as wk_03_budget
	,sum( wk_03_used ) as wk_03_used
	,sum( wk_03_avail ) as wk_03_avail
	,max( wk_04_dt ) as wk_04_dt
	,sum( wk_04_budget ) as wk_04_budget
	,sum( wk_04_used ) as wk_04_used
	,sum( wk_04_avail ) as wk_04_avail
	,max( wk_05_dt ) as wk_05_dt
	,sum( wk_05_budget ) as wk_05_budget
	,sum( wk_05_used ) as wk_05_used
	,sum( wk_05_avail ) as wk_05_avail
	,max( wk_06_dt ) as wk_06_dt
	,sum( wk_06_budget ) as wk_06_budget
	,sum( wk_06_used ) as wk_06_used
	,sum( wk_06_avail ) as wk_06_avail
	,max( wk_07_dt ) as wk_07_dt
	,sum( wk_07_budget ) as wk_07_budget
	,sum( wk_07_used ) as wk_07_used
	,sum( wk_07_avail ) as wk_07_avail
	,max( wk_08_dt ) as wk_08_dt
	,sum( wk_08_budget ) as wk_08_budget
	,sum( wk_08_used ) as wk_08_used
	,sum( wk_08_avail ) as wk_08_avail
	,max( wk_09_dt ) as wk_09_dt
	,sum( wk_09_budget ) as wk_09_budget
	,sum( wk_09_used ) as wk_09_used
	,sum( wk_09_avail ) as wk_09_avail
	,max( wk_10_dt ) as wk_10_dt
	,sum( wk_10_budget ) as wk_10_budget
	,sum( wk_10_used ) as wk_10_used
	,sum( wk_10_avail ) as wk_10_avail
	,max( wk_11_dt ) as wk_11_dt
	,sum( wk_11_budget ) as wk_11_budget
	,sum( wk_11_used ) as wk_11_used
	,sum( wk_11_avail ) as wk_11_avail
	,max( wk_12_dt ) as wk_12_dt
	,sum( wk_12_budget ) as wk_12_budget
	,sum( wk_12_used ) as wk_12_used
	,sum( wk_12_avail ) as wk_12_avail
	,max( wk_13_dt ) as wk_13_dt
	,sum( wk_13_budget ) as wk_13_budget
	,sum( wk_13_used ) as wk_13_used
	,sum( wk_13_avail ) as wk_13_avail
	,max( wk_14_dt ) as wk_14_dt
	,sum( wk_14_budget ) as wk_14_budget
	,sum( wk_14_used ) as wk_14_used
	,sum( wk_14_avail ) as wk_14_avail
	,max( wk_15_dt ) as wk_15_dt
	,sum( wk_15_budget ) as wk_15_budget
	,sum( wk_15_used ) as wk_15_used
	,sum( wk_15_avail ) as wk_15_avail
	,max( wk_16_dt ) as wk_16_dt
	,sum( wk_16_budget ) as wk_16_budget
	,sum( wk_16_used ) as wk_16_used
	,sum( wk_16_avail ) as wk_16_avail
	,max( wk_17_dt ) as wk_17_dt
	,sum( wk_17_budget ) as wk_17_budget
	,sum( wk_17_used ) as wk_17_used
	,sum( wk_17_avail ) as wk_17_avail
	,max( wk_18_dt ) as wk_18_dt
	,sum( wk_18_budget ) as wk_18_budget
	,sum( wk_18_used ) as wk_18_used
	,sum( wk_18_avail ) as wk_18_avail
	,max( wk_19_dt ) as wk_19_dt
	,sum( wk_19_budget ) as wk_19_budget
	,sum( wk_19_used ) as wk_19_used
	,sum( wk_19_avail ) as wk_19_avail
	,max( wk_20_dt ) as wk_20_dt
	,sum( wk_20_budget ) as wk_20_budget
	,sum( wk_20_used ) as wk_20_used
	,sum( wk_20_avail ) as wk_20_avail
	,max( wk_21_dt ) as wk_21_dt
	,sum( wk_21_budget ) as wk_21_budget
	,sum( wk_21_used ) as wk_21_used
	,sum( wk_21_avail ) as wk_21_avail
	,max( wk_22_dt ) as wk_22_dt
	,sum( wk_22_budget ) as wk_22_budget
	,sum( wk_22_used ) as wk_22_used
	,sum( wk_22_avail ) as wk_22_avail
	,max( wk_23_dt ) as wk_23_dt
	,sum( wk_23_budget ) as wk_23_budget
	,sum( wk_23_used ) as wk_23_used
	,sum( wk_23_avail ) as wk_23_avail
	,max( wk_24_dt ) as wk_24_dt
	,sum( wk_24_budget ) as wk_24_budget
	,sum( wk_24_used ) as wk_24_used
	,sum( wk_24_avail ) as wk_24_avail
	,max( wk_25_dt ) as wk_25_dt
	,sum( wk_25_budget ) as wk_25_budget
	,sum( wk_25_used ) as wk_25_used
	,sum( wk_25_avail ) as wk_25_avail
	,max( wk_26_dt ) as wk_26_dt
	,sum( wk_26_budget ) as wk_26_budget
	,sum( wk_26_used ) as wk_26_used
	,sum( wk_26_avail ) as wk_26_avail
from rpt.PRP_Actuals_Level_04_v
group by
	 cpc_code
	,level_03
go


if object_id('rpt.PRP_Actuals_Level_04_v', 'V') is not null
	drop view rpt.PRP_Actuals_Level_04_v
go 
create view rpt.PRP_Actuals_Level_04_v
as
-- ALL DEPT ASGN BY DAY
with dates as (
	select top 26 cal_dt, rank() over (order by cal_dt ) as wk_num
	from dbo.cal_dim 
	where 1=1
		and day_of_wk = 2
		and cal_dt between cast( getdate() - 6 as date) and getdate() + 200 ),

dept_prp as (
	select 
		 r.cpc_code
		,r.level_03
		,r.level_04
		,r.dept_name
		,r.dept_level
		,max( case when c.wk_num = 1 then c.cal_dt end ) as wk_01_dt
		,max( case when c.wk_num = 1 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_01_budget
		,max( case when c.wk_num = 1 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_01_requested
		,max( case when c.wk_num = 1 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_01_used
		,max( case when c.wk_num = 2 then c.cal_dt end ) as wk_02_dt
		,max( case when c.wk_num = 2 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_02_budget
		,max( case when c.wk_num = 2 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_02_requested
		,max( case when c.wk_num = 2 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_02_used
		,max( case when c.wk_num = 3 then c.cal_dt end ) as wk_03_dt
		,max( case when c.wk_num = 3 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_03_budget
		,max( case when c.wk_num = 3 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_03_requested
		,max( case when c.wk_num = 3 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_03_used
		,max( case when c.wk_num = 4 then c.cal_dt end ) as wk_04_dt
		,max( case when c.wk_num = 4 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_04_budget
		,max( case when c.wk_num = 4 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_04_requested
		,max( case when c.wk_num = 4 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_04_used
		,max( case when c.wk_num = 5 then c.cal_dt end ) as wk_05_dt
		,max( case when c.wk_num = 5 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_05_budget
		,max( case when c.wk_num = 5 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_05_requested
		,max( case when c.wk_num = 5 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_05_used
		,max( case when c.wk_num = 6 then c.cal_dt end ) as wk_06_dt
		,max( case when c.wk_num = 6 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_06_budget
		,max( case when c.wk_num = 6 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_06_requested
		,max( case when c.wk_num = 6 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_06_used
		,max( case when c.wk_num = 7 then c.cal_dt end ) as wk_07_dt
		,max( case when c.wk_num = 7 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_07_budget
		,max( case when c.wk_num = 7 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_07_requested
		,max( case when c.wk_num = 7 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_07_used
		,max( case when c.wk_num = 8 then c.cal_dt end ) as wk_08_dt
		,max( case when c.wk_num = 8 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_08_budget
		,max( case when c.wk_num = 8 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_08_requested
		,max( case when c.wk_num = 8 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_08_used
		,max( case when c.wk_num = 9 then c.cal_dt end ) as wk_09_dt
		,max( case when c.wk_num = 9 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_09_budget
		,max( case when c.wk_num = 9 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_09_requested
		,max( case when c.wk_num = 9 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_09_used
		,max( case when c.wk_num = 10 then c.cal_dt end ) as wk_10_dt
		,max( case when c.wk_num = 10 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_10_budget
		,max( case when c.wk_num = 10 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_10_requested
		,max( case when c.wk_num = 10 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_10_used
		,max( case when c.wk_num = 11 then c.cal_dt end ) as wk_11_dt
		,max( case when c.wk_num = 11 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_11_budget
		,max( case when c.wk_num = 11 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_11_requested
		,max( case when c.wk_num = 11 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_11_used
		,max( case when c.wk_num = 12 then c.cal_dt end ) as wk_12_dt
		,max( case when c.wk_num = 12 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_12_budget
		,max( case when c.wk_num = 12 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_12_requested
		,max( case when c.wk_num = 12 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_12_used
		,max( case when c.wk_num = 13 then c.cal_dt end ) as wk_13_dt
		,max( case when c.wk_num = 13 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_13_budget
		,max( case when c.wk_num = 13 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_13_requested
		,max( case when c.wk_num = 13 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_13_used
		,max( case when c.wk_num = 14 then c.cal_dt end ) as wk_14_dt
		,max( case when c.wk_num = 14 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_14_budget
		,max( case when c.wk_num = 14 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_14_requested
		,max( case when c.wk_num = 14 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_14_used
		,max( case when c.wk_num = 15 then c.cal_dt end ) as wk_15_dt
		,max( case when c.wk_num = 15 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_15_budget
		,max( case when c.wk_num = 15 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_15_requested
		,max( case when c.wk_num = 15 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_15_used
		,max( case when c.wk_num = 16 then c.cal_dt end ) as wk_16_dt
		,max( case when c.wk_num = 16 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_16_budget
		,max( case when c.wk_num = 16 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_16_requested
		,max( case when c.wk_num = 16 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_16_used
		,max( case when c.wk_num = 17 then c.cal_dt end ) as wk_17_dt
		,max( case when c.wk_num = 17 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_17_budget
		,max( case when c.wk_num = 17 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_17_requested
		,max( case when c.wk_num = 17 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_17_used
		,max( case when c.wk_num = 18 then c.cal_dt end ) as wk_18_dt
		,max( case when c.wk_num = 18 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_18_budget
		,max( case when c.wk_num = 18 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_18_requested
		,max( case when c.wk_num = 18 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_18_used
		,max( case when c.wk_num = 19 then c.cal_dt end ) as wk_19_dt
		,max( case when c.wk_num = 19 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_19_budget
		,max( case when c.wk_num = 19 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_19_requested
		,max( case when c.wk_num = 19 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_19_used
		,max( case when c.wk_num = 20 then c.cal_dt end ) as wk_20_dt
		,max( case when c.wk_num = 20 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_20_budget
		,max( case when c.wk_num = 20 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_20_requested
		,max( case when c.wk_num = 20 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_20_used
		,max( case when c.wk_num = 21 then c.cal_dt end ) as wk_21_dt
		,max( case when c.wk_num = 21 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_21_budget
		,max( case when c.wk_num = 21 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_21_requested
		,max( case when c.wk_num = 21 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_21_used
		,max( case when c.wk_num = 22 then c.cal_dt end ) as wk_22_dt
		,max( case when c.wk_num = 22 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_22_budget
		,max( case when c.wk_num = 22 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_22_requested
		,max( case when c.wk_num = 22 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_22_used
		,max( case when c.wk_num = 23 then c.cal_dt end ) as wk_23_dt
		,max( case when c.wk_num = 23 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_23_budget
		,max( case when c.wk_num = 23 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_23_requested
		,max( case when c.wk_num = 23 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_23_used
		,max( case when c.wk_num = 24 then c.cal_dt end ) as wk_24_dt
		,max( case when c.wk_num = 24 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_24_budget
		,max( case when c.wk_num = 24 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_24_requested
		,max( case when c.wk_num = 24 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_24_used
		,max( case when c.wk_num = 25 then c.cal_dt end ) as wk_25_dt
		,max( case when c.wk_num = 25 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_25_budget
		,max( case when c.wk_num = 25 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_25_requested
		,max( case when c.wk_num = 25 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_25_used
		,max( case when c.wk_num = 26 then c.cal_dt end ) as wk_26_dt
		,max( case when c.wk_num = 26 and r.prp_subtype = 'Available' then r.bed_cnt else 0 end ) as wk_26_budget
		,max( case when c.wk_num = 26 and r.prp_subtype = 'Requested' then r.bed_cnt else 0 end ) as wk_26_requested
		,max( case when c.wk_num = 26 and r.prp_subtype = 'Used' then r.bed_cnt else 0 end ) as wk_26_used
	from dates c 
	left join rpt.Resource_Plan_Dept_v r
		on c.cal_dt = r.cal_dt
		and r.prp_type = 'Dept Beds'
	where 1=1
		--and r.hpr_dept_key = 217
	group by
		 r.cpc_code
		,r.level_03
		,r.level_04
		,r.dept_name
		,r.dept_level ),

dept_num as (
	select 
		 cpc_code
		,level_03
		,level_04
		,dept_name
		,dept_level
		,wk_01_dt
		,wk_01_budget
		,case when wk_01_requested > wk_01_used then wk_01_requested else wk_01_used end as wk_01_used
		,wk_02_dt
		,wk_02_budget
		,case when wk_02_requested > wk_02_used then wk_02_requested else wk_02_used end as wk_02_used
		,wk_03_dt
		,wk_03_budget
		,case when wk_03_requested > wk_03_used then wk_03_requested else wk_03_used end as wk_03_used
		,wk_04_dt
		,wk_04_budget
		,case when wk_04_requested > wk_04_used then wk_04_requested else wk_04_used end as wk_04_used
		,wk_05_dt
		,wk_05_budget
		,case when wk_05_requested > wk_05_used then wk_05_requested else wk_05_used end as wk_05_used
		,wk_06_dt
		,wk_06_budget
		,case when wk_06_requested > wk_06_used then wk_06_requested else wk_06_used end as wk_06_used
		,wk_07_dt
		,wk_07_budget
		,case when wk_07_requested > wk_07_used then wk_07_requested else wk_07_used end as wk_07_used
		,wk_08_dt
		,wk_08_budget
		,case when wk_08_requested > wk_08_used then wk_08_requested else wk_08_used end as wk_08_used
		,wk_09_dt
		,wk_09_budget
		,case when wk_09_requested > wk_09_used then wk_09_requested else wk_09_used end as wk_09_used
		,wk_10_dt
		,wk_10_budget
		,case when wk_10_requested > wk_10_used then wk_10_requested else wk_10_used end as wk_10_used
		,wk_11_dt
		,wk_11_budget
		,case when wk_11_requested > wk_11_used then wk_11_requested else wk_11_used end as wk_11_used
		,wk_12_dt
		,wk_12_budget
		,case when wk_12_requested > wk_12_used then wk_12_requested else wk_12_used end as wk_12_used
		,wk_13_dt
		,wk_13_budget
		,case when wk_13_requested > wk_13_used then wk_13_requested else wk_13_used end as wk_13_used
		,wk_14_dt
		,wk_14_budget
		,case when wk_14_requested > wk_14_used then wk_14_requested else wk_14_used end as wk_14_used
		,wk_15_dt
		,wk_15_budget
		,case when wk_15_requested > wk_15_used then wk_15_requested else wk_15_used end as wk_15_used
		,wk_16_dt
		,wk_16_budget
		,case when wk_16_requested > wk_16_used then wk_16_requested else wk_16_used end as wk_16_used
		,wk_17_dt
		,wk_17_budget
		,case when wk_17_requested > wk_17_used then wk_17_requested else wk_17_used end as wk_17_used
		,wk_18_dt
		,wk_18_budget
		,case when wk_18_requested > wk_18_used then wk_18_requested else wk_18_used end as wk_18_used
		,wk_19_dt
		,wk_19_budget
		,case when wk_19_requested > wk_19_used then wk_19_requested else wk_19_used end as wk_19_used
		,wk_20_dt
		,wk_20_budget
		,case when wk_20_requested > wk_20_used then wk_20_requested else wk_20_used end as wk_20_used
		,wk_21_dt
		,wk_21_budget
		,case when wk_21_requested > wk_21_used then wk_21_requested else wk_21_used end as wk_21_used
		,wk_22_dt
		,wk_22_budget
		,case when wk_22_requested > wk_22_used then wk_22_requested else wk_22_used end as wk_22_used
		,wk_23_dt
		,wk_23_budget
		,case when wk_23_requested > wk_23_used then wk_23_requested else wk_23_used end as wk_23_used
		,wk_24_dt
		,wk_24_budget
		,case when wk_24_requested > wk_24_used then wk_24_requested else wk_24_used end as wk_24_used
		,wk_25_dt
		,wk_25_budget
		,case when wk_25_requested > wk_25_used then wk_25_requested else wk_25_used end as wk_25_used
		,wk_26_dt
		,wk_26_budget
		,case when wk_26_requested > wk_26_used then wk_26_requested else wk_26_used end as wk_26_used
	from dept_prp
	--where dept_level > 3 
	),

lvl_04 as (
	select 
		 cpc_code
		,level_03
		,level_04
		,max( wk_01_dt ) as wk_01_dt
		,sum( wk_01_budget ) as wk_01_budget
		,sum( wk_01_used ) as wk_01_used
		,sum( wk_01_budget ) - sum( wk_01_used ) as wk_01_avail
		,max( wk_02_dt ) as wk_02_dt
		,sum( wk_02_budget ) as wk_02_budget
		,sum( wk_02_used ) as wk_02_used
		,sum( wk_02_budget ) - sum( wk_02_used ) as wk_02_avail
		,max( wk_03_dt ) as wk_03_dt
		,sum( wk_03_budget ) as wk_03_budget
		,sum( wk_03_used ) as wk_03_used
		,sum( wk_03_budget ) - sum( wk_03_used ) as wk_03_avail
		,max( wk_04_dt ) as wk_04_dt
		,sum( wk_04_budget ) as wk_04_budget
		,sum( wk_04_used ) as wk_04_used
		,sum( wk_04_budget ) - sum( wk_04_used ) as wk_04_avail
		,max( wk_05_dt ) as wk_05_dt
		,sum( wk_05_budget ) as wk_05_budget
		,sum( wk_05_used ) as wk_05_used
		,sum( wk_05_budget ) - sum( wk_05_used ) as wk_05_avail
		,max( wk_06_dt ) as wk_06_dt
		,sum( wk_06_budget ) as wk_06_budget
		,sum( wk_06_used ) as wk_06_used
		,sum( wk_06_budget ) - sum( wk_06_used ) as wk_06_avail
		,max( wk_07_dt ) as wk_07_dt
		,sum( wk_07_budget ) as wk_07_budget
		,sum( wk_07_used ) as wk_07_used
		,sum( wk_07_budget ) - sum( wk_07_used ) as wk_07_avail
		,max( wk_08_dt ) as wk_08_dt
		,sum( wk_08_budget ) as wk_08_budget
		,sum( wk_08_used ) as wk_08_used
		,sum( wk_08_budget ) - sum( wk_08_used ) as wk_08_avail
		,max( wk_09_dt ) as wk_09_dt
		,sum( wk_09_budget ) as wk_09_budget
		,sum( wk_09_used ) as wk_09_used
		,sum( wk_09_budget ) - sum( wk_09_used ) as wk_09_avail
		,max( wk_10_dt ) as wk_10_dt
		,sum( wk_10_budget ) as wk_10_budget
		,sum( wk_10_used ) as wk_10_used
		,sum( wk_10_budget ) - sum( wk_10_used ) as wk_10_avail
		,max( wk_11_dt ) as wk_11_dt
		,sum( wk_11_budget ) as wk_11_budget
		,sum( wk_11_used ) as wk_11_used
		,sum( wk_11_budget) - sum( wk_11_used ) as wk_11_avail
		,max( wk_12_dt ) as wk_12_dt
		,sum( wk_12_budget ) as wk_12_budget
		,sum( wk_12_used ) as wk_12_used
		,sum( wk_12_budget ) - sum( wk_12_used ) as wk_12_avail
		,max( wk_13_dt ) as wk_13_dt
		,sum( wk_13_budget ) as wk_13_budget
		,sum( wk_13_used ) as wk_13_used
		,sum( wk_13_budget ) - sum( wk_13_used ) as wk_13_avail
		,max( wk_14_dt ) as wk_14_dt
		,sum( wk_14_budget ) as wk_14_budget
		,sum( wk_14_used ) as wk_14_used
		,sum( wk_14_budget ) - sum( wk_14_used ) as wk_14_avail
		,max( wk_15_dt ) as wk_15_dt
		,sum( wk_15_budget ) as wk_15_budget
		,sum( wk_15_used ) as wk_15_used
		,sum( wk_15_budget ) - sum( wk_15_used ) as wk_15_avail
		,max( wk_16_dt ) as wk_16_dt
		,sum( wk_16_budget ) as wk_16_budget
		,sum( wk_16_used ) as wk_16_used
		,sum( wk_16_budget) - sum( wk_16_used ) as wk_16_avail
		,max( wk_17_dt ) as wk_17_dt
		,sum( wk_17_budget ) as wk_17_budget
		,sum( wk_17_used ) as wk_17_used
		,sum( wk_17_budget ) - sum( wk_17_used ) as wk_17_avail
		,max( wk_18_dt ) as wk_18_dt
		,sum( wk_18_budget ) as wk_18_budget
		,sum( wk_18_used ) as wk_18_used
		,sum( wk_18_budget ) - sum( wk_18_used ) as wk_18_avail
		,max( wk_19_dt ) as wk_19_dt
		,sum( wk_19_budget ) as wk_19_budget
		,sum( wk_19_used ) as wk_19_used
		,sum( wk_19_budget ) - sum( wk_19_used ) as wk_19_avail
		,max( wk_20_dt ) as wk_20_dt
		,sum( wk_20_budget ) as wk_20_budget
		,sum( wk_20_used ) as wk_20_used
		,sum( wk_20_budget ) - sum( wk_20_used ) as wk_20_avail
		,max( wk_21_dt ) as wk_21_dt
		,sum( wk_21_budget ) as wk_21_budget
		,sum( wk_21_used ) as wk_21_used
		,sum( wk_21_budget) - sum( wk_21_used ) as wk_21_avail
		,max( wk_22_dt ) as wk_22_dt
		,sum( wk_22_budget ) as wk_22_budget
		,sum( wk_22_used ) as wk_22_used
		,sum( wk_22_budget ) - sum( wk_22_used ) as wk_22_avail
		,max( wk_23_dt ) as wk_23_dt
		,sum( wk_23_budget ) as wk_23_budget
		,sum( wk_23_used ) as wk_23_used
		,sum( wk_23_budget ) - sum( wk_23_used ) as wk_23_avail
		,max( wk_24_dt ) as wk_24_dt
		,sum( wk_24_budget ) as wk_24_budget
		,sum( wk_24_used ) as wk_24_used
		,sum( wk_24_budget ) - sum( wk_24_used ) as wk_24_avail
		,max( wk_25_dt ) as wk_25_dt
		,sum( wk_25_budget ) as wk_25_budget
		,sum( wk_25_used ) as wk_25_used
		,sum( wk_25_budget ) - sum( wk_25_used ) as wk_25_avail
		,max( wk_26_dt ) as wk_26_dt
		,sum( wk_26_budget ) as wk_26_budget
		,sum( wk_26_used ) as wk_26_used
		,sum( wk_26_budget ) - sum( wk_26_used ) as wk_26_avail
	from dept_num
	group by 
		 cpc_code
		,level_03
		,level_04 )

select 
	 cpc_code
	,level_03
	,level_04
	,wk_01_dt
	,wk_01_budget
	,wk_01_used
	,wk_01_avail
	,wk_02_dt
	,wk_02_budget
	,wk_02_used
	,wk_02_avail
	,wk_03_dt
	,wk_03_budget
	,wk_03_used
	,wk_03_avail
	,wk_04_dt
	,wk_04_budget
	,wk_04_used
	,wk_04_avail
	,wk_05_dt
	,wk_05_budget
	,wk_05_used
	,wk_05_avail
	,wk_06_dt
	,wk_06_budget
	,wk_06_used
	,wk_06_avail
	,wk_07_dt
	,wk_07_budget
	,wk_07_used
	,wk_07_avail
	,wk_08_dt
	,wk_08_budget
	,wk_08_used
	,wk_08_avail
	,wk_09_dt
	,wk_09_budget
	,wk_09_used
	,wk_09_avail
	,wk_10_dt
	,wk_10_budget
	,wk_10_used
	,wk_10_avail
	,wk_11_dt
	,wk_11_budget
	,wk_11_used
	,wk_11_avail
	,wk_12_dt
	,wk_12_budget
	,wk_12_used
	,wk_12_avail
	,wk_13_dt
	,wk_13_budget
	,wk_13_used
	,wk_13_avail
	,wk_14_dt
	,wk_14_budget
	,wk_14_used
	,wk_14_avail
	,wk_15_dt
	,wk_15_budget
	,wk_15_used
	,wk_15_avail
	,wk_16_dt
	,wk_16_budget
	,wk_16_used
	,wk_16_avail
	,wk_17_dt
	,wk_17_budget
	,wk_17_used
	,wk_17_avail
	,wk_18_dt
	,wk_18_budget
	,wk_18_used
	,wk_18_avail
	,wk_19_dt
	,wk_19_budget
	,wk_19_used
	,wk_19_avail
	,wk_20_dt
	,wk_20_budget
	,wk_20_used
	,wk_20_avail
	,wk_21_dt
	,wk_21_budget
	,wk_21_used
	,wk_21_avail
	,wk_22_dt
	,wk_22_budget
	,wk_22_used
	,wk_22_avail
	,wk_23_dt
	,wk_23_budget
	,wk_23_used
	,wk_23_avail
	,wk_24_dt
	,wk_24_budget
	,wk_24_used
	,wk_24_avail
	,wk_25_dt
	,wk_25_budget
	,wk_25_used
	,wk_25_avail
	,wk_26_dt
	,wk_26_budget
	,wk_26_used
	,wk_26_avail
from lvl_04
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
	
	
if object_id('rpt.PRP_CPC_v', 'V') is not null
	drop view rpt.PRP_CPC_v
go 
create view rpt.PRP_CPC_v
as
select 
	 cpc_code
	,cal_dt as start_dt
	,eomonth( cal_dt ) as end_dt
	,bed_cnt
from dbo.prp_cpc
go	


if object_id('rpt.Resource_Plan_Dept_v', 'V') is not null
	drop view rpt.Resource_Plan_Dept_v
go 
create view rpt.Resource_Plan_Dept_v
as
with project_beds as (
	select 
		'Project Beds' as prp_type
		,c.cal_dt
		,sum( case when reporting_category like 'Bed Capacity%' then bed_cnt else 0 end ) as project_available_bed_cnt
		,sum( case when reporting_category = 'Bed Space Required Total' then bed_cnt else 0 end ) as project_required_bed_cnt
		,sum( case when reporting_category = 'Commuter Forecast' then bed_cnt else 0 end ) as project_commuter_forecast_cnt
	from rpt.PRP_Bed_Space_v b
	inner join dbo.cal_dim c
		on c.cal_dt between b.cal_dt and dateadd(dd, 6-(datepart( dw, b.cal_dt ) -1 ), b.cal_dt )
		and day_of_wk = 2
	group by c.cal_dt ),

cpc_beds as (
	select 'CPC Beds' as prp_type, c.cal_dt, p.cpc_code, '' as PC_Code, p.bed_cnt as cpc_bed_cnt
	from rpt.PRP_CPC_v p
	inner join dbo.cal_dim c
		on c.cal_dt between p.start_dt and p.end_dt
		and day_of_wk = 2 ),

dept_beds as (
	select 'Dept Beds' as prp_type, p.hpr_dept_key, c.cal_dt, p.cpc_code, p.bed_cnt as dept_avail_bed_cnt, coalesce( nullif( d.work_group_name, '' ), d.dept_name ) as dept_name,  
		case when d.level_02 is null then 1 when d.level_03 is null then 2 when level_04 is null then 3 when level_05 is null then 4 when level_06 is null then 5 end as dept_level
	from rpt.PRP_v p
	inner join dbo.cal_dim c
		on c.cal_dt between p.cal_dt and dateadd(dd, 6-(datepart( dw, p.cal_dt ) -1 ), p.cal_dt )
		and day_of_wk = 2
	inner join dbo.hpr_dept d
		on p.hpr_dept_key = d.hpr_dept_key
		and d.active_flag = 'Y' ),

dept_req_base as (
	select v.hpr_dept_key, v.cal_dt, sum(v.bed_cnt) as requested_bed_cnt
	from rpt.Resource_Plan_Vol_v v
	inner join dbo.cal_dim c
		on v.cal_dt = c.cal_dt
		and c.day_of_wk = 2
	group by v.hpr_dept_key, v.cal_dt ),

dept_req as (
	select 'Dept Beds' as prp_type, a.hpr_dept_key, a.cal_dt, d.cpc_code, a.requested_bed_cnt, coalesce( nullif( d.work_group_name, '' ), d.dept_name ) as dept_name,  
		case when d.level_02 is null then 1 when d.level_03 is null then 2 when level_04 is null then 3 when level_05 is null then 4 when level_06 is null then 5 end as dept_level
	from dept_req_base a
	inner join dbo.hpr_dept d
		on a.hpr_dept_key = d.hpr_dept_key
		and d.active_flag = 'Y' ),

dept_used_base as (
	select v.hpr_dept_key, v.cal_dt, sum(v.bed_cnt) as used_bed_cnt
	from rpt.Resource_Plan_Vol_v v
	inner join dbo.cal_dim c
		on v.cal_dt = c.cal_dt
		and c.day_of_wk = 2
	where v.record_type <> 'PROJECTED'
	group by v.hpr_dept_key, v.cal_dt ),

dept_used as (
	select 'Dept Beds' as prp_type, u.hpr_dept_key, u.cal_dt, d.cpc_code, u.used_bed_cnt, coalesce( nullif( d.work_group_name, '' ), d.dept_name ) as dept_name,  
		case when d.level_02 is null then 1 when d.level_03 is null then 2 when level_04 is null then 3 when level_05 is null then 4 when level_06 is null then 5 end as dept_level
	from dept_used_base u
	inner join dbo.hpr_dept d
		on u.hpr_dept_key = d.hpr_dept_key
		and d.active_flag = 'Y' ),

dept_avail as (
	select 'Dept Beds' as prp_type, p.hpr_dept_key, c.cal_dt, p.cpc_code, p.bed_cnt as dept_avail_bed_cnt, coalesce( nullif( d.work_group_name, '' ), d.dept_name ) as dept_name,  
			case when d.level_02 is null then 1 when d.level_03 is null then 2 when level_04 is null then 3 when level_05 is null then 4 when level_06 is null then 5 end as dept_level
		from rpt.PRP_v p
		inner join dbo.cal_dim c
			on c.cal_dt between p.cal_dt and dateadd(dd, 6-(datepart( dw, p.cal_dt ) -1 ), p.cal_dt )
			and c.day_of_wk = 2
		inner join dbo.hpr_dept d
			on p.hpr_dept_key = d.hpr_dept_key
			and d.active_flag = 'Y' ),

final as (
	select prp_type, 'Available' as prp_subtype, cal_dt, null as cpc_code, null as hpr_dept_key, null as dept_name, null as dept_level, project_available_bed_cnt as bed_cnt from project_beds
	union all
	select prp_type, 'Required' as prp_subtype, cal_dt, null as cpc_code, null as hpr_dept_key, null as dept_name, null as dept_level, project_required_bed_cnt as bed_cnt from project_beds
	union all
	select prp_type, 'Commuter Forecast' as prp_subtype, cal_dt, null as cpc_code, null as hpr_dept_key, null as dept_name, null as dept_level, project_commuter_forecast_cnt as bed_cnt from project_beds
	union all
	select prp_type, 'Approved' as prp_subtype, cal_dt, cpc_code, null as hpr_dept_key, null as dept_name, null as dept_level, cpc_bed_cnt as bed_cnt from cpc_beds
	union all
	select prp_type, 'Available' as prp_subtype, cal_dt, cpc_code, hpr_dept_key, dept_name, dept_level, dept_avail_bed_cnt as bed_cnt from dept_beds 
	union all
	select prp_type, 'Requested' as prp_subtype, cal_dt, cpc_code, hpr_dept_key, dept_name, dept_level, requested_bed_cnt as bed_cnt from dept_req
	union all
	select prp_type, 'Used' as prp_subtype, cal_dt, cpc_code, hpr_dept_key, dept_name, dept_level, used_bed_cnt as bed_cnt from dept_used 
	)

select 
	 f.prp_type
	,f.prp_subtype
	,f.cal_dt
	,f.cpc_code
	,d.Level_03
	,d.level_04
	,f.dept_level
	,f.dept_name
	,f.hpr_dept_key
	,f.bed_cnt
from final f
left join dbo.hpr_dept d
	on f.hpr_dept_key = d.HPR_Dept_Key
where 1=1
--order by dept_name
go


if object_id('rpt.Resource_Plan_Vol_v', 'V') is not null
	drop view rpt.Resource_Plan_Vol_v
go 
create view rpt.Resource_Plan_Vol_v
as
with cal as (
	select cal_dt, day_of_wk, day_nm, day_of_mth 
	from dbo.cal_dim 
	where cal_dt between '2020-01-01' and '2030-03-01'
		and day_of_wk = 2
),

bbo as (
	select 
		 volunteer_key
		,max( ba.mon ) as mon_flag
		,max( ba.tue ) as tue_flag
		,max( ba.wed ) as wed_flag
		,max( ba.thu ) as thu_flag
		,max( ba.fri ) as fri_flag
		,max( ba.sat ) as sat_flag
		,max( ba.sun ) as sun_flag
	from rpt.Volunteer_Rpt_v v
	inner join cal dt
		on dt.cal_dt between v.enrollment_1_start_date and coalesce( v.enrollment_1_end_date, '2030-01-01' )
	inner join dbo.ba_event_snp ba
		on v.ba_volunteer_num = ba.ba_volunteer_num
		and dt.cal_dt between ba.start_date and ba.end_date
	where enrollment_1_code in ( 'BBO' )
	group by volunteer_key
),

actuals as (
	select distinct
		 v.volunteer_key
		,dr.Dept_Role_Key as dept_asgn_key
		,v.volunteer_name
		,v.volunteer_name_short
		,v.Enrollment_1_code as enrollment_code
		,coalesce( v.dept_1_hpr_dept_key, v.dept_2_hpr_dept_key ) as hpr_dept_key
		,dr.crew_name
		,dr.dept_role
		,dr.dept_asgn_status_code	
		,c.cal_dt
        ,coalesce( dr.role_start_date, cast( dateadd( wk, datediff( wk, 0, getdate() ), 0 ) as date ) ) as role_start_date
        ,coalesce( dr.role_end_date,'2030-03-01' ) as role_end_date        
		,case 
			when v.Enrollment_1_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV', 'BCL', 'BRS' ) then 1 
			else 0 
		 end as bed_cnt
		,case 
			when v.Enrollment_1_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV', 'BCL', 'BRS' ) then 1
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) then 0.2
			else 0
		 end as fte
		,case 
			when v.Enrollment_1_code in ( 'BCS', 'BBR', 'BCF', 'BBF', 'BCV', 'BCL', 'BBV', 'BCC' ) then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 2 and v.dept_1_mon_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 3 and v.dept_1_tue_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 4 and v.dept_1_wed_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 5 and v.dept_1_thu_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 6 and v.dept_1_fri_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 2 and bbo.mon_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 3 and bbo.tue_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 4 and bbo.wed_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 5 and bbo.thu_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 6 and bbo.fri_flag = 'Y' then 'Y'
			else 'N' 
		 end as onsite_flag
		,v.Room_Site_Code
		,v.Room_Bldg
		,v.Room_Bldg_Code
		,v.Room
		,v.record_type
	from rpt.volunteer_rpt_v v
	inner join cal c -- JOIN ON DEPT 1 OR DEPT 2 IF ITS A HPR ASSIGNMENT
		on ( c.cal_dt between coalesce( v.dept_1_start_date, v.enrollment_1_start_date ) and coalesce( coalesce( v.dept_1_end_date, v.enrollment_1_end_date ), '2030-12-31' ) and v.dept_1_hpr_flag = 'Y' )
		or ( c.cal_dt between coalesce( v.dept_2_start_date, v.enrollment_2_start_date ) and coalesce( coalesce( v.dept_2_end_date, v.enrollment_2_end_date ), '2030-12-31' ) and v.dept_2_hpr_flag = 'Y' )
	left join bbo 
		on v.volunteer_key = bbo.volunteer_key
	left join dbo.Dept_Role_Volunteer_v drv  -- RG:  Believe this join of the Role_Volunteer data is needed to get the volunteer on a role that matches the HuB actual record by the volunteer key/enrollment code.  Will need to join in Role data to get the fields needed in this view.
		on v.volunteer_key = drv.volunteer_key
		and v.enrollment_1_code = drv.ps_enrollment_code
		and c.cal_dt between drv.vol_start_date and coalesce( drv.vol_end_date, '2030-12-31' )  -- RG:  Is this just double checking to make sure the RVD record start/end date lines up with HuB?  Don't think this needs to be the role start/end date, right?
		and drv.active_flag = 'Y'
		and drv.Dept_Asgn_Status_Key not in ( 19, 22 ) -- DO NOT PURSUE, DEPARTED
	left join dbo.Dept_Role_v dr  -- RG:  Joining in Role data to get the two fields referenced in this view
		on drv.Dept_Role_Key = dr.Dept_Role_Key
	where 1=1
        and isnull(drv.Volunteer_Type_Description, 'VOLUNTEER') = 'VOLUNTEER' --RG:  Added this to identify only Volunteers and exclude Candidates

),
	
projected as (
	select 
		 v.volunteer_key
		,v.Dept_Role_Key as dept_asgn_key
		,v.volunteer_name
		,v.volunteer_name_short
		,v.enrollment_code
		,v.hpr_dept_key
		,v.crew_name
		,v.dept_role
		,v.dept_asgn_status_code
		,v.cal_dt
	    ,coalesce( v.role_start_date, cast( dateadd( wk, datediff( wk, 0, getdate() ), 0 ) as date ) ) as role_start_date
        ,coalesce( v.role_end_date,'2030-03-01' ) as role_end_date        
		,v.bed_cnt
		,v.fte
		,v.onsite_flag
		,null as Room_Site_Code
		,null as Room_Bldg
		,null as Room_Bldg_Code
		,null as Room		
		,v.record_type
	from rpt.Volunteer_Projected_v v
	inner join cal c
		on c.cal_dt = v.cal_dt
),

base as (
	select * from actuals 
	union all
	select * from projected 
)

select *
from base
--where cal_dt = '2025-07-07'
	--and volunteer_key in (641583)
--order by 3
go


if object_id('rpt.Resource_Plan_Vol_Daily_v', 'V') is not null
	drop view rpt.Resource_Plan_Vol_Daily_v
go 
create view rpt.Resource_Plan_Vol_Daily_v
as
with cal as (
	select cal_dt, day_of_wk, day_nm, day_of_mth 
	from dbo.cal_dim 
	where cal_dt between '2020-01-01' and '2030-03-01'
),

bbo as (
	select 
		 volunteer_key
		,max( ba.mon ) as mon_flag
		,max( ba.tue ) as tue_flag
		,max( ba.wed ) as wed_flag
		,max( ba.thu ) as thu_flag
		,max( ba.fri ) as fri_flag
		,max( ba.sat ) as sat_flag
		,max( ba.sun ) as sun_flag
	from rpt.Volunteer_Rpt_v v
	inner join cal dt
		on dt.cal_dt between v.enrollment_1_start_date and coalesce( v.enrollment_1_end_date, '2030-01-01' )
	inner join dbo.ba_event_snp ba
		on v.ba_volunteer_num = ba.ba_volunteer_num
		and dt.cal_dt between ba.start_date and ba.end_date
	where enrollment_1_code in ( 'BBO' )
	group by volunteer_key
),

actuals as (
	select distinct
		 v.volunteer_key
		,dr.Dept_Role_Key as dept_asgn_key
		,v.volunteer_name
		,v.volunteer_name_short
		,v.Enrollment_1_code as enrollment_code
		,coalesce( v.dept_1_hpr_dept_key, v.dept_2_hpr_dept_key ) as hpr_dept_key
		,dr.crew_name
		,dr.dept_role
		,dr.dept_asgn_status_code
		,c.cal_dt
        ,coalesce( dr.role_start_date, cast( dateadd( wk, datediff( wk, 0, getdate() ), 0 ) as date ) ) as role_start_date
        ,coalesce( dr.role_end_date,'2030-03-01' ) as role_end_date
		,case 
			when v.Enrollment_1_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV', 'BCL', 'BRS' ) then 1 
			else 0 
		 end as bed_cnt
		,case 
			when v.Enrollment_1_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV', 'BCL', 'BRS' ) then 1
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) then 0.2
			else 0
		 end as fte
		,case 
			when v.Enrollment_1_code in ( 'BCS', 'BBR', 'BCF', 'BBF', 'BCV', 'BCL', 'BBV', 'BCC' ) then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 2 and v.dept_1_mon_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 3 and v.dept_1_tue_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 4 and v.dept_1_wed_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 5 and v.dept_1_thu_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBV', 'BCC' ) and c.day_of_wk = 6 and v.dept_1_fri_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 2 and bbo.mon_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 3 and bbo.tue_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 4 and bbo.wed_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 5 and bbo.thu_flag = 'Y' then 'Y'
			when v.Enrollment_1_code in ( 'BBO' ) and c.day_of_wk = 6 and bbo.fri_flag = 'Y' then 'Y'
			else 'N' 
		 end as onsite_flag
		,v.Room_Site_Code
		,v.Room_Bldg
		,v.Room_Bldg_Code
		,v.Room
		,v.record_type
	from rpt.volunteer_rpt_v v
	inner join cal c -- JOIN ON DEPT 1 OR DEPT 2 IF ITS A HPR ASSIGNMENT
		on ( c.cal_dt between coalesce( v.dept_1_start_date, v.enrollment_1_start_date ) and coalesce( coalesce( v.dept_1_end_date, v.enrollment_1_end_date ), '2030-12-31' ) and v.dept_1_hpr_flag = 'Y' )
		or ( c.cal_dt between coalesce( v.dept_2_start_date, v.enrollment_2_start_date ) and coalesce( coalesce( v.dept_2_end_date, v.enrollment_2_end_date ), '2030-12-31' ) and v.dept_2_hpr_flag = 'Y' )
	left join bbo 
		on v.volunteer_key = bbo.volunteer_key
	left join dbo.Dept_Role_Volunteer_v drv
		on v.volunteer_key = drv.volunteer_key
		and v.enrollment_1_code = drv.ps_enrollment_code
		and c.cal_dt between drv.vol_start_date and coalesce( drv.vol_end_date, '2030-12-31' )
		and drv.active_flag = 'Y'
		and drv.Dept_Asgn_Status_Key not in ( 19, 22 ) -- DO NOT PURSUE, DEPARTED
	left join dbo.Dept_Role_v dr
		on drv.Dept_Role_Key = dr.Dept_Role_Key
	where isnull(drv.Volunteer_Type_Description, 'VOLUNTEER') = 'VOLUNTEER' ),
	
projected as (
	select 
		 v.volunteer_key
		,v.Dept_Role_Key as dept_asgn_key
		,v.volunteer_name
		,v.volunteer_name_short
		,v.enrollment_code
		,v.hpr_dept_key
		,v.crew_name
		,v.dept_role
		,v.dept_asgn_status_code
		,v.cal_dt
	    ,coalesce( v.role_start_date, cast( dateadd( wk, datediff( wk, 0, getdate() ), 0 ) as date ) ) as role_start_date
        ,coalesce( v.role_end_date,'2030-03-01' ) as role_end_date
		,v.bed_cnt
		,v.fte
		,v.onsite_flag
		,null as Room_Site_Code
		,null as Room_Bldg
		,null as Room_Bldg_Code
		,null as Room		
		,v.record_type
	from rpt.Volunteer_Projected_v v
	inner join cal c
		on c.cal_dt = v.cal_dt
),

base as (
	select * from actuals 
	union all
	select * from projected 
)

select *
from base
--where cal_dt = '2025-10-27'
--	and volunteer_key in (641583)
--order by 3
go


if object_id('rpt.Staffing_Tool_v', 'V') is not null
	drop view rpt.Staffing_Tool_v
go 
create view rpt.Staffing_Tool_v
as
select
	 volunteer_key
	,HUB_Volunteer_Num
	,hub_person_id
	,HUB_Person_GUID
	,BA_Volunteer_Num
	,first_name
	,last_name
	,volunteer_name
	,volunteer_name_short
	,Gender_Code
	,Marital_Status_code
	,Cong_Servant_Code
	,cong_midweek_mt_dow
	,cong_midweek_mt_time
	,cong_weekend_mt_dow
	,cong_weekend_mt_time
	,age
	,address
	,city
	,state_code
	,postal_code
	,home_phone
	,mobile_phone
	,bethel_email
	,jwpub_email
	,spouse_hub_person_id
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email
	,enrollment_1_code
	,enrollment_1_site_code
	,enrollment_1_start_date
	,enrollment_1_start_date_raw
	,enrollment_1_end_date
	,enrollment_2_code
	,enrollment_2_site_code
	,enrollment_2_start_date
	,enrollment_2_start_date_raw
	,enrollment_2_end_date
	,dept_1_hpr_dept_key
	,dept_1_hub_dept_id
	,dept_1_cpc_code
	,dept_1_parent_dept_name
	,dept_1_dept_name
	,dept_1_ovsr_name
	,dept_1_start_date
	,dept_1_end_date
	,dept_1_temp_flag
	,dept_1_primary_flag
	,dept_1_split_asgn_flag
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
	,dept_2_hpr_dept_key
	,dept_2_hub_dept_id
	,dept_2_cpc_code
	,dept_2_parent_dept_name
	,dept_2_dept_name
	,dept_2_ovsr_name
	,dept_2_start_date
	,dept_2_end_date
	,dept_2_temp_flag
	,dept_2_primary_flag
	,dept_2_split_asgn_flag
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
	,loan_dept_name
	,tentative_end_date
	,room_site_code
	,room_bldg
	,room_bldg_code
	,room_bldg_desc
	,room
	,staffing_number_exception_flag
	,record_type
	,work_days
	,hpr_flag
	,base_helmet_id
	,rownum
	,helmet_id
	,enrollment_status
from rpt.Volunteer_All_v 

union all

select 
	 p.volunteer_key
	,null as HUB_Volunteer_Num
	,null as hub_person_id
	,null as HUB_Person_GUID
	,null as BA_Volunteer_Num
	,'********' as first_name
	,'********' as last_name
	,'********' as volunteer_name
	,'********' as volunteer_name_short
	,v.Gender_Code
	,ms.Marital_Status_code
	,v.Cong_Servant_Code
	,null as cong_midweek_mt_dow
	,null as cong_midweek_mt_time
	,null as cong_weekend_mt_dow
	,null as cong_weekend_mt_time
	,null as age
	,null as address
	,null as city
	,null as state_code
	,null as postal_code
	,null as home_phone
	,null as mobile_phone
	,null as bethel_email
	,null as jwpub_email
	,null as spouse_hub_person_id
	,null as spouse_hub_volunteer_num
	,null as spouse_bethel_email
	,null as spouse_jwpub_email
	,p.enrollment_1_code
	,'RMP' as enrollment_1_site_code
	,p.enrollment_1_start_date
	,p.enrollment_1_start_date as enrollment_1_start_date_raw
	,p.enrollment_1_end_date
	,null as enrollment_2_code
	,null as enrollment_2_site_code
	,null as enrollment_2_start_date
	,null as enrollment_2_start_date_raw
	,null as enrollment_2_end_date
	,p.dept_1_hpr_dept_key
	,p.dept_1_hub_dept_id
	,p.dept_1_cpc_code
	,p.dept_1_parent_dept_name
	,p.dept_1_dept_name
	,d.Dept_Ovsr as dept_1_ovsr_name
	,p.dept_1_start_date
	,p.dept_1_end_date
	,'N' as dept_1_temp_flag
	,'Y' as dept_1_primary_flag
	,'N' as dept_1_split_asgn_flag
	,null as dept_1_split_allocation_pct
	,'Y' as dept_1_hpr_flag
	,null as dept_1_pc_category
	,null as dept_1_mon_flag
	,null as dept_1_tue_flag
	,null as dept_1_wed_flag
	,null as dept_1_thu_flag
	,null as dept_1_fri_flag
	,null as dept_1_sat_flag
	,null as dept_1_sun_flag
	,null as dept_2_hpr_dept_key
	,null as dept_2_hub_dept_id
	,null as dept_2_cpc_code
	,null as dept_2_parent_dept_name
	,null as dept_2_dept_name
	,null as dept_2_ovsr_name
	,null as dept_2_start_date
	,null as dept_2_end_date
	,null as dept_2_temp_flag
	,null as dept_2_primary_flag
	,null as dept_2_split_asgn_flag
	,null as dept_2_split_allocation_pct
	,null as dept_2_hpr_flag
	,null as dept_2_pc_category
	,null as dept_2_mon_flag
	,null as dept_2_tue_flag
	,null as dept_2_wed_flag
	,null as dept_2_thu_flag
	,null as dept_2_fri_flag
	,null as dept_2_sat_flag
	,null as dept_2_sun_flag
	,null as loan_dept_name
	,null as tentative_end_date
	,null as room_site_code
	,null as room_bldg
	,null as room_bldg_code
	,null as room_bldg_desc
	,null as room
	,null as staffing_number_exception_flag
	,p.record_type
	,null as work_days
	,'Y' as hpr_flag
	,null as base_helmet_id
	,null as rownum
	,null as helmet_id
	,'REQUESTED' as enrollment_status
from rpt.Volunteer_Projected_v p
inner join dbo.volunteer v
	on p.volunteer_key = v.volunteer_key
inner join dbo.Marital_Status ms
	on v.Marital_Status_Key = ms.Marital_Status_Key
inner join dbo.hpr_dept d
	on p.hpr_dept_key = d.HPR_Dept_Key
where 1=1
	and p.cal_dt = cast( getdate() as date )

union all

select
	 volunteer_key
	,HUB_Volunteer_Num
	,hub_person_id
	,HUB_Person_GUID
	,BA_Volunteer_Num
	,first_name
	,last_name
	,volunteer_name
	,last_name + ', ' + left( first_name, 1 ) + '.' as volunteer_name_short
	,Gender_Code
	,Marital_Status_code
	,null as Cong_Servant_Code
	,null as cong_midweek_mt_dow
	,null as cong_midweek_mt_time
	,null as cong_weekend_mt_dow
	,null as cong_weekend_mt_time
	,age
	,address
	,city
	,state_code
	,postal_code
	,home_phone
	,mobile_phone
	,bethel_email
	,jwpub_email
	,null as spouse_hub_person_id
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email
	,enrollment_code as enrollment_1_code
	,enrollment_site_code as enrollment_1_site_code
	,enrollment_start_date as enrollment_1_start_date
	,enrollment_start_date as enrollment_1_start_date_raw
	,enrollment_end_date as enrollment_1_end_date
	,null as enrollment_2_code
	,null as enrollment_2_site_code
	,null as enrollment_2_start_date
	,null as enrollment_2_start_date_raw
	,null as enrollment_2_end_date
	,null as dept_1_hpr_dept_key
	,null as dept_1_hub_dept_id
	,null as dept_1_cpc_code
	,parent_dept_name as dept_1_parent_dept_name
	,dept_name as dept_1_dept_name
	,null as dept_1_ovsr_name
	,null as dept_1_start_date
	,null as dept_1_end_date
	,temp_flag as dept_1_temp_flag
	,primary_flag as dept_1_primary_flag
	,split_asgn_flag as dept_1_split_asgn_flag
	,null asdept_1_split_allocation_pct
	,'Y' as dept_1_hpr_flag
	,pc_category as dept_1_pc_category
	,mon_flag as dept_1_mon_flag
	,tue_flag as dept_1_tue_flag
	,wed_flag as dept_1_wed_flag
	,thu_flag as dept_1_thu_flag
	,fri_flag as dept_1_fri_flag
	,sat_flag as dept_1_sat_flag
	,sun_flag as dept_1_sun_flag
	,null as dept_2_hpr_dept_key
	,null as dept_2_hub_dept_id
	,null as dept_2_cpc_code
	,null as dept_2_parent_dept_name
	,null as dept_2_dept_name
	,null as dept_2_ovsr_name
	,null as dept_2_start_date
	,null as dept_2_end_date
	,null as dept_2_temp_flag
	,null as dept_2_primary_flag
	,null as dept_2_split_asgn_flag
	,null as dept_2_split_allocation_pct
	,null as dept_2_hpr_flag
	,null as dept_2_pc_category
	,null as dept_2_mon_flag
	,null as dept_2_tue_flag
	,null as dept_2_wed_flag
	,null as dept_2_thu_flag
	,null as dept_2_fri_flag
	,null as dept_2_sat_flag
	,null as dept_2_sun_flag
	,loan_dept_name
	,null as tentative_end_date
	,null as room_site_code
	,null as room_bldg
	,null as room_bldg_code
	,null as room_bldg_desc
	,null as room
	,'N' as staffing_number_exception_flag
	,null as record_type
	,null as work_days
	,'Y' as hpr_flag
	,null as base_helmet_id
	,null as rownum
	,null as helmet_id
	,'DEPARTED' as enrollment_status
from rpt.Volunteer_Departure_v
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


if object_id('rpt.Volunteer_Projected_v', 'V') is not null
	drop view rpt.Volunteer_Projected_v
go 
create view rpt.Volunteer_Projected_v
as
with cal as (
	select cal_dt, day_of_wk, day_nm, day_of_mth 
	from dbo.cal_dim 
	where cal_dt between '2020-01-01' and '2030-03-01' 
)

select
	 drv.volunteer_key
	,dr.Dept_Role_Key
	,drv.full_name as volunteer_name
	,coalesce( drv.volunteer_name_short, drv.ps_enrollment_code, dr.dept_enrollment_code ) as volunteer_name_short
	,c.cal_dt
	,dr.hpr_dept_key
	,coalesce( drv.ps_enrollment_code, dr.dept_enrollment_code ) as enrollment_code
	,dr.crew_name
	,dr.dept_role
	,drv.dept_asgn_status_code
    ,dr.role_start_date_rpt as role_start_date
    ,dr.role_end_date_rpt as role_end_date
	,case 
		when coalesce( drv.ps_enrollment_code, dr.dept_enrollment_code ) in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV', 'BCL', 'BRS' ) then 1 
		else 0 
	 end as bed_cnt
	,case 
		when coalesce( drv.ps_enrollment_code, dr.dept_enrollment_code ) in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV', 'BCL', 'BRS' ) then 1
		when coalesce( drv.ps_enrollment_code, dr.dept_enrollment_code ) in ( 'BBV', 'BCC' ) then 0.2
		else 0
		end as fte
	,'N' as onsite_flag
	,'PROJECTED' as record_type
	-- ADDED FOR CI TOOL BEING BUILT BY OS
	,drv.HUB_Person_ID
	,coalesce( drv.ps_enrollment_code, dr.dept_enrollment_code ) as enrollment_1_code
	,coalesce( drv.vol_start_date, dr.role_start_date_rpt ) as enrollment_1_start_date
	,coalesce( drv.vol_end_date, dr.role_end_date_rpt ) as enrollment_1_end_date
	,dr.hpr_dept_key as dept_1_hpr_dept_key
	,d.HUB_Dept_ID as dept_1_hub_dept_id
	,d.CPC_Code as dept_1_cpc_code
	,case 
		when d.level_06 is not null then d.level_05 
		when d.level_05 is not null then d.level_04
		when d.level_04 is not null then d.level_03
		when d.level_03 is not null then d.level_02
		else d.level_01
	  end as dept_1_parent_dept_name
	,case 
		when d.level_06 is not null then d.level_06
		when d.level_05 is not null then d.level_05
		when d.level_04 is not null then d.level_04
		when d.level_03 is not null then d.level_03
		when d.level_02 is not null then d.level_02
		else d.level_01
	  end as dept_1_dept_name
	,coalesce( drv.vol_start_date, dr.role_start_date_rpt ) as dept_1_start_date
	,coalesce( drv.vol_end_date, dr.role_end_date_rpt ) as dept_1_end_date
	,'Y' as dept_1_hpr_flag
from dbo.Dept_Role_v dr
inner join cal c
	on c.cal_dt between dr.role_start_date_rpt and dr.role_end_date_rpt
inner join dbo.hpr_dept d
	on dr.hpr_dept_key = d.hpr_dept_key
	and d.Active_Flag = 'Y'
left join dbo.Dept_Role_Volunteer_v drv
	on dr.Dept_Role_Key = drv.Dept_Role_Key	
	and drv.Volunteer_Type_Description = 'VOLUNTEER'
where dr.active_flag = 'Y'
	and dr.Dept_Asgn_Status_Key not in ( 19, 22 ) -- DO NOT PURSUE, DEPARTED
	--and dr.dept_role_key = 655
	--and d.hpr_dept_key = 217
	--and c.cal_dt = '2025-11-03'
	and not exists ( 
		select 1 from rpt.volunteer_rpt_v act 
		where coalesce( drv.volunteer_key, -1 ) = act.volunteer_key 
			and coalesce( drv.ps_enrollment_code, dr.dept_enrollment_code ) = act.enrollment_1_code )
go


if object_id('rpt.Volunteer_v', 'V') is not null
	drop view rpt.Volunteer_v
go 
create view rpt.Volunteer_v
as
with base as (
	select  
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code
		,v.cong_servant_code
		,c.midweek_meeting_dow as cong_midweek_mt_dow
		,c.midweek_meeting_time as cong_midweek_mt_time
		,c.weekend_meeting_dow as cong_weekend_mt_dow
		,c.weekend_meeting_time as cong_weekend_mt_time
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
		,d1.hpr_dept_key as dept_1_hpr_dept_key
		,vd1.hub_dept_id as dept_1_hub_dept_id
		,d1.cpc_code as dept_1_cpc_code
		,vd1.Parent_Dept_Name as dept_1_parent_dept_name
		,vd1.Dept_Name as dept_1_dept_name
		,coalesce( d1.work_group_ovsr, d1.dept_ovsr ) as dept_1_ovsr_name		
		,vd1.start_date as dept_1_start_date
		,vd1.end_date as dept_1_end_date
		,vd1.temp_flag as dept_1_temp_flag
		,vd1.primary_flag as dept_1_primary_flag
		,case when vd1.Primary_Flag = 'N' then 'Y' else 'N' end as dept_1_split_asgn_flag
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
		,d2.hpr_dept_key as dept_2_hpr_dept_key
		,vd2.hub_dept_id as dept_2_hub_dept_id
		,d2.cpc_code as dept_2_cpc_code
		,vd2.Parent_Dept_Name as dept_2_parent_dept_name
		,vd2.Dept_Name as dept_2_dept_name
		,coalesce( d2.work_group_ovsr, d2.dept_ovsr ) as dept_2_ovsr_name		
		,vd2.start_date as dept_2_start_date
		,vd2.end_date as dept_2_end_date
		,vd2.temp_flag as dept_2_temp_flag
		,vd2.primary_flag as dept_2_primary_flag
		,case when vd2.Primary_Flag = 'N' then 'Y' else 'N' end as dept_2_split_asgn_flag
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
		,v.mate_hub_person_id as spouse_hub_person_id
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
		,nullif( v.Room_Site_Code, '' ) as room_site_code
		,nullif( v.Room_Bldg, '' ) as room_bldg
		,nullif( v.Room_Bldg_Code, '' ) as room_bldg_code
		,nullif( left( v.room, charindex( '-', v.room ) - 1 ), '' ) as room_bldg_desc
		,nullif( v.Room, '' ) as room
		,v.staffing_number_exception_flag
		,'HPR' as record_type
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
	left join dbo.cong c
		on v.Cong_Key = c.Cong_Key
	where 1=1
		and v.hpr_volunteer_exception_flag = 'N'
		--and v.volunteer_key = 238580
),

exceptions as (
	select 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code
		,v.cong_servant_code
		,c.midweek_meeting_dow
		,c.midweek_meeting_time
		,c.weekend_meeting_dow
		,c.weekend_meeting_time
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
		,d1.hpr_dept_key as dept_1_hpr_dept_key		
		,vd1.hub_dept_id as dept_1_hub_dept_id
		,d1.cpc_code as dept_1_cpc_code
		,vd1.Parent_Dept_Name as dept_1_parent_dept_name
		,vd1.Dept_Name as dept_1_dept_name
		,coalesce( d1.work_group_ovsr, d1.dept_ovsr ) as dept_1_ovsr_name		
		,vd1.start_date as dept_1_start_date
		,vd1.end_date as dept_1_end_date
		,vd1.temp_flag as dept_1_temp_flag
		,vd1.primary_flag as dept_1_primary_flag
		,case when vd1.Primary_Flag = 'N' then 'Y' else 'N' end as dept_1_split_asgn_flag
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
		,d2.hpr_dept_key as dept_2_hpr_dept_key
		,vd2.hub_dept_id as dept_2_hub_dept_id
		,d2.cpc_code as dept_2_cpc_code
		,vd2.Parent_Dept_Name as dept_2_parent_dept_name
		,vd2.Dept_Name as dept_2_dept_name
		,coalesce( d2.work_group_ovsr, d2.dept_ovsr ) as dept_2_ovsr_name		
		,vd2.start_date as dept_2_start_date
		,vd2.end_date as dept_2_end_date
		,vd2.temp_flag as dept_2_temp_flag
		,vd2.primary_flag as dept_2_primary_flag
		,case when vd2.Primary_Flag = 'N' then 'Y' else 'N' end as dept_2_split_asgn_flag
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
		,v.mate_hub_person_id as spouse_hub_person_id
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
		,nullif( v.Room_Site_Code, '' ) as room_site_code
		,nullif( v.Room_Bldg, '' ) as room_bldg
		,nullif( v.Room_Bldg_Code, '' ) as room_bldg_code
		,nullif( left( v.room, charindex( '-', v.room ) - 1 ), '' ) as room_bldg_desc
		,nullif( v.Room, '' ) as room
		,v.staffing_number_exception_flag
		,'EXCEPTION' as record_type
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
	left join dbo.cong c
		on v.Cong_Key = c.Cong_Key
	where v.hpr_volunteer_exception_flag = 'Y'
		--and v.volunteer_key = 908039
),

hpr as (
	select * from base
	union all
	select * from exceptions
),

woodgrove as (
	select 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code
		,v.cong_servant_code
		,c.midweek_meeting_dow
		,c.midweek_meeting_time
		,c.weekend_meeting_dow
		,c.weekend_meeting_time
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
		,d1.hpr_dept_key as dept_1_hpr_dept_key		
		,vd1.hub_dept_id as dept_1_hub_dept_id
		,d1.cpc_code as dept_1_cpc_code
		,vd1.Parent_Dept_Name as dept_1_parent_dept_name
		,vd1.Dept_Name as dept_1_dept_name
		,coalesce( d1.work_group_ovsr, d1.dept_ovsr ) as dept_1_ovsr_name		
		,vd1.start_date as dept_1_start_date
		,vd1.end_date as dept_1_end_date
		,vd1.temp_flag as dept_1_temp_flag
		,vd1.primary_flag as dept_1_primary_flag
		,case when vd1.Primary_Flag = 'N' then 'Y' else 'N' end as dept_1_split_asgn_flag
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
		,d2.hpr_dept_key as dept_2_hpr_dept_key
		,vd2.hub_dept_id as dept_2_hub_dept_id
		,d2.cpc_code as dept_2_cpc_code
		,vd2.Parent_Dept_Name as dept_2_parent_dept_name
		,vd2.Dept_Name as dept_2_dept_name
		,coalesce( d2.work_group_ovsr, d2.dept_ovsr ) as dept_2_ovsr_name		
		,vd2.start_date as dept_2_start_date
		,vd2.end_date as dept_2_end_date
		,vd2.temp_flag as dept_2_temp_flag
		,vd2.primary_flag as dept_2_primary_flag
		,case when vd2.Primary_Flag = 'N' then 'Y' else 'N' end as dept_2_split_asgn_flag
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
		,v.mate_hub_person_id as spouse_hub_person_id
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
		,nullif( v.Room_Site_Code, '' ) as room_site_code
		,nullif( v.Room_Bldg, '' ) as room_bldg
		,nullif( v.Room_Bldg_Code, '' ) as room_bldg_code
		,nullif( left( v.room, charindex( '-', v.room ) - 1 ), '' ) as room_bldg_desc
		,nullif( v.Room, '' ) as room
		,v.staffing_number_exception_flag
		,'WOODGROVE' as record_type
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
	left join dbo.cong c
		on v.Cong_Key = c.Cong_Key
	where 1=1
		and v.room_site_code = 'RMP'
		and v.volunteer_key not in ( select volunteer_key from hpr )
),

guest as (
	select 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_Name
		,v.gender_code
		,ms.marital_status_code
		,v.cong_servant_code
		,c.midweek_meeting_dow
		,c.midweek_meeting_time
		,c.weekend_meeting_dow
		,c.weekend_meeting_time
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
		,d1.hpr_dept_key as dept_1_hpr_dept_key		
		,vd1.hub_dept_id as dept_1_hub_dept_id
		,d1.cpc_code as dept_1_cpc_code
		,vd1.Parent_Dept_Name as dept_1_parent_dept_name
		,vd1.Dept_Name as dept_1_dept_name
		,coalesce( d1.work_group_ovsr, d1.dept_ovsr ) as dept_1_ovsr_name		
		,vd1.start_date as dept_1_start_date
		,vd1.end_date as dept_1_end_date
		,vd1.temp_flag as dept_1_temp_flag
		,vd1.primary_flag as dept_1_primary_flag
		,case when vd1.Primary_Flag = 'N' then 'Y' else 'N' end as dept_1_split_asgn_flag
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
		,d2.hpr_dept_key as dept_2_hpr_dept_key
		,vd2.hub_dept_id as dept_2_hub_dept_id
		,d2.cpc_code as dept_2_cpc_code
		,vd2.Parent_Dept_Name as dept_2_parent_dept_name
		,vd2.Dept_Name as dept_2_dept_name
		,coalesce( d2.work_group_ovsr, d2.dept_ovsr ) as dept_2_ovsr_name		
		,vd2.start_date as dept_2_start_date
		,vd2.end_date as dept_2_end_date
		,vd2.temp_flag as dept_2_temp_flag
		,vd2.primary_flag as dept_2_primary_flag
		,case when vd2.Primary_Flag = 'N' then 'Y' else 'N' end as dept_2_split_asgn_flag
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
		,v.mate_hub_person_id as spouse_hub_person_id
		,mate.hub_volunteer_num as spouse_hub_volunteer_num
		,mate.alt_email as spouse_bethel_email
		,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
		,nullif( v.Room_Site_Code, '' ) as room_site_code
		,nullif( v.Room_Bldg, '' ) as room_bldg
		,nullif( v.Room_Bldg_Code, '' ) as room_bldg_code
		,nullif( left( v.room, charindex( '-', v.room ) - 1 ), '' ) as room_bldg_desc
		,nullif( v.Room, '' ) as room
		,v.staffing_number_exception_flag
		,'GUEST' as record_type
	from dbo.volunteer v
	inner join dbo.marital_status ms 
		on v.marital_status_key = ms.marital_status_key
	left join dbo.state s
		on v.State_Key = s.State_Key
	left join dbo.Postal_Code pc
		on v.Postal_Code_Key = pc.Postal_Code_Key
	inner join dbo.volunteer_enrollment_rpt ve1
		on v.volunteer_key = ve1.volunteer_key
		and ve1.row_num = 1
	left join dbo.volunteer_enrollment_rpt ve2
		on v.volunteer_key = ve2.volunteer_key
		and ve2.row_num = 2
	left join dbo.volunteer_dept_rpt vd1
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
	left join dbo.cong c
		on v.Cong_Key = c.Cong_Key
	inner join stg.stg_rooming r
		on v.hub_person_id = r.person_id 
	where 1=1
		and r.overnight_guest_category is not null
		and v.volunteer_key not in ( select volunteer_key from hpr )
		and v.volunteer_key not in ( select volunteer_key from woodgrove )		
		and v.hub_person_id <> 627794
),

final as (
	select * from hpr
	union all
	select * from woodgrove
	union all
	select * from guest
)

select 
	 volunteer_key
 	,hub_volunteer_num
 	,hub_person_id
 	,hub_person_guid
	,cast( ba_volunteer_num as varchar(10) ) as ba_volunteer_num
	,first_name
	,last_name
	,volunteer_name
	,last_name + ', ' + left( first_name, 1 ) + '.' as volunteer_name_short
	,gender_code
	,marital_status_code
	,cong_servant_code
	,cong_midweek_mt_dow
	,cong_midweek_mt_time
	,cong_weekend_mt_dow
	,cong_weekend_mt_time
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
	,spouse_hub_person_id
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email		
	-- BACKWARDS COMPATIBILITY ------
	,enrollment_1_code as enrollment_code
	,coalesce( enrollment_1_site_code, 'UNK' ) as enrollment_site_code
	,case when enrollment_1_start_date < dept_1_start_date then enrollment_1_start_date else dept_1_start_date end as enrollment_start_date
	,enrollment_1_start_date as enrollment_start_date_raw
	,case
		when enrollment_1_code in ( 'BCV' ) then coalesce( enrollment_1_end_date, tentative_end_date )
		else enrollment_1_end_date
	 end as enrollment_end_date	 
	,dept_1_hub_dept_id as hub_dept_id
	,dept_1_parent_dept_name as parent_dept_name
	,dept_1_cpc_code as parent_dept_code
	,dept_1_dept_name as dept_name
	,null as non_hpr_parent_dept_name
	,null as non_hpr_dept_name
	,dept_1_start_date as dept_start_date
	,dept_1_end_date as dept_end_date
	,dept_1_pc_category	as pc_category
	,dept_1_temp_flag as temp_flag
	,dept_1_primary_flag as primary_flag	
	,dept_1_split_asgn_flag as split_asgn_flag
	,dept_1_mon_flag as mon_flag
	,dept_1_tue_flag as tue_flag
	,dept_1_wed_flag as wed_flag
	,dept_1_thu_flag as thu_flag
	,dept_1_fri_flag as fri_flag
	,dept_1_sat_flag as sat_flag
	,dept_1_sun_flag as sun_flag
	---------------------------------	
	,enrollment_1_code
	,coalesce( enrollment_1_site_code, 'UNK' ) as enrollment_1_site_code
	--,case when enrollment_1_start_date < dept_1_start_date then enrollment_1_start_date else dept_1_start_date end as enrollment_1_start_date
	,enrollment_1_start_date
	,enrollment_1_start_date as enrollment_1_start_date_raw
	,case
		when enrollment_1_code in ( 'BCV' ) then coalesce( enrollment_1_end_date, tentative_end_date )
		else enrollment_1_end_date
	 end as enrollment_1_end_date
	,enrollment_2_code
	,enrollment_2_site_code
	,enrollment_2_start_date
	,enrollment_2_start_date as enrollment_2_start_date_raw
	,case
		when enrollment_1_code in ( 'BBV', 'BRV' ) then coalesce( enrollment_2_end_date, tentative_end_date )
		else enrollment_2_end_date
	 end as enrollment_2_end_date
	,dept_1_hpr_dept_key
	,dept_1_hub_dept_id
	,dept_1_cpc_code
	,dept_1_parent_dept_name
	,dept_1_dept_name
	,dept_1_ovsr_name
	,dept_1_start_date
	,dept_1_end_date
	,dept_1_temp_flag
	,dept_1_primary_flag
	,dept_1_split_asgn_flag
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
	,dept_2_hpr_dept_key
	,dept_2_hub_dept_id
	,dept_2_cpc_code
	,dept_2_parent_dept_name
	,dept_2_dept_name
	,dept_2_ovsr_name
	,dept_2_start_date
	,dept_2_end_date
	,dept_2_temp_flag
	,dept_2_primary_flag
	,dept_2_split_asgn_flag
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
	,case when dept_1_temp_flag = 'Y' then dept_1_parent_dept_name + ' > ' + dept_1_dept_name else null end as loan_dept_name
	,tentative_end_date
	,room_site_code
	,room_bldg
	,room_bldg_code
	,room_bldg_desc
	,room
	,staffing_number_exception_flag
	,record_type
from final
go


if object_id('rpt.Volunteer_All_v', 'V') is not null
	drop view rpt.Volunteer_All_v
go 
create view rpt.Volunteer_All_v
as
with base as (
	select 
		 *
		,case 
			when enrollment_1_code in ( 'BBB', 'BBF', 'BBR', 'BCF', 'BCL', 'BCS', 'BCV', 'BRS' ) then 5 
			when enrollment_1_code in ( 'BBO', 'BOC' ) then 0
			else
				( case when dept_1_mon_flag = 'Y' then 1 else 0 end ) + 
				( case when dept_1_tue_flag = 'Y' then 1 else 0 end ) +
				( case when dept_1_wed_flag = 'Y' then 1 else 0 end ) +
				( case when dept_1_thu_flag = 'Y' then 1 else 0 end ) +
				( case when dept_1_fri_flag = 'Y' then 1 else 0 end ) +
				( case when dept_1_sat_flag = 'Y' then 1 else 0 end ) +
				( case when dept_1_sun_flag = 'Y' then 1 else 0 end ) 
		 end as work_days
		,case when record_type in ( 'HPR', 'EXCEPTION' ) then 'Y' else 'N' end as hpr_flag
		,upper( left( first_name, 1 ) + 
		 substring( cast( hub_volunteer_num as varchar(30) ), 3, 1 ) + 
		 substring( first_name, 2, 1 ) + 
		 right( cast( hub_volunteer_num as varchar(30) ), 1 ) + 
		 right( last_name, 1 ) ) as base_helmet_id
	from dbo.Volunteer_v_snp ),

helmet as (
	select 
		volunteer_key
		,row_number() over ( partition by base_helmet_id order by enrollment_1_start_date ) as rownum
	from base )

select 
	 base.* 
	,helmet.rownum
	,case 
		when helmet.rownum = 1 then base.base_helmet_id
		when helmet.rownum between 2 and 27 then base.base_helmet_id + char( 64 + helmet.rownum )	-- a=65, so 64+2=a, up to z=90
		else base.base_helmet_id + '_' + cast( helmet.rownum as varchar )							-- fallback if more than 26 duplicates
	 end as helmet_id
	,case when enrollment_1_start_date > getdate() then 'INVITED' else 'ARRIVED' end as enrollment_status
from base
inner join helmet 
	on base.volunteer_key = helmet.volunteer_key
go


if object_id('rpt.Volunteer_Rpt_v', 'V') is not null
	drop view rpt.Volunteer_Rpt_v
go 
create view rpt.Volunteer_Rpt_v
as
select *
from dbo.Volunteer_v_snp
where record_type in ( 'HPR', 'EXCEPTION' )
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
		and d.cpc_code in ( 'CO', 'DD', 'PCC', 'CI', 'PS', 'VD' )	
		and d.level_01 = 'Headquarters Project Ramapo'		
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
		and v.volunteer_key not in ( select volunteer_key from dbo.Volunteer_v_snp )
		
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
	 v.hub_volunteer_num as volunteer_number
	,v.volunteer_name
	,v.bethel_email
	,v.dept_1_cpc_code as parent_dept_code
	,v.dept_1_parent_dept_name as parent_dept_name
	,v.dept_1_dept_name as dept_name
	,v.enrollment_1_code as enrollment_code
	,v.enrollment_1_start_date as enrollment_start_date
	,v.enrollment_1_end_date as enrollment_end_date
	,t.class_number
	,t.class_name
	,t.host_branch_code	
	,t.course_type
	,t.course_name
	,t.course_desc
	,t.assign_date
	,t.complete_date
	,t.attendance_status	
	,t.active_flag
	,v.volunteer_key
from rpt.volunteer_rpt_v v
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


-- WDC reporting
with raw as (
	select 
		 c.cal_dt
		,v.volunteer_key
		,v.full_name
		,max( v.parent_dept_name ) as parent_dept_nm
		,max( v.dept_name ) as dept_nm
		,max( v.enrollment_code ) as enrl_cd
		,max( v2.room_bldg ) as room_bldg
	from dbo.volunteer_dept_v v
	inner join dbo.volunteer v2
		on v.volunteer_key = v2.volunteer_key
	inner join dbo.cal_dim c
		on c.cal_dt between v.start_date and coalesce( v.end_date, '2030-12-31' )
		and c.day_of_mth = 1
	where 1=1
		and v.site_code = 'RMP' 
		--and c.cal_dt = '2025-03-01'
		--and primary_flag = 'Y'
		--and parent_dept_name = 'Warwick Computer Department' and dept_name = 'CD Engineering'
		--and volunteer_key in (256215,725499,537287,339970,263665, 237671) 
	group by c.cal_dt, v.volunteer_key, v.full_name order by full_name ),
base as (
	select 
		 cal_dt
		,parent_dept_nm
		,dept_nm
		,case 
			when 
				parent_dept_nm like 'HPR%' or 
				parent_dept_nm like '%-RMP' or
				parent_dept_nm in ( 'Headquarters Project Ramapo', 'Architectural', 'Building Group', 'Construction Implementation', 'CPC Office', 'Design Development', 'MEP', 
					'Personnel Support', 'Personnel Support Office', 'Procurement Cost Control', 'Site', 'Support', 'Trade Group' ) or 
				dept_nm like '%-RMP' or
				dept_nm in ( 'Personnel Support Office', 'Personnel Support Office - Volunteer Desk', 'MEP - Electrical' ) then 'Y'
			when parent_dept_nm in ( 'Purchasing Department' ) or dept_nm in ( 'Purchasing Department', 'Global Purchasing Department', 'WHQ CD Engineering', 'CD Engineering' ) then 'N'
			else 'X'
		 end as hpr_flag
		,case
			when enrl_cd in ( 'BCF', 'BCS', 'BCL' ) then '1_BCF_BCS_BCL'
			when enrl_cd in ( 'BRS' ) then '2_BRS'
			when enrl_cd in ( 'BBT', 'BBR', 'BBF', 'BBL' ) then '3_BBT_BBR_BBF_BBL'
			when enrl_cd in ( 'BCV', 'BBC', 'BBW' ) then '4_BCV_BBC_BBW'
			when enrl_cd in ( 'BRV', 'BOC' ) then '5_BRV_BOC'
			when enrl_cd in ( 'BCC', 'BBO', 'BBV' ) then '6_BCC_BBO_BBV'
			else enrl_cd
		 end as enrollment_code
		,volunteer_key
	from raw
	where enrl_cd in ( 'BCF', 'BCS', 'BCL', 'BRS', 'BBT', 'BBR', 'BBF', 'BBL','BCV', 'BBC', 'BBW', 'BRV', 'BOC', 'BCC', 'BBO', 'BBV' ) ),
--select parent_dept_nm, dept_nm, count(*) from base  where hpr_flag <> 'X'  group by parent_dept_nm, dept_nm order by 1,2

grp as (
	select 
		 cal_dt
		,enrollment_code
		,hpr_flag
		,count(*) as total_cnt
	from base
	where 1=1
		and not ( enrollment_code in ( '3_BBT_BBR_BBF_BBL', '5_BRV_BOC' ) and hpr_flag = 'N' )
		and hpr_flag <> 'X'
		and cal_dt between '2019-04-01' and '2025-08-01'
	group by cal_dt, enrollment_code, hpr_flag ),
dw as (
	select 
		 enrollment_code
		,hpr_flag
		,cal_dt
		,coalesce( case when cal_dt = '2019-04-01' then total_cnt end, 0 ) as 'Apr_19'
		,coalesce( case when cal_dt = '2019-05-01' then total_cnt end, 0 ) as 'May_19'
		,coalesce( case when cal_dt = '2019-06-01' then total_cnt end, 0 ) as 'Jun_19'
		,coalesce( case when cal_dt = '2019-07-01' then total_cnt end, 0 ) as 'Jul_19'
		,coalesce( case when cal_dt = '2019-08-01' then total_cnt end, 0 ) as 'Aug_19'
		,coalesce( case when cal_dt = '2019-09-01' then total_cnt end, 0 ) as 'Sep_19'
		,coalesce( case when cal_dt = '2019-10-01' then total_cnt end, 0 ) as 'Oct_19'
		,coalesce( case when cal_dt = '2019-11-01' then total_cnt end, 0 ) as 'Nov_19'
		,coalesce( case when cal_dt = '2019-12-01' then total_cnt end, 0 ) as 'Dec_19'

		,coalesce( case when cal_dt = '2020-01-01' then total_cnt end, 0 ) as 'Jan_20'
		,coalesce( case when cal_dt = '2020-02-01' then total_cnt end, 0 ) as 'Feb_20'
		,coalesce( case when cal_dt = '2020-03-01' then total_cnt end, 0 ) as 'Mar_20'
		,coalesce( case when cal_dt = '2020-04-01' then total_cnt end, 0 ) as 'Apr_20'
		,coalesce( case when cal_dt = '2020-05-01' then total_cnt end, 0 ) as 'May_20'
		,coalesce( case when cal_dt = '2020-06-01' then total_cnt end, 0 ) as 'Jun_20'
		,coalesce( case when cal_dt = '2020-07-01' then total_cnt end, 0 ) as 'Jul_20'
		,coalesce( case when cal_dt = '2020-08-01' then total_cnt end, 0 ) as 'Aug_20'
		,coalesce( case when cal_dt = '2020-09-01' then total_cnt end, 0 ) as 'Sep_20'
		,coalesce( case when cal_dt = '2020-10-01' then total_cnt end, 0 ) as 'Oct_20'
		,coalesce( case when cal_dt = '2020-11-01' then total_cnt end, 0 ) as 'Nov_20'
		,coalesce( case when cal_dt = '2020-12-01' then total_cnt end, 0 ) as 'Dec_20'

		,coalesce( case when cal_dt = '2021-01-01' then total_cnt end, 0 ) as 'Jan_21'
		,coalesce( case when cal_dt = '2021-02-01' then total_cnt end, 0 ) as 'Feb_21'
		,coalesce( case when cal_dt = '2021-03-01' then total_cnt end, 0 ) as 'Mar_21'
		,coalesce( case when cal_dt = '2021-04-01' then total_cnt end, 0 ) as 'Apr_21'
		,coalesce( case when cal_dt = '2021-05-01' then total_cnt end, 0 ) as 'May_21'
		,coalesce( case when cal_dt = '2021-06-01' then total_cnt end, 0 ) as 'Jun_21'
		,coalesce( case when cal_dt = '2021-07-01' then total_cnt end, 0 ) as 'Jul_21'
		,coalesce( case when cal_dt = '2021-08-01' then total_cnt end, 0 ) as 'Aug_21'
		,coalesce( case when cal_dt = '2021-09-01' then total_cnt end, 0 ) as 'Sep_21'
		,coalesce( case when cal_dt = '2021-10-01' then total_cnt end, 0 ) as 'Oct_21'
		,coalesce( case when cal_dt = '2021-11-01' then total_cnt end, 0 ) as 'Nov_21'
		,coalesce( case when cal_dt = '2021-12-01' then total_cnt end, 0 ) as 'Dec_21'

		,coalesce( case when cal_dt = '2022-01-01' then total_cnt end, 0 ) as 'Jan_22'
		,coalesce( case when cal_dt = '2022-02-01' then total_cnt end, 0 ) as 'Feb_22'
		,coalesce( case when cal_dt = '2022-03-01' then total_cnt end, 0 ) as 'Mar_22'
		,coalesce( case when cal_dt = '2022-04-01' then total_cnt end, 0 ) as 'Apr_22'
		,coalesce( case when cal_dt = '2022-05-01' then total_cnt end, 0 ) as 'May_22'
		,coalesce( case when cal_dt = '2022-06-01' then total_cnt end, 0 ) as 'Jun_22'
		,coalesce( case when cal_dt = '2022-07-01' then total_cnt end, 0 ) as 'Jul_22'
		,coalesce( case when cal_dt = '2022-08-01' then total_cnt end, 0 ) as 'Aug_22'
		,coalesce( case when cal_dt = '2022-09-01' then total_cnt end, 0 ) as 'Sep_22'
		,coalesce( case when cal_dt = '2022-10-01' then total_cnt end, 0 ) as 'Oct_22'
		,coalesce( case when cal_dt = '2022-11-01' then total_cnt end, 0 ) as 'Nov_22'
		,coalesce( case when cal_dt = '2022-12-01' then total_cnt end, 0 ) as 'Dec_22'

		,coalesce( case when cal_dt = '2023-01-01' then total_cnt end, 0 ) as 'Jan_23'
		,coalesce( case when cal_dt = '2023-02-01' then total_cnt end, 0 ) as 'Feb_23'
		,coalesce( case when cal_dt = '2023-03-01' then total_cnt end, 0 ) as 'Mar_23'
		,coalesce( case when cal_dt = '2023-04-01' then total_cnt end, 0 ) as 'Apr_23'
		,coalesce( case when cal_dt = '2023-05-01' then total_cnt end, 0 ) as 'May_23'
		,coalesce( case when cal_dt = '2023-06-01' then total_cnt end, 0 ) as 'Jun_23'
		,coalesce( case when cal_dt = '2023-07-01' then total_cnt end, 0 ) as 'Jul_23'
		,coalesce( case when cal_dt = '2023-08-01' then total_cnt end, 0 ) as 'Aug_23'
		,coalesce( case when cal_dt = '2023-09-01' then total_cnt end, 0 ) as 'Sep_23'
		,coalesce( case when cal_dt = '2023-10-01' then total_cnt end, 0 ) as 'Oct_23'
		,coalesce( case when cal_dt = '2023-11-01' then total_cnt end, 0 ) as 'Nov_23'
		,coalesce( case when cal_dt = '2023-12-01' then total_cnt end, 0 ) as 'Dec_23'

		,coalesce( case when cal_dt = '2024-01-01' then total_cnt end, 0 ) as 'Jan_24'
		,coalesce( case when cal_dt = '2024-02-01' then total_cnt end, 0 ) as 'Feb_24'
		,coalesce( case when cal_dt = '2024-03-01' then total_cnt end, 0 ) as 'Mar_24'
		,coalesce( case when cal_dt = '2024-04-01' then total_cnt end, 0 ) as 'Apr_24'
		,coalesce( case when cal_dt = '2024-05-01' then total_cnt end, 0 ) as 'May_24'
		,coalesce( case when cal_dt = '2024-06-01' then total_cnt end, 0 ) as 'Jun_24'
		,coalesce( case when cal_dt = '2024-07-01' then total_cnt end, 0 ) as 'Jul_24'
		,coalesce( case when cal_dt = '2024-08-01' then total_cnt end, 0 ) as 'Aug_24'
		,coalesce( case when cal_dt = '2024-09-01' then total_cnt end, 0 ) as 'Sep_24'
		,coalesce( case when cal_dt = '2024-10-01' then total_cnt end, 0 ) as 'Oct_24'
		,coalesce( case when cal_dt = '2024-11-01' then total_cnt end, 0 ) as 'Nov_24'
		,coalesce( case when cal_dt = '2024-12-01' then total_cnt end, 0 ) as 'Dec_24'

		,coalesce( case when cal_dt = '2025-01-01' then total_cnt end, 0 ) as 'Jan_25'
		,coalesce( case when cal_dt = '2025-02-01' then total_cnt end, 0 ) as 'Feb_25'
		,coalesce( case when cal_dt = '2025-03-01' then total_cnt end, 0 ) as 'Mar_25'
		,coalesce( case when cal_dt = '2025-04-01' then total_cnt end, 0 ) as 'Apr_25'
		,coalesce( case when cal_dt = '2025-05-01' then total_cnt end, 0 ) as 'May_25'
		,coalesce( case when cal_dt = '2025-06-01' then total_cnt end, 0 ) as 'Jun_25'
		,coalesce( case when cal_dt = '2025-07-01' then total_cnt end, 0 ) as 'Jul_25'
		,coalesce( case when cal_dt = '2025-08-01' then total_cnt end, 0 ) as 'Aug_25'
		,coalesce( case when cal_dt = '2025-09-01' then total_cnt end, 0 ) as 'Sep_25'
		,coalesce( case when cal_dt = '2025-10-01' then total_cnt end, 0 ) as 'Oct_25'
		,coalesce( case when cal_dt = '2025-11-01' then total_cnt end, 0 ) as 'Nov_25'
		,coalesce( case when cal_dt = '2025-12-01' then total_cnt end, 0 ) as 'Dec_25'

		,coalesce( case when cal_dt = '2026-01-01' then total_cnt end, 0 ) as 'Jan_26'
		,coalesce( case when cal_dt = '2026-02-01' then total_cnt end, 0 ) as 'Feb_26'
		,coalesce( case when cal_dt = '2026-03-01' then total_cnt end, 0 ) as 'Mar_26'
		,coalesce( case when cal_dt = '2026-04-01' then total_cnt end, 0 ) as 'Apr_26'
		,coalesce( case when cal_dt = '2026-05-01' then total_cnt end, 0 ) as 'May_26'
		,coalesce( case when cal_dt = '2026-06-01' then total_cnt end, 0 ) as 'Jun_26'
		,coalesce( case when cal_dt = '2026-07-01' then total_cnt end, 0 ) as 'Jul_26'
		,coalesce( case when cal_dt = '2026-08-01' then total_cnt end, 0 ) as 'Aug_26'
		,coalesce( case when cal_dt = '2026-09-01' then total_cnt end, 0 ) as 'Sep_26'
		,coalesce( case when cal_dt = '2026-10-01' then total_cnt end, 0 ) as 'Oct_26'
		,coalesce( case when cal_dt = '2026-11-01' then total_cnt end, 0 ) as 'Nov_26'
		,coalesce( case when cal_dt = '2026-12-01' then total_cnt end, 0 ) as 'Dec_26'

		,coalesce( case when cal_dt = '2027-01-01' then total_cnt end, 0 ) as 'Jan_27'
		,coalesce( case when cal_dt = '2027-02-01' then total_cnt end, 0 ) as 'Feb_27'
		,coalesce( case when cal_dt = '2027-03-01' then total_cnt end, 0 ) as 'Mar_27'
		,coalesce( case when cal_dt = '2027-04-01' then total_cnt end, 0 ) as 'Apr_27'
		,coalesce( case when cal_dt = '2027-05-01' then total_cnt end, 0 ) as 'May_27'
		,coalesce( case when cal_dt = '2027-06-01' then total_cnt end, 0 ) as 'Jun_27'
		,coalesce( case when cal_dt = '2027-07-01' then total_cnt end, 0 ) as 'Jul_27'
		,coalesce( case when cal_dt = '2027-08-01' then total_cnt end, 0 ) as 'Aug_27'
		,coalesce( case when cal_dt = '2027-09-01' then total_cnt end, 0 ) as 'Sep_27'
		,coalesce( case when cal_dt = '2027-10-01' then total_cnt end, 0 ) as 'Oct_27'
		,coalesce( case when cal_dt = '2027-11-01' then total_cnt end, 0 ) as 'Nov_27'
		,coalesce( case when cal_dt = '2027-12-01' then total_cnt end, 0 ) as 'Dec_27'

		,coalesce( case when cal_dt = '2028-01-01' then total_cnt end, 0 ) as 'Jan_28'
		,coalesce( case when cal_dt = '2028-02-01' then total_cnt end, 0 ) as 'Feb_28'
		,coalesce( case when cal_dt = '2028-03-01' then total_cnt end, 0 ) as 'Mar_28'
		,coalesce( case when cal_dt = '2028-04-01' then total_cnt end, 0 ) as 'Apr_28'
		,coalesce( case when cal_dt = '2028-05-01' then total_cnt end, 0 ) as 'May_28'
		,coalesce( case when cal_dt = '2028-06-01' then total_cnt end, 0 ) as 'Jun_28'
		,coalesce( case when cal_dt = '2028-07-01' then total_cnt end, 0 ) as 'Jul_28'
		,coalesce( case when cal_dt = '2028-08-01' then total_cnt end, 0 ) as 'Aug_28'
		,coalesce( case when cal_dt = '2028-09-01' then total_cnt end, 0 ) as 'Sep_28'
		,coalesce( case when cal_dt = '2028-10-01' then total_cnt end, 0 ) as 'Oct_28'
		,coalesce( case when cal_dt = '2028-11-01' then total_cnt end, 0 ) as 'Nov_28'
		,coalesce( case when cal_dt = '2028-12-01' then total_cnt end, 0 ) as 'Dec_28'
	from grp )
select 
	 enrollment_code
	,hpr_flag
	,sum( apr_19 ) as apr_19
	,sum( may_19 ) as may_19
	,sum( jun_19 ) as jun_19
	,sum( jul_19 ) as jul_19
	,sum( aug_19 ) as aug_19
	,sum( sep_19 ) as sep_19
	,sum( oct_19 ) as oct_19
	,sum( nov_19 ) as nov_19
	,sum( dec_19 ) as dec_19
	
	,sum( jan_20 ) as jan_20
	,sum( feb_20 ) as feb_20
	,sum( mar_20 ) as mar_20
	,sum( apr_20 ) as apr_20
	,sum( may_20 ) as may_20
	,sum( jun_20 ) as jun_20
	,sum( jul_20 ) as jul_20
	,sum( aug_20 ) as aug_20
	,sum( sep_20 ) as sep_20
	,sum( oct_20 ) as oct_20
	,sum( nov_20 ) as nov_20
	,sum( dec_20 ) as dec_20
	
	,sum( jan_21 ) as jan_21
	,sum( feb_21 ) as feb_21
	,sum( mar_21 ) as mar_21
	,sum( apr_21 ) as apr_21
	,sum( may_21 ) as may_21
	,sum( jun_21 ) as jun_21
	,sum( jul_21 ) as jul_21
	,sum( aug_21 ) as aug_21
	,sum( sep_21 ) as sep_21
	,sum( oct_21 ) as oct_21
	,sum( nov_21 ) as nov_21
	,sum( dec_21 ) as dec_21
	
	,sum( jan_22 ) as jan_22
	,sum( feb_22 ) as feb_22
	,sum( mar_22 ) as mar_22
	,sum( apr_22 ) as apr_22
	,sum( may_22 ) as may_22
	,sum( jun_22 ) as jun_22
	,sum( jul_22 ) as jul_22
	,sum( aug_22 ) as aug_22
	,sum( sep_22 ) as sep_22
	,sum( oct_22 ) as oct_22
	,sum( nov_22 ) as nov_22
	,sum( dec_22 ) as dec_22

	,sum( jan_23 ) as jan_23
	,sum( feb_23 ) as feb_23
	,sum( mar_23 ) as mar_23
	,sum( apr_23 ) as apr_23
	,sum( may_23 ) as may_23
	,sum( jun_23 ) as jun_23
	,sum( jul_23 ) as jul_23
	,sum( aug_23 ) as aug_23
	,sum( sep_23 ) as sep_23
	,sum( oct_23 ) as oct_23
	,sum( nov_23 ) as nov_23
	,sum( dec_23 ) as dec_23

	,sum( jan_24 ) as jan_24
	,sum( feb_24 ) as feb_24
	,sum( mar_24 ) as mar_24
	,sum( apr_24 ) as apr_24
	,sum( may_24 ) as may_24
	,sum( jun_24 ) as jun_24
	,sum( jul_24 ) as jul_24
	,sum( aug_24 ) as aug_24
	,sum( sep_24 ) as sep_24
	,sum( oct_24 ) as oct_24
	,sum( nov_24 ) as nov_24
	,sum( dec_24 ) as dec_24
	
	,sum( jan_25 ) as jan_25
	,sum( feb_25 ) as feb_25
	,sum( mar_25 ) as mar_25
	--,sum( apr_25 ) as apr_25
	--,sum( may_25 ) as may_25
	--,sum( jun_25 ) as jun_25
	--,sum( jul_25 ) as jul_25
	--,sum( aug_25 ) as aug_25
	--,sum( sep_25 ) as sep_25
	--,sum( oct_25 ) as oct_25
	--,sum( nov_25 ) as nov_25
	--,sum( dec_25 ) as dec_25
	
	--,sum( jan_26 ) as jan_26
	--,sum( feb_26 ) as feb_26
	--,sum( mar_26 ) as mar_26
	--,sum( apr_26 ) as apr_26
	--,sum( may_26 ) as may_26
	--,sum( jun_26 ) as jun_26
	--,sum( jul_26 ) as jul_26
	--,sum( aug_26 ) as aug_26
	--,sum( sep_26 ) as sep_26
	--,sum( oct_26 ) as oct_26
	--,sum( nov_26 ) as nov_26
	--,sum( dec_26 ) as dec_26
	
	--,sum( jan_27 ) as jan_27
	--,sum( feb_27 ) as feb_27
	--,sum( mar_27 ) as mar_27
	--,sum( apr_27 ) as apr_27
	--,sum( may_27 ) as may_27
	--,sum( jun_27 ) as jun_27
	--,sum( jul_27 ) as jul_27
	--,sum( aug_27 ) as aug_27
	--,sum( sep_27 ) as sep_27
	--,sum( oct_27 ) as oct_27
	--,sum( nov_27 ) as nov_27
	--,sum( dec_27 ) as dec_27
from dw
where cal_dt < getdate()
group by enrollment_code, hpr_flag
order by enrollment_code, hpr_flag desc


