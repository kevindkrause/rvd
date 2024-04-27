use rvdrehearsal
go

/***********************************************************
**				PURSUED BY - INDIVIDUAL VOLUNTEER
***********************************************************/
if object_id('dbo.Pursued_By_Set_By_Vol_proc') is null
    exec( 'create procedure dbo.Pursued_By_Set_By_Vol_proc as set nocount on;' )
go

alter procedure dbo.Pursued_By_Set_By_Vol_proc
	@p_volunteer_key integer
as
begin
	set nocount on
	
	-- UPSERT ATTRIBUTE - pursuit is active, app is active and approved, app is A-8/A-19/DC-50
	insert into data_xchg.app_attribute_hist( applicant_id, applicant_attribute_id, attribute_id, attribute, attribute_value, status )
	select distinct a.applicant_id, case when a.attrib_pursued_by_app_attrib_id = 0 then null else a.attrib_pursued_by_app_attrib_id end as applicant_attribute_id, aa.attribute_id, aa.attribute_name, p.attribute_value, 'Pending' as status
	from dbo.volunteer_pursuit_hist p
	inner join dbo.volunteer_app a
		on p.volunteer_key = a.volunteer_key
	inner join dbo.app_status sts
		on a.App_Status_Key = sts.App_Status_Key
	cross join dbo.App_Attribute aa
	where p.active_flag = 'Y'
		and a.expired_flag = 'N'
		--and sts.App_Status_Code = 'APP'
		and a.app_type_key in ( 1, 2, 7 )
		and aa.Attribute_Name = 'Applicant Being Pursued By:'
		and coalesce( a.attrib_pursued_by_val, '' ) <> p.Attribute_Value		
		and p.volunteer_key = @p_volunteer_key

	-- REMOVE ATTRIBUTE - volunteer requested, app is active and approved, app is A-8/A-19/DC-50
	insert into data_xchg.app_attribute_hist( applicant_id, applicant_attribute_id, attribute_id, attribute, attribute_value, status )	
	select distinct a.applicant_id, a.attrib_pursued_by_app_attrib_id as applicant_attribute_id, a.attrib_pursued_by_attrib_id, null as attribute_name, null as attribute_value, 'Pending' as status
	from dbo.volunteer_pursuit_hist p
	inner join dbo.volunteer_app a
		on p.volunteer_key = a.volunteer_key
	inner join dbo.app_status sts
		on a.App_Status_Key = sts.App_Status_Key
	where 1=1
		--and p.requested_flag = 'Y'
		and a.expired_flag = 'N'
		--and sts.App_Status_Code = 'APP'
		and a.app_type_key in ( 1, 2, 7 )
		and coalesce( a.attrib_pursued_by_val, '' ) <> ''
		and ( a.attrib_pursued_by_val like 'R. Horne%' or a.attrib_pursued_by_val like 'N. Washburn%' or a.attrib_pursued_by_val like 'M. Takhar%' 
			or a.attrib_pursued_by_val like 'J. Livesay%' or a.attrib_pursued_by_val like 'C. Morelli%' or a.attrib_pursued_by_val like 'C. Jacob%'
			or a.attrib_pursued_by_val like 'C. Docket%' or a.attrib_pursued_by_val like 'R. Seydli%' or a.attrib_pursued_by_val like 'F. Shue%'
			or a.attrib_pursued_by_val like 'J. Brews%' or a.attrib_pursued_by_val like 'B. Cran%' or a.attrib_pursued_by_val like 'H. Simm%'
			or a.attrib_pursued_by_val like 'J. Paiv%' or a.attrib_pursued_by_val like 'K. Rice%' or a.attrib_pursued_by_val like 'T. Will%' )		
		and p.volunteer_key = @p_volunteer_key		

end
go

grant execute on object::dbo.Pursued_By_Set_By_Vol_proc to rvd_app_prod;  
go


/***********************************************************
**				PURSUED BY - INDIVIDUAL COMPLETE
***********************************************************/
alter procedure dbo.Pursued_By_Set_Complete_proc
	@p_app_attribute_hist_key integer
as
begin
	set nocount on
	
	begin try
		update data_xchg.app_attribute_hist
		set status = 'Complete',
			update_date = getdate()
		where app_attribute_hist_key = @p_app_attribute_hist_key
	end try

	begin catch
		-- PENDING
	end catch

end
go

grant execute on object::dbo.Pursued_By_Set_Complete_proc to rvd_app_prod;  
go


/***********************************************************
**				PURSUED BY - SCAN FOR NEW APPS
***********************************************************/
if object_id('dbo.Pursued_By_New_Apps_proc') is null
    exec( 'create procedure dbo.Pursued_By_New_Apps_proc as set nocount on;' )
go

