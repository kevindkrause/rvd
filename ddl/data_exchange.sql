use rvd
go

if object_id('data_xchg.App_Attribute_Hist', 'U') is not null
	drop table data_xchg.App_Attribute_Hist
go 
create table data_xchg.App_Attribute_Hist(
	App_Attribute_Hist_Key 		integer identity(1,1) 	not null constraint app_attribute_hist_pk primary key,
	Applicant_ID               	integer             	not null, 
	Applicant_Attribute_ID     	integer,
	Attribute_ID               	integer					not null,	
	Attribute                  	nvarchar(50),
	Attribute_Value            	nvarchar(255),
	Status                   	nvarchar(50)        	not null, 
	Load_Date 					datetime 				not null constraint df_app_attribute_hist_load_date default getdate(),
	Update_Date 				datetime 				not null constraint df_app_attribute_hist_update_date default getdate() )
go 


if object_id('data_xchg.App_Attribute_Hist_v', 'V') is not null
	drop view data_xchg.App_Attribute_Hist_v
go 
create view data_xchg.App_Attribute_Hist_v
as
select
	 h.app_attribute_hist_key
	,a.full_name
	,a.volunteer_key
	,a.app_type_code
	,a.app_status_code
	,h.applicant_id            	
	,h.applicant_attribute_id  	
	,a.attrib_pursued_by_app_attrib_id
	,h.attribute_id            	
	,a.attrib_pursued_by_attrib_id
	,h.attribute               	
	,h.attribute_value         	
	,a.attrib_pursued_by_val
	,h.status                  	
	,h.load_date
	,h.update_date
from data_xchg.App_Attribute_Hist h
inner join dbo.Volunteer_App_v a
	on h.Applicant_ID = a.applicant_id
where h.Attribute_ID = 103
union all
select
	 h.app_attribute_hist_key
	,a.full_name
	,a.volunteer_key
	,a.app_type_code
	,a.app_status_code
	,h.applicant_id            	
	,h.applicant_attribute_id  	
	,a.attrib_contacted_app_attrib_id
	,h.attribute_id            	
	,a.attrib_contacted_attrib_id
	,h.attribute               	
	,h.attribute_value         	
	,a.attrib_contacted_val
	,h.status                  	
	,h.load_date
	,h.update_date
from data_xchg.App_Attribute_Hist h
inner join dbo.Volunteer_App_v a
	on h.Applicant_ID = a.applicant_id
where h.Attribute_ID = 123
go


if object_id('data_xchg.App_Attribute_Pending_v', 'V') is not null
	drop view data_xchg.App_Attribute_Pending_v
go 
create view data_xchg.App_Attribute_Pending_v
as
select
	 h.app_attribute_hist_key
	,a.full_name
	,a.app_type_code
	,a.app_status_code
	,h.applicant_id            	
	,coalesce( h.applicant_attribute_id, a.attrib_pursued_by_app_attrib_id ) as applicant_attribute_id 	
	,h.attribute_id            	
	,h.attribute               	
	,h.attribute_value         	
	,h.status                  	
	,h.load_date
	,h.update_date
from data_xchg.App_Attribute_Hist h
inner join ( select applicant_id, max( load_date ) as max_dt from data_xchg.App_Attribute_Hist where status = 'Pending' and attribute_value is not null group by applicant_id ) h2
	on h.applicant_id = h2.applicant_id
	and h.load_date = h2.max_dt
inner join dbo.Volunteer_App_v a
	on h.Applicant_ID = a.applicant_id
where h.status = 'Pending'
	and h.Attribute_Value is not null
go


if object_id('data_xchg.App_Attribute_Pending_Removal_v', 'V') is not null
	drop view data_xchg.App_Attribute_Pending_Removal_v
go 
create view data_xchg.App_Attribute_Pending_Removal_v
as
select distinct
	 h.app_attribute_hist_key
	,a.full_name
	,a.app_type_code
	,a.app_status_code
	,h.applicant_id            	
	,h.applicant_attribute_id  	
	,h.attribute_id            	
	,h.attribute               	
	,h.attribute_value         	
	,h.status                  	
	,h.load_date
	,h.update_date
from data_xchg.App_Attribute_Hist h
inner join ( select applicant_id, max( load_date ) as max_dt from data_xchg.App_Attribute_Hist where attribute_id = 103 group by applicant_id ) h2
	on h.applicant_id = h2.applicant_id
	and h.load_date = h2.max_dt
inner join dbo.Volunteer_App_v a
	on h.Applicant_ID = a.applicant_id
inner join dbo.volunteer_pursuit_hist p
	on p.volunteer_key = a.volunteer_key
	and not exists ( select * from dbo.volunteer_pursuit_hist p2 where p.volunteer_key = p2.volunteer_key and p2.active_flag = 'Y' )
where 1=1
	and h.attribute_id = 103
	and ( p.Volunteer_Pursuit_Cancel_Reason_Key is not null or p.requested_flag = 'Y' )
	and h.status = 'Pending'
go
