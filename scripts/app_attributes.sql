select 
	 ph.volunteer_key
	,va.full_name
	,va.app_type_code
	,va.app_status_code
	,va.applicant_id
	,ph.attribute_value as rvd
	,va.attrib_pursued_by_val as hub
	,ah.app_attribute_hist_key as wip_key
	,ah.attribute_value as wip_val
	,va.status_notes as app_notes
	,ah.status as wip_status
	,ah.load_date
from dbo.Volunteer_Pursuit_Hist_Curr_v ph
inner join dbo.Volunteer_App_v va
	on ph.volunteer_key = va.volunteer_key
	and va.active_flag = 'Y'
left join data_xchg.App_Attribute_Hist ah
	on va.applicant_id = ah.applicant_id
	and ah.attribute_id = 103
	and ah.status = 'Pending'
where 1=1
	and app_status_code not in ('PNDC','PNDE','DEN')
	and coalesce(ph.attribute_value,'x') <> coalesce(va.attrib_pursued_by_val,'x')
	and va.applicant_id not in ( 945112, 633859, 633843, 1082427, 468323, 804032, 959027, 591574, 361336, 334865, 729068, 834905, 501096, 866807, 472110, 446778, 625349, 227359, 964614, 958685, 1060124, 814978, 936517, 1022065, 1090029, 993419, 913055, 1127271 )
order by 2, 3

/*
select * from stg.stg_App where applicant_id = 1019319
select * from dbo.Volunteer_Pursuit_Hist where volunteer_key in ( select volunteer_key from dbo.volunteer_app_v where applicant_id in ( 533473 ) ) order by load_date desc
select * from dbo.Volunteer_Pursuit_Hist where volunteer_key in ( 1066892 )
update dbo.Volunteer_Pursuit_Hist set attribute_value = 'Pursued by - D. Rollins targeting 08/12/26 for CI -  Trade Group - Electrical, Apprentice. Updated: 12/23/25.' where volunteer_key in ( 1066892 )
select * from data_xchg.App_Attribute_Hist where applicant_id in ( 533473,583985 ) and status = 'Pending'
update data_xchg.App_Attribute_Hist set status = 'Complete' where App_Attribute_Hist_Key in ( 8921,8923 )
update dbo.volunteer_pursuit_hist set active_flag = 'N' where volunteer_pursuit_hist_key in ( 8200 )