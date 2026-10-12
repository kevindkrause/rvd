if object_id('rpt.Volunteer_All_v', 'V') is not null
	drop view rpt.Volunteer_All_v
go
create view rpt.Volunteer_All_v
as
with base_raw as (
	select 
		*
		,case 
			when enrollment_status = 'Transferring' then 1
			when enrollment_status = 'Arrived' then 2 
			else 3 
		 end as rn
	from rpt.volunteer_v 
),

find_min as ( 
	select volunteer_key, min( rn ) as min_rn
	from base_raw
	group by volunteer_key
),

base_prep as (
	select b.*
	from base_raw b
	inner join find_min m 
		on b.volunteer_key = m.volunteer_key
		and b.rn = m.min_rn 
), 

base as (
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
		,case when record_type in ( 'HPR', 'EXCEPTION', 'TRANSFER' ) then 'Y' else 'N' end as hpr_flag
		,upper( left( first_name, 1 ) +
		 substring( cast( hub_volunteer_num as varchar(30) ), 3, 1 ) +
		 substring( first_name, 2, 1 ) +
		 right( cast( hub_volunteer_num as varchar(30) ), 1 ) +
		 right( last_name, 1 ) ) as base_helmet_id
	from base_prep
),

helmet as (
	select
		volunteer_key
		,row_number() over ( partition by base_helmet_id order by enrollment_1_start_date ) as rownum
	from base )

select
	 base.volunteer_key
	,base.hub_volunteer_num
	,base.hub_person_id
	,base.hub_person_guid
	,base.ba_volunteer_num
	,base.first_name
	,base.last_name
	,base.volunteer_name
	,base.volunteer_name_short
	,base.gender_code
	,base.marital_status_code
	,base.cong_servant_code
	,base.cong_midweek_mt_dow
	,base.cong_midweek_mt_time
	,base.cong_weekend_mt_dow
	,base.cong_weekend_mt_time
	,base.age
	,base.address
	,base.city
	,base.state_code
	,base.postal_code
	,base.home_phone
	,base.mobile_phone
	,base.bethel_email
	,base.jwpub_email
	,base.personal_email
	,base.spouse_hub_person_id
	,base.spouse_hub_volunteer_num
	,base.spouse_bethel_email
	,base.spouse_jwpub_email
	,base.enrollment_code
	,base.enrollment_site_code
	,base.enrollment_start_date
	,base.enrollment_start_date_raw
	,base.enrollment_end_date
	,base.hub_dept_id
	,base.parent_dept_name
	,base.parent_dept_code
	,base.dept_name
	,base.non_hpr_parent_dept_name
	,base.non_hpr_dept_name
	,base.dept_start_date
	,base.dept_end_date
	,base.pc_category
	,base.temp_flag
	,base.primary_flag
	,base.split_asgn_flag
	,base.mon_flag
	,base.tue_flag
	,base.wed_flag
	,base.thu_flag
	,base.fri_flag
	,base.sat_flag
	,base.sun_flag
	,base.enrollment_1_code
	,base.enrollment_1_site_code
	,base.enrollment_1_start_date
	,base.enrollment_1_start_date_raw
	,base.enrollment_1_end_date
	,base.enrollment_2_code
	,base.enrollment_2_site_code
	,base.enrollment_2_start_date
	,base.enrollment_2_start_date_raw
	,base.enrollment_2_end_date
	,base.dept_1_hpr_dept_key
	,base.dept_1_hub_dept_id
	,base.dept_1_cpc_code
	,base.dept_1_parent_dept_name
	,base.dept_1_dept_name
	,base.dept_1_dept_role
	,base.dept_1_ovsr_name
	,base.dept_1_start_date
	,base.dept_1_end_date
	,base.dept_1_temp_flag
	,base.dept_1_primary_flag
	,base.dept_1_split_asgn_flag
	,base.dept_1_split_allocation_pct
	,base.dept_1_hpr_flag
	,base.dept_1_pc_category
	,base.dept_1_mon_flag
	,base.dept_1_tue_flag
	,base.dept_1_wed_flag
	,base.dept_1_thu_flag
	,base.dept_1_fri_flag
	,base.dept_1_sat_flag
	,base.dept_1_sun_flag
	,base.dept_2_hpr_dept_key
	,base.dept_2_hub_dept_id
	,base.dept_2_cpc_code
	,base.dept_2_parent_dept_name
	,base.dept_2_dept_name
	,base.dept_2_dept_role
	,base.dept_2_ovsr_name
	,base.dept_2_start_date
	,base.dept_2_end_date
	,base.dept_2_temp_flag
	,base.dept_2_primary_flag
	,base.dept_2_split_asgn_flag
	,base.dept_2_split_allocation_pct
	,base.dept_2_hpr_flag
	,base.dept_2_pc_category
	,base.dept_2_mon_flag
	,base.dept_2_tue_flag
	,base.dept_2_wed_flag
	,base.dept_2_thu_flag
	,base.dept_2_fri_flag
	,base.dept_2_sat_flag
	,base.dept_2_sun_flag
	,base.loan_dept_name
	,base.tentative_end_date
	,base.room_site_code
	,base.room_bldg
	,base.room_bldg_code
	,base.room_bldg_desc
	,base.room
	,base.staffing_number_exception_flag
	,base.record_type 
	,base.work_days
	,base.hpr_flag
	,base.base_helmet_id
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
