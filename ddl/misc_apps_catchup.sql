use rvdrehearsal;

select *
into dbo.apps_catchup
from (
select * from dbo.apps_catchup_1
union all
select * from dbo.apps_catchup_2
union all
select * from dbo.apps_catchup_3 ) x;

--select top 10 c.*, sts.App_Status, va.App_Status_Key, sts2.App_Status_Key
--select count(*)
select * into rvd.dbo.Volunteer_App_bak2 from rvd.dbo.Volunteer_App;

update rvd.dbo.Volunteer_App
set App_Status_Key = sts2.App_Status_Key,
	Update_Date = getdate()
from dbo.apps_catchup c
inner join rvd.dbo.Volunteer_App va
	on c.[Applicant Id] = va.Applicant_ID
inner join rvd.dbo.App_Status sts
	on va.App_Status_Key = sts.App_Status_Key
inner join rvd.dbo.App_Status sts2
	on c.[Application Status] = sts2.App_Status
where c.[Application Status] <> sts.App_Status;

select * from rvd.dbo.Volunteer_App_bak2 where volunteer_key = 274407;