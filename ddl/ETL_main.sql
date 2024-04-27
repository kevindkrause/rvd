use rvdrehearsal
go

/***********************************************************
**				MAIN CALLING PROCEDURE
***********************************************************/
if object_id('dbo.ETL_main_proc') is null
    exec( 'create procedure dbo.ETL_main_proc as set nocount on;' )
go

alter procedure dbo.ETL_main_proc
as
begin
	set nocount on
	
	declare 
		@RVD_HUB_dt	date, 
		@RVD_BA_dt 	date, 
		@HUB_dt 	date,
		@BA_dt 		date
		
	begin try
		set @RVD_HUB_dt = ( select cast( attribute_value as date ) from dbo.App_Metadata where attribute_name = 'HUB_Update_Date' and active_flag = 'Y' )	
		set @RVD_BA_dt = ( select cast( attribute_value as date ) from dbo.App_Metadata where attribute_name = 'BA_Update_Date' and active_flag = 'Y' )
		
		set @HUB_dt = ( select min( load_date ) from stg.stg_person )
		set @BA_dt = ( select BA_Load_Status_Date from stg.stg_ba_load_status )
	
	if ( @HUB_dt is not null and @HUB_dt > @RVD_HUB_dt ) or ( @BA_dt is not null and @BA_dt > @RVD_BA_dt )
		begin
			exec dbo.ETL_lkp_proc
			exec dbo.ETL_data_proc

			update dbo.App_Metadata
			set attribute_value = convert( varchar, @HUB_dt, 101 )
			where attribute_name = 'HUB_Update_Date' 
				and active_flag = 'Y'
				
			update dbo.App_Metadata
			set attribute_value = convert( varchar, @BA_dt, 101 )
			where attribute_name = 'BA_Update_Date' 
				and active_flag = 'Y'
		end 
		
		exec dbo.Data_Validation_proc
		
		exec dbo.Pursued_By_New_Apps_proc
		exec dbo.Contacted_New_Apps_proc		
	end try
	
	begin catch
		-- DO SOMETHING HERE
	end catch
	
end
go