update volunteer_dept
set end_date = '2020-11-29', active_flag = 'N'
--delete Volunteer_Dept
where Volunteer_Dept_Key = 617758


select * from dbo.Volunteer_Dept where person_id = 599494 --and end_date is null 
order by start_date
select * from stg.stg_Person_Dept_History where person_id = 599494 --and end_date is null
order by start_date


select * from volunteer where HUB_Person_ID = 284409


select volunteer_key, v.jw_username, v.full_name, p.person_id, v.load_date,* from dbo.volunteer v 
left join stg.stg_person p
	on v.hub_person_id = p.person_id
where JW_Username in (select jw_username from dbo.Volunteer where jw_username is not null group by jw_username having count(*) > 1) order by v.jw_username

update dbo.volunteer set JW_Username = null where volunteer_key = 612171

delete from dbo.volunteer
where volunteer_key in (

)

select volunteer_key, v.ba_volunteer_id, v.full_name, p.person_id, v.load_date,* from dbo.volunteer v 
left join stg.stg_person p
	on v.hub_person_id = p.person_id
where ba_volunteer_id in (select ba_volunteer_id from dbo.Volunteer where ba_volunteer_id is not null group by ba_volunteer_id having count(*) > 1) order by v.ba_volunteer_id

update dbo.volunteer set ba_volunteer_id = null where volunteer_key in (610742,629064,673323,675654 )

delete from dbo.volunteer
where volunteer_key in (
)


-- DUPS
drop table stg.dups1

select full_name, birth_date
into stg.dups1
from volunteer
where 1=1
	--and full_name = 'Usoroh, Idara Aniedi'
	and hub_person_id is not null
	and birth_date is not null
group by full_name, birth_date
having count(*) > 1

select * from stg.dups1

drop table stg.dups2

select volunteer_key, full_name, hub_person_id, hub_person_guid
into stg.dups2
from volunteer v
where 1=1
	and exists ( select * from stg.dups1 d where d.full_name = v.full_name and d.birth_date = v.birth_date )

select * from stg.dups2 order by full_name

select *
from stg.dups2
where hub_person_id in ( select person_id from stg.stg_person )
	or hub_person_guid is not null

delete
from stg.dups2
where hub_person_id in ( select person_id from stg.stg_person )
	or hub_person_guid is not null

select * from stg.dups2 order by full_name

select *
from volunteer
where volunteer_key in ( select volunteer_key from stg.dups2 )

delete
from volunteer_role
where volunteer_key in ( select volunteer_key from stg.dups2 )

delete
from volunteer
where volunteer_key in ( select volunteer_key from stg.dups2 )





select 
	 app.full_name
	,v.Volunteer_Key
	,app.applicant_id
	,app.app_type_code
	,app.app_date
	,stg.app_date as stg_app_dt
	,v.A8_App_Date
	,v.A19_App_Date
	,'' as x
	,stg.App_Status as stg_app_sts
	,app.app_status_code
	,v.A8_Approved_Flag
	,v.A19_Approved_Flag
	,'' as x
	,stg.app_expiry_date as stg_app_exp_dt
	,app.expiration_date
	,app.expired_flag
	,app.active_flag
	,'' as x
	,stg.App_Review_Status_Submitted_Date as stg_submit_dt
	,app.Review_Status_Submitted_Date
	,stg.App_Review_Stage_Elders_Date as stg_eld_dt
	,app.Review_Stage_Elders_Date
	,stg.App_Review_Stage_CO_Date as stg_co_dt
	,app.Review_Stage_CO_Date
from volunteer_app_v app
inner join volunteer v
	on app.volunteer_key = v.volunteer_key
inner join stg.stg_app stg
	on stg.Applicant_ID = app.applicant_id
where 1=1
	and v.volunteer_key = 507085
	--and stg.applicant_id = 280438
	--and app.volunteer_key in ( select volunteer_key from dbo.volunteer where Full_Name like 'Madan, Yaro%' )
	and stg.Applicant_ID = app.applicant_id
	and app_type_code = 'A-19'
	--and app.app_date <> v.A19_App_Date
