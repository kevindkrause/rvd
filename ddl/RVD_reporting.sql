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
	,dept_2_parent_dept_name as parent_dept_name
	,dept_2_dept_name as dept_name
	,case 
		when charindex( ' - ', dept_2_dept_name ) = 0 then dept_2_dept_name
		else right( dept_2_dept_name, charindex( ' - ', reverse( dept_2_dept_name ) ) - 1 )
	 end as sub_dept_name
	,enrollment_1_code as enrollment_code
	,enrollment_1_start_date as enrollment_start_date
	,enrollment_1_end_date as enrollment_end_date
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email
	,volunteer_key
	,'Transfer' as enrollment_status
from rpt.Volunteer_Rpt_v
where dept_1_cpc_code is null
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
-- ALL DEPT ASGN BY DAY
with dates as (
	select top 26 cal_dt, rank() over (order by cal_dt ) as wk_num
	from dbo.cal_dim 
	where 1=1
		and day_of_wk = 2
		and cal_dt between cast(getdate()-6 as date) and getdate() + 200 ),

dept_req as (
	select 
		 da.cpc_code
		,da.level_02
		,da.level_03
		,da.level_04
		,da.full_dept_name
		,da.crew_name
		,da.dept_role
		,case
			when da.volunteer_name_short is not null then da.volunteer_name_short
			when c.cal_dt between coalesce( da.ps_start_date, da.dept_start_date ) and coalesce( da.ps_end_date, da.dept_end_date, '2031-12-31' ) then coalesce( da.dept_enrollment_code, da.ps_enrollment_code )
		 end as volunteer_name
		,c.cal_dt
		,coalesce( da.ps_start_date, da.dept_start_date ) as start_date
		,coalesce( da.ps_end_date, da.dept_end_date, '2031-12-31' ) as end_date
		,coalesce( da.dept_enrollment_code, da.ps_enrollment_code ) as enrollment_code
		,da.dept_asgn_status_code as dept_asgn_status
		,case 
			when 
			       da.dept_enrollment_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV' )
				or da.ps_enrollment_code in  ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV' )
			then 1 
			else 0 
		 end as used_bed_cnt
		,da.dept_asgn_key
		,da.hpr_dept_key
		,enrollment_key
		,da.volunteer_key
		,c.wk_num
	from dates c 
	left join dbo.dept_asgn_v da
		on c.cal_dt between coalesce( da.ps_start_date, da.dept_start_date ) and coalesce( da.ps_end_date, da.dept_end_date, '2031-12-31' )
		and da.active_flag = 'Y'
		and da.test_data_flag = 'N' )

select
	 cpc_code
	,level_03
	,level_04
	,crew_name
	,dept_role
	,enrollment_code
	,used_bed_cnt
	,dept_asgn_status
	,dept_asgn_key
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
from dept_req
where 1=1
	--and cpc_code = 'CI'
	--and level_03 = 'Trade Group'
	--and level_04 = 'Siteworks'
	--and used_bed_cnt = 1
group by 
	 cpc_code
	,level_03
	,level_04
	,crew_name
	,dept_role
	,enrollment_code
	,used_bed_cnt
	,dept_asgn_status
	,dept_asgn_key	
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
	and cpc_code in ( 'CO', 'DD', 'PCC', 'PS', 'CI' ) 
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
with base as (
	select 
		 c.cal_dt
		,d.cpc_code
		,d.level_02
		,d.level_03
		,d.level_04
		,d.level_05
		,d.level_06
		,d.pc_code
		,d.pc_category
		,v.enrollment_1_code as enrollment_code
		,enrollment_1_site_code as site_code
		,room_bldg_desc as site_bldg
		,room_bldg_code as site_bldg_code
		,v.volunteer_key
	from rpt.volunteer_rpt_v v
	inner join dbo.hpr_dept d
		on coalesce( v.dept_1_hpr_dept_key, v.dept_2_hpr_dept_key ) = d.hpr_dept_key
	inner join dbo.cal_dim c
		on c.cal_dt between v.enrollment_1_start_date and coalesce( v.enrollment_1_end_date, '12/31/2030' )
		and c.day_of_mth = 1 ),
		
