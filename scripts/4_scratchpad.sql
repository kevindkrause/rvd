select *
from rpt.PCC_Project_Volunteer_v
where volunteer_name like 'Lewis%' or volunteer_name like 'Mills%'

--select volunteer_name, dept_1_dept_name, dept_1_start_date, dept_1_hpr_flag, dept_2_dept_name, dept_2_start_date, dept_2_hpr_flag, cal_dt, *
--from rpt.volunteer_arrival_v
--where volunteer_name like 'Mills%'
--	or volunteer_key in (293671,613308)
--	order by last_name

SELECT * from rpt.volunteer_v where volunteer_key in (293671,613308)

with x as (
select volunteer_name
	,case
		when dept_1_hpr_flag = 'Y' and dept_1_start_date <= cast( getdate() as date ) then 'Y'
		when dept_2_hpr_flag = 'Y' and dept_2_start_date <= cast( getdate() as date ) then 'Y'
		when record_type = 'EXCEPTION' and dept_1_start_date <= cast( getdate() as date ) then 'Y'
		else 'N'
	 end as hpr_flag
	,case
		when dept_1_hpr_flag = 'Y' and record_type <> 'TRANSFER' then 'Y'
		when dept_2_hpr_flag = 'Y' and record_type <> 'TRANSFER' then 'Y'
		when record_type = 'EXCEPTION' and dept_1_start_date <= cast( getdate() as date ) then 'Y'
		else 'N'
	 end as hpr_flag2
	 ,dept_1_dept_name, dept_1_hpr_flag, dept_1_start_date, dept_2_dept_name, dept_2_hpr_flag, dept_2_start_date, record_type
	,work_days
	,volunteer_key
	,m.attribute_value as refresh_date
from rpt.volunteer_all_v
full join dbo.app_metadata m
	on m.attribute_name = 'HUB_Update_Date'
where 1=1
	and enrollment_1_start_date <= dateadd( d, 6, dateadd( week, datediff( week, 0, getdate() ), 7 ) ) -- FUTURE JUST UPCOMING WEEK
)
select *
from x where hpr_flag <> hpr_flag2
order by 1