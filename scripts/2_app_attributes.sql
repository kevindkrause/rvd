select 
	 ph.volunteer_key
	,va.full_name
	,va.app_type_code
	,va.app_status_code
	,va.applicant_id
	,ph.attribute_value as rvd
	,va.attrib_pursued_by_val as hub
	,ah.app_attribute_hist_key as wip_key
	,ah.attribute_value as wip
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
	and app_status_code not in ('PNDC','PNDE','DEN','RES','ARR','INV')
	and coalesce(ph.attribute_value,'x') <> coalesce(va.attrib_pursued_by_val,'x')
	and va.applicant_id not in ( 468323, 804032, 591574, 361336, 334865, 729068, 834905, 501096, 866807, 472110, 446778, 625349, 227359, 964614, 958685, 1060124, 814978, 936517, 1323466, 857273, 991908, 835695, 1329441, 
		1289522, 1289546, 806440, 1352892, 1287306, 866441, 1094689, 1147573, 1359853, 1352408, 721611, 1239999, 1365456, 1084965, 1092122, 1361944, 1259638 )
	--and va.applicant_id = 1071343
order by 2, 3

--9 rows

/*
select * from stg.stg_App where applicant_id = 867809
select * from dbo.Volunteer_Pursuit_Hist where volunteer_key in ( select volunteer_key from dbo.volunteer_app_v where applicant_id in ( 867809 ) ) order by load_date desc
select * from dbo.Volunteer_Pursuit_Hist where volunteer_key in ( 761880 )
update dbo.Volunteer_Pursuit_Hist set volunteer_pursuit_cancel_reason_key = 9, request_cancel_reason = 'Other', active_flag = 'N', requested_flag ='N' where volunteer_key in ( 1019952 )
update dbo.Volunteer_Pursuit_Hist set vtc_name = 'D. Rollins', start_date = '2026-01-07', target_date = '2026-07-04', attribute_value = 'D. Rollins 1/7/2026 for CI -  Trade Group - Electrical - Commercial , Crew Overseer+, targeting 07/04/26' where volunteer_key in ( 877821 )
select * from data_xchg.App_Attribute_Hist where app_attribute_hist_key = 32730 applicant_id in ( 1335169 ) and status = 'Pending'
update data_xchg.App_Attribute_Hist set status = 'Pending' where App_Attribute_Hist_Key in ( 30929 )
update dbo.volunteer_pursuit_hist set active_flag = 'N' where volunteer_pursuit_hist_key in ( 8200 )

select * from Volunteer_Pursuit_Hist_Curr_v where volunteer_key = 755017

select volunteer_key, min(volunteer_pursuit_hist_key) as min_key
into tmp
from dbo.Volunteer_Pursuit_Hist 
where active_flag ='Y'
group by volunteer_key
having count(*) > 1

update volunteer_pursuit_hist
set active_flag = 'N'
where exists ( select * from tmp where volunteer_pursuit_hist.volunteer_key = tmp.volunteer_key and volunteer_pursuit_hist.Volunteer_Pursuit_Hist_Key = tmp.min_key )

select 
	 ph.volunteer_key
	,va.full_name
	,va.app_type_code
	,va.app_status_code
	,va.applicant_id
	,ph.attribute_value as rvd
	,va.attrib_pursued_by_val as hub
	,ah.app_attribute_hist_key as wip_key
	,ah.attribute_value as wip
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
	and ph.volunteer_key = 610540
	--and coalesce(ph.attribute_value,'x') <> coalesce(va.attrib_pursued_by_val,'x')
	--and va.applicant_id not in ( 468323, 804032, 591574, 361336, 334865, 729068, 834905, 501096, 866807, 472110, 446778 )
order by 2, 3



select * from dbo.Volunteer_Contact_Hist where volunteer_key in ( select volunteer_key from dbo.volunteer_app_v where applicant_id in ( 468286 ) ) order by load_date desc

select * from dbo.volunteer_app_v where volunteer_key = 569663 and applicant_id in ( 824704, 824705 )
select * from stg.stg_app_attribute where applicant_id in ( 824704, 824705 )
select * from stg.stg_app where applicant_id = 296658
*/
/*
select 
	 ph.volunteer_key
	,va.full_name
	,va.app_type_code
	,va.app_status_code
	,va.applicant_id
	,ph.attribute_value as rvd
	,va.attrib_pursued_by_val as hub
	,ah.app_attribute_hist_key as wip_key
	,ah.attribute_value as wip
	,va.status_notes as app_notes
	,ah.status as wip_status
	,ah.load_date
from dbo.Volunteer_Contact_Hist_Curr_v ph
inner join dbo.Volunteer_App_v va
	on ph.volunteer_key = va.volunteer_key
	and va.active_flag = 'Y'
left join data_xchg.App_Attribute_Hist ah
	on va.applicant_id = ah.applicant_id
	and ah.attribute_id = 123
	and ah.status = 'Pending'
where 1=1
	and app_status_code not in ('PNDC','PNDE')
	and coalesce(ph.attribute_value,'x') <> coalesce(va.attrib_pursued_by_val,'x')
	and ph.attribute_value like 'K. Flores%'
order by 2, 3
*/
