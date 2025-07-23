use rvdrehearsal
go


/***********************************************************
**				BA EVENT VOLUNTEER INVITE
***********************************************************/
if object_id('dbo.ETL_BA_Event_Volunteer_Invite_proc') is null
    exec( 'create procedure dbo.ETL_BA_Event_Volunteer_Invite_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Event_Volunteer_Invite_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'BA_Event_Volunteer_Invite', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.ba_event_volunteer_invite( 
			 event_id 				
			,volunteer_id			
			,person_guid				
			,event_name 				
			,link					
			,start_date				
			,event_length 			
			,maximum_confirmations 	
			,status_day_1 			
			,status_day_2 			
			,status_day_3 			
			,status_day_4 			
			,status_day_5 			
			,status_day_6 			
			,status_day_7 			
			,comments 				
			,manager_comments )
		select 
			 event_id 				
			,volunteer_id			
			,person_guid				
			,event_name 				
			,link					
			,start_date				
			,event_length 			
			,maximum_confirmations 	
			,status_day_1 			
			,status_day_2 			
			,status_day_3 			
			,status_day_4 			
			,status_day_5 			
			,status_day_6 			
			,status_day_7 			
			,comments 				
			,manager_comments 
		from 
			( select 
				 event_id 				
				,volunteer_id			
				,person_guid				
				,event_name 				
				,link					
				,start_date				
				,event_length 			
				,maximum_confirmations 	
				,status_day_1 			
				,status_day_2 			
				,status_day_3 			
				,status_day_4 			
				,status_day_5 			
				,status_day_6 			
				,status_day_7 			
				,comments 				
				,max( manager_comments ) as manager_comments 
			  from stg.stg_ba_volunteer_invite
			  group by 
				 event_id 				
				,volunteer_id			
				,person_guid				
				,event_name 				
				,link					
				,start_date				
				,event_length 			
				,maximum_confirmations 	
				,status_day_1 			
				,status_day_2 			
				,status_day_3 			
				,status_day_4 			
				,status_day_5 			
				,status_day_6 			
				,status_day_7 			
				,comments ) ei
		where not exists 
			( select 1 from dbo.ba_event_volunteer_invite ei2 
			  where ei.event_id = ei2.event_id
				and ei.volunteer_id = ei2.volunteer_id )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.ba_event_volunteer_invite
		set 
			event_name = src.event_name,
			link = src.link,
			start_date = src.start_date,
			event_length = src.event_length,
			maximum_confirmations = src.maximum_confirmations, 	
			status_day_1 = src.status_day_1, 			
			status_day_2 = src.status_day_2, 			
			status_day_3 = src.status_day_3, 			
			status_day_4 = src.status_day_4, 			
			status_day_5 = src.status_day_5, 			
			status_day_6 = src.status_day_6, 			
			status_day_7 = src.status_day_7,			
			comments = src.comments,			
			manager_comments = src.manager_comments,
			update_date = getdate()
		from dbo.ba_event_volunteer_invite tgt
		inner join 
			( select 
				 event_id 				
				,volunteer_id			
				,person_guid				
				,event_name 				
				,link					
				,start_date				
				,event_length 			
				,maximum_confirmations 	
				,status_day_1 			
				,status_day_2 			
				,status_day_3 			
				,status_day_4 			
				,status_day_5 			
				,status_day_6 			
				,status_day_7 			
				,comments 				
				,manager_comments 
			  from stg.stg_ba_volunteer_invite
			  group by 
				 event_id 				
				,volunteer_id			
				,person_guid				
				,event_name 				
				,link					
				,start_date				
				,event_length 			
				,maximum_confirmations 	
				,status_day_1 			
				,status_day_2 			
				,status_day_3 			
				,status_day_4 			
				,status_day_5 			
				,status_day_6 			
				,status_day_7 			
				,comments 				
				,manager_comments ) src
			on tgt.event_id = src.event_id
			and tgt.volunteer_id = src.volunteer_id
		where tgt.event_name <> src.event_name
			or tgt.link <> src.link
			or tgt.start_date <> src.start_date
			or tgt.event_length <> src.event_length
			or tgt.maximum_confirmations <> src.maximum_confirmations 	
			or tgt.status_day_1 <> src.status_day_1 			
			or tgt.status_day_2 <> src.status_day_2 			
			or tgt.status_day_3 <> src.status_day_3 			
			or tgt.status_day_4 <> src.status_day_4 			
			or tgt.status_day_5 <> src.status_day_5 			
			or tgt.status_day_6 <> src.status_day_6 			
			or tgt.status_day_7 <> src.status_day_7			
			or tgt.comments <> src.comments			
			or tgt.manager_comments <> src.manager_comments

		set @Upd = @@rowcount
		
		-- UPDATE SET INACTIVE		
		update dbo.ba_event_volunteer_invite
		set active_flag = 'N'
		from dbo.ba_event_volunteer_invite tgt
		where 1=1
			and start_date >= 1 + dateadd( week, datediff( week, 0, getdate() ), -1 )
			and not exists 
				( select 1 from stg.stg_ba_volunteer_invite src 
				  where tgt.event_id = src.event_id
					and tgt.volunteer_id = src.volunteer_id )
					
		set @Upd = @Upd + @@rowcount
		
		
		-- DELETE BA EVENT SNAPSHOT
		truncate table dbo.ba_event_snp
		
		set @Del = @Del + @@rowcount	

		-- INSERT BA EVENT SNAPSHOT
		insert into dbo.ba_event_snp
		select * from rpt.ba_event_v 
		
		set @Ins = @Ins + @@rowcount

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**				BA PROJECT GROUP VOLUNTEER
***********************************************************/
if object_id('dbo.ETL_BA_Project_Group_Volunteer_proc') is null
    exec( 'create procedure dbo.ETL_BA_Project_Group_Volunteer_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Project_Group_Volunteer_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'BA_Project_Group_Volunteer', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.ba_project_group_volunteer( 
			 ba_project_group_key
			,volunteer_key
			,project_id
			,group_id
			,person_guid )		
		select 
			 pg.ba_project_group_key
			,v.volunteer_key
			,vg.project_id
			,vg.group_id
			,vg.person_guid
		from stg.stg_ba_volunteer_group vg
		inner join dbo.ba_project_group pg
			on vg.project_id = pg.project_id
			and vg.group_id = pg.group_id
		inner join dbo.volunteer v
			on vg.person_guid = v.hub_person_guid
		where not exists 
			( select 1 from dbo.ba_project_group_volunteer pg2 
			  where pg2.project_id = vg.project_id
				and pg2.group_id = vg.group_id
				and pg2.person_guid = vg.person_guid )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.ba_project_group_volunteer
		set 
			active_flag = 'N',
			update_date = getdate()
		from dbo.ba_project_group_volunteer tgt
		where not exists 
			( select 1 from stg.stg_ba_volunteer_group vg
			  where tgt.project_id = vg.project_id
				and tgt.group_id = vg.group_id
				and tgt.person_guid = vg.person_guid )

		set @Upd = @@rowcount

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**						BA PROJECT VOLUNTEER
***********************************************************/
if object_id('dbo.ETL_BA_Project_Volunteer_proc') is null
    exec( 'create procedure dbo.ETL_BA_Project_Volunteer_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Project_Volunteer_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'BA_Project_Volunteer', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.ba_project_volunteer( 
			 project_id
			,volunteer_id
			,person_guid
			,invited_flag
			,accepted_flag
			,attended_flag )		
		select 
			 project_id
			,volunteer_id
			,person_guid
			,invited_flag
			,accepted_flag
			,attended_flag
		from 
			( select 
				 project_id
				,volunteer_id 
				,person_guid
				,case when max( invited ) = 1 then 'Y' else 'N' end as invited_flag
				,case when max( accepted ) = 1 then 'Y' else 'N' end as accepted_flag
				,case when max( attended ) = 1 then 'Y' else 'N' end as attended_flag			
			  from stg.stg_ba_project_volunteer
			  group by project_id, volunteer_id, person_guid ) pv
		where not exists 
			( select 1 from dbo.ba_project_volunteer pv2 
			  where pv.project_id = pv2.project_id
				and pv.volunteer_id = pv2.volunteer_id )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.ba_project_volunteer
		set 
			invited_flag = src.invited_flag,
			accepted_flag = src.accepted_flag,
			attended_flag = src.attended_flag,
			update_date = getdate()
		from dbo.ba_project_volunteer tgt
		inner join 
			( select 
				 project_id
				,volunteer_id 
				,person_guid
				,case when max( invited ) = 1 then 'Y' else 'N' end as invited_flag
				,case when max( accepted ) = 1 then 'Y' else 'N' end as accepted_flag
				,case when max( attended ) = 1 then 'Y' else 'N' end as attended_flag			
			  from stg.stg_ba_project_volunteer
			  group by project_id, volunteer_id, person_guid ) src
			on tgt.project_id = src.project_id
			and tgt.volunteer_id = src.volunteer_id
		where tgt.invited_flag <> src.invited_flag
			or tgt.accepted_flag <> src.accepted_flag
			or tgt.attended_flag <> src.attended_flag

		set @Upd = @@rowcount

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**				BA PROJECT VOLUNTEER ATTENDANCE
***********************************************************/
if object_id('dbo.ETL_BA_Project_Volunteer_Attendance_proc') is null
    exec( 'create procedure dbo.ETL_BA_Project_Volunteer_Attendance_proc as set nocount on;' )
go