order by 1, 3, 4



select * from stg.stg_person where volunteer_number = 561650

create function dbo.get_bad() returns int as begin return 265993 end;
create function dbo.get_good() returns int as begin return 904104 end;

select * from dbo.Volunteer_App where volunteer_key = dbo.get_bad() or volunteer_key = dbo.get_good()
select * from dbo.Volunteer_Availability where volunteer_key = dbo.get_bad() or volunteer_key = dbo.get_good()
select * from dbo.Volunteer_Dept where volunteer_key = dbo.get_bad() or volunteer_key = dbo.get_good()
select * from dbo.Volunteer_Enrollment where volunteer_key = dbo.get_bad() or volunteer_key = dbo.get_good()
update dbo.Volunteer_Enrollment set Volunteer_Key = dbo.get_good() where volunteer_key = dbo.get_bad()  

select * from dbo.Volunteer_Event where volunteer_key in ( 265993, 904104 )
update dbo.Volunteer_Event set Volunteer_Key = 904104 where volunteer_key = 265993  

select * from dbo.Volunteer_ID_Xref where volunteer_key in ( 265993, 904104 )
update dbo.Volunteer_ID_Xref set HUB_Person_ID = 833263, HUB_Volunteer_Num = 561650 where volunteer_key = 904104 
delete from dbo.Volunteer_ID_Xref where volunteer_key = 265993  

select * from dbo.Volunteer_Skill where volunteer_key in ( 265993, 904104 )

select * from dbo.Volunteer_Training where volunteer_key in ( 265993, 904104 )

delete from dbo.Volunteer where volunteer_key in (265993)

select * from volunteer 
update volunteer set hub_volunteer_num = null
where 1=1
	--and HUB_Volunteer_Num = 1064846 --566244
	and HUB_Volunteer_Num in (select hub_volunteer_num from dbo.Volunteer where hub_volunteer_num is not null group by hub_volunteer_num having count(*) > 1 )
	and HUB_Person_ID not in ( select person_id from stg.stg_Person )
	
select * from volunteer 
update volunteer set JW_Username = null
where 1=1
	--and JW_Username = '1JenniferOrtiz'
	and JW_Username in (select jw_username from dbo.Volunteer where jw_username is not null  and jw_username <> '' group by jw_username having count(*) > 1 )
	and HUB_Person_ID not in ( select person_id from stg.stg_Person )	
	
select volunteer_Key, hub_person_id, jw_username, p.person_id, p.JWPub_Email, v.load_date, v.*
from dbo.volunteer v
left join stg.stg_Person p
	on v.hub_Person_id = p.person_id
where v.jw_username = '1FMaritza'

update dbo.volunteer set JW_Username = null where volunteer_key = 976680

update dbo.Volunteer_id_xref
set HUB_Volunteer_Num = null
from dbo.Volunteer_id_xref v
left join stg.stg_Person p
	on v.HUB_person_id = p.Person_ID
where p.Person_ID is null
	and v.HUB_Volunteer_Num in (select HUB_Volunteer_Num from dbo.Volunteer_id_xref group by HUB_Volunteer_Num having count(*) > 1)
	and v.HUB_Volunteer_Num = 802895
	
select volunteer_key, hub_person_id, person_id, *
from dbo.volunteer v
left join stg.stg_person p
	on v.hub_person_id = p.Person_ID
where JW_Username in ( select jw_username from dbo.Volunteer where jw_username is not null group by jw_username having count(*) > 1 )
	--and p.person_id is null
order by jw_username	

update dbo.volunteer set vol_desk_user_Key = 1 where vol_desk_user_key is null

update dbo.volunteer set state_Key = 1 where state_Key is null

update dbo.volunteer set postal_code_Key = 1 where postal_code_Key is null

update dbo.volunteer set cong_key = 16957 where cong_key is null	

update dbo.volunteer set country_key = 1 where country_key is null	

update dbo.volunteer set marital_status_key = 6 where marital_status_key is null

update dbo.volunteer set tracking_status_key = 1 where tracking_status_key is null	