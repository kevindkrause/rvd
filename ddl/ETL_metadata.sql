use rvdrehearsal
go

if object_id('dbo.ETL_Table_Run_proc') is null
    exec( 'create procedure dbo.ETL_Table_Run_proc as set nocount on;' )
go

alter procedure dbo.ETL_Table_Run_proc
	@Table_Name nvarchar(150),
	@Rows_Inserted integer,
	@Rows_Updated integer,
	@Rows_Deleted integer,
	@Start_Time datetime,
	@End_Time datetime,
	@Status_Code nvarchar(1) = 'S'
as
begin
	set nocount on

    insert into dbo.ETL_Table_Run( ETL_Table, Status_Code, Rows_Inserted, Rows_Updated, Rows_Deleted, Start_Time, End_Time ) 
    values( @Table_Name, @Status_Code, @Rows_Inserted, @Rows_Updated, @Rows_Deleted, @Start_Time, @End_Time )
end
go