commuters as (
	select volunteer_key, mon + tues + wed + thurs + fri as commute_day_cnt
	from (
		select 
			 volunteer_key
			,sum( case when mon_am_flag = 'Y' then 1 else 0 end ) as mon
			,sum( case when tue_am_flag = 'Y' then 1 else 0 end ) as tues
			,sum( case when wed_am_flag = 'Y' then 1 else 0 end ) as wed
			,sum( case when thu_am_flag = 'Y' then 1 else 0 end ) as thurs
			,sum( case when fri_am_flag = 'Y' then 1 else 0 end ) as fri
		from dbo.Volunteer_Dept_v
		where active_flag = 'Y'
			and enrollment_code in ( 'BBV', 'BCC' )
			--and site_code = 'RMP'
		group by volunteer_key ) x )		

select
	 b.pc_code
	,b.pc_category
	,b.cpc_code
	,b.level_03
	,b.level_04
	,b.level_05
	,b.level_06 
	,b.cal_dt
	,b.enrollment_code
	,b.site_code
	,b.site_bldg
	,b.site_bldg_code
	,sum( case when b.enrollment_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV' ) then 1 else 0 end ) as bed_cnt
	,sum( case when b.enrollment_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV' ) then 0 else 1 end ) as no_bed_cnt
	,cast( sum(
		case 
			when b.enrollment_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV', 'BRS', 'BCL' ) then 5
			when b.enrollment_code in ( 'BBV', 'BCC' ) then coalesce( c.commute_day_cnt, 0 )
			else 0
		 end ) as decimal(5,1) ) / 5 as fte
from base b
left join commuters c
	on b.volunteer_key = c.volunteer_key
where 1=1
	--and cal_dt between '2025-01-01' and '2025-01-01'
	--and level_03 = 'Trade Group'
	--and level_04 = 'Siteworks'
	--and PC_Category = 'Tools'
group by 
	 b.pc_code
	,b.pc_category
	,b.cpc_code
	,b.level_03
	,b.level_04
	,b.level_05
	,b.level_06 
	,b.cal_dt
	,b.enrollment_code
	,b.site_code
	,b.site_bldg
	,b.site_bldg_code 
--order by 1, 2, 3, 4, 5, 6, 7, 8, 9
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
from dbo.PRP_Actuals_Level_04
group by cpc_code
	

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
from dbo.PRP_Actuals_Level_04
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
	where dept_level > 3 ),

lvl_04 as (
	select 
		 cpc_code
		,level_03
		,level_04
		,max( wk_01_dt ) as wk_01_dt
		,max( wk_01_budget ) as wk_01_budget
		,max( wk_01_used ) as wk_01_used
		,max( wk_01_budget ) - max( wk_01_used ) as wk_01_avail
		,max( wk_02_dt ) as wk_02_dt
		,max( wk_02_budget ) as wk_02_budget
		,max( wk_02_used ) as wk_02_used
		,max( wk_02_budget ) - max( wk_02_used ) as wk_02_avail
		,max( wk_03_dt ) as wk_03_dt
		,max( wk_03_budget ) as wk_03_budget
		,max( wk_03_used ) as wk_03_used
		,max( wk_03_budget ) - max( wk_03_used ) as wk_03_avail
		,max( wk_04_dt ) as wk_04_dt
		,max( wk_04_budget ) as wk_04_budget
		,max( wk_04_used ) as wk_04_used
		,max( wk_04_budget ) - max( wk_04_used ) as wk_04_avail
		,max( wk_05_dt ) as wk_05_dt
		,max( wk_05_budget ) as wk_05_budget
		,max( wk_05_used ) as wk_05_used
		,max( wk_05_budget ) - max( wk_05_used ) as wk_05_avail
		,max( wk_06_dt ) as wk_06_dt
		,max( wk_06_budget ) as wk_06_budget
		,max( wk_06_used ) as wk_06_used
		,max( wk_06_budget ) - max( wk_06_used ) as wk_06_avail
		,max( wk_07_dt ) as wk_07_dt
		,max( wk_07_budget ) as wk_07_budget
		,max( wk_07_used ) as wk_07_used
		,max( wk_07_budget ) - max( wk_07_used ) as wk_07_avail
		,max( wk_08_dt ) as wk_08_dt
		,max( wk_08_budget ) as wk_08_budget
		,max( wk_08_used ) as wk_08_used
		,max( wk_08_budget ) - max( wk_08_used ) as wk_08_avail
		,max( wk_09_dt ) as wk_09_dt
		,max( wk_09_budget ) as wk_09_budget
		,max( wk_09_used ) as wk_09_used
		,max( wk_09_budget ) - max( wk_09_used ) as wk_09_avail
		,max( wk_10_dt ) as wk_10_dt
		,max( wk_10_budget ) as wk_10_budget
		,max( wk_10_used ) as wk_10_used
		,max( wk_10_budget ) - max( wk_10_used ) as wk_10_avail
		,max( wk_11_dt ) as wk_11_dt
		,max( wk_11_budget ) as wk_11_budget
		,max( wk_11_used ) as wk_11_used
		,max( wk_11_budget) - max( wk_11_used ) as wk_11_avail
		,max( wk_12_dt ) as wk_12_dt
		,max( wk_12_budget ) as wk_12_budget
		,max( wk_12_used ) as wk_12_used
		,max( wk_12_budget ) - max( wk_12_used ) as wk_12_avail
		,max( wk_13_dt ) as wk_13_dt
		,max( wk_13_budget ) as wk_13_budget
		,max( wk_13_used ) as wk_13_used
		,max( wk_13_budget ) - max( wk_13_used ) as wk_13_avail
		,max( wk_14_dt ) as wk_14_dt
		,max( wk_14_budget ) as wk_14_budget
		,max( wk_14_used ) as wk_14_used
		,max( wk_14_budget ) - max( wk_14_used ) as wk_14_avail
		,max( wk_15_dt ) as wk_15_dt
		,max( wk_15_budget ) as wk_15_budget
		,max( wk_15_used ) as wk_15_used
		,max( wk_15_budget ) - max( wk_15_used ) as wk_15_avail
		,max( wk_16_dt ) as wk_16_dt
		,max( wk_16_budget ) as wk_16_budget
		,max( wk_16_used ) as wk_16_used
		,max( wk_16_budget) - max( wk_16_used ) as wk_16_avail
		,max( wk_17_dt ) as wk_17_dt
		,max( wk_17_budget ) as wk_17_budget
		,max( wk_17_used ) as wk_17_used
		,max( wk_17_budget ) - max( wk_17_used ) as wk_17_avail
		,max( wk_18_dt ) as wk_18_dt
		,max( wk_18_budget ) as wk_18_budget
		,max( wk_18_used ) as wk_18_used
		,max( wk_18_budget ) - max( wk_18_used ) as wk_18_avail
		,max( wk_19_dt ) as wk_19_dt
		,max( wk_19_budget ) as wk_19_budget
		,max( wk_19_used ) as wk_19_used
		,max( wk_19_budget ) - max( wk_19_used ) as wk_19_avail
		,max( wk_20_dt ) as wk_20_dt
		,max( wk_20_budget ) as wk_20_budget
		,max( wk_20_used ) as wk_20_used
		,max( wk_20_budget ) - max( wk_20_used ) as wk_20_avail
		,max( wk_21_dt ) as wk_21_dt
		,max( wk_21_budget ) as wk_21_budget
		,max( wk_21_used ) as wk_21_used
		,max( wk_21_budget) - max( wk_21_used ) as wk_21_avail
		,max( wk_22_dt ) as wk_22_dt
		,max( wk_22_budget ) as wk_22_budget
		,max( wk_22_used ) as wk_22_used
		,max( wk_22_budget ) - max( wk_22_used ) as wk_22_avail
		,max( wk_23_dt ) as wk_23_dt
		,max( wk_23_budget ) as wk_23_budget
		,max( wk_23_used ) as wk_23_used
		,max( wk_23_budget ) - max( wk_23_used ) as wk_23_avail
		,max( wk_24_dt ) as wk_24_dt
		,max( wk_24_budget ) as wk_24_budget
		,max( wk_24_used ) as wk_24_used
		,max( wk_24_budget ) - max( wk_24_used ) as wk_24_avail
		,max( wk_25_dt ) as wk_25_dt
		,max( wk_25_budget ) as wk_25_budget
		,max( wk_25_used ) as wk_25_used
		,max( wk_25_budget ) - max( wk_25_used ) as wk_25_avail
		,max( wk_26_dt ) as wk_26_dt
		,max( wk_26_budget ) as wk_26_budget
		,max( wk_26_used ) as wk_26_used
		,max( wk_26_budget ) - max( wk_26_used ) as wk_26_avail
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
	group by c.cal_dt ),

cpc_beds as (
	select 'CPC Beds' as prp_type, c.cal_dt, p.cpc_code, '' as PC_Code, p.bed_cnt as cpc_bed_cnt
	from rpt.PRP_CPC_v p
	inner join dbo.cal_dim c
		on c.cal_dt between p.start_dt and p.end_dt ),

dept_beds as (
	select 'Dept Beds' as prp_type, p.hpr_dept_key, c.cal_dt, p.cpc_code, p.bed_cnt as dept_avail_bed_cnt, coalesce( nullif( d.work_group_name, '' ), d.dept_name ) as dept_name,  
		case when d.level_02 is null then 1 when d.level_03 is null then 2 when level_04 is null then 3 when level_05 is null then 4 when level_06 is null then 5 end as dept_level
	from rpt.PRP_v p
	inner join dbo.cal_dim c
		on c.cal_dt between p.cal_dt and dateadd(dd, 6-(datepart( dw, p.cal_dt ) -1 ), p.cal_dt )
	inner join dbo.hpr_dept d
		on p.hpr_dept_key = d.hpr_dept_key
		and d.active_flag = 'Y' ),

dept_req_base as (
	select d.hpr_dept_key, c.cal_dt, count(*) as requested_bed_cnt
	from dbo.dept_asgn_v a
	inner join dbo.cal_dim c
		on c.cal_dt between coalesce( a.ps_start_date, a.dept_start_date ) and coalesce( coalesce( a.ps_end_date, a.dept_end_date ), '2031-12-31' )
	inner join dbo.hpr_dept d
		on a.level_04 = d.Level_04
		and d.level_05 is null
		and d.Active_Flag = 'Y'
	where a.active_flag = 'Y'
		and ( a.dept_enrollment_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV' )
			or a.ps_enrollment_code in  ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV' )	)
	group by d.hpr_dept_key, c.cal_dt ),

dept_req as (
	select 'Dept Beds' as prp_type, a.hpr_dept_key, a.cal_dt, d.cpc_code, a.requested_bed_cnt, coalesce( nullif( d.work_group_name, '' ), d.dept_name ) as dept_name,  
		case when d.level_02 is null then 1 when d.level_03 is null then 2 when level_04 is null then 3 when level_05 is null then 4 when level_06 is null then 5 end as dept_level
	from dept_req_base a
	inner join dbo.hpr_dept d
		on a.hpr_dept_key = d.hpr_dept_key
		and d.active_flag = 'Y' ),

dept_used_base as (
	select coalesce( v.dept_1_hpr_dept_key, v.dept_2_hpr_dept_key ) as hpr_dept_key, c.cal_dt, count(*) as used_bed_cnt
	from rpt.volunteer_rpt_v v
	inner join dbo.cal_dim c
		on c.cal_dt between v.enrollment_1_start_date and coalesce( v.enrollment_1_end_date, '12/31/2027' )
	where 1=1
		and v.dept_1_hpr_dept_key is not null
		and v.enrollment_1_code in ( 'BBC', 'BBF', 'BBR', 'BBT', 'BCF', 'BCS', 'BCV' )
	group by coalesce( v.dept_1_hpr_dept_key, v.dept_2_hpr_dept_key ), c.cal_dt ),

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
	--and cal_dt = '2025-02-03' 
	--and d.Level_04 = 'Mechanical'
	--and f.dept_level = 4
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
) core
go


if object_id('rpt.Volunteer_All_v', 'V') is not null
	drop view rpt.Volunteer_All_v
go 
create view rpt.volunteer_all_v
as
select distinct
	 core.volunteer_name
	,core.first_name
	,core.last_name
	,core.hub_volunteer_num
	,core.gender_code
	,core.marital_status_code
	,coalesce( core.cong_servant_code, '' ) as cong_servant_code
	,core.age	
	,core.enrollment_1_site_code
	,core.enrollment_1_code
	,core.enrollment_1_start_date
	,coalesce( convert( varchar, core.enrollment_1_end_date, 23 ), '' ) as enrollment_1_end_date
	,coalesce( core.enrollment_2_site_code, '' ) as enrollment_2_site_code
	,coalesce( core.enrollment_2_code, '' ) as enrollment_2_code
	,coalesce( convert( varchar, core.enrollment_2_start_date, 23 ), '' ) as enrollment_2_start_date
	,coalesce( convert( varchar, core.enrollment_2_end_date, 23 ), '' ) as enrollment_2_end_date
	,core.dept_1_hpr_dept_key
	,case 
		when core.dept_1_parent_dept_name like '%Committee' then core.dept_1_dept_name
		else core.dept_1_parent_dept_name
	 end as dept_1_parent_dept_name
	,core.dept_1_dept_name
	,core.dept_1_ovsr_name
	,core.dept_1_temp_flag
	,core.dept_1_primary_flag
	,coalesce( core.dept_1_split_allocation_pct, '' ) as dept_1_split_allocation_pct
	,core.dept_1_start_date
	,coalesce( convert( varchar, core.dept_1_end_date, 23 ), '' ) as dept_1_end_date
	,core.dept_2_hpr_dept_key
	,coalesce( core.dept_2_parent_dept_name, '' ) as dept_2_parent_dept_name
	,coalesce( core.dept_2_dept_name, '' ) as dept_2_dept_name
	,coalesce( core.dept_2_ovsr_name, '' ) as dept_2_ovsr_name
	,coalesce( core.dept_2_temp_flag, '' ) as dept_2_temp_flag
	,coalesce( core.dept_2_primary_flag, '' ) as dept_2_primary_flag
	,coalesce( core.dept_2_split_allocation_pct, '' ) as dept_2_split_allocation_pct
	,coalesce( convert( varchar, core.dept_2_start_date, 23 ), '' ) as dept_2_start_date
	,coalesce( convert( varchar, core.dept_2_end_date, 23 ), '' ) as dept_2_end_date
	,core.tentative_end_date
	,coalesce( core.room_site_code, '' ) as room_site_code
	,coalesce( core.room_bldg, '' ) as room_bldg
	,coalesce( core.room_bldg_code, '' ) as room_bldg_code
	,coalesce( core.room_bldg_desc, '' ) as room_bldg_desc
	,coalesce( core.room, '' ) as room
	,coalesce( core.bethel_email, '' ) as bethel_email
	,core.hpr_flag
	,case
		when core.work_days <> 5 and core.enrollment_1_code in ( 'BBB', 'BBC', 'BCV' ) then 5
		else core.work_days
	 end as work_days
	,core.volunteer_key
	,core.jwpub_email
	,mate.hub_volunteer_num as spouse_hub_volunteer_num
	,mate.alt_email as spouse_bethel_email
	,mate.jw_username + '@jwpub.org' as spouse_jwpub_email
from (
	select
		 volunteer_name
		,first_name
		,last_name 
		,hub_volunteer_num
		,gender_code
		,marital_status_code
		,cong_servant_code
		,age
		,enrollment_1_site_code
		,enrollment_1_code
		,enrollment_1_start_date
		,enrollment_1_end_date
		,enrollment_2_site_code
		,enrollment_2_code
		,enrollment_2_start_date
		,enrollment_2_end_date
		,dept_1_hpr_dept_key
		,dept_1_parent_dept_name
		,dept_1_dept_name
		,dept_1_ovsr_name
		,dept_1_temp_flag
		,dept_1_primary_flag
		,dept_1_split_allocation_pct
		,dept_1_start_date
		,dept_1_end_date
		,dept_2_hpr_dept_key
		,dept_2_parent_dept_name
		,dept_2_dept_name
		,dept_2_ovsr_name
		,dept_2_temp_flag
		,dept_2_primary_flag
		,dept_2_split_allocation_pct
		,dept_2_start_date
		,dept_2_end_date
		,tentative_end_date
		,room_site_code
		,room_bldg
		,room_bldg_code
		,room_bldg_desc
		,room		
		,bethel_email
		,jwpub_email
		,'Y' as hpr_flag
		,( case when dept_1_mon_flag = 'Y' then 1 else 0 end ) + 
		 ( case when dept_1_tue_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_wed_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_thu_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_fri_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_sat_flag = 'Y' then 1 else 0 end  ) +
		 ( case when dept_1_sun_flag = 'Y' then 1 else 0 end  ) as work_days	 
		,volunteer_key
		,spouse_hub_person_id
	from rpt.volunteer_rpt_v
	where 1=1

	union all

	select 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_name 
		,v.hub_volunteer_num
		,v.gender_code
		,ms.marital_status_code
		,v.cong_servant_code
		,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,ve1.enrollment_site_code as enrollment_1_site_code
		,ve1.Enrollment_Code as enrollment_1_code
		,ve1.Start_Date as enrollment_1_start_date
		,ve1.End_Date as enrollment_1_end_date
		,ve2.enrollment_site_code as enrollment_2_site_code
		,ve2.Enrollment_Code as enrollment_2_code
		,ve2.Start_Date as enrollment_2_start_date
		,ve2.end_date as enrollment_2_end_date
		,d1.hpr_dept_key as dept_1_hpr_dept_key
		,vd1.Parent_Dept_Name as dept_1_parent_dept_name
		,vd1.Dept_Name as dept_1_dept_name
		,'' as dept_1_ovsr_name
		,vd1.temp_flag as dept_1_temp_flag
		,vd1.primary_flag as dept_1_primary_flag
		,vd1.split_allocation_pct as dept_1_split_allocation_pct
		,vd1.start_date as dept_1_start_date
		,vd1.end_date as dept_1_end_date
		,d2.hpr_dept_key as dept_2_hpr_dept_key
		,vd2.Parent_Dept_Name as dept_2_parent_dept_name
		,vd2.Dept_Name as dept_2_dept_name
		,'' as dept_1_ovsr_name		
		,vd2.temp_flag as dept_2_temp_flag
		,vd2.primary_flag as dept_2_primary_flag
		,vd2.split_allocation_pct as dept_2_split_allocation_pct
		,vd2.start_date as dept_2_start_date
		,vd2.end_date as dept_2_end_date
		,v.tentative_end_date
		,v.room_site_code
		,v.room_bldg
		,v.room_bldg_code
		,left( v.room, charindex( '-', v.room ) - 1 ) as room_bldg_desc
		,v.room
		,v.alt_Email as bethel_email
		,v.jw_username + '@jwpub.org' as jwpub_email
		,'N' as hpr_flag
		,5 as work_days
		,v.volunteer_key
		,v.mate_hub_person_id as spouse_hub_person_id
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
	left join dbo.hpr_dept d1
		on vd1.HUB_Dept_ID = d1.HUB_Dept_ID
	left join dbo.volunteer_dept_rpt vd2
		on v.volunteer_key = vd2.volunteer_key
		and vd2.Row_Num = 2
	left join dbo.hpr_dept d2
		on vd2.HUB_Dept_ID = d2.HUB_Dept_ID
	where 1=1
		and v.room_site_code = 'RMP'
		and v.volunteer_key not in ( select volunteer_key from rpt.volunteer_rpt_v )
		
	union all
	
	select 
		 v.full_name as volunteer_name
		,v.first_name
		,v.last_name 
		,v.hub_volunteer_num
		,v.gender_code
		,ms.marital_status_code
		,v.cong_servant_code
		,cast( round( ( datediff( day, v.birth_date, getdate() ) / 365.25 ), 1 ) as decimal(4,1) ) as age
		,ve1.enrollment_site_code as enrollment_1_site_code
		,ve1.Enrollment_Code as enrollment_1_code
		,ve1.Start_Date as enrollment_1_start_date
		,ve1.end_Date as enrollment_1_end_date
		,ve2.enrollment_site_code as enrollment_2_site_code
		,ve2.Enrollment_Code as enrollment_2_code
		,ve2.Start_Date as enrollment_2_start_date
		,ve2.end_Date as enrollment_2_end_date
		,d1.hpr_dept_key as dept_1_hpr_dept_key
		,vd1.Parent_Dept_Name as dept_1_parent_dept_name
		,vd1.Dept_Name as dept_1_dept_name
		,'' as dept_1_ovsr_name
		,vd1.temp_flag as dept_1_temp_flag
		,vd1.primary_flag as dept_1_primary_flag
		,vd1.split_allocation_pct as dept_1_split_allocation_pct
		,vd1.start_date as dept_1_start_date
		,vd1.end_date as dept_1_end_date
		,d2.hpr_dept_key as dept_2_hpr_dept_key
		,vd2.Parent_Dept_Name as dept_2_parent_dept_name
		,vd2.Dept_Name as dept_2_dept_name
		,'' as dept_1_ovsr_name		
		,vd2.temp_flag as dept_2_temp_flag
		,vd2.primary_flag as dept_2_primary_flag
		,vd2.split_allocation_pct as dept_2_split_allocation_pct
		,vd2.start_date as dept_2_start_date
		,vd2.end_date as dept_2_end_date
		,v.tentative_end_date
		,v.room_site_code
		,v.room_bldg
		,v.room_bldg_code
		,left( v.room, charindex( '-', v.room ) - 1 ) as room_bldg_desc
		,v.room
		,v.alt_Email as bethel_email
		,v.jw_username + '@jwpub.org' as jwpub_email
		,'N' as hpr_flag
		,5 as work_days
		,v.volunteer_key
		,v.mate_hub_person_id as spouse_hub_person_id
	from dbo.volunteer v
	inner join dbo.marital_status ms 
		on v.marital_status_key = ms.marital_status_key	
	inner join dbo.volunteer_enrollment_rpt ve1
		on v.volunteer_key = ve1.volunteer_key
		and ve1.row_num = 1
	inner join stg.stg_rooming r
		on r.person_id = v.hub_person_id
	left join dbo.volunteer_enrollment_rpt ve2
		on v.volunteer_key = ve2.volunteer_key
		and ve2.row_num = 2
	inner join dbo.volunteer_dept_rpt vd1
		on v.volunteer_key = vd1.volunteer_key
		and vd1.Row_Num = 1
	left join dbo.hpr_dept d1
		on vd1.HUB_Dept_ID = d1.HUB_Dept_ID
	left join dbo.volunteer_dept_rpt vd2
		on v.volunteer_key = vd2.volunteer_key
		and vd2.Row_Num = 2
	left join dbo.hpr_dept d2
		on vd2.HUB_Dept_ID = d2.HUB_Dept_ID		
	where 1=1
		and r.overnight_guest_category is not null
		and v.volunteer_key not in ( select volunteer_key from rpt.volunteer_rpt_v )
	) core
left join dbo.volunteer mate
	on core.spouse_hub_person_id = mate.hub_person_id	
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
	,spouse_hub_person_id
	,spouse_hub_volunteer_num
	,spouse_bethel_email
	,spouse_jwpub_email		
	,enrollment_1_code
	,coalesce( enrollment_1_site_code, 'UNK' ) as enrollment_1_site_code
	,enrollment_1_start_date
	,case
		when enrollment_1_code in ( 'BCV' ) then coalesce( enrollment_1_end_date, tentative_end_date )
		else enrollment_1_end_date
	 end as enrollment_1_end_date
	,enrollment_2_code
	,enrollment_2_site_code
	,enrollment_2_start_date
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
	,room_bldg_desc
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
