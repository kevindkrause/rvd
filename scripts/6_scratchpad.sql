	  select
		 a.hub_volunteer_num
    	,a.first_name
		,a.last_name
		,a.address
		,a.city
		,a.state_code
		,a.postal_code
		,a.gender_code
		,a.marital_status_code	
		,a.home_phone
		,a.mobile_phone
		,a.bethel_email
		,a.jwpub_email
		,a.personal_email
		,a.dept_1_cpc_code as cpc_code
		,a.parent_dept_name
		,a.dept_name
		,case
			when charindex( ' - ', a.dept_1_dept_name ) = 0 then a.dept_1_dept_name
			else right( a.dept_1_dept_name, charindex( ' - ', reverse( a.dept_1_dept_name ) ) - 1 )
		 end as sub_dept_name
		,a.enrollment_code
		,a.enrollment_start_date
		,a.enrollment_end_date
		,a.spouse_hub_volunteer_num
		,a.spouse_bethel_email
		,a.spouse_jwpub_email
		,a.volunteer_key
		,'Departed' as enrollment_status
	  from dbo.volunteer_fact_actual a
	  inner join 
		( select volunteer_key, max( cal_dt ) as cal_dt
		  from dbo.Volunteer_Fact_Actual
		  where 1=1 
			and cal_dt < cast( getdate() as date ) -- HISTORICAL RECORDS
			-- ENROLLMENT ENDED IN LAST 30 DAYS
			and (
				( enrollment_1_start_date < cast( getdate() as date )
					and enrollment_1_end_date between cast( getdate() - 30 as date ) and cast( getdate() - 1 as date ) ) or
				( enrollment_2_start_date < cast( getdate() as date )
					and enrollment_2_end_date between cast( getdate() - 30 as date ) and cast( getdate() - 1 as date ) )
				)
		  group by volunteer_key ) d
		on a.volunteer_key = d.volunteer_key
		and a.cal_dt = d.cal_dt
ORDER BY LAST_NAME, FIRST_NAME
