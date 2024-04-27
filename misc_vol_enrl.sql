update dbo.Volunteer_Enrollment
set Geo_Name = src.geo
	,site_code = src.site
	,Update_Date = getdate()
from 
	(select 
		 e.Volunteer_Enrollment_Key
		,x.hub_person_id
		,enrl.enrollment_code
		,e.start_date
		,e.end_date
		,( select max(case when countryname = 'United States' then 'USA' else countryname end) from rvdrehearsal.dbo.zzz_geosite g 
			where g.personid = x.hub_person_id and g.begindate between e.start_date and coalesce(e.end_date,'9999-12-31') ) as geo
		,( select max(bethelsitecode) from rvdrehearsal.dbo.zzz_geosite g 
			where g.personid = x.hub_person_id and g.begindate between e.start_date and coalesce(e.end_date,'9999-12-31') ) as site
	--select *
	from dbo.Volunteer_Enrollment e
	inner join dbo.Enrollment enrl
		on e.Enrollment_Key = enrl.Enrollment_Key
	--from dbo.zzz_Enrl e
	inner join dbo.Volunteer_ID_Xref x
		on e.volunteer_key = x.Volunteer_Key
	--where x.HUB_Person_ID = 30567
	group by e.Volunteer_enrollment_Key,x.hub_person_id,enrl.enrollment_code,e.start_date,e.end_date ) src
where dbo.Volunteer_Enrollment.Volunteer_Enrollment_Key = src.Volunteer_Enrollment_Key