alter procedure dbo.ETL_BA_Project_Volunteer_Attendance_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'BA_Project_Volunteer_Attendance', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.ba_project_volunteer_attendance( 
			 project_id
			,volunteer_id
			,person_guid
			,check_in_date
			,event_id
			,event_name
			,status )		
		select 
			 project_id
			,volunteer_id
			,person_guid
			,check_in_date
			,event_id
			,event_name
			,status 
		from 
			( select 
				 project_id
				,volunteer_id 
				,person_guid
				,checkin_date as check_in_date
				,event_id
				,event_name
				,status
			  from stg.stg_ba_volunteer_attendance
			  group by 
				 project_id
				,volunteer_id
				,person_guid
				,checkin_date
				,event_id
				,event_name
				,status ) pva
		where not exists 
			( select 1 from dbo.ba_project_volunteer_attendance pva2 
			  where pva.project_id = pva2.project_id
				and pva.volunteer_id = pva2.volunteer_id
				and pva.event_id = pva2.event_id
				and pva.check_in_date = pva2.check_in_date )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.ba_project_volunteer_attendance
		set 
			event_name = src.event_name,
			status = src.status,
			update_date = getdate()
		from dbo.ba_project_volunteer_attendance tgt
		inner join 
			( select 
				 project_id
				,volunteer_id 
				,person_guid
				,checkin_date as check_in_date
				,event_id
				,event_name
				,status
			  from stg.stg_ba_volunteer_attendance
			  group by 
				 project_id
				,volunteer_id
				,person_guid
				,checkin_date
				,event_id
				,event_name
				,status ) src
			on tgt.project_id = src.project_id
			and tgt.volunteer_id = src.volunteer_id
			and tgt.event_id = src.event_id
			and tgt.check_in_date = src.check_in_date
		where tgt.event_name <> src.event_name
			or tgt.status <> src.status

		set @Upd = @@rowcount

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**		VOLUNTEER + TRACKING + BA VOLUNTEER + KEY ROLE
***********************************************************/
if object_id('dbo.ETL_Volunteer_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.volunteer( 
			 full_name
			,first_name
			,last_name
			,middle_name
			,suffix
			,maiden_name
			,address
			,address2
			,city
			,postal_code_key 
			,state_key
			,country_key
			,home_phone
			,mobile_phone
			,email
			,alt_email
			,birth_date
			,baptism_date
			,gender_code
			,marital_status_key 
			,cong_servant_code
			,pioneer_flag
			,cong_key
			,hub_person_id
			,hub_person_guid
			,hub_volunteer_num
			,hub_volunteer_id
			,jw_username
			,mate_hub_person_id
			,mate_hub_person_guid
			,vol_desk_user_key
			,tracking_status_key
			,whatsapp_flag
			,sms_flag )
		select 
			 last_name + ', ' + first_name + ' ' + coalesce( middle_name, '' ) as full_name
			,first_name
			,last_name
			,middle_name
			,suffix
			,maiden_name
			,address1
			,address2
			,p.city
			,coalesce( pc.postal_code_key, 1 ) as postal_code_key
			,coalesce( s.state_key, 1 ) as state_key
			,coalesce( c.country_key, 1 ) as country_key
			,home_phone
			,mobile_phone
			,external_email as email
			,bethel_email as alt_email
			,birth_date
			,baptism_date
			,left( gender_code, 1 ) as gender_code
			,coalesce( ms.marital_status_key, 6 ) as marital_status_key
			,cong_servant_code
			,case when pioneer_status = 1 then 'Y' else 'N' end as pioneer_flag
			,coalesce( cong.cong_key, 16957 ) as cong_key 
			,person_id as hub_person_id
			,person_guid as hub_person_guid
			,volunteer_number as hub_volunteer_num
			,volunteer_id as hub_volunteer_id
			,replace( jwpub_email, '@jwpub.org', '' ) as jw_username
			,mate_person_id as mate_hub_person_id
			,mate_person_guid as mate_hub_person_guid
			,1 as vol_desk_user_key
			,1 as tracking_status_key
			,case when p.whatsapp = 0 then 'N' else 'Y' end as whatsapp_flag
			,case when p.text_message = 0 then 'N' else 'Y' end as sms_flag
		from stg.stg_person p
		left join dbo.postal_code pc
			on p.postal_code = pc.postal_code
		left join dbo.country c
			on p.country_code = c.country_code
		left join dbo.state s
			on p.state_code = s.state_code
			and c.Country_Key = s.Country_Key			
		left join dbo.marital_status ms
			on p.marital_status = ms.marital_status
		left join dbo.cong cong
			on p.cong_number = cong.cong_number
		where not exists ( select * from dbo.volunteer v where p.person_id = v.hub_person_id )

		set @Ins = @@rowcount

		-- UPDATE		
		update dbo.volunteer
		set 
			first_name = src.first_name,
			last_name = src.last_name,
			full_name = src.last_name + ', ' + src.first_name + ' ' + coalesce( src.middle_name, '' ),
			middle_name = src.middle_name,
			suffix = src.suffix,
			maiden_name = src.maiden_name,
			address = src.address1,
			address2 = src.address2,
			city = src.city,
			home_phone = src.home_phone,
			mobile_phone = src.mobile_phone,
			email = src.external_email,
			alt_email = src.bethel_email,
			birth_date = src.birth_date,
			baptism_date = src.baptism_date,
			gender_code = left( src.gender_code, 1 ),
			cong_servant_code = src.cong_servant_code,
			pioneer_flag = case when src.pioneer_status = 1 then 'Y' else 'N' end,
			hub_volunteer_num = src.volunteer_number,
			hub_volunteer_id = src.volunteer_id,
			hub_person_guid = src.person_guid,
			jw_username = replace( src.jwpub_email, '@jwpub.org', '' ),
			mate_hub_person_id = src.mate_person_id,
			mate_hub_person_guid = src.mate_person_guid,
			whatsapp_flag = case when src.whatsapp = 0 then 'N' else 'Y' end, 
			sms_flag = case when src.text_message = 0 then 'N' else 'Y' end,
			update_date = getdate()
		from dbo.volunteer tgt
		inner join stg.stg_person src
			on tgt.hub_person_id = src.person_id
		where tgt.first_name <> src.first_name
			or tgt.last_name <> src.last_name
			or coalesce( tgt.middle_name, '' ) <> coalesce( src.middle_name, '' )
			or coalesce( tgt.suffix, '' ) <> coalesce( src.suffix, '' )
			or coalesce( tgt.maiden_name, '' ) <> coalesce( src.maiden_name, '' )
			or coalesce( tgt.address, '' ) <> coalesce( src.address1, '' )
			or coalesce( tgt.address2, '' ) <> coalesce( src.address2, '' )
			or coalesce( tgt.city, '' ) <> coalesce( src.city, '' )
			or coalesce( tgt.home_phone, '' ) <> coalesce( src.home_phone, '' )
			or coalesce( tgt.mobile_phone, '' ) <> coalesce( src.mobile_phone, '' )
			or coalesce( tgt.email, '' ) <> coalesce( src.external_email, '' )
			or coalesce( tgt.alt_email, '' ) <> coalesce( src.bethel_email, '' )
			or coalesce( tgt.birth_date, cast( getdate() as date ) ) <> coalesce( src.birth_date, cast( getdate() as date ) )
			or coalesce( tgt.baptism_date, cast( getdate() as date ) ) <> coalesce( src.baptism_date, cast( getdate() as date ) )
			or coalesce( tgt.gender_code, '' ) <> coalesce( left( src.gender_code, 1 ), '' )
			or coalesce( tgt.cong_servant_code, '' ) <> coalesce( src.cong_servant_code, '' )
			or tgt.pioneer_flag <> case when coalesce( src.pioneer_status, 0 ) = 1 then 'Y' else 'N' end
			or coalesce( tgt.hub_volunteer_num, 0 ) <> coalesce( src.volunteer_number, 0 )
			or coalesce( tgt.hub_volunteer_id, 0 ) <> coalesce( src.volunteer_id, 0 )			
			or coalesce( cast( tgt.hub_person_guid as nvarchar(64) ), '' ) <> coalesce( cast( src.person_guid as nvarchar(64) ) , '' )					
			or coalesce( tgt.jw_username, '' ) <> coalesce( replace( src.jwpub_email, '@jwpub.org', '' ), '' )
			or coalesce( tgt.mate_hub_person_id, 0 ) <> coalesce( src.mate_person_id, 0 )
			or coalesce( cast( tgt.mate_hub_person_guid as nvarchar(64) ), '' ) <> coalesce( cast( src.mate_person_guid as nvarchar(64) ), '' )
			or tgt.whatsapp_flag <> case when coalesce( src.whatsapp, 0 ) = 0 then 'N' else 'Y' end 
			or tgt.sms_flag <> case when coalesce( src.text_message, 0 ) = 0 then 'N' else 'Y' end	

		update dbo.volunteer
		set 
			postal_code_key = coalesce( pc.postal_code_key, 1 ),
			state_key = coalesce( s.state_key, 1 ),
			country_key = coalesce( c.country_key, 1 ),
			marital_status_key = coalesce( ms.marital_status_key, 6 ),
			cong_key = coalesce( cong.cong_key, 16957 ),
			update_date = getdate()
		from dbo.volunteer tgt
		inner join stg.stg_person src
			on tgt.hub_person_id = src.person_id
		left join dbo.country c
			on src.country_code = c.country_code
		left join dbo.state s
			on src.state_code = s.state_code
			and c.country_key = s.country_key
		left join dbo.postal_code pc
			on src.postal_code = pc.postal_code
			and pc.State_Key = s.state_key
		left join dbo.marital_status ms
			on src.marital_status = ms.marital_status
		left join dbo.cong cong
			on src.cong_number = cong.cong_number		
		where 
			   coalesce( tgt.postal_code_key, 1 ) <> coalesce( pc.postal_code_key, 1 )
			or coalesce( tgt.state_key, 1 ) <> coalesce( s.state_key, 1 )
			or coalesce( tgt.country_key, 1 ) <> coalesce( c.country_key, 1 )
			or coalesce( tgt.marital_status_key, 6 ) <> coalesce( ms.marital_status_key, 6 )
			or coalesce( tgt.cong_key, 16957 ) <> coalesce( cong.cong_key, 16957 )
			
		set @Upd = @@rowcount

		-- UPDATE - VOLUNTEER NUMBER SYNC		
		update dbo.volunteer 
		set hub_volunteer_num = null
		where hub_volunteer_num is not null
			and not exists ( select 1 from stg.stg_person where person_id = hub_person_id and volunteer_number = hub_volunteer_num )

		set @Upd = @Upd + @@rowcount

		-- UPDATE - TURN HUB TRACKING ON
		update dbo.volunteer
		set 
			hub_tracking_flag = 'Y',
			update_date = getdate()
		where hub_tracking_flag = 'N'
			and hub_person_id in ( select person_id from stg.stg_person_tracking )

		set @Upd = @Upd + @@rowcount

		-- UPDATE - TURN HUB TRACKING OFF
		update dbo.volunteer
		set 
			hub_tracking_flag = 'N',
			update_date = getdate()
		where hub_tracking_flag = 'Y'
			and hub_person_id not in ( select person_id from stg.stg_person_tracking )

		set @Upd = @Upd + @@rowcount

		-- UPDATE - BA INFO
		select 
			tgt.volunteer_key,
			src.volunteer_id						as ba_volunteer_id,
			src.volunteer_banumber					as ba_volunteer_num,
			src.mate_volunteer_id					as mate_ba_volunteer_id,
			src.mate_volunteer_banumber				as mate_ba_volunteer_num, 
			left( src.preferred_name, 150 )			as preferred_name,
			left( src.preferred_phone_number, 20 )	as preferred_phone,
			src.preferred_phone_type,
			src.safety_orientation_date				as ba_safety_orientation_date
		into #ba_tmp
		from dbo.volunteer tgt
		inner join stg.stg_ba_volunteer src
			on tgt.hub_person_guid = src.person_guid
		where coalesce( tgt.ba_volunteer_id, 0 ) <> coalesce( src.volunteer_id, 0 )
			or coalesce( tgt.ba_volunteer_num, 0 ) <> coalesce( src.volunteer_banumber, 0 )
			or coalesce( tgt.mate_ba_volunteer_id, 0 ) <> coalesce( src.mate_volunteer_id, 0 )
			or coalesce( tgt.mate_ba_volunteer_num, 0 ) <> coalesce( src.mate_volunteer_banumber, 0 )
			or coalesce( tgt.preferred_name, '' ) <> coalesce( left( src.preferred_name, 150 ), '' )
			or coalesce( tgt.preferred_phone, '' ) <> coalesce( left( src.preferred_phone_number, 20 ), '' )
			or coalesce( tgt.preferred_phone_type, '' ) <> coalesce( src.preferred_phone_type, '' )
			or coalesce( tgt.ba_safety_orientation_date, '2999-12-31' ) <> coalesce( src.Safety_Orientation_Date, '2999-12-31' )

		update dbo.volunteer
		set 
			ba_volunteer_id = src.ba_volunteer_id,
			ba_volunteer_num = src.ba_volunteer_num,
			mate_ba_volunteer_id = src.mate_ba_volunteer_id,
			mate_ba_volunteer_num = src.mate_ba_volunteer_num, 
			preferred_name = src.preferred_name,
			preferred_phone = src.preferred_phone,
			preferred_phone_type = src.preferred_phone_type,
			ba_safety_orientation_date = src.ba_safety_orientation_date,
			ba_active_flag = 'Y',
			update_date = getdate()
		from dbo.volunteer tgt
		inner join #ba_tmp src
			on tgt.volunteer_key = src.volunteer_key
			
		set @Upd = @Upd + @@rowcount	
		
		-- UPDATE - TURN ALL KEY ROLES OFF
		update dbo.volunteer
		set 
			person_key_roles_flag = 'N',
			update_date = getdate()
		where person_key_roles_flag = 'Y'

		set @Upd = @Upd + @@rowcount

		-- UPDATE - TURN KEY ROLES ON FOR HID
		update dbo.volunteer
		set 
			person_key_roles_flag = 'Y',
			update_date = getdate()
		where person_key_roles_flag = 'N'
			and volunteer_key in ( select volunteer_key from dbo.volunteer_role where active_flag = 'Y' and role_data = 'HLC Chairman' )

		set @Upd = @Upd + @@rowcount

		-- UPDATE - TURN KEY ROLES ON FOR SERVICE
		update dbo.volunteer
		set 
			person_key_roles_flag = 'Y',
			update_date = getdate()
		where person_key_roles_flag = 'N'
			and volunteer_key in ( select volunteer_key from dbo.volunteer_role where active_flag = 'Y' and role in (			
				'Kingdom Ministry School Instructor',
				'Substitute Circuit Overseer',
				'Bible School Graduate',
				'Pioneer School Instructor',
				'Convention Contract Representative',
				'Convention Contract Representative Assistant',
				'Convention Rooming Coordinator',
				'Convention Rooming Coordinator Assistant',
				'SCOTW Instructor',
				'SCE Instructor',
				'SKE Instructor',
				'Convention Equipment Pool Committee',
				'Convention Responsibility',		-- CONVENTION COMMITTEE COORDINATOR
				'Witnessing group coordinator' ) )

		set @Upd = @Upd + @@rowcount
				
		-- UPDATE - TURN KEY ROLES ON FOR LDC
		update dbo.volunteer
		set 
			person_key_roles_flag = 'Y',
			update_date = getdate()
		where person_key_roles_flag = 'N'
			and volunteer_key in 
				( select volunteer_key from dbo.volunteer_role 
				  where active_flag = 'Y'
					and role = 'LDC Entity Person' 
					and ( role_data in ( 'LDC Department', 'Disaster Relief', 'Design Section', 'Maintenance Section', 'Planning Section', 'Project Management Section',
										   'Quality Assurance Section', 'Support Section' ) 
						or role_data like 'Design Zone%'
						or role_data like 'CFR %'
						or role_data like 'CCGO %'
						or role_data like 'FR %'
						or role_data like 'FR-P %'
						or role_data like 'Construction Group %' ) )

		set @Upd = @Upd + @@rowcount
		
		-- ROOMING
		update dbo.volunteer
		set 
			Room_Site_Code 	= null,
			Room_Bldg 		= null,
			Room_Bldg_Code 	= null,
			Room 			= null
		where room is not null			

		set @Upd = @Upd + @@rowcount
		
		update dbo.volunteer
		set 
			Room_Site_Code 	= src.room_site_code,
			Room_Bldg 		= src.room_building_name,
			Room_Bldg_Code 	= src.room_building_code,
			Room 			= src.room_number,
			update_date 	= getdate()
		from dbo.volunteer tgt
		inner join stg.stg_Rooming src
			on tgt.hub_person_id = src.person_id

		set @Upd = @Upd + @@rowcount
		
		-- DELETE DECEASED
		delete from dbo.volunteer_role
		where volunteer_key in 
			( select volunteer_key from dbo.volunteer
	 		  where hub_person_id in 
	 		  	( select person_id
				  from stg.stg_person
				  where deceased_date is not null ) )

		set @Del = @Del + @@rowcount
		
		delete from dbo.volunteer
		where hub_person_id in ( 
			select person_id
			from stg.stg_person
			where deceased_date is not null )

		set @Del = @Del + @@rowcount
		
		-- TENTATIVE END DATE
		update dbo.volunteer
		set tentative_end_date = null
		where tentative_end_date is not null

		set @Upd = @Upd + @@rowcount
		
		update dbo.volunteer
		set 
			tentative_end_date = src.tentative_end_date,
			update_date 	= getdate()
		from dbo.volunteer tgt
		inner join ( select personid, max( tentativeenddate ) as tentative_end_date
					 from stg.stg_bethel_member_availability 
					 group by personid ) src
			on tgt.hub_person_id = src.personid
			and src.tentative_end_date is not null

		set @Upd = @Upd + @@rowcount
		
		-- CONG RELOCATION DATE
		update dbo.volunteer
		set cong_relocation_date = null
		where cong_relocation_date is not null

		set @Upd = @Upd + @@rowcount
		
		update dbo.volunteer
		set 
			cong_relocation_date = src.min_dt,
			update_date	= getdate()
		from dbo.volunteer tgt
		inner join stg.Volunteer_Cong_Hist_Ranking_v src
			on tgt.hub_person_id = src.person_id

		set @Upd = @Upd + @@rowcount	
				
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**					VOLUNTEER APP
***********************************************************/
if object_id('dbo.ETL_Volunteer_App_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_App_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_App_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_App', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.volunteer_app( 
			 volunteer_key
			,app_type_key
			,app_status_key
			,app_date
			,expiration_date
			,status_notes
			,app_notes
			,review_status_submitted_date
			,review_stage_elders_date
			,review_stage_co_date
			,applicant_id
			,expired_flag
			,active_flag )		
		select 
			 v.volunteer_key
			,apt.app_type_key
			,aps.app_status_key
			,a.app_date
			,a.app_expiry_date
			,a.app_status_notes
			,a.app_notes
			,a.app_review_status_submitted_date
			,a.app_review_stage_elders_date
			,a.app_review_stage_co_date
			,a.applicant_id
			,case when getdate() < a.app_expiry_date then 'N' else 'Y' end as expired_flag
			,case when getdate() <= a.app_expiry_date then 'Y' else 'N' end as active_flag
		from stg.stg_app a
		inner join dbo.volunteer v
			on a.person_id = v.hub_person_id
		inner join dbo.app_type apt
			on a.app_type_id = apt.hub_app_type_id
		inner join dbo.app_status aps
			on a.app_status = aps.app_status
		where applicant_id not in ( select applicant_id from dbo.volunteer_app )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.volunteer_app
		set 
			app_date = src.app_date,
			expiration_date = src.app_expiry_date,
			app_status_key = aps.app_status_key,
			status_notes = src.app_status_notes,
			app_notes = src.app_notes,
			review_status_submitted_date = src.app_review_status_submitted_date,
			review_stage_elders_date = src.app_review_stage_elders_date,
			review_stage_co_date = src.app_review_stage_co_date,
			update_date = getdate()
		from dbo.volunteer_app tgt
		inner join stg.stg_app src
			on tgt.applicant_id = src.applicant_id
		inner join dbo.app_status aps
			on src.app_status = aps.app_status		
		where tgt.app_date <> src.app_date
			or tgt.expiration_date <> src.app_expiry_date
			or tgt.app_status_key <> aps.app_status_key
			or coalesce( tgt.status_notes, '' ) <> coalesce( src.app_status_notes, '' )
			or coalesce( tgt.app_notes, '' ) <> coalesce( src.app_notes, '' )
			or coalesce( tgt.review_status_submitted_date, '1900-01-01' ) <> coalesce( src.app_review_status_submitted_date, '1900-01-01' )
			or coalesce( tgt.review_stage_elders_date, '1900-01-01' ) <> coalesce( src.app_review_stage_elders_date, '1900-01-01' )
			or coalesce( tgt.review_stage_co_date, '1900-01-01' ) <> coalesce( src.app_review_stage_co_date, '1900-01-01' ) 

		set @Upd = @@rowcount

		-- UPDATE - FLAGS
		update dbo.volunteer_app
		set active_flag = 'Y'
		where active_flag <> 'Y'
			and expiration_date >= getdate()
			
		set @Upd = @Upd + @@rowcount
		
		update dbo.volunteer_app
		set active_flag = 'N'
		where active_flag = 'Y'
			and expired_flag = 'Y'
			
		set @Upd = @Upd + @@rowcount			
		
		
		update dbo.volunteer_app
		set 
			expired_flag = case when getdate() > expiration_date then 'Y' else 'N' end,
			active_flag = case when getdate() > expiration_date then 'N' else 'Y' end,
			update_date = getdate()
		from dbo.volunteer_app tgt
		where 
			   ( expired_flag = 'N' and getdate() > expiration_date )
			or ( active_flag = 'Y' and getdate() > expiration_date )

		set @Upd = @Upd + @@rowcount
		
		-- UPDATE - FLAGS WHERE THE EXPIRE DATE CHANGED AND WE DIDNT RECEIVE NOTIFICATION
		update dbo.volunteer_app
		set 
			expired_flag = 'Y',
			active_flag = 'N',
			update_date = getdate()
		where expired_flag = 'N'
			and active_flag = 'Y'
			and not exists ( select 1 from stg.stg_app a where volunteer_app.applicant_Id = a.applicant_id )		

		set @Upd = @Upd + @@rowcount
		
		-- UPDATE - ATTRIBUTES
		update dbo.volunteer_app
		set 
			attrib_approval_level_app_attrib_id = src.attrib_approval_level_app_attrib_id,			
			attrib_approval_level_attrib_id = src.attrib_approval_level_attrib_id,
			attrib_approval_level_val = src.attrib_approval_level_val,
			
			attrib_pursued_by_app_attrib_id = src.attrib_pursued_by_app_attrib_id,
			attrib_pursued_by_attrib_id = src.attrib_pursued_by_attrib_id,
			attrib_pursued_by_val = src.attrib_pursued_by_val,			
			
			attrib_contacted_app_attrib_id = src.attrib_contacted_app_attrib_id,
			attrib_contacted_attrib_id = src.attrib_contacted_attrib_id,
			attrib_contacted_val = src.attrib_contacted_val,			
			
			attrib_ske_app_attrib_id = src.attrib_ske_app_attrib_id,
			attrib_ske_attrib_id = src.attrib_ske_attrib_id,
			attrib_ske_val = src.attrib_ske_val,			
			
			attrib_other_app_attrib_id = src.attrib_other_app_attrib_id,
			attrib_other_attrib_id = src.attrib_other_attrib_id,
			attrib_other_val = src.attrib_other_val,
			
			update_date = getdate()
		from dbo.volunteer_app tgt
		inner join 
			( select applicant_id
				,max( case when attribute = 'Approval Level' then applicant_attribute_id else 0 end ) as attrib_approval_level_app_attrib_id
				,max( case when attribute = 'Approval Level' then attribute_id else 0 end ) as attrib_approval_level_attrib_id				
				,max( case when attribute = 'Approval Level' then attribute_value else '' end ) as attrib_approval_level_val

				,max( case when attribute = 'Applicant Being Pursued By:' then applicant_attribute_id else 0 end ) as attrib_pursued_by_app_attrib_id
				,max( case when attribute = 'Applicant Being Pursued By:' then attribute_id else 0 end ) as attrib_pursued_by_attrib_id				
				,max( case when attribute = 'Applicant Being Pursued By:' then attribute_value else '' end ) as attrib_pursued_by_val
				
				,max( case when attribute = 'Contacted' then applicant_attribute_id else 0 end ) as attrib_contacted_app_attrib_id
				,max( case when attribute = 'Contacted' then attribute_id else 0 end ) as attrib_contacted_attrib_id
				,max( case when attribute = 'Contacted' then attribute_value else '' end ) as attrib_contacted_val				
				
				,max( case when attribute like '%SKE%' then applicant_attribute_id else 0 end ) as attrib_ske_app_attrib_id
				,max( case when attribute like '%SKE%' then attribute_id else 0 end ) as attrib_ske_attrib_id
				,max( case when attribute like '%SKE%' then attribute_value else '' end ) as attrib_ske_val				
				
				,max( case when attribute not in ( 'Approval Level', 'Applicant Being Pursued By:', 'Contacted' ) and attribute not like '%SKE%' 
					then applicant_attribute_id else 0 end ) as attrib_other_app_attrib_id
				,max( case when attribute not in ( 'Approval Level', 'Applicant Being Pursued By:', 'Contacted' ) and attribute not like '%SKE%' 
					then attribute_id else 0 end ) as attrib_other_attrib_id
				,max( case when attribute not in ( 'Approval Level', 'Applicant Being Pursued By:', 'Contacted' ) and attribute not like '%SKE%' 
					then attribute_value else '' end ) as attrib_other_val				
			  from stg.stg_app_attribute
			  group by applicant_id ) src
			on tgt.applicant_id = src.applicant_id	
		where coalesce( tgt.attrib_approval_level_val, '' ) <> coalesce( src.attrib_approval_level_val, '' )
			or coalesce( tgt.attrib_pursued_by_val, '' ) <> coalesce( src.attrib_pursued_by_val, '' )
			or coalesce( tgt.attrib_contacted_val, '' ) <> coalesce( src.attrib_contacted_val, '' )
			or coalesce( tgt.attrib_ske_val, '' ) <> coalesce( src.attrib_ske_val, '' )
			or coalesce( tgt.attrib_other_val, '' ) <> coalesce( src.attrib_other_val, '' )
			or coalesce( tgt.attrib_approval_level_app_attrib_id, 0 ) <> coalesce( src.attrib_approval_level_app_attrib_id, 0 )
			or coalesce( tgt.attrib_pursued_by_app_attrib_id, 0 ) <> coalesce( src.attrib_pursued_by_app_attrib_id, 0 )
			or coalesce( tgt.attrib_contacted_app_attrib_id, 0 ) <> coalesce( src.attrib_contacted_app_attrib_id, 0 )
			or coalesce( tgt.attrib_ske_app_attrib_id, 0 ) <> coalesce( src.attrib_ske_app_attrib_id, 0 )
			or coalesce( tgt.attrib_other_app_attrib_id, 0 ) <> coalesce( src.attrib_other_app_attrib_id, 0 )

		set @Upd = @Upd + @@rowcount

		-- UPDATE - VOLUNTEER A-8
		update dbo.volunteer
		set 
			a8_approved_flag = case when src.app_status_key in ( 1, 4, 9 ) then 'Y' else 'N' end,
			a8_app_status_key = src.app_status_key,
			a8_app_date = src.app_date,
			update_date = getdate()
		from dbo.volunteer tgt
		inner join dbo.volunteer_app src
			on tgt.volunteer_key = src.volunteer_key
			and src.app_type_key = 2
		inner join ( select volunteer_key, max( app_date ) as max_dt from dbo.volunteer_app where app_type_key = 2 group by volunteer_key ) curr
			on src.volunteer_key = curr.volunteer_key
			and src.app_date = curr.max_dt			
		where src.expired_flag = 'N'
			and ( coalesce( tgt.a8_app_status_key, 0 ) <> src.app_status_key
				or coalesce( tgt.a8_app_date, '1900-01-01' ) <> src.app_date
				or coalesce( tgt.a8_approved_flag, '' ) <> case when src.app_status_key in ( 1, 4, 9 ) then 'Y' else 'N' end )

		set @Upd = @Upd + @@rowcount		

		-- UPDATE - VOLUNTEER A-19
		update dbo.volunteer
		set 
			a19_approved_flag = case when src.app_status_key in ( 1, 4, 9 ) then 'Y' else 'N' end,
			a19_app_status_key = src.app_status_key,
			a19_app_date = src.app_date,
			update_date = getdate()
		from dbo.volunteer tgt
		inner join dbo.volunteer_app src
			on tgt.volunteer_key = src.volunteer_key
			and src.app_type_key = 1
		inner join ( select volunteer_key, max( app_date ) as max_app_date from dbo.volunteer_app where app_type_key = 1 group by volunteer_key ) curr
			on src.volunteer_key = curr.volunteer_key
			and src.app_date = curr.max_app_date			
		where src.expired_flag = 'N'
			and ( coalesce( tgt.a19_app_status_key, 0 ) <> src.app_status_key
				or coalesce( tgt.a19_app_date, '1900-01-01' ) <> src.app_date
				or coalesce( tgt.a19_approved_flag, '' ) <> case when src.app_status_key in ( 1, 4, 9 ) then 'Y' else 'N' end )

		set @Upd = @Upd + @@rowcount	
		
		-- EXPIRED - VOLUNTEER A-8
		update dbo.volunteer
		set 
			a8_app_status_key = 16,
			update_date = getdate()
		from dbo.volunteer tgt
		inner join dbo.volunteer_app src
			on tgt.volunteer_key = src.volunteer_key
			and src.app_type_key = 2
		inner join ( select volunteer_key, max( app_date ) as max_dt from dbo.volunteer_app where app_type_key = 2 group by volunteer_key ) curr
			on src.volunteer_key = curr.volunteer_key
			and src.app_date = curr.max_dt			
		where src.expired_flag = 'Y'
			and tgt.A8_App_Status_Key is not null
			and tgt.A8_App_Status_Key <> 16 -- EXPIRED		

		set @Upd = @Upd + @@rowcount			

		-- EXPIRED - VOLUNTEER A-19
		update dbo.volunteer
		set 
			a19_app_status_key = 16,
			update_date = getdate()
		from dbo.volunteer tgt
		inner join dbo.volunteer_app src
			on tgt.volunteer_key = src.volunteer_key
			and src.app_type_key = 1
		inner join ( select volunteer_key, max( app_date ) as max_dt from dbo.volunteer_app where app_type_key = 1 group by volunteer_key ) curr
			on src.volunteer_key = curr.volunteer_key
			and src.app_date = curr.max_dt			
		where src.expired_flag = 'Y'
			and tgt.A19_App_Status_Key is not null
			and tgt.A19_App_Status_Key <> 16 -- EXPIRED		

		set @Upd = @Upd + @@rowcount		
		
		-- PURSUED BY - ALL VALUES
		update dbo.volunteer
		set 
			App_Pursued_By_Value = src.attrib_pursued_by_val,
			update_date = getdate()
		from dbo.volunteer tgt
		inner join ( select volunteer_key, first_value( attrib_pursued_by_val ) over( partition by volunteer_key order by update_date desc ) as attrib_pursued_by_val
					 from dbo.volunteer_app_v where active_flag = 'Y' and attrib_pursued_by_val is not null and attrib_pursued_by_val <> ''  ) src
			on tgt.volunteer_key = src.volunteer_key
		where 1=1

		set @Upd = @Upd + @@rowcount			

		-- PURSUED BY - RVD VALUES
		update dbo.volunteer
		set 
			App_Pursued_By_Value = src.attrib_pursued_by_val,
			update_date = getdate()
		from dbo.volunteer tgt
		inner join ( select volunteer_key, first_value( attribute_value ) over( partition by volunteer_key order by update_date desc ) as attrib_pursued_by_val
					 from dbo.Volunteer_Pursuit_Hist where active_flag = 'Y' ) src
			on tgt.volunteer_key = src.volunteer_key
		where 1=1

		set @Upd = @Upd + @@rowcount			
		
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**			VOLUNTEER APP - APP REQUEST COLLECTION
***********************************************************/
if object_id('dbo.ETL_Volunteer_App_Collection_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_App_Collection_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_App_Collection_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_App_Collection_Flag', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try
		-- UPDATE RESET APP COLLECTION FLAG
		update dbo.volunteer
		set 
			App_Request_Collection_Flag = 'N',
			update_date = getdate()
		where App_Request_Collection_Flag = 'Y'			

		set @Upd = @@rowcount	
	
		-- UPDATE
		update dbo.volunteer
		set 
			App_Request_Collection_Flag = 'Y',
			update_date = getdate()		
		where volunteer_key in (
			select v.volunteer_key
			from dbo.volunteer_app_v a
			inner join dbo.volunteer v
				   on a.volunteer_key = v.volunteer_key
				   and v.vol_desk_user_key = 1  -- NOT ASSIGNED
			inner join dbo.enrollment e
				on v.Current_Enrollment_Key = e.Enrollment_Key
				and e.SFTS_Flag = 'N'			-- NOT SFTS
			where a.app_status_code = 'RES' 	-- RESERVED = ON AN APP REQ COLLECTION
				   and a.active_flag = 'Y' )      

		set @Upd = @Upd + @@rowcount

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**				  VOLUNTEER APPROVAL LEVEL 
***********************************************************/
if object_id('dbo.ETL_Volunteer_Approval_Level_Hist_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Approval_Level_Hist_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Approval_Level_Hist_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Approval_Level_Hist',
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.volunteer_approval_level_hist( 
			 volunteer_key
			,approval_level
			,start_date )		
		select 
			 volunteer_key
			,approval_level
			,getdate() as start_date
		from dbo.Volunteer_Approval_Level_v v
		where not exists
			( select 1 from dbo.volunteer_approval_level_hist h
			  where v.volunteer_key = h.volunteer_key
				and v.approval_level = h.approval_level
				and h.active_flag = 'Y' )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.volunteer_approval_level_hist
		set 
			active_flag = 'N',
			end_date = getdate() - 1,
			update_date = getdate()
		from dbo.volunteer_approval_level_hist tgt
		inner join 
			( select volunteer_key, max( start_date ) as start_date 
			  from dbo.volunteer_approval_level_hist 
			  where active_flag = 'Y' 
			  group by volunteer_key ) src
			on tgt.volunteer_key = src.volunteer_key
		where tgt.start_date <> src.start_date

		set @Upd = @@rowcount
		
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**					VOLUNTEER AVAILABILITY
***********************************************************/
if object_id('dbo.ETL_Volunteer_Availability_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Availability_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Availability_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Availability', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.volunteer_availability( 
			 volunteer_key
			,avail_as_consultant_flag
			,avail_as_commuter_flag 
			,avail_as_commuter_as_needed_flag 
			,avail_as_commuter_closest_site 	
			,avail_as_commuter_days_per_wk 		
			,avail_as_commuter_weekly_flag 		
			,avail_as_commuter_notes 			
			,avail_as_commuter_mon_am_flag		
			,avail_as_commuter_mon_pm_flag		
			,avail_as_commuter_tue_am_flag		
			,avail_as_commuter_tue_pm_flag		
			,avail_as_commuter_wed_am_flag		
			,avail_as_commuter_wed_pm_flag		
			,avail_as_commuter_thu_am_flag		
			,avail_as_commuter_thu_pm_flag		
			,avail_as_commuter_fri_am_flag		
			,avail_as_commuter_fri_pm_flag		
			,avail_as_commuter_sat_am_flag		
			,avail_as_commuter_sat_pm_flag		
			,avail_as_commuter_sun_am_flag		
			,avail_as_commuter_sun_pm_flag		
			,avail_as_remote_vol_flag 			
			,avail_as_remote_vol_days_per_wk 
			,avail_as_remote_vol_notes 			
			,avail_as_vol_flag 					
			,avail_as_vol_anytime_flag 			
			,avail_as_vol_start_date 			
			,avail_as_vol_end_date 				
			,avail_as_vol_date_notes 			
			,avail_as_vol_date_short_term_days
			,avail_as_vol_long_term_flag 						
			,avail_as_vol_notes
			,last_update_date )		
		select 
			 v.volunteer_key
			,case when a.avail_as_consultant = 1 then 'Y' else 'N' end as avail_as_consultant_flag
			,case when a.avail_as_commuter = 1 then 'Y' else 'N' end as avail_as_commuter_flag
			,case when a.avail_as_commuter_as_needed = 1 then 'Y' else 'N' end as avail_as_commuter_as_needed_flag
			,a.avail_as_commuter_closest_site 				
			,a.avail_as_commuter_days_per_wk 				
			,case when a.avail_as_commuter_weekly = 1 then 'Y' else 'N' end as avail_as_commuter_weekly_flag
			,a.avail_as_commuter_notes 					
			,case when a.avail_as_commuter_mon_am = 1 then 'Y' else 'N' end as avail_as_commuter_mon_am_flag
			,case when a.avail_as_commuter_mon_pm = 1 then 'Y' else 'N' end as avail_as_commuter_mon_pm_flag
			,case when a.avail_as_commuter_tue_am = 1 then 'Y' else 'N' end as avail_as_commuter_tue_am_flag
			,case when a.avail_as_commuter_tue_pm = 1 then 'Y' else 'N' end as avail_as_commuter_tue_pm_flag
			,case when a.avail_as_commuter_wed_am = 1 then 'Y' else 'N' end as avail_as_commuter_wed_am_flag
			,case when a.avail_as_commuter_wed_pm = 1 then 'Y' else 'N' end as avail_as_commuter_wed_pm_flag
			,case when a.avail_as_commuter_thu_am = 1 then 'Y' else 'N' end as avail_as_commuter_thu_am_flag
			,case when a.avail_as_commuter_thu_pm = 1 then 'Y' else 'N' end as avail_as_commuter_thu_pm_flag
			,case when a.avail_as_commuter_fri_am = 1 then 'Y' else 'N' end as avail_as_commuter_fri_am_flag
			,case when a.avail_as_commuter_fri_pm = 1 then 'Y' else 'N' end as avail_as_commuter_fri_pm_flag
			,case when a.avail_as_commuter_sat_am = 1 then 'Y' else 'N' end as avail_as_commuter_sat_am_flag
			,case when a.avail_as_commuter_sat_pm = 1 then 'Y' else 'N' end as avail_as_commuter_sat_pm_flag
			,case when a.avail_as_commuter_sun_am = 1 then 'Y' else 'N' end as avail_as_commuter_sun_am_flag
			,case when a.avail_as_commuter_sun_pm = 1 then 'Y' else 'N' end as avail_as_commuter_sun_pm_flag
			,case when a.avail_as_remote_vol = 1 then 'Y' else 'N' end as avail_as_remote_vol_flag
			,a.avail_as_remote_vol_days_per_wk 			
			,a.avail_as_remote_vol_notes 					
			,case when a.avail_as_vol = 1 then 'Y' else 'N' end as avail_as_vol_flag
			,case when a.avail_as_vol_anytime = 1 then 'Y' else 'N' end as avail_as_vol_anytime_flag
			,coalesce( a.avail_as_vol_start_date, cast( getdate() as date) ) as avail_as_vol_start_date
			,a.avail_as_vol_end_date 						
			,a.avail_as_vol_date_notes 					
			,a.avail_as_vol_date_short_term_days 			
			,case when a.avail_as_vol_long_term = 1 then 'Y' else 'N' end as avail_as_vol_long_term_flag
			,a.avail_as_vol_notes
			,a.last_update_date
		from stg.stg_person_availability a
		inner join 
			( select person_id, max( coalesce( avail_as_vol_start_date, cast( getdate() as date ) ) ) as max_dt 
			  from stg.stg_person_availability group by person_id ) a2
			on a.person_id = a2.person_id
			and coalesce( a.avail_as_vol_start_date, cast( getdate() as date ) ) = a2.max_dt	
		inner join dbo.volunteer v
			on a.person_id = v.hub_person_id
		where v.volunteer_key not in ( select volunteer_key from dbo.volunteer_availability )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.volunteer_availability
		set 
			avail_as_consultant_flag = case when src.avail_as_consultant = 1 then 'Y' else 'N' end,
			avail_as_commuter_flag = case when src.avail_as_commuter = 1 then 'Y' else 'N' end,		
			avail_as_commuter_as_needed_flag = case when src.avail_as_commuter_as_needed = 1 then 'Y' else 'N' end, 				
			avail_as_commuter_closest_site = src.avail_as_commuter_closest_site,
			avail_as_commuter_days_per_wk = src.avail_as_commuter_days_per_wk, 				
			avail_as_commuter_weekly_flag = case when src.avail_as_commuter_weekly = 1 then 'Y' else 'N' end, 					
			avail_as_commuter_notes = src.avail_as_commuter_notes, 					
			avail_as_commuter_mon_am_flag = case when src.avail_as_commuter_mon_am = 1 then 'Y' else 'N' end,					
			avail_as_commuter_mon_pm_flag = case when src.avail_as_commuter_mon_pm = 1 then 'Y' else 'N' end,					
			avail_as_commuter_tue_am_flag = case when src.avail_as_commuter_tue_am = 1 then 'Y' else 'N' end,					
			avail_as_commuter_tue_pm_flag = case when src.avail_as_commuter_tue_pm = 1 then 'Y' else 'N' end,					
			avail_as_commuter_wed_am_flag = case when src.avail_as_commuter_wed_am = 1 then 'Y' else 'N' end,					
			avail_as_commuter_wed_pm_flag = case when src.avail_as_commuter_wed_pm = 1 then 'Y' else 'N' end,					
			avail_as_commuter_thu_am_flag = case when src.avail_as_commuter_thu_am = 1 then 'Y' else 'N' end,					
			avail_as_commuter_thu_pm_flag = case when src.avail_as_commuter_thu_pm = 1 then 'Y' else 'N' end,					
			avail_as_commuter_fri_am_flag = case when src.avail_as_commuter_fri_am = 1 then 'Y' else 'N' end,					
			avail_as_commuter_fri_pm_flag = case when src.avail_as_commuter_fri_pm = 1 then 'Y' else 'N' end,					
			avail_as_commuter_sat_am_flag = case when src.avail_as_commuter_sat_am = 1 then 'Y' else 'N' end,					
			avail_as_commuter_sat_pm_flag = case when src.avail_as_commuter_sat_pm = 1 then 'Y' else 'N' end,					
			avail_as_commuter_sun_am_flag = case when src.avail_as_commuter_sun_am = 1 then 'Y' else 'N' end,					
			avail_as_commuter_sun_pm_flag = case when src.avail_as_commuter_sun_pm = 1 then 'Y' else 'N' end,					
			avail_as_remote_vol_flag = case when src.avail_as_remote_vol = 1 then 'Y' else 'N' end, 						
			avail_as_remote_vol_days_per_wk = src.avail_as_remote_vol_days_per_wk, 			
			avail_as_remote_vol_notes = src.avail_as_remote_vol_notes,					
			avail_as_vol_flag = case when src.avail_as_vol = 1 then 'Y' else 'N' end,						
			avail_as_vol_anytime_flag = case when src.avail_as_vol_anytime = 1 then 'Y' else 'N' end,
			avail_as_vol_start_date = coalesce( src.avail_as_vol_start_date, cast( getdate() as date) ), 					
			avail_as_vol_end_date = src.avail_as_vol_end_date, 						
			avail_as_vol_date_notes = src.avail_as_vol_date_notes, 					
			avail_as_vol_date_short_term_days = src.avail_as_vol_date_short_term_days, 			
			avail_as_vol_long_term_flag = case when src.avail_as_vol_long_term = 1 then 'Y' else 'N' end, 						
			avail_as_vol_notes = src.avail_as_vol_notes,
			update_date = getdate(),
			last_update_date = src.last_update_date
		from dbo.volunteer_availability tgt
		inner join dbo.volunteer v
			on tgt.volunteer_key = v.volunteer_key
		inner join stg.stg_person_availability src
			on v.hub_person_id = src.person_id
		where coalesce( tgt.avail_as_consultant_flag, 'N' ) <> case when src.avail_as_consultant = 1 then 'Y' else 'N' end			
			or coalesce( tgt.avail_as_commuter_flag, 'N' ) <> case when src.avail_as_commuter = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_as_needed_flag, 'N' ) <> case when src.avail_as_commuter_as_needed = 1 then 'Y' else 'N' end 				
			or coalesce( tgt.avail_as_commuter_closest_site, '' ) <> coalesce( src.avail_as_commuter_closest_site, '' )
			or coalesce( tgt.avail_as_commuter_days_per_wk, 0 ) <> coalesce( src.avail_as_commuter_days_per_wk, 0 )
			or coalesce( tgt.avail_as_commuter_weekly_flag, 'N' ) <> case when src.avail_as_commuter_weekly = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_notes, '' ) <> coalesce( src.avail_as_commuter_notes, '' )
			or coalesce( tgt.avail_as_commuter_mon_am_flag, 'N' ) <> case when src.avail_as_commuter_mon_am = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_mon_pm_flag, 'N' ) <> case when src.avail_as_commuter_mon_pm = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_tue_am_flag, 'N' ) <> case when src.avail_as_commuter_tue_am = 1 then 'Y' else 'N' end				
			or coalesce( tgt.avail_as_commuter_tue_pm_flag, 'N' ) <> case when src.avail_as_commuter_tue_pm = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_wed_am_flag, 'N' ) <> case when src.avail_as_commuter_wed_am = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_wed_pm_flag, 'N' ) <> case when src.avail_as_commuter_wed_pm = 1 then 'Y' else 'N' end				
			or coalesce( tgt.avail_as_commuter_thu_am_flag, 'N' ) <> case when src.avail_as_commuter_thu_am = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_thu_pm_flag, 'N' ) <> case when src.avail_as_commuter_thu_pm = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_fri_am_flag, 'N' ) <> case when src.avail_as_commuter_fri_am = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_fri_pm_flag, 'N' ) <> case when src.avail_as_commuter_fri_pm = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_sat_am_flag, 'N' ) <> case when src.avail_as_commuter_sat_am = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_sat_pm_flag, 'N' ) <> case when src.avail_as_commuter_sat_pm = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_sun_am_flag, 'N' ) <> case when src.avail_as_commuter_sun_am = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_commuter_sun_pm_flag, 'N' ) <> case when src.avail_as_commuter_sun_pm = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_remote_vol_flag, 'N' ) <> case when src.avail_as_remote_vol = 1 then 'Y' else 'N' end					
			or coalesce( tgt.avail_as_remote_vol_days_per_wk, 0 ) <> coalesce( src.avail_as_remote_vol_days_per_wk, 0 )
			or coalesce( tgt.avail_as_remote_vol_notes, '' ) <> coalesce( src.avail_as_remote_vol_notes, '' )
			or coalesce( tgt.avail_as_vol_flag, 'N' ) <> case when src.avail_as_vol = 1 then 'Y' else 'N' end 								
			or coalesce( tgt.avail_as_vol_anytime_flag, 'N' ) <> case when src.avail_as_vol_anytime = 1 then 'Y' else 'N' end 						
			or ( src.avail_as_vol_start_date is not null
				and coalesce( tgt.avail_as_vol_start_date, '1900-01-01' ) <> coalesce( src.avail_as_vol_start_date, '1900-01-01' ) )		
			or coalesce( tgt.avail_as_vol_end_date, '1900-01-01' ) <> coalesce( src.avail_as_vol_end_date, '1900-01-01' )
			or coalesce( tgt.avail_as_vol_date_notes, '' ) <> coalesce( src.avail_as_vol_date_notes, '' ) 					
			or coalesce( tgt.avail_as_vol_date_short_term_days, 0 ) <> coalesce( src.avail_as_vol_date_short_term_days, 0 )
			or coalesce( tgt.avail_as_vol_long_term_flag, 'N' ) <> case when src.avail_as_vol_long_term = 1 then 'Y' else 'N' end 						
			or coalesce( tgt.avail_as_vol_notes, '' ) <> coalesce( src.avail_as_vol_notes, '' )
			or coalesce( tgt.last_update_date, '1900-01-01' ) <> coalesce( src.last_update_date, '1900-01-01' )

		set @Upd = @@rowcount

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**					   VOLUNTEER DEPT 
***********************************************************/
if object_id('dbo.ETL_Volunteer_Dept_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Dept_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Dept_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Dept', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- DELETE
		if object_id('stg.tmp_vol_dept', 'U') is not null
			drop table stg.tmp_vol_dept

		if object_id('stg.tmp_vol_dept_rvd', 'U') is not null
			drop table stg.tmp_vol_dept_rvd;

		-- GET RECORDCOUNT AND MINIMUM DATE FROM HUB FEED FOR A PERSON
		-- COMPARE TO WHAT EXISTS IN RVD
		with src as (
			select person_id, min(start_date) as min_dt, count(*) as cnt
			from stg.stg_Person_Dept_History
			--where person_id = 46057
			group by person_id ),

		rvd as (
			select vd.person_id, count(*) as rvd_cnt, max( src.cnt ) as src_cnt, max( src.min_dt ) as src_dt
			from dbo.Volunteer_Dept vd
			inner join src 
				on vd.Person_ID = src.Person_ID
				and vd.Start_Date >= src.min_dt
			--where vd.person_id = 46057
			group by vd.person_id )

		select *
		into stg.tmp_vol_dept
		from rvd
		where rvd_cnt != src_cnt 

		--select * from stg.tmp_vol_dept

		select vd.*
		into stg.tmp_vol_dept_rvd
		from dbo.Volunteer_Dept vd
		inner join stg.tmp_vol_dept tmp 
			on vd.person_id = tmp.person_id 
			and vd.start_date >= tmp.src_dt 

		--select count(*) from stg.tmp_vol_dept_rvd

		delete from dbo.volunteer_dept
		where volunteer_dept_key in ( select volunteer_dept_key from stg.tmp_vol_dept_rvd )
		
		set @Del = @@rowcount		

		-- UPDATE
		update dbo.volunteer_dept
		set 
			site_code = src.site_code,
			end_date = src.end_date,
			update_date = getdate()
		from dbo.volunteer_dept tgt
		inner join stg.stg_person_dept_history src
			on tgt.person_id = src.person_id
			--and coalesce( tgt.site_code, 'x' ) = coalesce( src.site_code, 'x' )
			and tgt.parent_dept_name = src.parent_department_name
			and tgt.dept_name = src.department_name
			and tgt.temp_flag = case when src.temporary_flag = 1 then 'Y' else 'N' end
			and tgt.primary_flag = case when src.primary_flag = 1 then 'Y' else 'N' end
			and coalesce( tgt.enrollment_code, 'x' ) = coalesce( src.effective_enrollment_code, 'x' )
			and coalesce( tgt.dept_role, 'x' ) = coalesce( src.role, 'x' )			
			and tgt.start_date = src.start_date
			and coalesce( tgt.notes, 'x' ) = coalesce( src.notes, 'x' )
		where coalesce( tgt.end_date, '2999-12-31' ) <> coalesce( src.end_date, '2999-12-31' )

		set @Upd = @@rowcount		
	
		-- INSERT
		insert into dbo.volunteer_dept( 
			 volunteer_key
			,person_id
			,hub_dept_id
			,site_code
			,parent_dept_name
			,dept_name
			,temp_flag
			,primary_flag
			,enrollment_code
			,dept_role
			,start_date
			,end_date
			,notes
			,active_flag )		
		select distinct
			 v.volunteer_key
			,d.person_id
			,d.department_id
			,d.site_code
			,d.parent_department_name as parent_dept_name
			,d.department_name as dept_name
			,case when d.temporary_flag = 1 then 'Y' else 'N' end as temp_flag
			,case when d.primary_flag = 1 then 'Y' else 'N' end as primary_flag
			,d.effective_enrollment_code as enrollment_code
			,role as dept_role
			,d.start_date
			,d.end_date
			,d.notes
			,case when getdate() between d.start_date and coalesce( d.end_date, '2999-12-31' ) then 'Y' else 'N' end as active_flag
		from stg.stg_person_dept_history d
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on d.person_id = v.hub_person_id
		where not exists 
			( select 1 from dbo.volunteer_dept vd 
			  where vd.person_id = d.person_id
				and coalesce( vd.site_code, 'x' ) = coalesce( d.site_code, 'x' )
				and coalesce( vd.parent_dept_name, 'x' ) = coalesce( d.parent_department_name, 'x' )
				and vd.dept_name = d.department_name
				and vd.temp_flag = case when d.temporary_flag = 1 then 'Y' else 'N' end
				and vd.primary_flag = case when d.primary_flag = 1 then 'Y' else 'N' end
				and coalesce( vd.enrollment_code, 'x' ) = coalesce( d.effective_enrollment_code, 'x' )
				and coalesce( vd.dept_role, 'x' ) = coalesce( d.role, 'x' )
				and vd.start_date = d.start_date
				and coalesce( vd.end_date, '2999-12-31' ) = coalesce( d.end_date, '2999-12-31' )
				and coalesce( vd.notes, 'x' ) = coalesce( d.notes, 'x' ) )

		set @Ins = @@rowcount

		-- UPDATE - FLAG INACTIVE
		update dbo.volunteer_dept
		set 
			active_flag = 'N',
			update_date = getdate()
		where active_flag = 'Y'
			and getdate() > coalesce( end_date, '2999-12-31' )

		set @Upd = @Upd + @@rowcount	
		
		-- UPDATE - FLAG ACTIVE
		update dbo.volunteer_dept
		set 
			active_flag = 'Y',
			update_date = getdate()
		where active_flag = 'N'
			and ( end_date is null or end_date > getdate() )

		set @Upd = @Upd + @@rowcount			

		-- UPDATE - WORKDAYS FOR COMMUTERS
		update dbo.volunteer_dept
		set 
			mon_am_flag = case when src.daysperweekbitwise_mon_am = 1 then 'Y' else 'N' end,
			mon_pm_flag = case when src.daysperweekbitwise_mon_pm = 1 then 'Y' else 'N' end,
			tue_am_flag = case when src.daysperweekbitwise_tue_am = 1 then 'Y' else 'N' end,
			tue_pm_flag = case when src.daysperweekbitwise_tue_pm = 1 then 'Y' else 'N' end,
			wed_am_flag = case when src.daysperweekbitwise_wed_am = 1 then 'Y' else 'N' end,
			wed_pm_flag = case when src.daysperweekbitwise_wed_pm = 1 then 'Y' else 'N' end,
			thu_am_flag = case when src.daysperweekbitwise_thu_am = 1 then 'Y' else 'N' end,
			thu_pm_flag = case when src.daysperweekbitwise_thu_pm = 1 then 'Y' else 'N' end,
			fri_am_flag = case when src.daysperweekbitwise_fri_am = 1 then 'Y' else 'N' end,
			fri_pm_flag = case when src.daysperweekbitwise_fri_pm = 1 then 'Y' else 'N' end,
			sat_am_flag = case when src.daysperweekbitwise_sat_am = 1 then 'Y' else 'N' end,
			sat_pm_flag = case when src.daysperweekbitwise_sat_pm = 1 then 'Y' else 'N' end,
			sun_am_flag = case when src.daysperweekbitwise_sun_am = 1 then 'Y' else 'N' end,
			sun_pm_flag = case when src.daysperweekbitwise_sun_pm = 1 then 'Y' else 'N' end,
			update_date = getdate()
		from dbo.volunteer_dept tgt
		inner join dbo.volunteer v
			on tgt.volunteer_key = v.volunteer_key
			and tgt.active_flag = 'Y'
		inner join stg.stg_bethel_member_availability src
			on v.hub_person_id = src.personid
			and tgt.hub_dept_id = src.department_id
		where tgt.mon_am_flag <> case when src.daysperweekbitwise_mon_am = 1 then 'Y' else 'N' end
			or tgt.mon_pm_flag <> case when src.daysperweekbitwise_mon_pm = 1 then 'Y' else 'N' end
			or tgt.tue_am_flag <> case when src.daysperweekbitwise_tue_am = 1 then 'Y' else 'N' end
			or tgt.tue_pm_flag <> case when src.daysperweekbitwise_tue_pm = 1 then 'Y' else 'N' end
			or tgt.wed_am_flag <> case when src.daysperweekbitwise_wed_am = 1 then 'Y' else 'N' end
			or tgt.wed_pm_flag <> case when src.daysperweekbitwise_wed_pm = 1 then 'Y' else 'N' end
			or tgt.thu_am_flag <> case when src.daysperweekbitwise_thu_am = 1 then 'Y' else 'N' end
			or tgt.thu_pm_flag <> case when src.daysperweekbitwise_thu_pm = 1 then 'Y' else 'N' end
			or tgt.fri_am_flag <> case when src.daysperweekbitwise_fri_am = 1 then 'Y' else 'N' end
			or tgt.fri_pm_flag <> case when src.daysperweekbitwise_fri_pm = 1 then 'Y' else 'N' end
			or tgt.sat_am_flag <> case when src.daysperweekbitwise_sat_am = 1 then 'Y' else 'N' end
			or tgt.sat_pm_flag <> case when src.daysperweekbitwise_sat_pm = 1 then 'Y' else 'N' end
			or tgt.sun_am_flag <> case when src.daysperweekbitwise_sun_am = 1 then 'Y' else 'N' end
			or tgt.sun_pm_flag <> case when src.daysperweekbitwise_sun_pm = 1 then 'Y' else 'N' end


		set @Upd = @Upd + @@rowcount
		
		update dbo.volunteer_dept
		set 
			mon_am_flag = 'Y',
			mon_pm_flag = 'Y',
			tue_am_flag = 'Y',
			tue_pm_flag = 'Y',
			wed_am_flag = 'Y',
			wed_pm_flag = 'Y',
			thu_am_flag = 'Y',
			thu_pm_flag = 'Y',
			fri_am_flag = 'Y',
			fri_pm_flag = 'Y',
			update_date = getdate()
		where active_flag = 'Y'
			and enrollment_code in ( 'BBF', 'BBL', 'BBR', 'BBT', 'BCF', 'BCL', 'BCS', 'BRS' )

		set @Upd = @Upd + @@rowcount
		
		-- DELETE ORPHANED RECORDS FROM HUB HARD DELETES
		delete dbo.Volunteer_Dept
		where 1=1
			and active_flag = 'Y'
			and hub_dept_id is null
			
		set @Del = @Del + @@rowcount			

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**					   VOLUNTEER DEPT RPT
***********************************************************/
if object_id('dbo.ETL_Volunteer_Dept_Rpt_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Dept_Rpt_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Dept_Rpt_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Dept_Rpt', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- DELETE
	 	delete from dbo.volunteer_dept_rpt
		
		set @Del = @@rowcount	

		-- INSERT
		insert into dbo.volunteer_dept_rpt( 
			 volunteer_key
			,full_name
			,hub_dept_id
			,parent_dept_name
			,dept_name
			,temp_flag
			,primary_flag
			,split_allocation_pct
			,start_date
			,end_date
			,hpr_flag
			,mon_flag
			,tue_flag
			,wed_flag
			,thu_flag
			,fri_flag
			,sat_flag
			,sun_flag
			,row_num )
		select 
			 volunteer_key
			,full_name
			,hub_dept_id
			,parent_dept_name
			,dept_name
			,temp_flag
			,primary_flag
			,split_allocation_pct
			,start_date
			,end_date
			,case when hpr_volunteer_exception_flag = 'Y' then 'Y' else hpr_flag end as hpr_flag
			,mon_flag
			,tue_flag
			,wed_flag
			,thu_flag
			,fri_flag
			,sat_flag
			,sun_flag			
			,row_num
		from 
			( -- TEMP ASSIGNMENTS
			  select 
			  	 volunteer_key
				,full_name
				,hub_dept_id
				,parent_dept_name
				,dept_name
				,temp_flag
				,primary_flag
				,split_allocation_pct
				,start_date
				,end_date
				,hpr_flag
				,mon_flag
				,tue_flag
				,wed_flag
				,thu_flag
				,fri_flag
				,sat_flag
				,sun_flag			
				,hpr_volunteer_exception_flag
				,row_num
			  from 
				( select 
					 vd.volunteer_key
					,v.full_name
					,vd.hub_dept_id
					,vd.parent_dept_name
					,vd.dept_name
					,vd.temp_flag
					,vd.primary_flag
					,vd.split_allocation_pct
					,vd.start_date
					,vd.end_date
					,case when d.hub_dept_id is not null and d.level_01 = 'Headquarters Project Ramapo' then 'Y' else 'N' end as hpr_flag
					,case when ( vd.Mon_AM_Flag = 'Y' or vd.Mon_PM_Flag = 'Y' ) then 'Y' else 'N' end as mon_flag
					,case when ( vd.tue_AM_Flag = 'Y' or vd.tue_PM_Flag = 'Y' ) then 'Y' else 'N' end as tue_flag
					,case when ( vd.wed_AM_Flag = 'Y' or vd.wed_PM_Flag = 'Y' ) then 'Y' else 'N' end as wed_flag
					,case when ( vd.thu_AM_Flag = 'Y' or vd.thu_PM_Flag = 'Y' ) then 'Y' else 'N' end as thu_flag
					,case when ( vd.fri_AM_Flag = 'Y' or vd.fri_PM_Flag = 'Y' ) then 'Y' else 'N' end as fri_flag
					,case when ( vd.sat_AM_Flag = 'Y' or vd.sat_PM_Flag = 'Y' ) then 'Y' else 'N' end as sat_flag
					,case when ( vd.sun_AM_Flag = 'Y' or vd.sun_PM_Flag = 'Y' ) then 'Y' else 'N' end as sun_flag
					,v.hpr_volunteer_exception_flag
					,0 as row_num
					,row_number() over( partition by v.volunteer_key order by vd.start_date ) as row_seq
				  from dbo.Volunteer_Dept vd
				  inner join dbo.volunteer v
					on vd.volunteer_key = v.volunteer_key
				  left join dbo.HPR_Dept d
					on vd.hub_dept_id = d.hub_dept_id
					and d.Active_Flag = 'Y' 
					and d.cpc_code in ( 'CO', 'DD', 'PCC', 'CI', 'PS', 'VD' )
				  where 1=1
					and ( vd.active_flag = 'Y' or vd.start_date > cast( getdate() as date ) )
					--and vd.volunteer_dept_key not in ( 71744681, 76839101 ) -- JUSTIN POTTER RDC  KEVIN KUZMINSKI PCC					
					and vd.temp_flag = 'Y' ) x
			  where row_seq = 1					

			  union all

			  -- PRIMARY ASSIGNMENTS MOST RECENT START DATE
			  select *
			  from 
				( select 
					 vd.volunteer_key
					,v.full_name
					,vd.hub_dept_id
					,vd.parent_dept_name
					,vd.dept_name
					,vd.temp_flag
					,vd.primary_flag
					,vd.split_allocation_pct
					,vd.start_date
					,vd.end_date
					,case when d.hub_dept_id is not null and d.level_01 = 'Headquarters Project Ramapo' then 'Y' else 'N' end as hpr_flag
					,case when ( vd.Mon_AM_Flag = 'Y' or vd.Mon_PM_Flag = 'Y' ) then 'Y' else 'N' end as mon_flag
					,case when ( vd.tue_AM_Flag = 'Y' or vd.tue_PM_Flag = 'Y' ) then 'Y' else 'N' end as tue_flag
					,case when ( vd.wed_AM_Flag = 'Y' or vd.wed_PM_Flag = 'Y' ) then 'Y' else 'N' end as wed_flag
					,case when ( vd.thu_AM_Flag = 'Y' or vd.thu_PM_Flag = 'Y' ) then 'Y' else 'N' end as thu_flag
					,case when ( vd.fri_AM_Flag = 'Y' or vd.fri_PM_Flag = 'Y' ) then 'Y' else 'N' end as fri_flag
					,case when ( vd.sat_AM_Flag = 'Y' or vd.sat_PM_Flag = 'Y' ) then 'Y' else 'N' end as sat_flag
					,case when ( vd.sun_AM_Flag = 'Y' or vd.sun_PM_Flag = 'Y' ) then 'Y' else 'N' end as sun_flag
					,v.hpr_volunteer_exception_flag
					,row_number() over( partition by vd.volunteer_key order by vd.start_date desc ) as row_num
				  from dbo.Volunteer_Dept vd
				  inner join dbo.volunteer v
					on vd.volunteer_key = v.volunteer_key
				  left join dbo.HPR_Dept d
					on vd.hub_dept_id = d.hub_dept_id
					and d.Active_Flag = 'Y'
					and d.cpc_code in ( 'CO', 'DD', 'PCC', 'CI', 'PS', 'VD' )					
				  where 1=1
					and ( vd.active_flag = 'Y' or vd.start_date > cast( getdate() as date ) )
					and vd.primary_flag = 'Y'
					and vd.temp_flag = 'N' ) x
			  where row_num = 1

			  union all

			  -- PRIMARY ASSIGNMENTS OLDEST START DATE
			  select *
			  from 
				( select 
					 vd.volunteer_key
					,v.full_name
					,vd.hub_dept_id
					,vd.parent_dept_name
					,vd.dept_name
					,vd.temp_flag
					,vd.primary_flag
					,vd.split_allocation_pct
					,vd.start_date
					,vd.end_date
					,case when d.hub_dept_id is not null and d.level_01 = 'Headquarters Project Ramapo' then 'Y' else 'N' end as hpr_flag
					,case when ( vd.Mon_AM_Flag = 'Y' or vd.Mon_PM_Flag = 'Y' ) then 'Y' else 'N' end as mon_flag
					,case when ( vd.tue_AM_Flag = 'Y' or vd.tue_PM_Flag = 'Y' ) then 'Y' else 'N' end as tue_flag
					,case when ( vd.wed_AM_Flag = 'Y' or vd.wed_PM_Flag = 'Y' ) then 'Y' else 'N' end as wed_flag
					,case when ( vd.thu_AM_Flag = 'Y' or vd.thu_PM_Flag = 'Y' ) then 'Y' else 'N' end as thu_flag
					,case when ( vd.fri_AM_Flag = 'Y' or vd.fri_PM_Flag = 'Y' ) then 'Y' else 'N' end as fri_flag
					,case when ( vd.sat_AM_Flag = 'Y' or vd.sat_PM_Flag = 'Y' ) then 'Y' else 'N' end as sat_flag
					,case when ( vd.sun_AM_Flag = 'Y' or vd.sun_PM_Flag = 'Y' ) then 'Y' else 'N' end as sun_flag
					,v.hpr_volunteer_exception_flag
					,row_number() over( partition by vd.volunteer_key order by vd.start_date desc ) as row_num
				  from dbo.Volunteer_Dept vd
				  inner join dbo.volunteer v
					on vd.volunteer_key = v.volunteer_key
				  left join dbo.HPR_Dept d
					on vd.hub_dept_id = d.hub_dept_id
					and d.Active_Flag = 'Y'
					and d.cpc_code in ( 'CO', 'DD', 'PCC', 'CI', 'PS', 'VD' )					
				  where 1=1
					and ( vd.active_flag = 'Y' or vd.start_date > cast( getdate() as date ) )
					and vd.primary_flag = 'Y'
					and vd.temp_flag = 'N' ) x
			  where row_num = 2

			  --union all

			  ---- NON-US BRANCH VOLUNTEERS
			  --select 
			--	 fb.volunteer_number * -1 as volunteer_key  -- ARTIFICIAL VOL KEY
			--	,fb.last_name + ', ' + fb.first_name as full_name
			--	,fb.hub_dept_id
			--	,d.dept_name as parent_dept_name
			--	,d.work_group_name as dept_name
			--	,'N' as temp_flag
			--	,'Y' as primary_flag
			--	,fb.department_start_date as start_date
			--	,null as end_date
			--	,'Y' as hpr_flag
			--	,'N' as mon_flag
			--	,'N' as tue_flag
			--	,'N' as wed_flag
			--	,'N' as thu_flag
			--	,'N' as fri_flag
			--	,'N' as sat_flag
			--	,'N' as sun_flag
			--	,'Y' as hpr_volunteer_exception_flag
			--	,0 as row_num
			  --from stg.stg_foreign_branches fb
			  --inner join dbo.HPR_Dept d
			--	on fb.hub_dept_id = d.hub_dept_id
			) vd

		set @Ins = @@rowcount;
		
		-- INSERT NON-PRIMARY HPR ASSIGNMENTS WHERE VOLUNTEERS DONT ALREADY HAVE A HPR ASSIGNMENT
		with tmp as (
			select 
				 vd.volunteer_key
				,v.full_name
				,vd.hub_dept_id
				,vd.parent_dept_name
				,vd.dept_name
				,vd.temp_flag
				,vd.primary_flag
				,vd.split_allocation_pct
				,vd.start_date
				,vd.end_date
				,'Y' as hpr_flag
				,case when ( vd.Mon_AM_Flag = 'Y' or vd.Mon_PM_Flag = 'Y' ) then 'Y' else 'N' end as mon_flag
				,case when ( vd.tue_AM_Flag = 'Y' or vd.tue_PM_Flag = 'Y' ) then 'Y' else 'N' end as tue_flag
				,case when ( vd.wed_AM_Flag = 'Y' or vd.wed_PM_Flag = 'Y' ) then 'Y' else 'N' end as wed_flag
				,case when ( vd.thu_AM_Flag = 'Y' or vd.thu_PM_Flag = 'Y' ) then 'Y' else 'N' end as thu_flag
				,case when ( vd.fri_AM_Flag = 'Y' or vd.fri_PM_Flag = 'Y' ) then 'Y' else 'N' end as fri_flag
				,case when ( vd.sat_AM_Flag = 'Y' or vd.sat_PM_Flag = 'Y' ) then 'Y' else 'N' end as sat_flag
				,case when ( vd.sun_AM_Flag = 'Y' or vd.sun_PM_Flag = 'Y' ) then 'Y' else 'N' end as sun_flag
				,2 as row_num
				,vd.volunteer_dept_key				
			from dbo.Volunteer_Dept vd
			inner join dbo.volunteer v
				on vd.volunteer_key = v.volunteer_key
			inner join dbo.HPR_Dept d
				on vd.hub_dept_id = d.hub_dept_id
				and d.Active_Flag = 'Y'
				and d.cpc_code in ( 'CO', 'DD', 'PCC', 'CI', 'PS', 'VD' )	
				and d.level_01 = 'Headquarters Project Ramapo'
			where 1=1
				and v.volunteer_key not in ( select volunteer_key from dbo.volunteer_dept_rpt where hpr_flag = 'Y' group by volunteer_key )
				and ( vd.active_flag = 'Y' or vd.start_date > cast( getdate() as date ) )
				and vd.primary_flag = 'N'
				and vd.temp_flag = 'N' )
			
		insert into dbo.volunteer_dept_rpt( 
			 volunteer_key
			,full_name
			,hub_dept_id
			,parent_dept_name
			,dept_name
			,temp_flag
			,primary_flag
			,split_allocation_pct
			,start_date
			,end_date
			,hpr_flag
			,mon_flag
			,tue_flag
			,wed_flag
			,thu_flag
			,fri_flag
			,sat_flag
			,sun_flag			
			,row_num )
		select 
			 tmp.volunteer_key
			,full_name
			,hub_dept_id
			,parent_dept_name
			,dept_name
			,temp_flag
			,primary_flag
			,split_allocation_pct
			,start_date
			,end_date
			,hpr_flag
			,mon_flag
			,tue_flag
			,wed_flag
			,thu_flag
			,fri_flag
			,sat_flag
			,sun_flag
			,row_num		
		from tmp
		inner join ( select volunteer_key, max( volunteer_dept_key ) as max_key from tmp group by volunteer_key ) x
			on tmp.volunteer_key = x.volunteer_key
			and tmp.volunteer_dept_key = x.max_key	 

		set @Ins = @Ins + @@rowcount;
		
		-- INSERT NON-PRIMARY ASSIGNMENTS WHERE VOLUNTEERS DONT ALREADY HAVE 2 ASSIGNMENTS
		with tmp as (
			select 
				 vd.volunteer_key
				,v.full_name
				,vd.hub_dept_id
				,vd.parent_dept_name
				,vd.dept_name
				,vd.temp_flag
				,vd.primary_flag
				,vd.split_allocation_pct
				,vd.start_date
				,vd.end_date
				,case when d.hub_dept_id is not null then 'Y' else 'N' end as hpr_flag
				,case when ( vd.Mon_AM_Flag = 'Y' or vd.Mon_PM_Flag = 'Y' ) then 'Y' else 'N' end as mon_flag
				,case when ( vd.tue_AM_Flag = 'Y' or vd.tue_PM_Flag = 'Y' ) then 'Y' else 'N' end as tue_flag
				,case when ( vd.wed_AM_Flag = 'Y' or vd.wed_PM_Flag = 'Y' ) then 'Y' else 'N' end as wed_flag
				,case when ( vd.thu_AM_Flag = 'Y' or vd.thu_PM_Flag = 'Y' ) then 'Y' else 'N' end as thu_flag
				,case when ( vd.fri_AM_Flag = 'Y' or vd.fri_PM_Flag = 'Y' ) then 'Y' else 'N' end as fri_flag
				,case when ( vd.sat_AM_Flag = 'Y' or vd.sat_PM_Flag = 'Y' ) then 'Y' else 'N' end as sat_flag
				,case when ( vd.sun_AM_Flag = 'Y' or vd.sun_PM_Flag = 'Y' ) then 'Y' else 'N' end as sun_flag
				,2 as row_num
				,vd.volunteer_dept_key
		  	from dbo.Volunteer_Dept vd
		  	inner join dbo.volunteer v
				on vd.volunteer_key = v.volunteer_key
		  	left join dbo.HPR_Dept d
				on vd.hub_dept_id = d.hub_dept_id
				and d.Active_Flag = 'Y'
				and d.cpc_code in ( 'CO', 'DD', 'PCC', 'CI', 'PS', 'VD' )	
				and d.level_01 = 'Headquarters Project Ramapo'
			where 1=1
				and v.volunteer_key not in ( select volunteer_key from dbo.volunteer_dept_rpt group by volunteer_key having count(*) > 1 )
				and ( vd.active_flag = 'Y' or vd.start_date > cast( getdate() as date ) )
				and vd.primary_flag = 'N'
				and vd.temp_flag = 'N' )

		insert into dbo.volunteer_dept_rpt( 
			 volunteer_key
			,full_name
			,hub_dept_id
			,parent_dept_name
			,dept_name
			,temp_flag
			,primary_flag
			,split_allocation_pct
			,start_date
			,end_date
			,hpr_flag
			,mon_flag
			,tue_flag
			,wed_flag
			,thu_flag
			,fri_flag
			,sat_flag
			,sun_flag			
			,row_num )
		select 
			 tmp.volunteer_key
			,full_name
			,hub_dept_id
			,parent_dept_name
			,dept_name
			,temp_flag
			,primary_flag
			,split_allocation_pct
			,start_date
			,end_date
			,hpr_flag
			,mon_flag
			,tue_flag
			,wed_flag
			,thu_flag
			,fri_flag
			,sat_flag
			,sun_flag
			,row_num 
		from tmp
		inner join ( select volunteer_key, max( volunteer_dept_key ) as max_key from tmp group by volunteer_key ) x
			on tmp.volunteer_key = x.volunteer_key
			and tmp.volunteer_dept_key = x.max_key	
			and not exists ( select * from dbo.volunteer_dept_rpt d where tmp.volunteer_key = d.volunteer_key and d.row_num = 2 )
			
		set @Ins = @Ins + @@rowcount		
		
		-- DELETE MULTIPLE ROW_NUM 2 IF NOT HPR ASSIGNMENT
		delete from volunteer_dept_rpt
		where 1=1
			and row_num = 2
			and hpr_flag = 'N'
			and volunteer_key in ( select volunteer_key from dbo.volunteer_dept_rpt 
								   where row_num = 2 
								   group by volunteer_key 
								   having count(*) > 1 )

		set @Del = @@rowcount
		
		-- DELETE MULTIPLE ROW_NUM 2 CAUSING DUPS
		delete top(1) from volunteer_dept_rpt
		where 1=1
			and row_num = 2
			and volunteer_key in ( 247599 )
			and volunteer_key in ( select volunteer_key from dbo.volunteer_dept_rpt 
								   where row_num = 2 
								   group by volunteer_key 
								   having count(*) > 1 )

		set @Del = @@rowcount		

		-- DELETE MULTIPLE FUTURE ROW_NUM 0		
		delete vd
		from dbo.volunteer_dept_rpt vd
		where exists 
			( select * from 
				( select volunteer_key, min( start_date ) as min_start_date from dbo.volunteer_dept_rpt 
				  where row_num = 0 and start_date > cast( getdate() as date )
				  group by volunteer_key
				  having count(*) > 1 ) x 
			  where vd.volunteer_Key = x.volunteer_key and vd.start_date = x.min_start_date )
			  
		set @Del = @Del + @@rowcount;
		
		-- UPDATE ROW_NUM TO 1 IF NO 1 EXISTS
		with tmp as (
			select volunteer_key, min( row_num ) as min_row_num, count(*) as cnt
			from dbo.volunteer_dept_rpt
			group by volunteer_key
			having min( row_num ) = 2 )
		
		update dbo.volunteer_dept_rpt
		set row_num = 1
		from dbo.volunteer_dept_rpt d
		inner join tmp
			on d.volunteer_key = tmp.volunteer_key
			
		set @Upd = @Upd + @@rowcount;
		
		-- REMOVE TEMP UNASSIGNED ENTRIES
		with dept1 as (
			select volunteer_key, hub_dept_id as dept1, parent_dept_name as dept1_parent_dept_name, dept_name as dept1_dept_name, start_date as dept1_start_date, end_date as dept1_end_date, row_num
			from dbo.Volunteer_Dept_Rpt
			where hub_dept_id = 9966 ),

		src as (
			select d1.*, vd.HUB_Dept_ID as dept2, vd.Parent_Dept_Name as dept2_parent_dept_name, vd.Dept_Name as dept2_dept_name, vd.Temp_Flag as dept2_temp_flag, vd.start_date as dept2_start_date, vd.end_date as dept2_end_date
			from dbo.Volunteer_Dept_Rpt vd
			inner join dept1 d1
				on vd.volunteer_key = d1.volunteer_key
				and vd.row_num != d1.row_num
			where vd.End_Date is null or d1.dept1_end_date = dateadd(day,1,d1.dept1_start_date) )

		delete
		from dbo.volunteer_dept_rpt 
		where volunteer_key in ( select volunteer_key from src )
			and hub_dept_id = 9966

		set @Del = @Del + @@rowcount		

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go



/***********************************************************
**					   VOLUNTEER ENROLLMENT 
***********************************************************/
if object_id('dbo.ETL_Volunteer_Enrollment_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Enrollment_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Enrollment_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Enrollment', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- GET RECORDCOUNT AND MINIMUM DATE FROM HUB FEED FOR A PERSON
		-- COMPARE TO WHAT EXISTS IN RVD	
		if object_id('stg.tmp_vol_enrl', 'U') is not null
			drop table stg.tmp_vol_enrl;
		
		if object_id('stg.tmp_vol_enrl_rvd', 'U') is not null
			drop table stg.tmp_vol_enrl_rvd;
		
		with src as (
			select person_id, min(start_date) as min_dt, count(*) as cnt
			from stg.stg_person_enrollment
			--where person_id = 545801
			group by person_id ),

		rvd as (
			select ve.hub_Person_ID as person_id, count(*) as rvd_cnt, max( src.cnt ) as src_cnt, max( src.min_dt ) as src_dt
			from dbo.Volunteer_enrollment_v ve
			inner join src 
				on ve.hub_Person_ID = src.Person_ID
				and ve.Start_Date >= src.min_dt
			where 1=1
				and ( ve.end_date is null or ve.end_date > getdate() )
				and ve.enrollment_key not in ( 137, 138 )
				--and ve.hub_Person_ID = 545801
			group by ve.hub_Person_ID )

		select *
		into stg.tmp_vol_enrl
		from rvd
		where rvd_cnt != src_cnt 

		select ve.*
		into stg.tmp_vol_enrl_rvd
		from dbo.Volunteer_enrollment_v ve
		inner join stg.tmp_vol_enrl tmp 
			on ve.hub_Person_ID = tmp.person_id 
			and ( ve.end_date is null or ve.end_date > getdate() )
			and ve.enrollment_key not in ( 137, 138 )
			and ve.start_date >= tmp.src_dt 

		delete
		from dbo.volunteer_enrollment
			where volunteer_enrollment_key in ( select volunteer_enrollment_key from stg.tmp_vol_enrl_rvd )

		set @Del = @@rowcount	
	
		-- INSERT
		insert into dbo.volunteer_enrollment( 
			 volunteer_key
			,enrollment_Key
			,geo_name
			,site_code
			,notes
			,start_date
			,end_date
			,active_flag )		
		select 
			 v.volunteer_key
			,enrl.enrollment_key
			,max( e.geo_location ) as geo_name
			,max( e.site_code ) as site_code
			,max( e.notes ) as notes
			,e.start_date
			,max( e.end_date ) as end_date
			,max( case when getdate() between e.start_date and e.end_date then 'Y' else 'N' end ) as active_flag
		from stg.stg_person_enrollment e
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on e.person_id = v.hub_person_id
		inner join dbo.enrollment enrl
			on e.enrollment_code = enrl.enrollment_code		
			and enrl.active_flag = 'Y'
		where not exists 
			( select 1 from dbo.volunteer_enrollment ve 
			  where ve.volunteer_key = v.volunteer_key
				and ve.enrollment_key = enrl.enrollment_key
				and ve.start_date = e.start_date )
		group by v.volunteer_key, enrl.enrollment_key, e.start_date				

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.volunteer_enrollment
		set 
			geo_name = src.geo_location,
			site_code = src.site_code,
			notes = src.notes,
			end_date = src.end_date,
			update_date = getdate()
		from dbo.volunteer_enrollment tgt
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
		inner join dbo.enrollment enrl
			on tgt.enrollment_key = enrl.enrollment_key
			and enrl.active_flag = 'Y'
		inner join stg.stg_person_enrollment src
			on v.hub_person_id = src.person_id
			and enrl.enrollment_code = src.enrollment_code
			and tgt.start_date = src.start_date
-- PERF ISSUE.  DOING A FULL UPDATE AS TEMP WORKAROUND
		--where tgt.geo_name <> src.geo_location
		--	or tgt.site_code <> src.site_code
		--	or tgt.notes <> src.notes
		--	or tgt.end_date <> src.end_date

		set @Upd = @@rowcount
		
		-- DELETE MISSING ENROLLMENTS, WE DONT RECEIVE HARD DELETES
		delete from dbo.volunteer_enrollment
		where volunteer_enrollment_key in ( 
			select ve.volunteer_enrollment_key
			from dbo.volunteer v
			inner join dbo.volunteer_enrollment ve
				on v.volunteer_key = ve.volunteer_key
				and ve.active_flag = 'Y'
				and	ve.start_date <= getdate()
			inner join dbo.enrollment e
				on ve.enrollment_key = e.enrollment_key
				and e.Active_Flag = 'Y'
			left join stg.stg_person_enrollment stg
				on stg.person_id= v.hub_person_id
				and stg.start_date = ve.start_date
			where stg.person_id is null )
			and enrollment_key <> 137
		
		set @Del = @Del + @@rowcount		
		
		-- UPDATE CURRENT ENRL ON VOLUNTEER
		-- RESET ALL TO NULL
--		update dbo.volunteer
--		set current_enrollment_key = null
--		where current_enrollment_key is not null

		set @Upd = @Upd + @@rowcount
				
		update dbo.volunteer
		set 
			current_Enrollment_Key = src.enrollment_key,
			update_date = getdate()
		from dbo.volunteer tgt
		left join 
			( select ve.Volunteer_Key, e.enrollment_key
			  from Volunteer_Enrollment ve
			  inner join enrollment e
				on ve.Enrollment_Key = e.Enrollment_Key
				and e.active_flag = 'Y'
			  where getdate() between ve.start_date and coalesce( ve.end_Date,'12/31/9999' )
				and exists ( select 1 from 
								( select ve.Volunteer_Key, min( e.rank_num ) as min_rank_num
								  from Volunteer_Enrollment ve
								  inner join enrollment e
									on ve.Enrollment_Key = e.Enrollment_Key
								  where getdate() between ve.start_date and coalesce( ve.end_Date,'12/31/9999' )
								  group by ve.volunteer_Key ) x 
							 where x.volunteer_Key = ve.Volunteer_Key and e.Rank_Num = x.min_rank_num )  ) src
			on tgt.volunteer_key = src.volunteer_key
		where coalesce( tgt.current_enrollment_key, 0 ) <> coalesce( src.enrollment_key, 0 )		

		set @Upd = @Upd + @@rowcount
		
		-- UPDATE INVITATION NOTES
		update dbo.volunteer_enrollment
		set 
			notes = src.notes,
			applicant_id = src.applicant_id,
			update_date = getdate()
		from dbo.volunteer_enrollment tgt
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
		inner join dbo.enrollment enrl
			on tgt.enrollment_key = enrl.enrollment_key
			and enrl.active_flag = 'Y'
		inner join stg.stg_app_invitation_history src
			on v.hub_person_id = src.person_id
			and enrl.enrollment_code = src.enrollment
			and tgt.site_code = src.site_code
			and tgt.start_date = src.invited_from
			and src.invitation_sent = 1
			and nullif( src.notes, '' ) is not null
		where coalesce( tgt.notes, '' ) <> src.notes	
			or coalesce( tgt.applicant_id, 0 ) <> coalesce( src.applicant_id, 0 )

		set @Upd = @Upd + @@rowcount
		

		-- ADD IN 5 DAY BA EVENTS
		insert into dbo.volunteer_enrollment(
		 	 volunteer_key
			,enrollment_key
			,notes
			,start_date
			,end_date )
		select 
			 v.volunteer_key
			,137 as enrollment_key
			,max( 'PROJECT: ' + coalesce( p.project_type,'' ) +
				' (' + coalesce( p.project_number, '' ) + ')' + 
				' DESC: ' + coalesce( p.project_desc, '' ) + 
				' EVENT: ' + coalesce( event_Name, '' ) + 
				' (' + coalesce( cast( event_id as varchar ), '' ) + ')' ) as notes
			,max( start_dt ) as start_date
			,max( end_dt ) as end_date
		from dbo.BA_Project_Volunteer_Attendance va
		inner join dbo.ba_project p
			on va.project_id = p.project_id
		inner join (
			select volunteer_id, check_in_date as start_dt, dateadd( day, 4, check_in_date ) as end_dt
			from dbo.BA_Project_Volunteer_Attendance 
			where ( datename( weekday, check_in_date ) = 'Monday' or datename( weekday, check_in_date ) = 'Tuesday' ) ) dt
			on va.Volunteer_ID = dt.volunteer_id
			and va.Check_In_Date between dt.start_dt and dt.end_dt
		inner join dbo.volunteer v
			on va.Person_GUID = v.HUB_Person_GUID
		where not exists 
			( select 1 from dbo.volunteer_enrollment ve 
			  where ve.volunteer_key = v.volunteer_key
				and ve.enrollment_key = 137
				and ve.start_date = dt.start_dt )			
		group by v.volunteer_key 
		having count(*) = 5

		set @Ins = @Ins + @@rowcount
		
		-- ADD IN HPR BA EVENTS
		insert into dbo.volunteer_enrollment(
		 	 volunteer_key
			,enrollment_key
			,notes
			,start_date
			,end_date )	
		select
			 volunteer_key
			,enrollment_key
			,notes
			,start_date
			,end_date
		from
			( select 
				 v.volunteer_key
				,138 as enrollment_key
				,' EVENT: ' + coalesce( event_Name, '' ) + ' (' + coalesce( cast( event_id as varchar ), '' ) + ')' + 
					' STATUS: ' + concat( status_day_1, '|', status_day_2, '|', status_day_3, '|', status_day_4, '|', status_day_5, '|', status_day_6, '|', status_day_7 ) as notes
				,start_date
				,dateadd( day, 6, start_date ) as end_date
				,rank() over( partition by v.volunteer_key order by vi.update_date desc ) as ranking
			from dbo.BA_Event_Volunteer_Invite vi
			inner join dbo.volunteer v
				on vi.Person_GUID = v.HUB_Person_GUID
			where 1=1
				and (  event_name like 'HPR%'  -- HPR EVENTS
					or event_name like 'Tuxedo %'
					or event_name like 'Ramapo %' )
				and (  status_day_1 = 'C'
					or status_day_2 = 'C'
					or status_day_3 = 'C'
					or status_day_4 = 'C'
					or status_day_5 = 'C'
					or status_day_6 = 'C'
					or status_day_7 = 'C' )
				and not exists 
					( select 1 from dbo.volunteer_enrollment ve 
					  where ve.volunteer_key = v.volunteer_key
						and ve.enrollment_key = 138
						and ve.start_date = vi.start_date )	) x
		where ranking = 1
			
		set @Ins = @Ins + @@rowcount
		
		-- UPDATE - FLAG OFF
		update dbo.volunteer_enrollment
		set 
			active_flag = 'N',
			update_date = getdate()
		where active_flag = 'Y'
			and (  getdate() > end_date 
				or start_date > getdate() )

		set @Upd = @Upd + @@rowcount
		
		-- UPDATE - FLAG ON
		update dbo.volunteer_enrollment
		set 
			active_flag = 'Y',
			update_date = getdate()
		where active_flag = 'N'
			and coalesce( end_date, getdate() +1 ) >= cast( getdate() as date )
			and start_date <= cast( getdate() as date )

		set @Upd = @Upd + @@rowcount
		
		-- UPDATE - BAD DATA FIX
		update dbo.volunteer_enrollment
		set 
			active_flag = 'N',
			end_date = '2016-05-31',
			update_date = getdate()
		where volunteer_enrollment_key in (
			8369689 )

		set @Upd = @Upd + @@rowcount				
		
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**					   VOLUNTEER ENROLLMENT RPT
***********************************************************/
if object_id('dbo.ETL_Volunteer_Enrollment_Rpt_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Enrollment_Rpt_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Enrollment_Rpt_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Enrollment_Rpt', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- DELETE
	 	delete from dbo.volunteer_enrollment_rpt
		
		set @Del = @@rowcount	

		-- INSERT
		insert into dbo.volunteer_enrollment_rpt( 
			 volunteer_key
			,full_name
			,enrollment_key
			,enrollment_code
			,enrollment_site_code
			,start_date
			,end_date
			,row_num )
		select 
			 volunteer_key
			,full_name
			,enrollment_key
			,enrollment_code
			,enrollment_site_code
			,start_date
			,end_date
			,row_num
		from 
			( -- MOST RECENT START DATE NOT IN FUTURE  NEW LOGIC = OLDEST ACTIVE START DATE
			  select *
			  from 
				( select 
					 ve.volunteer_key
					,v.full_name
					,ve.enrollment_key
					,e.enrollment_code
					,ve.Site_Code as enrollment_site_code
					,ve.start_date
					,ve.end_date
					,row_number() over( partition by ve.volunteer_key order by ve.start_date ) as row_num
				  from dbo.volunteer_enrollment ve
				  inner join dbo.enrollment e
					on ve.Enrollment_Key = e.Enrollment_Key
					and ( e.Bethel_Flag = 'Y'
						or e.enrollment_code in ( 'BCC', 'BCF', 'BCL', 'BCS', 'BCV', 'BOC', 'BBO' ) )
				  inner join dbo.volunteer v
					on ve.volunteer_key = v.volunteer_key
				  where 1=1
					and ve.active_flag = 'Y'
					/*and ve.Geo_Name = 'USA'*/ ) x
			  where row_num = 1

			  union all

			  -- FUTURE ENROLLMENTS
			  select 
			  	 volunteer_key
				,full_name
				,enrollment_key
				,enrollment_code
				,enrollment_site_code
				,start_date
				,end_date
				,row_num
			  from 
				( select 
					 ve.volunteer_key
					,v.full_name
					,ve.enrollment_key
					,e.enrollment_code
					,ve.Site_Code as enrollment_site_code
					,ve.start_date
					,ve.end_date
					,2 as row_num
					,row_number() over( partition by ve.volunteer_key order by ve.start_date ) as row_seq
				  from dbo.volunteer_enrollment ve
				  inner join dbo.enrollment e
					on ve.Enrollment_Key = e.Enrollment_Key
					and ( e.Bethel_Flag = 'Y'
						or e.enrollment_code in ( 'BCC', 'BCF', 'BCL', 'BCS', 'BCV', 'BOC', 'BBO' ) )
				  inner join dbo.volunteer v
					on ve.volunteer_key = v.volunteer_key
				  where 1=1
					and ve.start_Date > getdate()
					/*and ve.Geo_Name = 'USA'*/ ) x
			  where row_seq = 1
			  
			  union all

			  -- OTHER CURRENT ENROLLMENTS
			  select *
			  from 
				( select 
					 ve.volunteer_key
					,v.full_name
					,ve.enrollment_key
					,e.enrollment_code
					,ve.Site_Code as enrollment_site_code
					,ve.start_date
					,ve.end_date
					,row_number() over( partition by ve.volunteer_key order by ve.start_date ) as row_num
				  from dbo.volunteer_enrollment ve
				  inner join dbo.enrollment e
					on ve.Enrollment_Key = e.Enrollment_Key
					and ( e.Bethel_Flag = 'Y'
						or e.enrollment_code in ( 'BCC', 'BCF', 'BCL', 'BCS', 'BCV', 'BOC', 'BBO' ) )
				  inner join dbo.volunteer v
					on ve.volunteer_key = v.volunteer_key
				  where 1=1
					and ve.active_flag = 'Y'
					/*and ve.Geo_Name = 'USA'*/ ) x
			  where row_num <> 1

			  --union all

			  ---- NON-US BRANCH VOLUNTEERS
			  --select 
				-- fb.volunteer_number * -1 as volunteer_key  -- ARTIFICIAL VOL KEY
				--,fb.last_name + ', ' + fb.first_name as full_name
				--,e.enrollment_key
				--,fb.enrollment_code
				--,'RMP' as enrollment_site_code
				--,fb.enrollment_start_date
				--,fb.enrollment_end_date
				--,0 as row_num
			  --from stg.stg_foreign_branches fb
			  --inner join dbo.enrollment e
				--on fb.enrollment_code = e.enrollment_code
				--and e.active_flag = 'Y'
			) ve

		set @Ins = @@rowcount
		
		-- UPDATE IF MISSING ROW_NUM = 1
		update dbo.volunteer_enrollment_rpt
		set row_num = 1
		where 1=1
			and volunteer_key in ( select volunteer_key from dbo.volunteer_enrollment_rpt v
								   where not exists ( select 1 from dbo.volunteer_enrollment_rpt v2 where v.volunteer_key = v2.volunteer_key and v2.row_num = 1 ) )

		set @Upd = @@rowcount;
		
		-- DELETE MULTIPLE ROW_NUM = 2		
		with dups as (
			select ve.volunteer_key, ve.enrollment_code, ve.start_date, max(e.rank_num) as rank_num
			from ( select volunteer_key from dbo.volunteer_enrollment_rpt where row_num = 2 group by volunteer_key having count(*) > 1 ) dup
			inner join dbo.volunteer_enrollment_rpt ve
				on dup.volunteer_key = ve.volunteer_key
				and ve.row_num = 2
			inner join dbo.enrollment e
				on ve.enrollment_code = e.enrollment_code
			group by ve.volunteer_key, ve.enrollment_code, ve.start_date ),
		
		max_rank as (
			select volunteer_key, max( rank_num ) as max_rank_num
			from dups
			group by volunteer_key ),
		
		del as (
			select d.volunteer_key, d.enrollment_code, d.start_date
			from dups d
			inner join max_rank m
				on d.volunteer_key = m.volunteer_Key
				and d.rank_num = m.max_rank_num )
		
		delete ve
		from dbo.volunteer_enrollment_rpt ve
		where row_num = 2
			and exists ( select * from del where ve.volunteer_key = del.volunteer_key and ve.enrollment_code = del.enrollment_code and ve.start_date = del.start_date )
			
		set @Del = @Del + @@rowcount				

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go



/***********************************************************
**				   VOLUNTEER FTS
***********************************************************/
if object_id('dbo.ETL_Volunteer_FTS_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_FTS_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_FTS_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_FTS', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- DELETE
	 	delete from dbo.volunteer_fts
		
		set @Del = @@rowcount	

		-- INSERT
		insert into dbo.volunteer_fts( 
			 volunteer_key
			,fts
			,sfts
			,rounded_fts
			,rounded_sfts )
		select 
			 volunteer_key
			,fts
			,sfts
			,rounded_fts
			,rounded_sfts
		from dbo.volunteer_fts_v

		set @Ins = @@rowcount
		
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go



/***********************************************************
**					   VOLUNTEER ROLE 
***********************************************************/
if object_id('dbo.ETL_Volunteer_Role_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Role_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Role_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Role', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- INSERT
		insert into dbo.volunteer_role( 
			 volunteer_key
			,role
			,role_data
			,start_date
			,end_date
			,active_flag )		
		select  
			 v.volunteer_key
			,r.role
			,max( pr.role_data ) as role_data
			,pr.start_date
			,max( pr.end_date ) as end_date
			,max( case when getdate() between pr.start_date and coalesce( pr.end_date, '2999-12-31' ) then 'Y' else 'N' end ) as active_flag
		from stg.stg_person_role pr
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on pr.person_id = v.hub_person_id
		inner join stg.stg_role r
			on pr.role_code = r.role_code				
		where not exists 
			( select 1 from dbo.volunteer_role vr 
			  where vr.volunteer_key = v.volunteer_key
				and vr.role = r.role
				and vr.start_date = pr.start_date )	
		group by v.volunteer_key, r.role, pr.start_date			

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.volunteer_role
		set 
			role_data = src.role_data,
			end_date = src.end_date,
			update_date = getdate()
		from dbo.volunteer_role tgt
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
		inner join stg.stg_role r
			on tgt.role = r.role
		inner join ( select person_id, role_code, start_date, max( role_data ) as role_data, max( end_date ) as end_date
					 from stg.stg_person_role
					 group by person_id, role_code, start_date ) src
			on v.hub_person_id = src.person_id
			and r.role_code = src.role_code
			and tgt.start_date = src.start_date
		where coalesce( tgt.role_data, '' ) <> coalesce( src.role_data, '' )
			or coalesce( tgt.end_date, '2999-12-31' ) <> coalesce( src.end_date, '2999-12-31' )

		set @Upd = @@rowcount

		-- UPDATE - FLAG OFF
		update dbo.volunteer_role
		set 
			active_flag = 'N',
			update_date = getdate()
		where active_flag = 'Y'
			and getdate() > coalesce( end_date, '2999-12-31' )

		set @Upd = @Upd + @@rowcount
		
		-- UPDATE - FLAG ON
		update dbo.volunteer_role
		set 
			active_flag = 'Y',
			update_date = getdate()
		where active_flag = 'N'
			and coalesce( end_date, getdate() + 1 ) >= cast( getdate() as date )

		set @Upd = @Upd + @@rowcount	
		
		-- UPDATE - HARD DELETE IN HUB
		update dbo.volunteer_role
		set 
			end_date = '1/1/1900',
			active_flag = 'N',
			update_date = getdate()
		from dbo.volunteer_role vr
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
				from dbo.volunteer
				group by volunteer_key ) v
			on vr.volunteer_key = v.volunteer_key
		inner join stg.stg_role r
			on vr.Role = r.role
		where 1=1
			and not exists 
					( select 1 from stg.stg_person_role pr
					  where pr.person_id = v.hub_person_id
						and pr.role_code = r.role_code
				and pr.start_date = vr.start_date )
				
		set @Upd = @Upd + @@rowcount	

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**					   VOLUNTEER ROOMING 
***********************************************************/
if object_id('dbo.ETL_Volunteer_Rooming_Hist_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Rooming_Hist_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Rooming_Hist_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Rooming_Hist', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
		
	-- ONLY INSERT DATA IF MONDAY
	begin try	
		-- INSERT
		insert into dbo.volunteer_rooming_hist( 
			 volunteer_key
			,cal_dt
			,room_site_code
			,room_bldg
			,room_bldg_code
			,room_bldg_desc
			,room )		
		select
			 volunteer_key
			,cast( getdate() as date ) as cal_dt
			,room_site_code
			,room_bldg
			,room_bldg_code
			,room_bldg_desc
			,room
		from rpt.volunteer_all_v
		where datename( weekday, getdate() ) = 'Monday'

		set @Ins = @@rowcount

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			

	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**					   VOLUNTEER SEARCH 
***********************************************************/
if object_id('dbo.ETL_Volunteer_Search_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Search_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Search_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Search_Phone', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime

	begin try	
		-- DELETE
	 	delete from dbo.volunteer_search_phone
		
		set @Del = @@rowcount	
	
		-- INSERT
		insert into dbo.volunteer_search_phone( 
			 volunteer_key
			,phone_num )		
		select 
			 volunteer_key
			,phone_num
		from (
			select volunteer_key, dbo.remove_non_numeric_chars_fnc( preferred_phone ) as phone_num
			from dbo.volunteer
			union
			select volunteer_key, dbo.remove_non_numeric_chars_fnc( home_phone ) as phone_num
			from dbo.volunteer
			union
			select volunteer_key, dbo.remove_non_numeric_chars_fnc( mobile_phone ) as phone_num
			from dbo.volunteer ) x
		where phone_num is not null

		set @Ins = @@rowcount

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try			
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**					   VOLUNTEER SKILL 
***********************************************************/
if object_id('dbo.ETL_Volunteer_Skill_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Skill_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Skill_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Skill', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
	
	begin try
		-- INSERT
		insert into dbo.volunteer_skill( 
			 volunteer_key
			,skill_speciality_key
			,skill_level_key
			,source_system_key
			,skill_description
			,office_notes
			,yrs_exp
			,skill_update_date )		
		select 
			 v.volunteer_key
			,ss.skill_speciality_key
			,case when coalesce( bsl.skill_level_key, 1 ) = 1 then coalesce( psl.skill_level_key, 7 ) else coalesce( bsl.skill_level_key, 7 ) end as skill_level_key
			,case when coalesce( bsl.skill_level_key, 1 ) = 1 then 2 else 7 end as source_system_key
			,case when s.licensed = 1 then 'Licensed - ' else '' end +
				case when s.yrs_schooling is not null then 'Schooling: ' + cast( s.yrs_schooling as varchar(30) ) else '' end +
				case when s.licensed = 1 or s.yrs_schooling is not null then ' - ' else '' end +
				coalesce( s.skill_speciality_notes, '' ) + coalesce( s.office_notes, '' ) as skill_description
			,s.office_notes
			,s.yrs_exp
			,s.update_date
		from stg.stg_person_skill s
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on s.person_id = v.hub_person_id
		inner join dbo.skill_speciality ss
			on s.skill_subskill_id = ss.hub_skill_subskill_id
			and coalesce( s.skill_speciality_id, 0 ) = ss.hub_skill_speciality_id
			and ss.hub_flag = 'Y'
		left join dbo.skill_level bsl
			on s.skill_proficiency = bsl.skill_level_code -- BRANCH
		left join dbo.skill_level psl
			on coalesce( s.skill_proficiency_publisher, 0 ) = psl.skill_level_code -- PUBLISHER
		where not exists 
			( select 1 from dbo.volunteer_skill vs
			  where vs.volunteer_key = v.volunteer_key
				and vs.skill_speciality_key = ss.skill_speciality_key )

		set @Ins = @@rowcount

		-- UPDATE
		update dbo.volunteer_skill
		set 
			skill_level_key = case when coalesce( bsl.skill_level_key, 1 ) = 1 then coalesce( psl.skill_level_key, 7 ) else coalesce( bsl.skill_level_key, 7 ) end,
			source_system_key = case when coalesce( bsl.skill_level_key, 1 ) = 1 then 2 else 7 end, -- 2 = PUBLISHER, 7 = BRANCH
			yrs_exp = src.yrs_exp,
			skill_description = 
				case when src.licensed = 1 then 'Licensed - ' else '' end +
					case when src.yrs_schooling is not null then 'Schooling: ' + cast( src.yrs_schooling as varchar(30) ) else '' end +
					case when src.licensed = 1 or src.yrs_schooling is not null then ' - ' else '' end +
					coalesce( src.skill_speciality_notes, '' ) + coalesce( src.office_notes, '' ),
			office_notes = src.office_notes,
			skill_update_date = src.update_date,
			update_date = getdate()
		from dbo.volunteer_skill tgt
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
			--and tgt.source_system_key = 2
		inner join dbo.skill_speciality ss
			on tgt.skill_speciality_key = ss.skill_speciality_key
		inner join stg.stg_person_skill src
			on v.hub_person_id = src.person_id
			and ss.hub_skill_subskill_id = src.skill_subskill_id
			and ss.hub_skill_speciality_id = coalesce( src.skill_speciality_id, 0 )
			and ss.hub_flag = 'Y'
		left join dbo.skill_level bsl
			on src.skill_proficiency = bsl.skill_level_code -- BRANCH
		left join dbo.skill_level psl
			on coalesce( src.skill_proficiency_publisher, 0 ) = psl.skill_level_code -- PUBLISHER		
		where coalesce( tgt.skill_level_key, 0 ) <> case when coalesce( bsl.skill_level_key, 1 ) = 1 then coalesce( psl.skill_level_key, 7 ) else coalesce( bsl.skill_level_key, 7 ) end
			or coalesce( tgt.source_system_key, 0 ) <> case when coalesce( bsl.skill_level_key, 1 ) = 1 then 2 else 7 end		
			or coalesce( tgt.yrs_exp, 0 ) <> coalesce( src.yrs_exp, 0 )
			or coalesce( tgt.skill_description, '' ) <>
				case when src.licensed = 1 then 'Licensed - ' else '' end +
					case when src.yrs_schooling is not null then 'Schooling: ' + cast( src.yrs_schooling as varchar(30) ) else '' end +
					 case when src.licensed = 1 or src.yrs_schooling is not null then ' - ' else '' end +
				coalesce( src.skill_speciality_notes, '' ) + coalesce( src.office_notes, '' ) 
			or coalesce( tgt.office_notes, '' ) <> coalesce( src.office_notes, '' )
			or coalesce( tgt.skill_update_date, '2999-12-31' ) <> coalesce( src.update_date, '2999-12-31' )

		set @Upd = @@rowcount

		-- CREATE TEMP TABLE TO HOLD BA OVERSEER ASSESSMENT RECORDS FOR UPDATE FOR PERF
		if object_id( 'dbo.tmp_volunteer_skill', 'U' ) is not null
			drop table dbo.tmp_volunteer_skill

		-- NON-COMPUTER SKILLS			
		select 
			 tgt.volunteer_skill_key
			,case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end as skill_level_key
			,src.personal_notes
			,src.overseer_assessment_name as ovsr_assessment_name
			,case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end as ovsr_assessment_skill_level_key
			,src.overseer_assessment_notes as ovsr_assessment_notes
			,case when src.overseer_assessment_date = '0001-01-01' then null else src.overseer_assessment_date end as ovsr_assessment_date
		into dbo.tmp_volunteer_skill			
		from dbo.volunteer_skill tgt
		inner join 
			( select volunteer_key, max( hub_person_guid ) as hub_person_guid 
				from dbo.volunteer
				group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
		inner join dbo.skill_speciality ss
			on tgt.skill_speciality_key = ss.skill_speciality_key
		inner join dbo.skill s
			on ss.skill_key = s.skill_key
		inner join stg.stg_ba_volunteer_skill src
			on v.hub_person_guid = src.person_guid	
			and ss.ba_subskill_guid = src.subskill_guid 
			and ss.ba_skill_speciality_guid is null
		where tgt.skill_update_date >= getdate() - 30			

	/*			
		-- UPDATE - BA OVERSEER ASSESSMENT - NON-COMPUTER
		update dbo.volunteer_skill
		set 
			skill_level_key = case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end,
			personal_notes = src.personal_notes,
			ovsr_assessment_name = src.overseer_assessment_name,
			ovsr_assessment_skill_level_key =
				case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end,
			ovsr_assessment_notes = src.overseer_assessment_notes,
			ovsr_assessment_date = case when src.overseer_assessment_date = '0001-01-01' then null else src.overseer_assessment_date end,
			update_date = getdate()
		from dbo.volunteer_skill tgt
		inner join 
			( select volunteer_key, max( hub_person_guid ) as hub_person_guid 
				from dbo.volunteer
				group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
		inner join dbo.skill_speciality ss
			on tgt.skill_speciality_key = ss.skill_speciality_key
		inner join dbo.skill s
			on ss.skill_key = s.skill_key
		inner join stg.stg_ba_volunteer_skill src
			on v.hub_person_guid = src.person_guid	
			and ss.ba_subskill_guid = src.subskill_guid 
			and ss.ba_skill_speciality_guid is null
		where coalesce( tgt.skill_level_key, 0 ) <> case when coalesce( src.overseer_assessment, 0 ) = 0 then 7 else src.overseer_assessment end
			or coalesce( tgt.personal_notes, '' ) <> coalesce( src.personal_notes, '' )
			or coalesce( tgt.ovsr_assessment_name, '' ) <> coalesce( src.overseer_assessment_name, '' )
			or coalesce( tgt.ovsr_assessment_skill_level_key, 0 ) <> 
				case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end
			or coalesce( tgt.ovsr_assessment_notes, '' ) <> coalesce( src.overseer_assessment_notes, '' )
			or coalesce( tgt.ovsr_assessment_date, '2999-12-31' ) <> coalesce( src.overseer_assessment_date, '2999-12-31' )		
	*/			

		-- COMPUTER SKILLS			
		insert into dbo.tmp_volunteer_skill(
		 	 volunteer_skill_key
			,skill_level_key
			,personal_notes
			,ovsr_assessment_name
			,ovsr_assessment_skill_level_key
			,ovsr_assessment_notes
			,ovsr_assessment_date )
		select 
			 tgt.volunteer_skill_key
			,case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end as skill_level_key
			,src.personal_notes
			,src.overseer_assessment_name as ovsr_assessment_name
			,case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end as ovsr_assessment_skill_level_key
			,src.overseer_assessment_notes as ovsr_assessment_notes
			,case when src.overseer_assessment_date = '0001-01-01' then null else src.overseer_assessment_date end as ovsr_assessment_date		
		from dbo.volunteer_skill tgt
		inner join 
			( select volunteer_key, max( hub_person_guid ) as hub_person_guid 
				from dbo.volunteer
				group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
		inner join dbo.skill_speciality ss
			on tgt.skill_speciality_key = ss.skill_speciality_key
		inner join dbo.skill s
			on ss.skill_key = s.skill_key
		inner join stg.stg_ba_volunteer_skill src
			on v.hub_person_guid = src.person_guid	
			and ss.ba_skill_speciality_guid = src.subskill_guid
			and ss.ba_skill_speciality_guid is not null
		where tgt.skill_update_date >= getdate() - 30			
			
		--create nonclustered index stg_person_skill_idx_skill_subskill_id
		--	on stg.stg_person_skill (skill_subskill_id)
		--include (person_id, Skill_Speciality_ID, Licensed, Yrs_Exp, Yrs_Schooling, Skill_Speciality_Notes, Skill_Proficiency, Skill_Proficiency_Publisher, Office_Notes, Update_Date )

		--create index stg_ba_volunteer_skill_idx_guids
		--	on stg.stg_ba_volunteer_skill( person_guid, subskill_guid )
		--include ( personal_notes, Overseer_Assessment_Name, Overseer_Assessment, Overseer_Assessment_Notes, Overseer_Assessment_Date )

		create index tmp_volunteer_skill_idx_id
			on dbo.tmp_volunteer_skill (volunteer_skill_key )			

	/*
		-- UPDATE - BA OVERSEER ASSESSMENT - COMPUTER
		update dbo.volunteer_skill
		set 
			skill_level_key = case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end,
			personal_notes = src.personal_notes,
			ovsr_assessment_name = src.overseer_assessment_name,
			ovsr_assessment_skill_level_key =
				case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end,
			ovsr_assessment_notes = src.overseer_assessment_notes,
			ovsr_assessment_date = case when src.overseer_assessment_date = '0001-01-01' then null else src.overseer_assessment_date end,
			update_date = getdate()
		from dbo.volunteer_skill tgt
		inner join 
			( select volunteer_key, max( hub_person_guid ) as hub_person_guid 
				from dbo.volunteer
				group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
		inner join dbo.skill_speciality ss
			on tgt.skill_speciality_key = ss.skill_speciality_key
		inner join dbo.skill s
			on ss.skill_key = s.skill_key
		inner join stg.stg_ba_volunteer_skill src
			on v.hub_person_guid = src.person_guid	
			and ss.ba_skill_speciality_guid = src.subskill_guid
			and ss.ba_skill_speciality_guid is not null			
		--		where coalesce( tgt.personal_notes, '' ) <> coalesce( src.personal_notes, '' )
		--	or coalesce( tgt.ovsr_assessment_name, '' ) <> coalesce( src.overseer_assessment_name, '' )
		--	or coalesce( tgt.ovsr_assessment_skill_level_key, 0 ) <> 
		--		case when src.overseer_assessment = 0 then 7 else src.overseer_assessment end
		--	or coalesce( tgt.ovsr_assessment_notes, '' ) <> coalesce( src.overseer_assessment_notes, '' )
		--	or coalesce( tgt.ovsr_assessment_date, '2999-12-31' ) <> coalesce( src.overseer_assessment_date, '2999-12-31' )
	*/	
	
		-- UPDATE - BA OVERSEER ASSESSMENT
		update dbo.volunteer_skill
		set 
			skill_level_key = src.skill_level_key,
			personal_notes = src.personal_notes,
			ovsr_assessment_name = src.ovsr_assessment_name,
			ovsr_assessment_skill_level_key = src.ovsr_assessment_skill_level_key,
			ovsr_assessment_notes = src.ovsr_assessment_notes,
			ovsr_assessment_date = src.ovsr_assessment_date,
			update_date = getdate()
		from dbo.volunteer_skill tgt
		inner join dbo.tmp_volunteer_skill src
			on tgt.volunteer_skill_key = src.volunteer_skill_key
	
		
	/*			
		update dbo.volunteer_skill
		set
			skill_level_key = src.skill_level_key,
			personal_notes = src.personal_notes,
			ovsr_assessment_name = src.ovsr_assessment_name,
			ovsr_assessment_skill_level_key = src.ovsr_assessment_skill_level_key,
			ovsr_assessment_notes = src.ovsr_assessment_notes,
			ovsr_assessment_date = src.ovsr_assessment_date,
			update_date = getdate()
		from dbo.volunteer_skill tgt
		inner join
			( select 
				 v.volunteer_key
				,ss.skill_speciality_key
				,sl.skill_level_key
				,[personal_notes]
				,[overseer_assessment_name] as ovsr_assessment_name
				,sl.skill_level_key as ovsr_assessment_skill_level_key
				,[overseer_assessment_notes] as ovsr_assessment_notes
				,[overseer_assessment_date] as ovsr_assessment_date
			  from [rvd].[stg].[stg_ba_volunteer_skill] vs
			  inner join dbo.volunteer v
				on vs.person_guid = v.hub_person_guid
			  inner join dbo.skill_speciality ss
				on vs.subskill_guid = ss.ba_subskill_guid
			  inner join dbo.skill_level sl
				 on vs.overseer_assessment = sl.skill_level_code ) src
			on tgt.volunteer_Key = src.Volunteer_Key
			and tgt.Skill_Speciality_Key = src.Skill_Speciality_Key
		where tgt.skill_level_key <> src.skill_level_key
			or tgt.personal_notes <> src.personal_notes
			or tgt.ovsr_assessment_name <> src.ovsr_assessment_name
			or tgt.ovsr_assessment_skill_level_key <> src.ovsr_assessment_skill_level_key
			or tgt.ovsr_assessment_notes <> src.ovsr_assessment_notes
			or tgt.ovsr_assessment_date <> src.ovsr_assessment_date
		*/

		set @Upd = @Upd + @@rowcount		
	
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**				   VOLUNTEER TRAINING 
***********************************************************/
if object_id('dbo.ETL_Volunteer_Training_proc') is null
    exec( 'create procedure dbo.ETL_Volunteer_Training_proc as set nocount on;' )
go

alter procedure dbo.ETL_Volunteer_Training_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer_Training', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
	
	begin try
		-- INSERT BA
		insert into dbo.volunteer_training( 
			 volunteer_key
			,volunteer_id
			,person_guid
			,course_name
			,course_desc
			,course_type
			,assign_date
			,complete_date
			,modified_date
			,active_flag )		
		select 
			 v.volunteer_key
			,ba.volunteer_id
			,ba.person_guid
			,ba.course_name
			,ba.course_desc
			,ba.course_type
			,case when ba.assign_date = '0001-01-01 00:00:00.0000000 +00:00' then null else ba.assign_date end as assign_date
			,ba.complete_date
			,ba.modified_date
			,case when ba.active_flag = 1 then 'Y' else 'N' end as active_flag
		from stg.stg_ba_volunteer_training ba
		inner join 
			( select volunteer_key, max( hub_person_guid ) as hub_person_guid 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on ba.person_guid = v.hub_person_guid
		where not exists 
			( select 1 from dbo.volunteer_training vt
			  where vt.volunteer_key = v.volunteer_key
				and vt.course_name = ba.course_name )

		set @Ins = @@rowcount

		-- UPDATE BA
		update dbo.volunteer_training
		set 
			course_desc = src.course_desc,
			course_type = src.course_type,
			assign_date = case when src.assign_date = '0001-01-01 00:00:00.0000000 +00:00' then null else src.assign_date end,
			complete_date = src.complete_date,
			modified_date = src.modified_date,
			active_flag = case when src.active_flag = 1 then 'Y' else 'N' end,
			update_date = getdate()
		from dbo.volunteer_training tgt
		inner join 
			( select volunteer_key, max( hub_person_guid ) as hub_person_guid 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
		inner join stg.stg_ba_volunteer_training src
			on v.hub_person_guid = src.person_guid
			and tgt.course_name = src.course_name
		where coalesce( tgt.course_desc, '' ) <> src.course_desc
			or coalesce( tgt.course_type, '' ) <> src.course_type
			or coalesce( tgt.assign_date, '2999-12-31' ) <> src.assign_date
			or coalesce( tgt.complete_date, '2999-12-31' ) <> src.complete_date
			or coalesce( tgt.modified_date, '2999-12-31' ) <> src.modified_date
			or coalesce( tgt.active_flag, 'N' ) <> case when src.active_flag = 1 then 'Y' else 'N' end

		set @Upd = @@rowcount
		
		-- INSERT HUB
		insert into dbo.volunteer_training( 
			 volunteer_key
			,volunteer_id
			,person_guid
			,course_name
			,person_education_guid
			,person_education_id
			,course_desc
			,course_type_id
			,course_type
			,course_type_desc
			,class_number
			,class_name
			,class_completion_notes
			,course_objective
			,student_met_objective
			,attendance_status
			,assign_date
			,start_date
			,complete_date
			,modified_date
			,host_branch_code
			,active_flag )
		select 
			 v.volunteer_key
			,0 as volunteer_id
			,src.person_guid
			,coalesce( src.training_course, src.education_type_description ) as training_course
			,src.person_education_guid
			,src.person_education_id
			,coalesce( src.training_course_long_description, src.training_course, src.education_type_description ) as course_desc
			,src.education_type_id as course_type_id
			,src.education_type_description as course_type
			,src.education_type_local_description as course_type_desc
			,src.class_number
			,src.class_name
			,src.class_completion_notes
			,src.course_objective
			,src.student_met_objective
			,src.attendance_status
			,src.started_date as assign_date
			,src.started_date as start_date
			,cast( src.completed_date as date ) as complete_date
			,src.student_record_last_update as modified_date
			,src.host_branch_code
			,'Y' as active_flag
		from stg.stg_person_education src
		inner join dbo.volunteer v
			on src.person_id = v.hub_person_id
		where not exists 
			( select 1 from dbo.Volunteer_Training t 
			  where v.volunteer_key = t.volunteer_key 
			  	and coalesce( src.training_course, src.education_type_description ) = t.course_name
				and coalesce( src.person_education_id, 0 ) = coalesce( t.person_education_id, 0 )
				and coalesce( src.class_name, '' ) = coalesce( t.class_name, '' )
				and coalesce( src.class_number, '' ) = coalesce( t.class_number, '' ) )

		set @Ins = @Ins + @@rowcount		
		
		-- UPDATE HUB
		update dbo.volunteer_training
		set 
			person_education_guid = coalesce( convert( nvarchar(36), src.person_education_guid ), '' ),
			course_desc = coalesce( src.training_course_long_description, src.training_course, src.education_type_description ),
			course_type_id = coalesce( src.education_type_id, 0 ),
			course_type = coalesce( src.education_type_description, '' ),
			course_type_desc = coalesce( src.education_type_local_description, '' ),
			class_completion_notes = coalesce( src.class_completion_notes, '' ),
			course_objective = coalesce( src.course_objective, '' ),
			student_met_objective = coalesce( src.student_met_objective, '' ),
			attendance_status = coalesce( src.attendance_status, '' ),			
			assign_date = src.started_date,
			start_date = src.started_date,			
			complete_date = cast( src.completed_date as date ),
			modified_date = src.student_record_last_update,
			host_branch_code = coalesce( src.host_branch_code, '' ),
			update_date = getdate()			
		from dbo.volunteer_training tgt
		inner join 
			( select volunteer_key, max( hub_person_id ) as hub_person_id 
			  from dbo.volunteer
			  group by volunteer_key ) v
			on tgt.volunteer_key = v.volunteer_key
		inner join stg.stg_person_education src
			on v.hub_person_id = src.person_id
			and tgt.course_name = coalesce( src.training_course, src.education_type_description )
			and tgt.person_education_id = coalesce( src.person_education_id, 0 )
			and tgt.class_name = coalesce( src.class_name, '' )
			and tgt.class_number = coalesce( src.class_number, '' )			
		where coalesce( convert( nvarchar(36), tgt.person_education_guid ), '' ) <> coalesce( convert( nvarchar(36), src.person_education_guid ), '' )
			or coalesce( tgt.course_desc, '' ) <> coalesce( src.training_course_long_description, src.training_course, src.education_type_description )
			or coalesce( tgt.course_type_id, 0 ) <> coalesce( src.education_type_id, 0 )
			or coalesce( tgt.course_type, '' ) <> coalesce( src.education_type_description, '' )
			or coalesce( tgt.course_type_desc, '' ) <> coalesce( src.education_type_local_description, '' )
			or coalesce( tgt.class_completion_notes, '' ) <> coalesce( src.class_completion_notes, '' )			
			or coalesce( tgt.course_objective, '' ) <> coalesce( src.course_objective, '' )	
			or coalesce( tgt.student_met_objective, '' ) <> coalesce( src.student_met_objective, '' )	
			or coalesce( tgt.attendance_status, '' ) <> coalesce( src.attendance_status, '' )
			or coalesce( tgt.assign_date, '2999-12-31' ) <> coalesce( src.started_date, '2999-12-31' )
			or coalesce( tgt.start_date, '2999-12-31' ) <> coalesce( src.started_date, '2999-12-31' )			
			or coalesce( tgt.complete_date, '2999-12-31' ) <> coalesce( cast( src.completed_date as date ), '2999-12-31' )
			or coalesce( tgt.modified_date, '2999-12-31' ) <> coalesce( src.student_record_last_update, '2999-12-31' )
			or coalesce( tgt.host_branch_code, '' ) <> coalesce( src.host_branch_code, '' )
		
		set @Upd = @Upd + @@rowcount
		
		-- SET EMPTY COURSE_DESC VALUES TO WHITESPACE TO AVOID ERROR IN ACCESS
		update dbo.volunteer_training 
		set course_desc = ' ' 
		where course_desc = ''

		set @Upd = @Upd + @@rowcount		

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**				   RVD BANNER
***********************************************************/
if object_id('dbo.ETL_RVD_Banner_proc') is null
    exec( 'create procedure dbo.ETL_RVD_Banner_proc as set nocount on;' )
go

alter procedure dbo.ETL_RVD_Banner_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'RVD_Banner', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
	
	begin try
		-- RESET ALL
		update dbo.volunteer
		set rvd_banner = ''
		where rvd_banner <> ''
		
		-- VOL DESK USER 
		update dbo.volunteer
		set 
			rvd_banner = 'Applicant Being Pursued',
			update_date = getdate()
		where Vol_Desk_User_Key <> 1

		set @Upd = @@rowcount
		
		-- APP REQUEST COLLECTION		
		update dbo.volunteer
		set 
			rvd_banner = 'Applicant Being Pursued',
			update_date = getdate()		
		where rvd_banner <> 'Applicant Being Pursued'
			and volunteer_key in (
				select v.volunteer_key
				from dbo.volunteer_app_v a
				inner join dbo.volunteer v
					   on a.volunteer_key = v.volunteer_key
					   and v.vol_desk_user_key = 1  -- NOT ASSIGNED
				inner join dbo.enrollment e
					on v.Current_Enrollment_Key = e.Enrollment_Key
					and e.SFTS_Flag = 'N'			-- NOT SFTS
				where a.app_status_code = 'RES' 	-- RESERVED = ON AN APP REQ COLLECTION
					   and a.active_flag = 'Y' ) 	
					   
		set @Upd = @@rowcount					   

		-- APP ATTRIBUTE PURSUED BY
		update dbo.volunteer
		set 
			rvd_banner = 'Applicant Being Pursued',
			update_date = getdate()
		where rvd_banner <> 'Applicant Being Pursued'
			and coalesce( App_Pursued_By_Value, '' ) <> ''		
		
		set @Upd = @@rowcount
		
		-- PERSON IS TRACKED
--		update dbo.volunteer
--		set 
--			rvd_banner = case 
--							when rvd_banner = '' then 'Person is Tracked' 
--							else rvd_banner + char(13) + char(10) + 'Person is Tracked' 
--						 end,
--			update_date = getdate()
--		where hub_person_id in ( select person_id from stg.stg_person_tracking )	
		
		set @Upd = @@rowcount	
		
		-- DO NOT INVITE
		update dbo.volunteer
		set 
			rvd_banner = case 
							when rvd_banner = '' then 'Do Not Invite' 
							else rvd_banner + char(13) + char(10) + 'Do Not Invite' 
						 end,
			update_date = getdate()
		where tracking_status_key = 12
		
		set @Upd = @@rowcount		
		
		-- ROLE CHECK REQUIRED
		update dbo.volunteer
		set 
			rvd_banner = case 
							when rvd_banner = '' then 'Role Check Required' 
							else rvd_banner + char(13) + char(10) + 'Role Check Required' 
						 end,
			update_date = getdate()
		where 1=1
			and (
				    -- HID
				   ( volunteer_key in ( select volunteer_key from dbo.volunteer_role where active_flag = 'Y' and role = 'HLC Member' ) ) 
				    -- SERVICE
				or ( volunteer_key in ( select volunteer_key from dbo.volunteer_role where active_flag = 'Y' and role in (
						'Kingdom Ministry School Instructor',
						'Substitute Circuit Overseer',
						'Bible School Graduate',
						'Pioneer School Instructor',
						'Convention Contract Representative',
						'Convention Contract Representative Assistant',
						'Convention Rooming Coordinator',
						'Convention Rooming Coordinator Assistant',
						'SCOTW Instructor',
						'SCE Instructor',
						'SKE Instructor',
						'Convention Equipment Pool Committee',
						'Convention Responsibility',		-- CONVENTION COMMITTEE COORDINATOR
						'Witnessing group coordinator' ) ) ) 
					-- LDC
				or ( volunteer_key in ( select volunteer_key from dbo.volunteer_role where active_flag = 'Y' and role = 'LDC Entity Person' 
						and ( role_data in ( 'LDC Department', 'Disaster Relief', 'Design Section', 'Maintenance Section', 'Planning Section', 'Project Management Section',
										   'Quality Assurance Section', 'Support Section' ) 
						or role_data like 'Design Zone%'
						or role_data like 'CFR %'
						or role_data like 'CCGO %'
						or role_data like 'FR %'
						or role_data like 'FR-P %'
						or role_data like 'Construction Group %' ) ) )
				)				

		set @Upd = @Upd + @@rowcount

		-- SCHOOL GRAD
		update dbo.volunteer
		set 
			rvd_banner = case 
							when rvd_banner = '' then 'School Graduate' 
							else rvd_banner + char(13) + char(10) + 'School Graduate' 
						 end,
			update_date = getdate()
		where volunteer_key in ( select ve.volunteer_key from dbo.Volunteer_Enrollment ve inner join dbo.enrollment e on ve.Enrollment_Key = e.Enrollment_Key 
								 where e.Enrollment_Code in ( 'FGC', 'FGM', 'BBG', 'SKE' ) )

		set @Upd = @Upd + @@rowcount

		-- CURRENT ENROLLMENT
--		update dbo.volunteer
--		set 
--			rvd_banner = case 
--							when rvd_banner = '' then 'Currently Enrolled' 
--							else rvd_banner + char(13) + char(10) + 'Currently Enrolled' 
--						 end,
--			update_date = getdate()
--		where volunteer_key in ( select v.volunteer_key from dbo.Volunteer v inner join dbo.enrollment e on v.current_Enrollment_Key = e.Enrollment_Key 
--								 where e.Enrollment_Code not in ( 'BBC', 'BSE', 'FR', 'FRT', 'FST' ) )

		set @Upd = @Upd + @@rowcount

		-- INFORM DEPARTMENT
		update dbo.volunteer
		set 
			rvd_banner = case 
							when rvd_banner = '' then 'Inform Dept if Pursued' 
							else rvd_banner + char(13) + char(10) + 'Inform Dept if Pursued' 
						 end,
			update_date = getdate()
		where volunteer_key in ( select volunteer_key from dbo.Volunteer_role where active_flag = 'Y'
			and ( 
				 ( role in ( 'PID Key Role', 'PID Support Role' ) )
			  or ( role = 'HLC Member' and role_data is null )
			  or ( role = 'LDC Entity Person' 
				and (
					   role_data = 'Training Courses'
					or role_data like '%,%'
					or role_data like 'Safety Zone%'
					or role_data like 'VSG Zone%'
					or role_data like 'LDC Zone%'
					or role_data like '%(AH)%'
					or role_data like 'MT%'
					) )
				) )

		set @Upd = @Upd + @@rowcount
		
		-- ZIP CLOSEST TO HPR
--		update dbo.volunteer
--		set 
--			rvd_banner = case 
--							when rvd_banner = '' then 'Zip Code Closest to HPR' 
--							else rvd_banner + char(13) + char(10) + 'Zip Closest to HPR' 
--						 end,
--			update_date = getdate()
--		where postal_code_key in ( select postal_code_key from dbo.postal_code where local_flag = 'Y' and hpr_flag = 'Y' )

		set @Upd = @Upd + @@rowcount
		
		-- ZIP CLOSEST TO OTHER COMPLEXES
--		update dbo.volunteer
--		set 
--			rvd_banner = case 
--							when rvd_banner = '' then 'Zip Code Closest to Other Complexes' 
--							else rvd_banner + char(13) + char(10) + 'Zip Code Closest to Other Complexes' 
--						 end,
--			update_date = getdate()
--		where postal_code_key in ( select postal_code_key from dbo.postal_code where local_flag = 'Y' and hpr_flag = 'N' )

		set @Upd = @Upd + @@rowcount			

		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**				   PRP DATA
***********************************************************/
if object_id('dbo.ETL_PRP_Data_proc') is null
    exec( 'create procedure dbo.ETL_PRP_Data_proc as set nocount on;' )
go

alter procedure dbo.ETL_PRP_Data_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'PRP', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
	
	begin try
		-- FIX PRP DATA
		--update stg.stg_prp_dept set teamcode = 'HPR CI BG SL TE' where teamtrade = 'Site Logistics - Telehandler' 
		--update stg.stg_prp_dept set teamcode = 'HPR CI BG SL CR' where teamtrade = 'Site Logistics - Crane Operator'
		--update stg.stg_prp_dept set teamcode = 'HPR CI BG SL RI' where teamtrade = 'Site Logistics - Rigger'
		--update stg.stg_prp_dept set teamcode = 'HPR CI BG SL TC' where teamtrade = 'Site Logistics - Traffic Management'
		--update stg.stg_prp_dept set teamcode = 'HPR CI BG BP' where teamtrade = 'Batch Plant'

		-- DELETE BED DATA
		truncate table dbo.PRP
		
		set @Del = @Del + @@rowcount		
		
		-- INSERT BED DATA
		insert into dbo.PRP( hpr_dept_key, cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt )
		select hpr_dept_key, cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt 
		from (
			select hpr_dept_key, cast( left( 'jan_20', 3 ) +  ' 01 ' + '20' + right( 'jan_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_20', 3 ) +  ' 01 ' + '20' + right( 'feb_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_20', 3 ) +  ' 01 ' + '20' + right( 'mar_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_20', 3 ) +  ' 01 ' + '20' + right( 'apr_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_20', 3 ) +  ' 01 ' + '20' + right( 'may_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_20', 3 ) +  ' 01 ' + '20' + right( 'jun_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_20', 3 ) +  ' 01 ' + '20' + right( 'jul_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_20', 3 ) +  ' 01 ' + '20' + right( 'aug_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_20', 3 ) +  ' 01 ' + '20' + right( 'sep_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_20', 3 ) +  ' 01 ' + '20' + right( 'oct_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_20', 3 ) +  ' 01 ' + '20' + right( 'nov_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_20', 3 ) +  ' 01 ' + '20' + right( 'dec_20', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_20 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jan_21', 3 ) +  ' 01 ' + '20' + right( 'jan_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_21', 3 ) +  ' 01 ' + '20' + right( 'feb_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_21', 3 ) +  ' 01 ' + '20' + right( 'mar_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_21', 3 ) +  ' 01 ' + '20' + right( 'apr_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_21', 3 ) +  ' 01 ' + '20' + right( 'may_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_21', 3 ) +  ' 01 ' + '20' + right( 'jun_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_21', 3 ) +  ' 01 ' + '20' + right( 'jul_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_21', 3 ) +  ' 01 ' + '20' + right( 'aug_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_21', 3 ) +  ' 01 ' + '20' + right( 'sep_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_21', 3 ) +  ' 01 ' + '20' + right( 'oct_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_21', 3 ) +  ' 01 ' + '20' + right( 'nov_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_21', 3 ) +  ' 01 ' + '20' + right( 'dec_21', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_21 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jan_22', 3 ) +  ' 01 ' + '20' + right( 'jan_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_22', 3 ) +  ' 01 ' + '20' + right( 'feb_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_22', 3 ) +  ' 01 ' + '20' + right( 'mar_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_22', 3 ) +  ' 01 ' + '20' + right( 'apr_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_22', 3 ) +  ' 01 ' + '20' + right( 'may_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_22', 3 ) +  ' 01 ' + '20' + right( 'jun_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_22', 3 ) +  ' 01 ' + '20' + right( 'jul_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_22', 3 ) +  ' 01 ' + '20' + right( 'aug_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_22', 3 ) +  ' 01 ' + '20' + right( 'sep_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_22', 3 ) +  ' 01 ' + '20' + right( 'oct_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_22', 3 ) +  ' 01 ' + '20' + right( 'nov_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_22', 3 ) +  ' 01 ' + '20' + right( 'dec_22', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_22 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jan_23', 3 ) +  ' 01 ' + '20' + right( 'jan_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_23', 3 ) +  ' 01 ' + '20' + right( 'feb_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_23', 3 ) +  ' 01 ' + '20' + right( 'mar_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_23', 3 ) +  ' 01 ' + '20' + right( 'apr_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_23', 3 ) +  ' 01 ' + '20' + right( 'may_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_23', 3 ) +  ' 01 ' + '20' + right( 'jun_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_23', 3 ) +  ' 01 ' + '20' + right( 'jul_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_23', 3 ) +  ' 01 ' + '20' + right( 'aug_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_23', 3 ) +  ' 01 ' + '20' + right( 'sep_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_23', 3 ) +  ' 01 ' + '20' + right( 'oct_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_23', 3 ) +  ' 01 ' + '20' + right( 'nov_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_23', 3 ) +  ' 01 ' + '20' + right( 'dec_23', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_23 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jan_24', 3 ) +  ' 01 ' + '20' + right( 'jan_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_24', 3 ) +  ' 01 ' + '20' + right( 'feb_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_24', 3 ) +  ' 01 ' + '20' + right( 'mar_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_24', 3 ) +  ' 01 ' + '20' + right( 'apr_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_24', 3 ) +  ' 01 ' + '20' + right( 'may_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_24', 3 ) +  ' 01 ' + '20' + right( 'jun_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_24', 3 ) +  ' 01 ' + '20' + right( 'jul_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_24', 3 ) +  ' 01 ' + '20' + right( 'aug_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_24', 3 ) +  ' 01 ' + '20' + right( 'sep_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_24', 3 ) +  ' 01 ' + '20' + right( 'oct_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_24', 3 ) +  ' 01 ' + '20' + right( 'nov_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_24', 3 ) +  ' 01 ' + '20' + right( 'dec_24', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_24 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jan_25', 3 ) +  ' 01 ' + '20' + right( 'jan_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_25', 3 ) +  ' 01 ' + '20' + right( 'feb_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_25', 3 ) +  ' 01 ' + '20' + right( 'mar_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_25', 3 ) +  ' 01 ' + '20' + right( 'apr_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_25', 3 ) +  ' 01 ' + '20' + right( 'may_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_25', 3 ) +  ' 01 ' + '20' + right( 'jun_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_25', 3 ) +  ' 01 ' + '20' + right( 'jul_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_25', 3 ) +  ' 01 ' + '20' + right( 'aug_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_25', 3 ) +  ' 01 ' + '20' + right( 'sep_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_25', 3 ) +  ' 01 ' + '20' + right( 'oct_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_25', 3 ) +  ' 01 ' + '20' + right( 'nov_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_25', 3 ) +  ' 01 ' + '20' + right( 'dec_25', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_25 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jan_26', 3 ) +  ' 01 ' + '20' + right( 'jan_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_26', 3 ) +  ' 01 ' + '20' + right( 'feb_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_26', 3 ) +  ' 01 ' + '20' + right( 'mar_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_26', 3 ) +  ' 01 ' + '20' + right( 'apr_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_26', 3 ) +  ' 01 ' + '20' + right( 'may_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_26', 3 ) +  ' 01 ' + '20' + right( 'jun_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_26', 3 ) +  ' 01 ' + '20' + right( 'jul_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_26', 3 ) +  ' 01 ' + '20' + right( 'aug_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_26', 3 ) +  ' 01 ' + '20' + right( 'sep_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_26', 3 ) +  ' 01 ' + '20' + right( 'oct_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_26', 3 ) +  ' 01 ' + '20' + right( 'nov_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_26', 3 ) +  ' 01 ' + '20' + right( 'dec_26', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_26 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jan_27', 3 ) +  ' 01 ' + '20' + right( 'jan_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_27', 3 ) +  ' 01 ' + '20' + right( 'feb_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_27', 3 ) +  ' 01 ' + '20' + right( 'mar_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_27', 3 ) +  ' 01 ' + '20' + right( 'apr_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_27', 3 ) +  ' 01 ' + '20' + right( 'may_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_27', 3 ) +  ' 01 ' + '20' + right( 'jun_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_27', 3 ) +  ' 01 ' + '20' + right( 'jul_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_27', 3 ) +  ' 01 ' + '20' + right( 'aug_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_27', 3 ) +  ' 01 ' + '20' + right( 'sep_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_27', 3 ) +  ' 01 ' + '20' + right( 'oct_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_27', 3 ) +  ' 01 ' + '20' + right( 'nov_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_27', 3 ) +  ' 01 ' + '20' + right( 'dec_27', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_27 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jan_28', 3 ) +  ' 01 ' + '20' + right( 'jan_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_28', 3 ) +  ' 01 ' + '20' + right( 'feb_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_28', 3 ) +  ' 01 ' + '20' + right( 'mar_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_28', 3 ) +  ' 01 ' + '20' + right( 'apr_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_28', 3 ) +  ' 01 ' + '20' + right( 'may_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_28', 3 ) +  ' 01 ' + '20' + right( 'jun_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_28', 3 ) +  ' 01 ' + '20' + right( 'jul_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_28', 3 ) +  ' 01 ' + '20' + right( 'aug_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_28', 3 ) +  ' 01 ' + '20' + right( 'sep_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_28', 3 ) +  ' 01 ' + '20' + right( 'oct_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_28', 3 ) +  ' 01 ' + '20' + right( 'nov_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_28', 3 ) +  ' 01 ' + '20' + right( 'dec_28', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_28 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL
			select hpr_dept_key, cast( left( 'jan_29', 3 ) +  ' 01 ' + '20' + right( 'jan_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_29', 3 ) +  ' 01 ' + '20' + right( 'feb_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_29', 3 ) +  ' 01 ' + '20' + right( 'mar_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'apr_29', 3 ) +  ' 01 ' + '20' + right( 'apr_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select apr_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'may_29', 3 ) +  ' 01 ' + '20' + right( 'may_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select may_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jun_29', 3 ) +  ' 01 ' + '20' + right( 'jun_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jun_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'jul_29', 3 ) +  ' 01 ' + '20' + right( 'jul_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jul_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'aug_29', 3 ) +  ' 01 ' + '20' + right( 'aug_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select aug_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'sep_29', 3 ) +  ' 01 ' + '20' + right( 'sep_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select sep_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'oct_29', 3 ) +  ' 01 ' + '20' + right( 'oct_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select oct_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'nov_29', 3 ) +  ' 01 ' + '20' + right( 'nov_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select nov_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'dec_29', 3 ) +  ' 01 ' + '20' + right( 'dec_29', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select dec_29 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL
			select hpr_dept_key, cast( left( 'jan_30', 3 ) +  ' 01 ' + '20' + right( 'jan_30', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select jan_30 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'feb_30', 3 ) +  ' 01 ' + '20' + right( 'feb_30', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select feb_30 as bed_cnt, * FROM stg.stg_prp_v ) x UNION ALL 
			select hpr_dept_key, cast( left( 'mar_30', 3 ) +  ' 01 ' + '20' + right( 'mar_30', 2 ) as date ) as cal_dt, bed_cnt, cpc_code, hub_dept_name, dept_name, work_group_name, pc_category, pc_code, prp_cnt from ( select mar_30 as bed_cnt, * FROM stg.stg_prp_v ) x
		) core

		set @Ins = @Ins + @@rowcount
		
		-- DELETE BED SPACE DATA
		truncate table dbo.PRP_Bed_Space
		
		set @Del = @Del + @@rowcount		
		
		-- INSERT BED SPACE DATA
		insert into dbo.PRP_Bed_Space( cal_dt, rooming_category, rooming_detail, bed_cnt )		
		select cal_dt, rooming_category, rooming_detail, bed_cnt
		from (
			select cast( left( 'jan_20', 3 ) +  ' 01 ' + '20' + right( 'jan_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_20', 3 ) +  ' 01 ' + '20' + right( 'feb_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_20', 3 ) +  ' 01 ' + '20' + right( 'mar_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'apr_20', 3 ) +  ' 01 ' + '20' + right( 'apr_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_20', 3 ) +  ' 01 ' + '20' + right( 'may_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_20', 3 ) +  ' 01 ' + '20' + right( 'jun_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_20', 3 ) +  ' 01 ' + '20' + right( 'jul_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_20', 3 ) +  ' 01 ' + '20' + right( 'aug_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_20', 3 ) +  ' 01 ' + '20' + right( 'sep_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_20', 3 ) +  ' 01 ' + '20' + right( 'oct_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_20', 3 ) +  ' 01 ' + '20' + right( 'nov_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_20', 3 ) +  ' 01 ' + '20' + right( 'dec_20', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_20 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jan_21', 3 ) +  ' 01 ' + '20' + right( 'jan_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_21', 3 ) +  ' 01 ' + '20' + right( 'feb_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_21', 3 ) +  ' 01 ' + '20' + right( 'mar_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'apr_21', 3 ) +  ' 01 ' + '20' + right( 'apr_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_21', 3 ) +  ' 01 ' + '20' + right( 'may_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_21', 3 ) +  ' 01 ' + '20' + right( 'jun_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_21', 3 ) +  ' 01 ' + '20' + right( 'jul_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_21', 3 ) +  ' 01 ' + '20' + right( 'aug_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_21', 3 ) +  ' 01 ' + '20' + right( 'sep_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_21', 3 ) +  ' 01 ' + '20' + right( 'oct_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_21', 3 ) +  ' 01 ' + '20' + right( 'nov_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_21', 3 ) +  ' 01 ' + '20' + right( 'dec_21', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_21 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jan_22', 3 ) +  ' 01 ' + '20' + right( 'jan_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_22', 3 ) +  ' 01 ' + '20' + right( 'feb_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_22', 3 ) +  ' 01 ' + '20' + right( 'mar_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'apr_22', 3 ) +  ' 01 ' + '20' + right( 'apr_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_22', 3 ) +  ' 01 ' + '20' + right( 'may_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_22', 3 ) +  ' 01 ' + '20' + right( 'jun_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_22', 3 ) +  ' 01 ' + '20' + right( 'jul_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_22', 3 ) +  ' 01 ' + '20' + right( 'aug_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_22', 3 ) +  ' 01 ' + '20' + right( 'sep_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_22', 3 ) +  ' 01 ' + '20' + right( 'oct_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_22', 3 ) +  ' 01 ' + '20' + right( 'nov_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_22', 3 ) +  ' 01 ' + '20' + right( 'dec_22', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_22 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jan_23', 3 ) +  ' 01 ' + '20' + right( 'jan_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_23', 3 ) +  ' 01 ' + '20' + right( 'feb_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_23', 3 ) +  ' 01 ' + '20' + right( 'mar_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'apr_23', 3 ) +  ' 01 ' + '20' + right( 'apr_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_23', 3 ) +  ' 01 ' + '20' + right( 'may_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_23', 3 ) +  ' 01 ' + '20' + right( 'jun_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_23', 3 ) +  ' 01 ' + '20' + right( 'jul_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_23', 3 ) +  ' 01 ' + '20' + right( 'aug_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_23', 3 ) +  ' 01 ' + '20' + right( 'sep_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_23', 3 ) +  ' 01 ' + '20' + right( 'oct_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_23', 3 ) +  ' 01 ' + '20' + right( 'nov_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_23', 3 ) +  ' 01 ' + '20' + right( 'dec_23', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_23 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jan_24', 3 ) +  ' 01 ' + '20' + right( 'jan_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_24', 3 ) +  ' 01 ' + '20' + right( 'feb_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_24', 3 ) +  ' 01 ' + '20' + right( 'mar_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'apr_24', 3 ) +  ' 01 ' + '20' + right( 'apr_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_24', 3 ) +  ' 01 ' + '20' + right( 'may_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_24', 3 ) +  ' 01 ' + '20' + right( 'jun_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_24', 3 ) +  ' 01 ' + '20' + right( 'jul_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_24', 3 ) +  ' 01 ' + '20' + right( 'aug_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_24', 3 ) +  ' 01 ' + '20' + right( 'sep_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_24', 3 ) +  ' 01 ' + '20' + right( 'oct_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_24', 3 ) +  ' 01 ' + '20' + right( 'nov_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_24', 3 ) +  ' 01 ' + '20' + right( 'dec_24', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_24 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jan_25', 3 ) +  ' 01 ' + '20' + right( 'jan_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_25', 3 ) +  ' 01 ' + '20' + right( 'feb_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_25', 3 ) +  ' 01 ' + '20' + right( 'mar_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'apr_25', 3 ) +  ' 01 ' + '20' + right( 'apr_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_25', 3 ) +  ' 01 ' + '20' + right( 'may_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_25', 3 ) +  ' 01 ' + '20' + right( 'jun_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_25', 3 ) +  ' 01 ' + '20' + right( 'jul_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_25', 3 ) +  ' 01 ' + '20' + right( 'aug_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_25', 3 ) +  ' 01 ' + '20' + right( 'sep_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_25', 3 ) +  ' 01 ' + '20' + right( 'oct_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_25', 3 ) +  ' 01 ' + '20' + right( 'nov_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_25', 3 ) +  ' 01 ' + '20' + right( 'dec_25', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_25 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jan_26', 3 ) +  ' 01 ' + '20' + right( 'jan_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_26', 3 ) +  ' 01 ' + '20' + right( 'feb_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_26', 3 ) +  ' 01 ' + '20' + right( 'mar_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'apr_26', 3 ) +  ' 01 ' + '20' + right( 'apr_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_26', 3 ) +  ' 01 ' + '20' + right( 'may_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_26', 3 ) +  ' 01 ' + '20' + right( 'jun_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_26', 3 ) +  ' 01 ' + '20' + right( 'jul_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_26', 3 ) +  ' 01 ' + '20' + right( 'aug_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_26', 3 ) +  ' 01 ' + '20' + right( 'sep_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_26', 3 ) +  ' 01 ' + '20' + right( 'oct_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_26', 3 ) +  ' 01 ' + '20' + right( 'nov_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_26', 3 ) +  ' 01 ' + '20' + right( 'dec_26', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_26 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jan_27', 3 ) +  ' 01 ' + '20' + right( 'jan_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_27', 3 ) +  ' 01 ' + '20' + right( 'feb_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_27', 3 ) +  ' 01 ' + '20' + right( 'mar_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'apr_27', 3 ) +  ' 01 ' + '20' + right( 'apr_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_27', 3 ) +  ' 01 ' + '20' + right( 'may_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_27', 3 ) +  ' 01 ' + '20' + right( 'jun_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_27', 3 ) +  ' 01 ' + '20' + right( 'jul_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_27', 3 ) +  ' 01 ' + '20' + right( 'aug_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_27', 3 ) +  ' 01 ' + '20' + right( 'sep_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_27', 3 ) +  ' 01 ' + '20' + right( 'oct_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_27', 3 ) +  ' 01 ' + '20' + right( 'nov_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_27', 3 ) +  ' 01 ' + '20' + right( 'dec_27', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_27 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jan_28', 3 ) +  ' 01 ' + '20' + right( 'jan_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_28', 3 ) +  ' 01 ' + '20' + right( 'feb_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_28', 3 ) +  ' 01 ' + '20' + right( 'mar_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL
			select cast( left( 'apr_28', 3 ) +  ' 01 ' + '20' + right( 'apr_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_28', 3 ) +  ' 01 ' + '20' + right( 'may_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_28', 3 ) +  ' 01 ' + '20' + right( 'jun_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_28', 3 ) +  ' 01 ' + '20' + right( 'jul_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_28', 3 ) +  ' 01 ' + '20' + right( 'aug_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_28', 3 ) +  ' 01 ' + '20' + right( 'sep_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_28', 3 ) +  ' 01 ' + '20' + right( 'oct_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_28', 3 ) +  ' 01 ' + '20' + right( 'nov_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_28', 3 ) +  ' 01 ' + '20' + right( 'dec_28', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_28 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL
			select cast( left( 'jan_29', 3 ) +  ' 01 ' + '20' + right( 'jan_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_29', 3 ) +  ' 01 ' + '20' + right( 'feb_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_29', 3 ) +  ' 01 ' + '20' + right( 'mar_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL
			select cast( left( 'apr_29', 3 ) +  ' 01 ' + '20' + right( 'apr_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select apr_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'may_29', 3 ) +  ' 01 ' + '20' + right( 'may_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select may_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jun_29', 3 ) +  ' 01 ' + '20' + right( 'jun_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jun_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'jul_29', 3 ) +  ' 01 ' + '20' + right( 'jul_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jul_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'aug_29', 3 ) +  ' 01 ' + '20' + right( 'aug_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select aug_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'sep_29', 3 ) +  ' 01 ' + '20' + right( 'sep_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select sep_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'oct_29', 3 ) +  ' 01 ' + '20' + right( 'oct_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select oct_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'nov_29', 3 ) +  ' 01 ' + '20' + right( 'nov_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select nov_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'dec_29', 3 ) +  ' 01 ' + '20' + right( 'dec_29', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select dec_29 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL
			select cast( left( 'jan_30', 3 ) +  ' 01 ' + '20' + right( 'jan_30', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select jan_30 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'feb_30', 3 ) +  ' 01 ' + '20' + right( 'feb_30', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select feb_30 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x UNION ALL 
			select cast( left( 'mar_30', 3 ) +  ' 01 ' + '20' + right( 'mar_30', 2 ) as date ) as cal_dt, rooming_category, rooming_detail, bed_cnt from ( select mar_30 as bed_cnt, * FROM stg.stg_prp_bed_space_v ) x
		) core
		
		set @Ins = @Ins + @@rowcount
		
		update dbo.PRP_Bed_Space
		set reporting_category =
			case 
				when rooming_category in ( 'Bed Space Required Total', 'Commuter Forecast' ) then rooming_category
				when rooming_category = 'Branch' then 'Bed Capacity - Branch'
				when rooming_category = 'BCL/BRS' then 'Bed Capacity - BCL/BRS'
				when rooming_category = 'Newburgh' then 'Bed Capacity - Newburgh'
				when rooming_category = 'Woodgrove' then 'Bed Capacity - Woodgrove'
				when rooming_category = 'Ramapo Residences' then 'Bed Capacity - Ramapo'
				else 'Unknown'
			end

		set @Upd = @Upd + @@rowcount

		-- DELETE CPC LEVEL DATA
		truncate table dbo.PRP_CPC
		
		set @Del = @Del + @@rowcount		
		
		-- INSERT CPC LEVEL DATA
		insert into dbo.PRP_CPC( cpc_code, cal_dt, bed_cnt, pc_code )
		select cpc_code, cal_dt, bed_cnt, pc_code
		from (
			select cpc_code, cast( left( 'jan_20', 3 ) +  ' 01 ' + '20' + right( 'jan_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_20', 3 ) +  ' 01 ' + '20' + right( 'feb_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_20', 3 ) +  ' 01 ' + '20' + right( 'mar_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_20', 3 ) +  ' 01 ' + '20' + right( 'apr_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_20', 3 ) +  ' 01 ' + '20' + right( 'may_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_20', 3 ) +  ' 01 ' + '20' + right( 'jun_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_20', 3 ) +  ' 01 ' + '20' + right( 'jul_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_20', 3 ) +  ' 01 ' + '20' + right( 'aug_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_20', 3 ) +  ' 01 ' + '20' + right( 'sep_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_20', 3 ) +  ' 01 ' + '20' + right( 'oct_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_20', 3 ) +  ' 01 ' + '20' + right( 'nov_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_20', 3 ) +  ' 01 ' + '20' + right( 'dec_20', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_20 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jan_21', 3 ) +  ' 01 ' + '20' + right( 'jan_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_21', 3 ) +  ' 01 ' + '20' + right( 'feb_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_21', 3 ) +  ' 01 ' + '20' + right( 'mar_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_21', 3 ) +  ' 01 ' + '20' + right( 'apr_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_21', 3 ) +  ' 01 ' + '20' + right( 'may_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_21', 3 ) +  ' 01 ' + '20' + right( 'jun_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_21', 3 ) +  ' 01 ' + '20' + right( 'jul_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_21', 3 ) +  ' 01 ' + '20' + right( 'aug_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_21', 3 ) +  ' 01 ' + '20' + right( 'sep_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_21', 3 ) +  ' 01 ' + '20' + right( 'oct_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_21', 3 ) +  ' 01 ' + '20' + right( 'nov_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_21', 3 ) +  ' 01 ' + '20' + right( 'dec_21', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_21 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jan_22', 3 ) +  ' 01 ' + '20' + right( 'jan_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_22', 3 ) +  ' 01 ' + '20' + right( 'feb_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_22', 3 ) +  ' 01 ' + '20' + right( 'mar_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_22', 3 ) +  ' 01 ' + '20' + right( 'apr_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_22', 3 ) +  ' 01 ' + '20' + right( 'may_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_22', 3 ) +  ' 01 ' + '20' + right( 'jun_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_22', 3 ) +  ' 01 ' + '20' + right( 'jul_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_22', 3 ) +  ' 01 ' + '20' + right( 'aug_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_22', 3 ) +  ' 01 ' + '20' + right( 'sep_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_22', 3 ) +  ' 01 ' + '20' + right( 'oct_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_22', 3 ) +  ' 01 ' + '20' + right( 'nov_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_22', 3 ) +  ' 01 ' + '20' + right( 'dec_22', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_22 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jan_23', 3 ) +  ' 01 ' + '20' + right( 'jan_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_23', 3 ) +  ' 01 ' + '20' + right( 'feb_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_23', 3 ) +  ' 01 ' + '20' + right( 'mar_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_23', 3 ) +  ' 01 ' + '20' + right( 'apr_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_23', 3 ) +  ' 01 ' + '20' + right( 'may_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_23', 3 ) +  ' 01 ' + '20' + right( 'jun_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_23', 3 ) +  ' 01 ' + '20' + right( 'jul_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_23', 3 ) +  ' 01 ' + '20' + right( 'aug_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_23', 3 ) +  ' 01 ' + '20' + right( 'sep_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_23', 3 ) +  ' 01 ' + '20' + right( 'oct_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_23', 3 ) +  ' 01 ' + '20' + right( 'nov_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_23', 3 ) +  ' 01 ' + '20' + right( 'dec_23', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_23 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jan_24', 3 ) +  ' 01 ' + '20' + right( 'jan_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_24', 3 ) +  ' 01 ' + '20' + right( 'feb_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_24', 3 ) +  ' 01 ' + '20' + right( 'mar_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_24', 3 ) +  ' 01 ' + '20' + right( 'apr_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_24', 3 ) +  ' 01 ' + '20' + right( 'may_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_24', 3 ) +  ' 01 ' + '20' + right( 'jun_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_24', 3 ) +  ' 01 ' + '20' + right( 'jul_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_24', 3 ) +  ' 01 ' + '20' + right( 'aug_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_24', 3 ) +  ' 01 ' + '20' + right( 'sep_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_24', 3 ) +  ' 01 ' + '20' + right( 'oct_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_24', 3 ) +  ' 01 ' + '20' + right( 'nov_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_24', 3 ) +  ' 01 ' + '20' + right( 'dec_24', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_24 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jan_25', 3 ) +  ' 01 ' + '20' + right( 'jan_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_25', 3 ) +  ' 01 ' + '20' + right( 'feb_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_25', 3 ) +  ' 01 ' + '20' + right( 'mar_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_25', 3 ) +  ' 01 ' + '20' + right( 'apr_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_25', 3 ) +  ' 01 ' + '20' + right( 'may_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_25', 3 ) +  ' 01 ' + '20' + right( 'jun_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_25', 3 ) +  ' 01 ' + '20' + right( 'jul_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_25', 3 ) +  ' 01 ' + '20' + right( 'aug_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_25', 3 ) +  ' 01 ' + '20' + right( 'sep_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_25', 3 ) +  ' 01 ' + '20' + right( 'oct_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_25', 3 ) +  ' 01 ' + '20' + right( 'nov_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_25', 3 ) +  ' 01 ' + '20' + right( 'dec_25', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_25 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jan_26', 3 ) +  ' 01 ' + '20' + right( 'jan_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_26', 3 ) +  ' 01 ' + '20' + right( 'feb_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_26', 3 ) +  ' 01 ' + '20' + right( 'mar_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_26', 3 ) +  ' 01 ' + '20' + right( 'apr_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_26', 3 ) +  ' 01 ' + '20' + right( 'may_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_26', 3 ) +  ' 01 ' + '20' + right( 'jun_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_26', 3 ) +  ' 01 ' + '20' + right( 'jul_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_26', 3 ) +  ' 01 ' + '20' + right( 'aug_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_26', 3 ) +  ' 01 ' + '20' + right( 'sep_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_26', 3 ) +  ' 01 ' + '20' + right( 'oct_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_26', 3 ) +  ' 01 ' + '20' + right( 'nov_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_26', 3 ) +  ' 01 ' + '20' + right( 'dec_26', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_26 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jan_27', 3 ) +  ' 01 ' + '20' + right( 'jan_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_27', 3 ) +  ' 01 ' + '20' + right( 'feb_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_27', 3 ) +  ' 01 ' + '20' + right( 'mar_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_27', 3 ) +  ' 01 ' + '20' + right( 'apr_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_27', 3 ) +  ' 01 ' + '20' + right( 'may_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_27', 3 ) +  ' 01 ' + '20' + right( 'jun_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_27', 3 ) +  ' 01 ' + '20' + right( 'jul_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_27', 3 ) +  ' 01 ' + '20' + right( 'aug_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_27', 3 ) +  ' 01 ' + '20' + right( 'sep_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_27', 3 ) +  ' 01 ' + '20' + right( 'oct_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_27', 3 ) +  ' 01 ' + '20' + right( 'nov_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_27', 3 ) +  ' 01 ' + '20' + right( 'dec_27', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_27 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jan_28', 3 ) +  ' 01 ' + '20' + right( 'jan_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_28', 3 ) +  ' 01 ' + '20' + right( 'feb_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_28', 3 ) +  ' 01 ' + '20' + right( 'mar_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_28', 3 ) +  ' 01 ' + '20' + right( 'apr_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_28', 3 ) +  ' 01 ' + '20' + right( 'may_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_28', 3 ) +  ' 01 ' + '20' + right( 'jun_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_28', 3 ) +  ' 01 ' + '20' + right( 'jul_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_28', 3 ) +  ' 01 ' + '20' + right( 'aug_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_28', 3 ) +  ' 01 ' + '20' + right( 'sep_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_28', 3 ) +  ' 01 ' + '20' + right( 'oct_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_28', 3 ) +  ' 01 ' + '20' + right( 'nov_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_28', 3 ) +  ' 01 ' + '20' + right( 'dec_28', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_28 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL
			select cpc_code, cast( left( 'jan_29', 3 ) +  ' 01 ' + '20' + right( 'jan_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_29', 3 ) +  ' 01 ' + '20' + right( 'feb_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_29', 3 ) +  ' 01 ' + '20' + right( 'mar_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'apr_29', 3 ) +  ' 01 ' + '20' + right( 'apr_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select apr_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'may_29', 3 ) +  ' 01 ' + '20' + right( 'may_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select may_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jun_29', 3 ) +  ' 01 ' + '20' + right( 'jun_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jun_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'jul_29', 3 ) +  ' 01 ' + '20' + right( 'jul_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jul_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'aug_29', 3 ) +  ' 01 ' + '20' + right( 'aug_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select aug_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'sep_29', 3 ) +  ' 01 ' + '20' + right( 'sep_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select sep_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'oct_29', 3 ) +  ' 01 ' + '20' + right( 'oct_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select oct_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'nov_29', 3 ) +  ' 01 ' + '20' + right( 'nov_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select nov_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'dec_29', 3 ) +  ' 01 ' + '20' + right( 'dec_29', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select dec_29 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL
			select cpc_code, cast( left( 'jan_30', 3 ) +  ' 01 ' + '20' + right( 'jan_30', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select jan_30 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'feb_30', 3 ) +  ' 01 ' + '20' + right( 'feb_30', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select feb_30 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x UNION ALL 
			select cpc_code, cast( left( 'mar_30', 3 ) +  ' 01 ' + '20' + right( 'mar_30', 2 ) as date ) as cal_dt, bed_cnt, pc_code from ( select mar_30 as bed_cnt, * FROM stg.stg_prp_cpc_v ) x
		) core

		set @Ins = @Ins + @@rowcount
		
		-- PRP ACTUALS
		-- DELETE EXISTING DATA
		truncate table dbo.PRP_Actuals_Level_04_snp
		
		set @Del = @Del + @@rowcount		
		
		-- INSERT PRP ACTUALS DATA		
		insert into dbo.PRP_Actuals_Level_04_snp(
			cpc_code
           ,level_03
           ,level_04
           ,wk_01_dt
           ,wk_01_budget
           ,wk_01_used
           ,wk_01_avail
           ,wk_02_dt
           ,wk_02_budget
           ,wk_02_used
           ,wk_02_avail
           ,wk_03_dt
           ,wk_03_budget
           ,wk_03_used
           ,wk_03_avail
           ,wk_04_dt
           ,wk_04_budget
           ,wk_04_used
           ,wk_04_avail
           ,wk_05_dt
           ,wk_05_budget
           ,wk_05_used
           ,wk_05_avail
           ,wk_06_dt
           ,wk_06_budget
           ,wk_06_used
           ,wk_06_avail
           ,wk_07_dt
           ,wk_07_budget
           ,wk_07_used
           ,wk_07_avail
           ,wk_08_dt
           ,wk_08_budget
           ,wk_08_used
           ,wk_08_avail
           ,wk_09_dt
           ,wk_09_budget
           ,wk_09_used
           ,wk_09_avail
           ,wk_10_dt
           ,wk_10_budget
           ,wk_10_used
           ,wk_10_avail
           ,wk_11_dt
           ,wk_11_budget
           ,wk_11_used
           ,wk_11_avail
           ,wk_12_dt
           ,wk_12_budget
           ,wk_12_used
           ,wk_12_avail
           ,wk_13_dt
           ,wk_13_budget
           ,wk_13_used
           ,wk_13_avail
           ,wk_14_dt
           ,wk_14_budget
           ,wk_14_used
           ,wk_14_avail
           ,wk_15_dt
           ,wk_15_budget
           ,wk_15_used
           ,wk_15_avail
           ,wk_16_dt
           ,wk_16_budget
           ,wk_16_used
           ,wk_16_avail
           ,wk_17_dt
           ,wk_17_budget
           ,wk_17_used
           ,wk_17_avail
           ,wk_18_dt
           ,wk_18_budget
           ,wk_18_used
           ,wk_18_avail
           ,wk_19_dt
           ,wk_19_budget
           ,wk_19_used
           ,wk_19_avail
           ,wk_20_dt
           ,wk_20_budget
           ,wk_20_used
           ,wk_20_avail
           ,wk_21_dt
           ,wk_21_budget
           ,wk_21_used
           ,wk_21_avail
           ,wk_22_dt
           ,wk_22_budget
           ,wk_22_used
           ,wk_22_avail
           ,wk_23_dt
           ,wk_23_budget
           ,wk_23_used
           ,wk_23_avail
           ,wk_24_dt
           ,wk_24_budget
           ,wk_24_used
           ,wk_24_avail
           ,wk_25_dt
           ,wk_25_budget
           ,wk_25_used
           ,wk_25_avail
           ,wk_26_dt
           ,wk_26_budget
           ,wk_26_used
           ,wk_26_avail )
		select 
			cpc_code
           ,level_03
           ,level_04
           ,wk_01_dt
           ,wk_01_budget
           ,wk_01_used
           ,wk_01_avail
           ,wk_02_dt
           ,wk_02_budget
           ,wk_02_used
           ,wk_02_avail
           ,wk_03_dt
           ,wk_03_budget
           ,wk_03_used
           ,wk_03_avail
           ,wk_04_dt
           ,wk_04_budget
           ,wk_04_used
           ,wk_04_avail
           ,wk_05_dt
           ,wk_05_budget
           ,wk_05_used
           ,wk_05_avail
           ,wk_06_dt
           ,wk_06_budget
           ,wk_06_used
           ,wk_06_avail
           ,wk_07_dt
           ,wk_07_budget
           ,wk_07_used
           ,wk_07_avail
           ,wk_08_dt
           ,wk_08_budget
           ,wk_08_used
           ,wk_08_avail
           ,wk_09_dt
           ,wk_09_budget
           ,wk_09_used
           ,wk_09_avail
           ,wk_10_dt
           ,wk_10_budget
           ,wk_10_used
           ,wk_10_avail
           ,wk_11_dt
           ,wk_11_budget
           ,wk_11_used
           ,wk_11_avail
           ,wk_12_dt
           ,wk_12_budget
           ,wk_12_used
           ,wk_12_avail
           ,wk_13_dt
           ,wk_13_budget
           ,wk_13_used
           ,wk_13_avail
           ,wk_14_dt
           ,wk_14_budget
           ,wk_14_used
           ,wk_14_avail           
           ,wk_15_dt
           ,wk_15_budget
           ,wk_15_used
           ,wk_15_avail
           ,wk_16_dt
           ,wk_16_budget
           ,wk_16_used
           ,wk_16_avail
           ,wk_17_dt
           ,wk_17_budget
           ,wk_17_used
           ,wk_17_avail
           ,wk_18_dt
           ,wk_18_budget
           ,wk_18_used
           ,wk_18_avail
           ,wk_19_dt
           ,wk_19_budget
           ,wk_19_used
           ,wk_19_avail           
           ,wk_20_dt
           ,wk_20_budget
           ,wk_20_used
           ,wk_20_avail
		   ,wk_21_dt
           ,wk_21_budget
           ,wk_21_used
           ,wk_21_avail
           ,wk_22_dt
           ,wk_22_budget
           ,wk_22_used
           ,wk_22_avail
           ,wk_23_dt
           ,wk_23_budget
           ,wk_23_used
           ,wk_23_avail
           ,wk_24_dt
           ,wk_24_budget
           ,wk_24_used
           ,wk_24_avail
           ,wk_25_dt
           ,wk_25_budget
           ,wk_25_used
           ,wk_25_avail
           ,wk_26_dt
           ,wk_26_budget
           ,wk_26_used
           ,wk_26_avail           
		from rpt.PRP_Actuals_Level_04_v
		
		set @Ins = @Ins + @@rowcount		
				
		-- DELETE EXISTING DATA
		truncate table dbo.PRP_Actuals_Level_03_snp
		
		set @Del = @Del + @@rowcount		
		
		-- INSERT PRP ACTUALS DATA		
		insert into dbo.PRP_Actuals_Level_03_snp(
			cpc_code
           ,level_03
           ,wk_01_dt
           ,wk_01_budget
           ,wk_01_used
           ,wk_01_avail
           ,wk_02_dt
           ,wk_02_budget
           ,wk_02_used
           ,wk_02_avail
           ,wk_03_dt
           ,wk_03_budget
           ,wk_03_used
           ,wk_03_avail
           ,wk_04_dt
           ,wk_04_budget
           ,wk_04_used
           ,wk_04_avail
           ,wk_05_dt
           ,wk_05_budget
           ,wk_05_used
           ,wk_05_avail
           ,wk_06_dt
           ,wk_06_budget
           ,wk_06_used
           ,wk_06_avail
           ,wk_07_dt
           ,wk_07_budget
           ,wk_07_used
           ,wk_07_avail
           ,wk_08_dt
           ,wk_08_budget
           ,wk_08_used
           ,wk_08_avail
           ,wk_09_dt
           ,wk_09_budget
           ,wk_09_used
           ,wk_09_avail
           ,wk_10_dt
           ,wk_10_budget
           ,wk_10_used
           ,wk_10_avail
           ,wk_11_dt
           ,wk_11_budget
           ,wk_11_used
           ,wk_11_avail
           ,wk_12_dt
           ,wk_12_budget
           ,wk_12_used
           ,wk_12_avail
           ,wk_13_dt
           ,wk_13_budget
           ,wk_13_used
           ,wk_13_avail
           ,wk_14_dt
           ,wk_14_budget
           ,wk_14_used
           ,wk_14_avail
           ,wk_15_dt
           ,wk_15_budget
           ,wk_15_used
           ,wk_15_avail
           ,wk_16_dt
           ,wk_16_budget
           ,wk_16_used
           ,wk_16_avail
           ,wk_17_dt
           ,wk_17_budget
           ,wk_17_used
           ,wk_17_avail
           ,wk_18_dt
           ,wk_18_budget
           ,wk_18_used
           ,wk_18_avail
           ,wk_19_dt
           ,wk_19_budget
           ,wk_19_used
           ,wk_19_avail
           ,wk_20_dt
           ,wk_20_budget
           ,wk_20_used
           ,wk_20_avail
           ,wk_21_dt
           ,wk_21_budget
           ,wk_21_used
           ,wk_21_avail
           ,wk_22_dt
           ,wk_22_budget
           ,wk_22_used
           ,wk_22_avail
           ,wk_23_dt
           ,wk_23_budget
           ,wk_23_used
           ,wk_23_avail
           ,wk_24_dt
           ,wk_24_budget
           ,wk_24_used
           ,wk_24_avail
           ,wk_25_dt
           ,wk_25_budget
           ,wk_25_used
           ,wk_25_avail
           ,wk_26_dt
           ,wk_26_budget
           ,wk_26_used
           ,wk_26_avail )
		select 
			cpc_code
           ,level_03
           ,wk_01_dt
           ,wk_01_budget
           ,wk_01_used
           ,wk_01_avail
           ,wk_02_dt
           ,wk_02_budget
           ,wk_02_used
           ,wk_02_avail
           ,wk_03_dt
           ,wk_03_budget
           ,wk_03_used
           ,wk_03_avail
           ,wk_04_dt
           ,wk_04_budget
           ,wk_04_used
           ,wk_04_avail
           ,wk_05_dt
           ,wk_05_budget
           ,wk_05_used
           ,wk_05_avail
           ,wk_06_dt
           ,wk_06_budget
           ,wk_06_used
           ,wk_06_avail
           ,wk_07_dt
           ,wk_07_budget
           ,wk_07_used
           ,wk_07_avail
           ,wk_08_dt
           ,wk_08_budget
           ,wk_08_used
           ,wk_08_avail
           ,wk_09_dt
           ,wk_09_budget
           ,wk_09_used
           ,wk_09_avail
           ,wk_10_dt
           ,wk_10_budget
           ,wk_10_used
           ,wk_10_avail
           ,wk_11_dt
           ,wk_11_budget
           ,wk_11_used
           ,wk_11_avail
           ,wk_12_dt
           ,wk_12_budget
           ,wk_12_used
           ,wk_12_avail
           ,wk_13_dt
           ,wk_13_budget
           ,wk_13_used
           ,wk_13_avail
           ,wk_14_dt
           ,wk_14_budget
           ,wk_14_used
           ,wk_14_avail           
           ,wk_15_dt
           ,wk_15_budget
           ,wk_15_used
           ,wk_15_avail
           ,wk_16_dt
           ,wk_16_budget
           ,wk_16_used
           ,wk_16_avail
           ,wk_17_dt
           ,wk_17_budget
           ,wk_17_used
           ,wk_17_avail
           ,wk_18_dt
           ,wk_18_budget
           ,wk_18_used
           ,wk_18_avail
           ,wk_19_dt
           ,wk_19_budget
           ,wk_19_used
           ,wk_19_avail           
           ,wk_20_dt
           ,wk_20_budget
           ,wk_20_used
           ,wk_20_avail
		   ,wk_21_dt
           ,wk_21_budget
           ,wk_21_used
           ,wk_21_avail
           ,wk_22_dt
           ,wk_22_budget
           ,wk_22_used
           ,wk_22_avail
           ,wk_23_dt
           ,wk_23_budget
           ,wk_23_used
           ,wk_23_avail
           ,wk_24_dt
           ,wk_24_budget
           ,wk_24_used
           ,wk_24_avail
           ,wk_25_dt
           ,wk_25_budget
           ,wk_25_used
           ,wk_25_avail
           ,wk_26_dt
           ,wk_26_budget
           ,wk_26_used
           ,wk_26_avail           
		from rpt.PRP_Actuals_Level_03_v
		
		set @Ins = @Ins + @@rowcount		

		-- DELETE EXISTING DATA
		truncate table dbo.PRP_Actuals_Level_02_snp
		
		set @Del = @Del + @@rowcount		
		
		-- INSERT PRP ACTUALS DATA		
		insert into dbo.PRP_Actuals_Level_02_snp(
			cpc_code
           ,wk_01_dt
           ,wk_01_budget
           ,wk_01_used
           ,wk_01_avail
           ,wk_02_dt
           ,wk_02_budget
           ,wk_02_used
           ,wk_02_avail
           ,wk_03_dt
           ,wk_03_budget
           ,wk_03_used
           ,wk_03_avail
           ,wk_04_dt
           ,wk_04_budget
           ,wk_04_used
           ,wk_04_avail
           ,wk_05_dt
           ,wk_05_budget
           ,wk_05_used
           ,wk_05_avail
           ,wk_06_dt
           ,wk_06_budget
           ,wk_06_used
           ,wk_06_avail
           ,wk_07_dt
           ,wk_07_budget
           ,wk_07_used
           ,wk_07_avail
           ,wk_08_dt
           ,wk_08_budget
           ,wk_08_used
           ,wk_08_avail
           ,wk_09_dt
           ,wk_09_budget
           ,wk_09_used
           ,wk_09_avail
           ,wk_10_dt
           ,wk_10_budget
           ,wk_10_used
           ,wk_10_avail
           ,wk_11_dt
           ,wk_11_budget
           ,wk_11_used
           ,wk_11_avail
           ,wk_12_dt
           ,wk_12_budget
           ,wk_12_used
           ,wk_12_avail
           ,wk_13_dt
           ,wk_13_budget
           ,wk_13_used
           ,wk_13_avail
           ,wk_14_dt
           ,wk_14_budget
           ,wk_14_used
           ,wk_14_avail
           ,wk_15_dt
           ,wk_15_budget
           ,wk_15_used
           ,wk_15_avail
           ,wk_16_dt
           ,wk_16_budget
           ,wk_16_used
           ,wk_16_avail
           ,wk_17_dt
           ,wk_17_budget
           ,wk_17_used
           ,wk_17_avail
           ,wk_18_dt
           ,wk_18_budget
           ,wk_18_used
           ,wk_18_avail
           ,wk_19_dt
           ,wk_19_budget
           ,wk_19_used
           ,wk_19_avail
           ,wk_20_dt
           ,wk_20_budget
           ,wk_20_used
           ,wk_20_avail
           ,wk_21_dt
           ,wk_21_budget
           ,wk_21_used
           ,wk_21_avail
           ,wk_22_dt
           ,wk_22_budget
           ,wk_22_used
           ,wk_22_avail
           ,wk_23_dt
           ,wk_23_budget
           ,wk_23_used
           ,wk_23_avail
           ,wk_24_dt
           ,wk_24_budget
           ,wk_24_used
           ,wk_24_avail
           ,wk_25_dt
           ,wk_25_budget
           ,wk_25_used
           ,wk_25_avail
           ,wk_26_dt
           ,wk_26_budget
           ,wk_26_used
           ,wk_26_avail )
		select 
			cpc_code
           ,wk_01_dt
           ,wk_01_budget
           ,wk_01_used
           ,wk_01_avail
           ,wk_02_dt
           ,wk_02_budget
           ,wk_02_used
           ,wk_02_avail
           ,wk_03_dt
           ,wk_03_budget
           ,wk_03_used
           ,wk_03_avail
           ,wk_04_dt
           ,wk_04_budget
           ,wk_04_used
           ,wk_04_avail
           ,wk_05_dt
           ,wk_05_budget
           ,wk_05_used
           ,wk_05_avail
           ,wk_06_dt
           ,wk_06_budget
           ,wk_06_used
           ,wk_06_avail
           ,wk_07_dt
           ,wk_07_budget
           ,wk_07_used
           ,wk_07_avail
           ,wk_08_dt
           ,wk_08_budget
           ,wk_08_used
           ,wk_08_avail
           ,wk_09_dt
           ,wk_09_budget
           ,wk_09_used
           ,wk_09_avail
           ,wk_10_dt
           ,wk_10_budget
           ,wk_10_used
           ,wk_10_avail
           ,wk_11_dt
           ,wk_11_budget
           ,wk_11_used
           ,wk_11_avail
           ,wk_12_dt
           ,wk_12_budget
           ,wk_12_used
           ,wk_12_avail
           ,wk_13_dt
           ,wk_13_budget
           ,wk_13_used
           ,wk_13_avail
           ,wk_14_dt
           ,wk_14_budget
           ,wk_14_used
           ,wk_14_avail           
           ,wk_15_dt
           ,wk_15_budget
           ,wk_15_used
           ,wk_15_avail
           ,wk_16_dt
           ,wk_16_budget
           ,wk_16_used
           ,wk_16_avail
           ,wk_17_dt
           ,wk_17_budget
           ,wk_17_used
           ,wk_17_avail
           ,wk_18_dt
           ,wk_18_budget
           ,wk_18_used
           ,wk_18_avail
           ,wk_19_dt
           ,wk_19_budget
           ,wk_19_used
           ,wk_19_avail           
           ,wk_20_dt
           ,wk_20_budget
           ,wk_20_used
           ,wk_20_avail
		   ,wk_21_dt
           ,wk_21_budget
           ,wk_21_used
           ,wk_21_avail
           ,wk_22_dt
           ,wk_22_budget
           ,wk_22_used
           ,wk_22_avail
           ,wk_23_dt
           ,wk_23_budget
           ,wk_23_used
           ,wk_23_avail
           ,wk_24_dt
           ,wk_24_budget
           ,wk_24_used
           ,wk_24_avail
           ,wk_25_dt
           ,wk_25_budget
           ,wk_25_used
           ,wk_25_avail
           ,wk_26_dt
           ,wk_26_budget
           ,wk_26_used
           ,wk_26_avail           
		from rpt.PRP_Actuals_Level_02_v
		
		set @Ins = @Ins + @@rowcount		
		
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**				   APP ATTRIBUTES CLEANUP
***********************************************************/
if object_id('dbo.ETL_App_Attributes_Cleanup_proc') is null
    exec( 'create procedure dbo.ETL_App_Attributes_Cleanup_proc as set nocount on;' )
go

alter procedure dbo.ETL_App_Attributes_Cleanup_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'App_Attribute_Hist', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
	
	begin try		
		-- SET TO COMPLETE WHERE PURSUED MATCHES HUB
		update data_xchg.App_Attribute_Hist
		set status = 'Complete'
		where App_Attribute_Hist_Key in (
			select p.app_attribute_hist_key
				from data_xchg.App_Attribute_Pending_v p
				inner join ( select a.applicant_id, ph.attribute_value, a.attrib_pursued_by_val, a.attrib_contacted_val, a.active_flag from dbo.Volunteer_Pursuit_Hist_Curr_v ph
					inner join dbo.volunteer_app_v a on ph.volunteer_key = a.volunteer_key ) x on p.applicant_Id = x.applicant_id
				where app_status_code not in ('PNDC','PNDE') and x.attribute_value = x.attrib_pursued_by_val )
		
		set @Upd = @Upd + @@rowcount
		
		-- MULTIPLE ACTIVE PURSUIT HISTORY FOR A VOLUNTEER
		delete
		from dbo.volunteer_pursuit_hist
		where volunteer_pursuit_hist_key in ( select min( volunteer_pursuit_hist_key ) as min_key from dbo.Volunteer_Pursuit_Hist where active_flag = 'Y' group by volunteer_key having count(*) > 1 )

		set @Del = @Del + @@rowcount
		
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**				   BAD DATA CLEANUP
***********************************************************/
if object_id('dbo.ETL_Bad_Data_Cleanup_proc') is null
    exec( 'create procedure dbo.ETL_Bad_Data_Cleanup_proc as set nocount on;' )
go

alter procedure dbo.ETL_Bad_Data_Cleanup_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Bad Data Cleanup', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
	
	begin try		
		-- ORPHANED WORK ASSIGNMENTS
		update volunteer_dept set end_date = getdate(), active_flag = 'N' where volunteer_dept_key in ( select volunteer_dept_key from dbo.Volunteer_Dept_Orphaned_Records_v )
		
		set @Upd = @Upd + @@rowcount
		
		-- ORPHANED ENROLLMENTS
		delete from volunteer_enrollment where volunteer_enrollment_key in ( select volunteer_enrollment_key from dbo.Volunteer_enrollment_Orphaned_Records_v )
		
		set @Del = @Del + @@rowcount
		
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go


/***********************************************************
**				   REPORTING SNAPSHOTS
***********************************************************/
if object_id('dbo.ETL_Reporting_Snapshots_proc') is null
    exec( 'create procedure dbo.ETL_Reporting_Snapshots_proc as set nocount on;' )
go

alter procedure dbo.ETL_Reporting_Snapshots_proc
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Volunteer V Snapshot', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
	
	begin try		
	
		-- DELETE EXISTING DATA
		truncate table dbo.Volunteer_v_snp
		
		set @Del = @Del + @@rowcount	
		
		-- INSERT NEW DATA		
		insert into dbo.Volunteer_v_snp(
			 volunteer_key
			,hub_volunteer_num
			,hub_person_id
			,hub_person_guid
			,ba_volunteer_num
			,first_name
			,last_name
			,volunteer_name
			,volunteer_name_short
			,gender_code
			,marital_status_code
			,cong_servant_code
			,cong_midweek_mt_dow
			,cong_midweek_mt_time
			,cong_weekend_mt_dow
			,cong_weekend_mt_time
			,age
			,address
			,city
			,state_code
			,postal_code
			,home_phone
			,mobile_phone
			,bethel_email
			,jwpub_email
			,personal_email
			,spouse_hub_person_id
			,spouse_hub_volunteer_num
			,spouse_bethel_email
			,spouse_jwpub_email		
			,enrollment_1_code
			,enrollment_1_site_code
			,enrollment_1_start_date
			,enrollment_1_start_date_raw
			,enrollment_1_end_date
			,enrollment_2_code
			,enrollment_2_site_code
			,enrollment_2_start_date
			,enrollment_2_start_date_raw
			,enrollment_2_end_date
			,dept_1_hpr_dept_key
			,dept_1_hub_dept_id
			,dept_1_cpc_code
			,dept_1_parent_dept_name
			,dept_1_dept_name
			,dept_1_ovsr_name
			,dept_1_start_date
			,dept_1_end_date
			,dept_1_temp_flag
			,dept_1_primary_flag
			,dept_1_split_asgn_flag
			,dept_1_split_allocation_pct
			,dept_1_hpr_flag
			,dept_1_pc_category
			,dept_1_mon_flag
			,dept_1_tue_flag
			,dept_1_wed_flag
			,dept_1_thu_flag
			,dept_1_fri_flag
			,dept_1_sat_flag
			,dept_1_sun_flag
			,dept_2_hpr_dept_key
			,dept_2_hub_dept_id
			,dept_2_cpc_code
			,dept_2_parent_dept_name
			,dept_2_dept_name
			,dept_2_ovsr_name
			,dept_2_start_date
			,dept_2_end_date
			,dept_2_temp_flag
			,dept_2_primary_flag
			,dept_2_split_asgn_flag
			,dept_2_split_allocation_pct
			,dept_2_hpr_flag
			,dept_2_pc_category
			,dept_2_mon_flag
			,dept_2_tue_flag
			,dept_2_wed_flag
			,dept_2_thu_flag
			,dept_2_fri_flag
			,dept_2_sat_flag
			,dept_2_sun_flag
			,loan_dept_name
			,tentative_end_date
			,room_site_code
			,room_bldg
			,room_bldg_code
			,room_bldg_desc
			,room
			,staffing_number_exception_flag
			,record_type )		
		select
			 volunteer_key
			,hub_volunteer_num
			,hub_person_id
			,hub_person_guid
			,ba_volunteer_num
			,first_name
			,last_name
			,volunteer_name
			,volunteer_name_short
			,gender_code
			,marital_status_code
			,cong_servant_code
			,cong_midweek_mt_dow
			,cong_midweek_mt_time
			,cong_weekend_mt_dow
			,cong_weekend_mt_time
			,age
			,address
			,city
			,state_code
			,postal_code
			,home_phone
			,mobile_phone
			,bethel_email
			,jwpub_email
			,personal_email
			,spouse_hub_person_id
			,spouse_hub_volunteer_num
			,spouse_bethel_email
			,spouse_jwpub_email		
			,enrollment_1_code
			,enrollment_1_site_code
			,enrollment_1_start_date
			,enrollment_1_start_date_raw
			,enrollment_1_end_date
			,enrollment_2_code
			,enrollment_2_site_code
			,enrollment_2_start_date
			,enrollment_2_start_date_raw
			,enrollment_2_end_date
			,dept_1_hpr_dept_key
			,dept_1_hub_dept_id
			,dept_1_cpc_code
			,dept_1_parent_dept_name
			,dept_1_dept_name
			,dept_1_ovsr_name
			,dept_1_start_date
			,dept_1_end_date
			,dept_1_temp_flag
			,dept_1_primary_flag
			,dept_1_split_asgn_flag
			,dept_1_split_allocation_pct
			,dept_1_hpr_flag
			,dept_1_pc_category
			,dept_1_mon_flag
			,dept_1_tue_flag
			,dept_1_wed_flag
			,dept_1_thu_flag
			,dept_1_fri_flag
			,dept_1_sat_flag
			,dept_1_sun_flag
			,dept_2_hpr_dept_key
			,dept_2_hub_dept_id
			,dept_2_cpc_code
			,dept_2_parent_dept_name
			,dept_2_dept_name
			,dept_2_ovsr_name
			,dept_2_start_date
			,dept_2_end_date
			,dept_2_temp_flag
			,dept_2_primary_flag
			,dept_2_split_asgn_flag
			,dept_2_split_allocation_pct
			,dept_2_hpr_flag
			,dept_2_pc_category
			,dept_2_mon_flag
			,dept_2_tue_flag
			,dept_2_wed_flag
			,dept_2_thu_flag
			,dept_2_fri_flag
			,dept_2_sat_flag
			,dept_2_sun_flag
			,loan_dept_name
			,tentative_end_date
			,room_site_code
			,room_bldg
			,room_bldg_code
			,room_bldg_desc
			,room
			,staffing_number_exception_flag
			,record_type	
		from rpt.Volunteer_v

		set @Ins = @Ins+ @@rowcount	
		
		set @End = getdate()

		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch		
end
go



/***********************************************************
**				   DEPT ASGN STATUS UDPATE
***********************************************************/
if object_id('dbo.ETL_Status_Update_Process') is null
    exec( 'create procedure dbo.ETL_Status_Update_Process as set nocount on;' )
go

alter procedure dbo.ETL_Status_Update_Process
as
begin
	set nocount on
	
	declare 
		@Table nvarchar(150) = 'Dept Asgn Status', 
		@Ins integer = 0,
		@Upd integer = 0,
		@Del integer = 0,
		@Start datetime = getdate(), 
		@End datetime
		
	begin try		
		--Backup Dept_Asgn table
		INSERT INTO rvd.arch.Dept_Asgn
		SELECT *, cast(getdate() as date) FROM rvd.dbo.Dept_Asgn

		set @Ins = @Ins + @@rowcount	

		--Step 1 - NEW RECORDS:  Insert new requests showing in HuB into Dept_Asgn table
		insert into dbo.dept_asgn(
			hpr_dept_key
           ,hpr_crew_key
           ,hpr_dept_role_key
           ,enrollment_key
           ,skill_level
           ,dept_start_date
           ,dept_end_date
           ,dept_first_name
           ,dept_last_name
           ,dept_asgn_status_key
           ,vtc_meeting_code
           ,volunteer_key
           ,active_flag
           ,load_date
           ,update_date
           ,priority_key
           ,test_data_flag
           ,update_source
           ,update_type
           ,updatedate_source
           ,update_reviewedbyuser
           ,extension_flag
           ,extension_flag_updatedate )
		select 
			 coalesce( dept_1_hpr_dept_key, dept_2_hpr_dept_key )	as hpr_dept_key
			,0														as hpr_crew_key -- Set to 'Unassigned'
			,case coalesce( d.cpc_code, d2.cpc_code )
				when 'CI' then 76
				when 'DD' then 77
				when 'PCC' then 78
				when 'CO' then 79
				when 'PS' then 54
				else 95 -- VD
			 end													as hpr_dept_role_key  -- Set to 'Volunteer' based on CPC_Code
			,( select Enrollment_Key from dbo.Enrollment 
			   where enrollment_code = vr.enrollment_1_code 
					and Active_Flag = 'Y' )							as enrollment_key
			,7														as skill_level -- Set to 'Not Assessed'
			,dept_1_start_date										as dept_start_date
			,dept_1_end_date										as dept_end_date
			,vr.first_name											as dept_first_name
			,vr.last_name											as dept_last_name
			,case 
				when dept_1_start_date > cast( getdate() as date )  
					then ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'APPROVED' ) -- FUTURE START
				when dept_1_start_date <= cast( getdate() as date ) and isnull( dept_1_end_date, '12/31/9999' ) >= cast( getdate() as date )
					then ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'ARRIVED' ) -- START IN PAST AND END IS NULL OR IN FUTURE
				when dept_1_end_date < cast( getdate() as date ) 
					then (select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'DEPARTED' ) -- END IN PAST
				else ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'NEEDS HANDLING' )
			 end													as dept_asgn_status_key  
			,'N'													as vtc_meeting_code
			,vr.volunteer_key
			,'Y'													as active_flag
			,cast( getdate() as date )								as load_date
			,cast( getdate() as date )								as update_date
			,3														as priority_key -- set to 'normal'
			,'N'													as Test_Data_Flag
			,'HuB'													as Update_Source -- Indicate record added from HuB
			,'New Record'											as Update_type -- Indicates update type
			,cast( getdate() as date )								as UpdateDate_Source  -- Indicate date record added from HuB
			,'N'													as Update_ReviewedByUser
			,'N'													as Extension_Flag
			,cast( getdate() as date )								as Extension_Flag_UpdateDate
		FROM rpt.Volunteer_Rpt_v VR
		left outer join dbo.HPR_Dept D 
			on D.HPR_Dept_Key = VR.dept_1_hpr_dept_key
		left outer join dbo.HPR_Dept D2 
			on D2.HPR_Dept_Key = VR.dept_2_hpr_dept_key
		left outer join 
			( select da.volunteer_key, da.Enrollment_Key 
			  from dbo.Dept_Asgn da 
			  where Active_Flag = 'Y' and isnull( volunteer_key, 99999999 ) <> 99999999 ) A
			on a.Volunteer_Key = vr.volunteer_key 
			and a.Enrollment_Key = ( select Enrollment_Key from dbo.Enrollment where enrollment_code = VR.enrollment_1_code and Active_Flag = 'Y' )
		where isnull( a.volunteer_key, 999999999 ) = 999999999 -- DOES NOT EXIST IN DEPT ASGN
			and not ( isnull( dept_1_hpr_dept_key, 999999999 ) = 999999999 -- AT LEAST 1 VALID DEPT KEY
				  and isnull( dept_2_hpr_dept_key, 999999999 ) = 999999999 )

		set @Ins = @Ins + @@rowcount	

		--Step 2 - UPDATE DATES:  Sync Dept_Asgn Dept start/end date to Hub start/end dates where records are currently active or have a future date and extension_flag is 'N'
		--			Note:  Duplicate records (active records with same volunteer and enrollment) are being excluded from this check
		update dbo.dept_asgn
		set dept_start_date = vr.dept_1_start_date, 
			dept_end_date = coalesce( vr.enrollment_1_end_date, vr.dept_1_end_date ),
			update_source = 'HuB',
			update_type = 'Date Change', 
			updatedate_source = cast( getdate() as date ), 
			update_reviewedbyuser = 'N', 
			update_date = cast( getdate() as date )
		--select vr.volunteer_name, vr.volunteer_key, da.Volunteer_Key, vr.dept_1_start_date, vr.dept_1_end_date, vr.enrollment_1_end_date, da.Dept_Start_Date, da.Dept_End_Date, vr.enrollment_1_code, da.Enrollment_Key
		from rpt.volunteer_rpt_v vr
		inner join dbo.dept_asgn da 
			on da.volunteer_key = vr.volunteer_key 
			and da.enrollment_key = ( select enrollment_Key from dbo.Enrollment where enrollment_code = VR.enrollment_1_code and Active_Flag = 'Y' )
		left outer join 		
			( select da.volunteer_key as VolKey_Dup, da.enrollment_key as EnrKey_Dup
			  from dbo.Dept_Asgn_v da 
			  where Volunteer_Key is not null 
				and enrollment_key is not null 
				and active_flag = 'Y'
			  group by da.volunteer_key, da.Full_Name, da.enrollment_key, da.dept_enrollment_code 
			  having count(*)>1 ) Dup 
			on da.Volunteer_Key = dup.VolKey_Dup 
			and da.Enrollment_Key = dup.EnrKey_Dup
		where 1=1
			--and vr.volunteer_key = 482220
			and (
				   ( coalesce( vr.enrollment_1_end_date, vr.dept_1_end_date, '1/1/1901' ) > cast( getdate() as date ) -- FUTURE END
				or ( coalesce( vr.enrollment_1_end_date, vr.dept_1_end_date, '1/1/1901' ) = '1/1/1901' ) )  -- NO END DATE
				or vr.dept_1_start_date >= cast( getdate() as date ) -- FUTURE START
				) 
			and da.Active_Flag = 'Y'
			and ( 
				   da.dept_Start_Date <> VR.dept_1_start_date -- DIFFERENT START 
				or coalesce( vr.enrollment_1_end_date, vr.dept_1_end_date, '1/1/1901' ) <> isnull( da.dept_End_Date, '1/1/1901' ) -- DIFFERENT END
				) 
			and da.extension_flag = 'N' -- NOT EXTENSION
			and VolKey_Dup is null		-- NOT A DUP
			and not (  -- NOT NULL END DATE AND START BEFORE END
				(     ISNULL( da.dept_End_Date, '1/1/1901' ) <> '1/1/1901' 
				  and VR.dept_1_start_date > ISNULL( da.dept_End_Date, '1/1/1901' ) )
				)
			and coalesce( vr.enrollment_1_end_date, vr.dept_1_end_date, '12/31/9999' ) > vr.dept_1_start_date -- END AFTER START

		set @Upd = @Upd + @@rowcount

		--Step 2b - UPDATE DATES (EXTENSION START DATE):  Sync Dept_Asgn Dept start date to Hub end dates where Hub end date is greater than todays date and extension_flag is 'Y'
		update dbo.dept_asgn
		set ext_last_start_Date = VR.dept_1_start_date,
			update_source = 'HuB',
			update_type = 'Date Change-Ext',
			updatedate_source = cast( getdate() as date ),
			update_reviewedByUser = 'N', 
			update_date = cast( getdate() as date )
		--select vr.dept_1_start_date, VR.dept_1_start_date, Ext_Last_Start_Date, extension_flag
		from rpt.volunteer_rpt_v vr 
		inner join dbo.dept_asgn da 
			on da.volunteer_key = vr.volunteer_key 
			and da.enrollment_key = ( select enrollment_key from dbo.enrollment where enrollment_code = vr.enrollment_1_code and active_flag = 'Y' )
		where vr.dept_1_start_date > cast( getdate() as date ) -- START IN FUTURE
			and da.active_flag = 'Y'
			and ( isnull( Ext_Last_Start_Date, '1/1/1901' ) <> isnull( VR.dept_1_start_date, '1/1/1901' ) ) -- PRIOR START NOT CURRENT START
			and da.extension_flag = 'Y'

		set @Upd = @Upd + @@rowcount

		--Step 3 - STATUS UPATE (SUBMITTED TO APPROVED) - Update Dept_Asgn STATUS to APPROVED where status is Submitted and has a future start date
		update dbo.dept_asgn
		set dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'APPROVED' ),
			Update_Source = 'HuB',
			Update_Type = 'Status to APPROVED', 
			UpdateDate_Source = cast( getdate() as date ), 
			Update_ReviewedByUser = 'N', 
			Update_Date = cast( getdate() as date )
		--select *
		from dbo.dept_asgn da 
		left outer join rpt.volunteer_rpt_v h 
			on h.volunteer_key = da.volunteer_key 
			and ( select enrollment_key from dbo.enrollment where enrollment_code = h.enrollment_1_code and active_flag = 'Y' ) = da.enrollment_key
		where dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'SUBMITTED' ) -- SUBMITTED STATUS
			and dept_start_date > cast( getdate() as date ) -- START IN FUTURE
			and da.extension_flag = 'N' 
			and isnull( h.volunteer_key, 999999999 ) <> 999999999 -- VOLUNTEER IN HUB

		set @Upd = @Upd + @@rowcount

		--Step 3b - STATUS UPATE (SUBMITTED TO APPROVED) FOR EXTENSIONS - Update Dept_Asgn STATUS to APPROVED where status is Submitted and has a future start date
		update dbo.dept_asgn
		set dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'APPROVED' ),
			Update_Source = 'HuB',
			Update_Type = 'Status to APPROVED', 
			UpdateDate_Source = cast( getdate() as date ), 
			Update_ReviewedByUser = 'N', 
			Update_Date = cast( getdate() as date )
		--select *
		from dbo.dept_asgn da 
		left outer join rpt.volunteer_rpt_v h 
			on h.volunteer_key = da.volunteer_key 
			and ( select enrollment_key from dbo.enrollment where enrollment_code = h.enrollment_1_code and active_flag = 'Y' ) = da.enrollment_key
		where dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'SUBMITTED' ) -- SUBMITTED STATUS
			and ext_last_start_date > cast( getdate() as date ) -- START IN FUTURE
			and da.extension_flag = 'Y' 
			and isnull( h.volunteer_key, 999999999 ) <> 999999999 -- VOLUNTEER IN HUB

		set @Upd = @Upd + @@rowcount	
		
		--Step 4 - STATUS UPATE (APPROVED TO ARRIVED) - Update Dept_Asgn STATUS to ARRIVED where status is Approved and has a start date equals or after to today's date
		update dbo.dept_asgn
		set dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'ARRIVED' ),
			Update_Source = 'HuB',
			Update_Type = 'Status to ARRIVED',
			UpdateDate_Source = cast( getdate() as date ),
			Update_ReviewedByUser = 'N', 
			Update_Date = cast( getdate() as date ),
			Ext_Orig_PS_End_Date = null, 
			Ext_Orig_Enrollment_Key = null, 
			Ext_Orig_Dept_Asgn_Status_Key = null, 
			Extension_Flag_UpdateDate = cast( getdate() as date )
		--select *
		from dbo.dept_asgn 
		where dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'APPROVED' )
			and dept_start_date <= cast( getdate() as date ) 
			and extension_flag = 'N'

		set @Upd = @Upd + @@rowcount

		--Step 4b - STATUS UPATE (APPROVED TO ARRIVED) FOR EXTENSIONS - Update Dept_Asgn STATUS to ARRIVED where status is Approved and has a extension start date equals or after today's date
		update dbo.dept_asgn
		set dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'ARRIVED' ),
			Update_Source = 'HuB',
			Update_Type = 'Status to ARRIVED-Ext',
			UpdateDate_Source = cast( getdate() as date ),
			Update_ReviewedByUser = 'N',
			Update_Date = cast( getdate() as date ),
			Ext_Orig_PS_End_Date = null,
			Ext_Orig_Enrollment_Key = null, 
			Ext_Orig_Dept_Asgn_Status_Key = null, 
			Extension_Flag = 'N', 
			Extension_Flag_UpdateDate = cast( getdate() as date )
		--select *
		from dbo.dept_asgn
		where dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'APPROVED' )
			and ext_last_start_date <= cast( getdate() as date ) 			
			and extension_flag = 'Y'
			
		set @Upd = @Upd + @@rowcount

		--Step 5 - STATUS UPATE (ARRIVED TO DEPARTED) - Update Dept_Asgn STATUS to DEPARTED where status is Arrived and end date has passed
		update dbo.dept_asgn
		set dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'DEPARTED' ),
			Update_Source = 'HuB',
			Update_Type = 'Status to DEPARTED',
			UpdateDate_Source = cast( getdate() as date ), 
			Update_ReviewedByUser = 'N', 
			Update_Date = cast( getdate() as date )
		--select volunteer_Key, dept_start_date, dept_end_date, enrollment_key
		from dbo.dept_asgn
		where dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'ARRIVED' )
			and dept_end_date < cast( getdate() as date )

		set @Upd = @Upd + @@rowcount

		--Step 6 - STATUS UPATE (CHANGE TO NEEDS HANDLING) - Update Dept_Asgn_Status_Key to 'Needs Handling' where status is Approved and no future record exists in the Volunteer_Enrollment table
		update dbo.dept_asgn
		set dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'NEEDS HANDLING'),
			Update_Source = 'HuB',
			Update_Type = 'Status to NEEDS HANDLING - No future record', 
			UpdateDate_Source = cast( getdate() as date ),
			Update_ReviewedByUser = 'N', 
			Update_Date = cast( getdate() as date )
		--select da.Dept_Start_Date, da.dept_asgn_status_key, *
		from dbo.dept_asgn da
		left outer join -- FUTURE DEPT START DATE
			( select volunteer_key, enrollment_1_code 
			  from rpt.volunteer_rpt_v
			  where dept_1_start_date >= cast( getdate() as date ) ) a 
			on a.volunteer_key = da.volunteer_key 
			and da.enrollment_key = ( select enrollment_key from dbo.enrollment where enrollment_code = a.enrollment_1_code and active_flag = 'Y' )
		left outer join -- FUTURE ENROLLMENT 2 START DATE
			( select volunteer_key, enrollment_2_code 
			  from rpt.volunteer_rpt_v 
			  where enrollment_2_start_date >= cast( getdate() as date ) ) b
			on b.volunteer_key = da.volunteer_key 
			and da.enrollment_key = ( select enrollment_key from dbo.enrollment where enrollment_code = b.enrollment_2_code and active_flag = 'Y' )
		where isnull( a.volunteer_key, 999999999 ) = 999999999		-- NO FUTURE DEPT START DATE
			and isnull( b.volunteer_key, 999999999 ) = 999999999	-- NO FUTURE ENRL 2 START DATE
			and da.active_flag = 'Y' 
			and da.dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'APPROVED' )

		set @Upd = @Upd + @@rowcount

		--Step 7 - STATUS UPATE (CHANGE TO NEEDS HANDLING) - Update Dept_Asgn_Status_Key to 'Needs Handling' where status is ARRIVED and no volunteer is assigned
		update dbo.dept_asgn
		set dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'NEEDS HANDLING' ),
			Update_Source = 'HuB',
			Update_Type = 'Status to NEEDS HANDLING - Arrived no volunteer',
			UpdateDate_Source = cast( getdate() as date ), 
			Update_ReviewedByUser = 'N', 
			Update_Date = cast( getdate() as date )
		--select *
		from dbo.dept_asgn
		where isnull( volunteer_key, 999999999 ) = 999999999 -- NO VOLUNTEER KEY
			and active_flag = 'Y' 
			and dept_asgn_status_key = ( select dept_asgn_status_key from dbo.dept_asgn_status where dept_asgn_status_code = 'ARRIVED' )

		set @Upd = @Upd + @@rowcount
		
		set @End = getdate()		
	
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End
	end try
		
	begin catch
		execute dbo.ETL_Table_Run_proc
			@Table_Name = @Table,
			@Rows_Inserted = @Ins,
			@Rows_Updated = @Upd,
			@Rows_Deleted = @Del,
			@Start_Time = @Start,
			@End_Time = @End,
			@Status_Code = 'F'
	end catch
end
go


/***********************************************************
**					PARENT - DATA TABLES
***********************************************************/
if object_id('dbo.ETL_data_proc') is null
    exec( 'create procedure dbo.ETL_data_proc as set nocount on;' )
go

alter procedure dbo.ETL_data_proc
as
begin
	exec dbo.ETL_BA_Event_Volunteer_Invite_proc
	exec dbo.ETL_BA_Project_Group_Volunteer_proc
	exec dbo.ETL_BA_Project_Volunteer_proc
	exec dbo.ETL_BA_Project_Volunteer_Attendance_proc
	exec dbo.ETL_Volunteer_proc
	exec dbo.ETL_Volunteer_App_proc
	exec dbo.ETL_Volunteer_App_Collection_proc
	exec dbo.ETL_Volunteer_Approval_Level_Hist_proc
	exec dbo.ETL_Volunteer_Availability_proc
	exec dbo.ETL_Volunteer_Dept_proc
	exec dbo.ETL_Volunteer_Dept_Rpt_Proc
	exec dbo.ETL_Volunteer_Enrollment_proc
	exec dbo.ETL_Volunteer_Enrollment_Rpt_proc	
	exec dbo.ETL_Volunteer_FTS_proc
	exec dbo.ETL_Volunteer_Role_proc
	exec dbo.ETL_Volunteer_Rooming_Hist_proc
	exec dbo.ETL_Volunteer_Search_proc
	exec dbo.ETL_Volunteer_Skill_proc
	exec dbo.ETL_Volunteer_Training_proc
	exec dbo.ETL_RVD_Banner_proc
	exec dbo.ETL_PRP_Data_proc
	exec dbo.ETL_App_Attributes_Cleanup_proc
	exec dbo.ETL_Bad_Data_Cleanup_proc
	exec dbo.ETL_Status_Update_Process
	exec dbo.ETL_Reporting_Snapshots_proc
end
go