alter procedure dbo.Pursued_By_New_Apps_proc
as
begin
	set nocount on
	
	begin try
		insert into data_xchg.app_attribute_hist( 
			 applicant_id
			,applicant_attribute_id
			,attribute_id
			,attribute
			,attribute_value
			,status )
		select 
			 a.applicant_id
			,case when a.attrib_pursued_by_app_attrib_id = 0 then null else a.attrib_pursued_by_app_attrib_id end as applicant_attribute_id
			,aa.attribute_id
			,aa.attribute_name
			,ph.attribute_value
			,'Pending' as status
		from dbo.volunteer_pursuit_hist ph
		inner join dbo.volunteer_app_v a
			on ph.volunteer_key = a.volunteer_key	
			and a.active_flag = 'Y'
		inner join dbo.app_attribute aa
			on aa.attribute_name = 'Applicant Being Pursued By:'
			and aa.active_flag = 'Y'
		where ph.active_flag = 'Y'
			--and a.app_date > getdate() - 365 -- TEMP SOLUTION TO HANDLE MISSING APP ATTRIBUTE DATA FROM HUB		
			and ph.attribute_value <> ''				
			and ph.attribute_value <>  coalesce( a.attrib_pursued_by_val, '' )
			and coalesce( a.attrib_pursued_by_val, '' ) <> case when left( ph.attribute_value, len( coalesce( a.attrib_pursued_by_val, '' ) ) ) = '' then 'x' end -- TRAILING SPACES				
			and a.applicant_id not in ( select applicant_id from data_xchg.app_attribute_hist where status = 'Pending' )
			and ph.active_flag = 'Y'
			and a.app_status_code <> 'DEN'	
			and left( ph.attribute_value, 3 ) not in ( 'FKL', 'PAT', 'WRK', 'WKL', 'BBC', 'BCV', 'HPR' )			
	end try

	begin catch
		-- PENDING
	end catch

end
go

grant execute on object::dbo.Pursued_By_New_Apps_proc to rvd_app_prod;  
go


/***********************************************************
**				CONTACTED - INDIVIDUAL VOLUNTEER
***********************************************************/
if object_id('dbo.Contacted_Set_By_Vol_proc') is null
    exec( 'create procedure dbo.Contacted_Set_By_Vol_proc as set nocount on;' )
go

alter procedure dbo.Contacted_Set_By_Vol_proc
	@p_volunteer_key integer
as
begin
	set nocount on
	
	begin try		
		-- INSERT ATTRIBUTE - contacted, app is active and approved, app is A-8/A-19/DC-50
		insert into data_xchg.app_attribute_hist( applicant_id, applicant_attribute_id, attribute_id, attribute, attribute_value, status )
		select distinct a.applicant_id, a.attrib_pursued_by_app_attrib_id as applicant_attribute_id, aa.attribute_id, aa.attribute_name, c.attribute_value, 'Pending' as status
		from dbo.volunteer_contact_hist c
		inner join dbo.volunteer_app a
			on c.volunteer_key = a.volunteer_key
		inner join dbo.app_status sts
			on a.App_Status_Key = sts.App_Status_Key
		cross join dbo.App_Attribute aa
		where c.active_flag = 'Y'
			and a.expired_flag = 'N'
			--and sts.App_Status_Code = 'APP'
			and a.app_type_key in ( 1, 2, 7 )
			and aa.Attribute_Name = 'Contacted'
			and coalesce( a.attrib_contacted_val, '' ) <> c.Attribute_Value
			and c.volunteer_key = @p_volunteer_key
	end try

	begin catch
		-- PENDING
	end catch
	
end
go

grant execute on object::dbo.Contacted_Set_By_Vol_proc to rvd_app_prod;  
go


/***********************************************************
**				CONTACTED - SCAN FOR NEW APPS
***********************************************************/
if object_id('dbo.Contacted_New_Apps_proc') is null
    exec( 'create procedure dbo.Contacted_New_Apps_proc as set nocount on;' )
go

alter procedure dbo.Contacted_New_Apps_proc
as
begin
	set nocount on
	
	begin try
		insert into data_xchg.app_attribute_hist( 
			 applicant_id
			,applicant_attribute_id
			,attribute_id
			,attribute
			,attribute_value
			,status )
		select 
			 a.applicant_id
			,case when a.attrib_contacted_app_attrib_id = 0 then null else a.attrib_contacted_app_attrib_id end as applicant_attribute_id
			,aa.attribute_id
			,aa.attribute_name
			,ch.attribute_value
			,'Pending' as status
		from dbo.volunteer_contact_hist ch
		inner join dbo.volunteer_app_v a
			on ch.volunteer_key = a.volunteer_key	
			and a.active_flag = 'Y'
		inner join dbo.app_attribute aa
			on aa.attribute_name = 'Contacted'
			and aa.active_flag = 'Y'
		where ch.active_flag = 'Y'
			--and a.app_date > getdate() - 365 -- TEMP SOLUTION TO HANDLE MISSING APP ATTRIBUTE DATA FROM HUB			
			and ch.attribute_value <> coalesce( a.attrib_contacted_val, '' )
			and ( ( coalesce( a.attrib_contacted_val, '' ) = '' and ch.Attribute_Value is not null )
				or ( coalesce( a.attrib_contacted_val, '' ) <> left( ch.attribute_value, len( coalesce( a.attrib_contacted_val, '' ) ) ) ) ) -- TRAILING SPACES				
			and a.applicant_id not in ( select applicant_id from data_xchg.app_attribute_hist where status = 'Pending' )
			and ch.active_flag = 'Y'
			and a.app_status_code <> 'DEN'	
			and ( ch.attribute_value like 'R. Horne%' or ch.attribute_value like 'N. Washburn%' or ch.attribute_value like 'M. Takhar%' 
				or ch.attribute_value like 'J. Livesay%' or ch.attribute_value like 'C. Morelli%' or ch.attribute_value like 'C. Jacob%'
				or ch.attribute_value like 'C. Docket%' or ch.attribute_value like 'R. Seydli%' or ch.attribute_value like 'F. Shue%'
				or ch.attribute_value like 'J. Brews%' or ch.attribute_value like 'K. Flores%' )			
	end try

	begin catch
		-- PENDING
	end catch

end
go

grant execute on object::dbo.Contacted_New_Apps_proc to rvd_app_prod;  
go
