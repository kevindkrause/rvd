use rvd
go

if object_id('stg.stg_foreign_branches', 'U') is not
	drop table stg.stg_foreign_branches
go  
create table stg.stg_foreign_branches(
	person_id 								float,
	bethel_member_id 						float,
	volunteer_id 							float,
	spouse_person_id 						float,
	last_name 								nvarchar(255),
	first_name 								nvarchar(255),
	middle_name 							nvarchar(255),
	birth_date 								date,
	baptism_date 							date,
	marital_status 							nvarchar(255),
	race 									nvarchar(255),
	gender 									nvrchar(255),
	cellular_phone 							nvarchar(255),
	jw_email 								nvarchar(255),
	internal_email 							nvarchar(255),
	external_email 							nvarchar(255),
	hub_dept_id								integer,
	parent_department_name					nvarchar(255),
	department_name 						nvarchar(255),
	department_site 						nvarchar(255),
	department_start_date 					date,
	enrollment_code 						nvarchar(255),
	enrollment_start_date 					date,
	enrollment_end_date 					nvarchar(255),
	branch_of_record 						nvarchar(255),
	correspondencerecipientrecordid			float,
	correspondencerecipiententitytypenumber	float,
	volunteer_number 						float
) on primary
go


if object_id('stg.stg_hpr_dept_v', 'V') is not null
	drop view stg.stg_hpr_dept_v
go 
create view stg.stg_hpr_dept_v
as
with cte_org as (
    select       
         departmentid as dept_id
        ,departmentname as dept_name
        ,overseerpersonid as ovsr_person_id
		,assistantoverseerpersonid as asst_person_id
		,cast( null as nvarchar(255) ) as parent
		,0 as hier_level
		,cast( departmentname as varchar(max) ) as hier_lineage
    from stg.stg_hpr_dept
    where parentdepartmentid is null

    union all

    select 
         d.departmentid
        ,d.departmentname
        ,d.overseerpersonid
		,d.assistantoverseerpersonid
		,cast( o.dept_name as nvarchar(255) ) as parent
        ,hier_level + 1 as org_level
        ,cast( o.hier_lineage + '>' + d.departmentname as varchar(max) ) as hier_lineage
    from stg.stg_hpr_dept d
    inner join cte_org o 
		on o.dept_id = d.parentdepartmentid
)

select 
	 dept_id
	,dept_name
	,parent
	,hier_level
	,hier_lineage
	,[1] as level_01
	,[2] as level_02
	,[3] as level_03
	,[4] as level_04
	,[5] as level_05
	,[6] as level_06
	,[7] as level_07
	,[8] as level_08
	,[9] as level_09
	,[10] as level_10
from (
	select 
		 dept_id
		,dept_name
		,parent
		,hier_level
		,hier_lineage
		,f.val
		,row_number() over( partition by dept_id order by hier_level desc ) as seq
	from cte_org o
	cross apply dbo.parse_values( o.hier_lineage, '>' ) as f ) x
	pivot( max( val ) for seq in ( [1], [2], [3], [4], [5], [6], [7], [8], [9], [10] ) ) p
go



if object_id('stg.stg_prp_bed_space_v', 'V') is not null
	drop view stg.stg_prp_bed_space_v
go 
create view stg.stg_prp_bed_space_v
as
select
	 department as rooming_category
	,teamtrade as rooming_detail
	,coalesce( [Jan-20], 0 ) as jan_20
	,coalesce( [Feb-20], 0 ) as feb_20
	,coalesce( [Mar-20], 0 ) as mar_20
	,coalesce( [Apr-20], 0 ) as apr_20
	,coalesce( [May-20], 0 ) as may_20
	,coalesce( [Jun-20], 0 ) as jun_20
	,coalesce( [Jul-20], 0 ) as jul_20
	,coalesce( [Aug-20], 0 ) as aug_20
	,coalesce( [Sep-20], 0 ) as sep_20
	,coalesce( [Oct-20], 0 ) as oct_20
	,coalesce( [Nov-20], 0 ) as nov_20
	,coalesce( [Dec-20], 0 ) as dec_20
	,coalesce( [Jan-21], 0 ) as jan_21
	,coalesce( [Feb-21], 0 ) as feb_21
	,coalesce( [Mar-21], 0 ) as mar_21
	,coalesce( [Apr-21], 0 ) as apr_21
	,coalesce( [May-21], 0 ) as may_21
	,coalesce( [Jun-21], 0 ) as jun_21
	,coalesce( [Jul-21], 0 ) as jul_21
	,coalesce( [Aug-21], 0 ) as aug_21
	,coalesce( [Sep-21], 0 ) as sep_21
	,coalesce( [Oct-21], 0 ) as oct_21
	,coalesce( [Nov-21], 0 ) as nov_21
	,coalesce( [Dec-21], 0 ) as dec_21
	,coalesce( [Jan-22], 0 ) as jan_22
	,coalesce( [Feb-22], 0 ) as feb_22
	,coalesce( [Mar-22], 0 ) as mar_22
	,coalesce( [Apr-22], 0 ) as apr_22
	,coalesce( [May-22], 0 ) as may_22
	,coalesce( [Jun-22], 0 ) as jun_22
	,coalesce( [Jul-22], 0 ) as jul_22
	,coalesce( [Aug-22], 0 ) as aug_22
	,coalesce( [Sep-22], 0 ) as sep_22
	,coalesce( [Oct-22], 0 ) as oct_22
	,coalesce( [Nov-22], 0 ) as nov_22
	,coalesce( [Dec-22], 0 ) as dec_22
	,coalesce( [Jan-23], 0 ) as jan_23
	,coalesce( [Feb-23], 0 ) as feb_23
	,coalesce( [Mar-23], 0 ) as mar_23
	,coalesce( [Apr-23], 0 ) as apr_23
	,coalesce( [May-23], 0 ) as may_23
	,coalesce( [Jun-23], 0 ) as jun_23
	,coalesce( [Jul-23], 0 ) as jul_23
	,coalesce( [Aug-23], 0 ) as aug_23
	,coalesce( [Sep-23], 0 ) as sep_23
	,coalesce( [Oct-23], 0 ) as oct_23
	,coalesce( [Nov-23], 0 ) as nov_23
	,coalesce( [Dec-23], 0 ) as dec_23
	,coalesce( [Jan-24], 0 ) as jan_24
	,coalesce( [Feb-24], 0 ) as feb_24
	,coalesce( [Mar-24], 0 ) as mar_24
	,coalesce( [Apr-24], 0 ) as apr_24
	,coalesce( [May-24], 0 ) as may_24
	,coalesce( [Jun-24], 0 ) as jun_24
	,coalesce( [Jul-24], 0 ) as jul_24
	,coalesce( [Aug-24], 0 ) as aug_24
	,coalesce( [Sep-24], 0 ) as sep_24
	,coalesce( [Oct-24], 0 ) as oct_24
	,coalesce( [Nov-24], 0 ) as nov_24
	,coalesce( [Dec-24], 0 ) as dec_24
	,coalesce( [Jan-25], 0 ) as jan_25
	,coalesce( [Feb-25], 0 ) as feb_25
	,coalesce( [Mar-25], 0 ) as mar_25
	,coalesce( [Apr-25], 0 ) as apr_25
	,coalesce( [May-25], 0 ) as may_25
	,coalesce( [Jun-25], 0 ) as jun_25
	,coalesce( [Jul-25], 0 ) as jul_25
	,coalesce( [Aug-25], 0 ) as aug_25
	,coalesce( [Sep-25], 0 ) as sep_25
	,coalesce( [Oct-25], 0 ) as oct_25
	,coalesce( [Nov-25], 0 ) as nov_25
	,coalesce( [Dec-25], 0 ) as dec_25
	,coalesce( [Jan-26], 0 ) as jan_26
	,coalesce( [Feb-26], 0 ) as feb_26
	,coalesce( [Mar-26], 0 ) as mar_26
	,coalesce( [Apr-26], 0 ) as apr_26
	,coalesce( [May-26], 0 ) as may_26
	,coalesce( [Jun-26], 0 ) as jun_26
	,coalesce( [Jul-26], 0 ) as jul_26
	,coalesce( [Aug-26], 0 ) as aug_26
	,coalesce( [Sep-26], 0 ) as sep_26
	,coalesce( [Oct-26], 0 ) as oct_26
	,coalesce( [Nov-26], 0 ) as nov_26
	,coalesce( [Dec-26], 0 ) as dec_26
	,coalesce( [Jan-27], 0 ) as jan_27
	,coalesce( [Feb-27], 0 ) as feb_27
	,coalesce( [Mar-27], 0 ) as mar_27
	,coalesce( [Apr-27], 0 ) as apr_27
	,coalesce( [May-27], 0 ) as may_27
	,coalesce( [Jun-27], 0 ) as jun_27
	,coalesce( [Jul-27], 0 ) as jul_27
	,coalesce( [Aug-27], 0 ) as aug_27
	,coalesce( [Sep-27], 0 ) as sep_27
	,coalesce( [Oct-27], 0 ) as oct_27
	,coalesce( [Nov-27], 0 ) as nov_27
	,coalesce( [Dec-27], 0 ) as dec_27
	,coalesce( [Jan-28], 0 ) as jan_28
	,coalesce( [Feb-28], 0 ) as feb_28
	,coalesce( [Mar-28], 0 ) as mar_28
	,coalesce( [Apr-28], 0 ) as apr_28
	,coalesce( [May-28], 0 ) as may_28
	,coalesce( [Jun-28], 0 ) as jun_28
	,coalesce( [Jul-28], 0 ) as jul_28
	,coalesce( [Aug-28], 0 ) as aug_28
	,coalesce( [Sep-28], 0 ) as sep_28
	,coalesce( [Oct-28], 0 ) as oct_28
	,coalesce( [Nov-28], 0 ) as nov_28
	,coalesce( [Dec-28], 0 ) as dec_28
	,coalesce( [Jan-29], 0 ) as jan_29
	,coalesce( [Feb-29], 0 ) as feb_29
	,coalesce( [Mar-29], 0 ) as mar_29
	,coalesce( [Apr-29], 0 ) as apr_29
	,coalesce( [May-29], 0 ) as may_29
	,coalesce( [Jun-29], 0 ) as jun_29
	,coalesce( [Jul-29], 0 ) as jul_29
	,coalesce( [Aug-29], 0 ) as aug_29
	,coalesce( [Sep-29], 0 ) as sep_29
	,coalesce( [Oct-29], 0 ) as oct_29
	,coalesce( [Nov-29], 0 ) as nov_29
	,coalesce( [Dec-29], 0 ) as dec_29
	,coalesce( [Jan-30], 0 ) as jan_30
	,coalesce( [Feb-30], 0 ) as feb_30
	,coalesce( [Mar-30], 0 ) as mar_30
	,coalesce( [Apr-30], 0 ) as apr_30
	,coalesce( [May-30], 0 ) as may_30
	,coalesce( [Jun-30], 0 ) as jun_30	
from stg.stg_PRP_Dept
where 1=1
	and (
		--BED CAPACITY
		( department = 'Branch' and teamtrade = 'Total' )
	 or ( department = 'BCL/BRS' and teamtrade = 'Total' )
	 or ( department = 'Newburgh' and teamtrade = 'Total' )
	 or ( department = 'Woodgrove' and teamtrade = 'Total' )
	 or ( department = 'Ramapo Residences' and teamtrade = 'Total' )
		-- BEDS REQUIRED FORECAST
	 or ( department = 'Bed Space Required Total' )
		-- COMMUTER
	 or ( department = 'Commuter Forecast' )
	)
go		


if object_id('stg.stg_prp_cpc_v', 'V') is not null
	drop view stg.stg_prp_cpc_v
go 
create view stg.stg_prp_cpc_v
as
select
	 cpc_code
	,max( teamcode ) as pc_code
	,coalesce( sum( [Jan-20] ), 0 ) as jan_20
	,coalesce( sum( [Feb-20] ), 0 ) as feb_20
	,coalesce( sum( [Mar-20] ), 0 ) as mar_20
	,coalesce( sum( [Apr-20] ), 0 ) as apr_20
	,coalesce( sum( [May-20] ), 0 ) as may_20
	,coalesce( sum( [Jun-20] ), 0 ) as jun_20
	,coalesce( sum( [Jul-20] ), 0 ) as jul_20
	,coalesce( sum( [Aug-20] ), 0 ) as aug_20
	,coalesce( sum( [Sep-20] ), 0 ) as sep_20
	,coalesce( sum( [Oct-20] ), 0 ) as oct_20
	,coalesce( sum( [Nov-20] ), 0 ) as nov_20
	,coalesce( sum( [Dec-20] ), 0 ) as dec_20
	,coalesce( sum( [Jan-21] ), 0 ) as jan_21
	,coalesce( sum( [Feb-21] ), 0 ) as feb_21
	,coalesce( sum( [Mar-21] ), 0 ) as mar_21
	,coalesce( sum( [Apr-21] ), 0 ) as apr_21
	,coalesce( sum( [May-21] ), 0 ) as may_21
	,coalesce( sum( [Jun-21] ), 0 ) as jun_21
	,coalesce( sum( [Jul-21] ), 0 ) as jul_21
	,coalesce( sum( [Aug-21] ), 0 ) as aug_21
	,coalesce( sum( [Sep-21] ), 0 ) as sep_21
	,coalesce( sum( [Oct-21] ), 0 ) as oct_21
	,coalesce( sum( [Nov-21] ), 0 ) as nov_21
	,coalesce( sum( [Dec-21] ), 0 ) as dec_21
	,coalesce( sum( [Jan-22] ), 0 ) as jan_22
	,coalesce( sum( [Feb-22] ), 0 ) as feb_22
	,coalesce( sum( [Mar-22] ), 0 ) as mar_22
	,coalesce( sum( [Apr-22] ), 0 ) as apr_22
	,coalesce( sum( [May-22] ), 0 ) as may_22
	,coalesce( sum( [Jun-22] ), 0 ) as jun_22
	,coalesce( sum( [Jul-22] ), 0 ) as jul_22
	,coalesce( sum( [Aug-22] ), 0 ) as aug_22
	,coalesce( sum( [Sep-22] ), 0 ) as sep_22
	,coalesce( sum( [Oct-22] ), 0 ) as oct_22
	,coalesce( sum( [Nov-22] ), 0 ) as nov_22
	,coalesce( sum( [Dec-22] ), 0 ) as dec_22
	,coalesce( sum( [Jan-23] ), 0 ) as jan_23
	,coalesce( sum( [Feb-23] ), 0 ) as feb_23
	,coalesce( sum( [Mar-23] ), 0 ) as mar_23
	,coalesce( sum( [Apr-23] ), 0 ) as apr_23
	,coalesce( sum( [May-23] ), 0 ) as may_23
	,coalesce( sum( [Jun-23] ), 0 ) as jun_23
	,coalesce( sum( [Jul-23] ), 0 ) as jul_23
	,coalesce( sum( [Aug-23] ), 0 ) as aug_23
	,coalesce( sum( [Sep-23] ), 0 ) as sep_23
	,coalesce( sum( [Oct-23] ), 0 ) as oct_23
	,coalesce( sum( [Nov-23] ), 0 ) as nov_23
	,coalesce( sum( [Dec-23] ), 0 ) as dec_23
	,coalesce( sum( [Jan-24] ), 0 ) as jan_24
	,coalesce( sum( [Feb-24] ), 0 ) as feb_24
	,coalesce( sum( [Mar-24] ), 0 ) as mar_24
	,coalesce( sum( [Apr-24] ), 0 ) as apr_24
	,coalesce( sum( [May-24] ), 0 ) as may_24
	,coalesce( sum( [Jun-24] ), 0 ) as jun_24
	,coalesce( sum( [Jul-24] ), 0 ) as jul_24
	,coalesce( sum( [Aug-24] ), 0 ) as aug_24
	,coalesce( sum( [Sep-24] ), 0 ) as sep_24
	,coalesce( sum( [Oct-24] ), 0 ) as oct_24
	,coalesce( sum( [Nov-24] ), 0 ) as nov_24
	,coalesce( sum( [Dec-24] ), 0 ) as dec_24
	,coalesce( sum( [Jan-25] ), 0 ) as jan_25
	,coalesce( sum( [Feb-25] ), 0 ) as feb_25
	,coalesce( sum( [Mar-25] ), 0 ) as mar_25
	,coalesce( sum( [Apr-25] ), 0 ) as apr_25
	,coalesce( sum( [May-25] ), 0 ) as may_25
	,coalesce( sum( [Jun-25] ), 0 ) as jun_25
	,coalesce( sum( [Jul-25] ), 0 ) as jul_25
	,coalesce( sum( [Aug-25] ), 0 ) as aug_25
	,coalesce( sum( [Sep-25] ), 0 ) as sep_25
	,coalesce( sum( [Oct-25] ), 0 ) as oct_25
	,coalesce( sum( [Nov-25] ), 0 ) as nov_25
	,coalesce( sum( [Dec-25] ), 0 ) as dec_25
	,coalesce( sum( [Jan-26] ), 0 ) as jan_26
	,coalesce( sum( [Feb-26] ), 0 ) as feb_26
	,coalesce( sum( [Mar-26] ), 0 ) as mar_26
	,coalesce( sum( [Apr-26] ), 0 ) as apr_26
	,coalesce( sum( [May-26] ), 0 ) as may_26
	,coalesce( sum( [Jun-26] ), 0 ) as jun_26
	,coalesce( sum( [Jul-26] ), 0 ) as jul_26
	,coalesce( sum( [Aug-26] ), 0 ) as aug_26
	,coalesce( sum( [Sep-26] ), 0 ) as sep_26
	,coalesce( sum( [Oct-26] ), 0 ) as oct_26
	,coalesce( sum( [Nov-26] ), 0 ) as nov_26
	,coalesce( sum( [Dec-26] ), 0 ) as dec_26
	,coalesce( sum( [Jan-27] ), 0 ) as jan_27
	,coalesce( sum( [Feb-27] ), 0 ) as feb_27
	,coalesce( sum( [Mar-27] ), 0 ) as mar_27
	,coalesce( sum( [Apr-27] ), 0 ) as apr_27
	,coalesce( sum( [May-27] ), 0 ) as may_27
	,coalesce( sum( [Jun-27] ), 0 ) as jun_27
	,coalesce( sum( [Jul-27] ), 0 ) as jul_27
	,coalesce( sum( [Aug-27] ), 0 ) as aug_27
	,coalesce( sum( [Sep-27] ), 0 ) as sep_27
	,coalesce( sum( [Oct-27] ), 0 ) as oct_27
	,coalesce( sum( [Nov-27] ), 0 ) as nov_27
	,coalesce( sum( [Dec-27] ), 0 ) as dec_27
	,coalesce( sum( [Jan-28] ), 0 ) as jan_28
	,coalesce( sum( [Feb-28] ), 0 ) as feb_28
	,coalesce( sum( [Mar-28] ), 0 ) as mar_28
	,coalesce( sum( [Apr-28] ), 0 ) as apr_28
	,coalesce( sum( [May-28] ), 0 ) as may_28
	,coalesce( sum( [Jun-28] ), 0 ) as jun_28
	,coalesce( sum( [Jul-28] ), 0 ) as jul_28
	,coalesce( sum( [Aug-28] ), 0 ) as aug_28
	,coalesce( sum( [Sep-28] ), 0 ) as sep_28
	,coalesce( sum( [Oct-28] ), 0 ) as oct_28
	,coalesce( sum( [Nov-28] ), 0 ) as nov_28
	,coalesce( sum( [Dec-28] ), 0 ) as dec_28
	,coalesce( sum( [Jan-29] ), 0 ) as jan_29
	,coalesce( sum( [Feb-29] ), 0 ) as feb_29
	,coalesce( sum( [Mar-29] ), 0 ) as mar_29
	,coalesce( sum( [Apr-29] ), 0 ) as apr_29
	,coalesce( sum( [May-29] ), 0 ) as may_29
	,coalesce( sum( [Jun-29] ), 0 ) as jun_29
	,coalesce( sum( [Jul-29] ), 0 ) as jul_29
	,coalesce( sum( [Aug-29] ), 0 ) as aug_29
	,coalesce( sum( [Sep-29] ), 0 ) as sep_29
	,coalesce( sum( [Oct-29] ), 0 ) as oct_29
	,coalesce( sum( [Nov-29] ), 0 ) as nov_29
	,coalesce( sum( [Dec-29] ), 0 ) as dec_29	
	,coalesce( sum( [Jan-30] ), 0 ) as jan_30
	,coalesce( sum( [Feb-30] ), 0 ) as feb_30
	,coalesce( sum( [Mar-30] ), 0 ) as mar_30	
	,coalesce( sum( [Apr-30] ), 0 ) as apr_30
	,coalesce( sum( [May-30] ), 0 ) as may_30	
	,coalesce( sum( [Jun-30] ), 0 ) as jun_30	
from
	( select 
		 department
		,teamtrade
		,replace( teamcode, ' ',  '-' ) as teamcode
		,case
			when teamcode = 'HPR CO' then 'CO'
			when teamcode = 'HPR DD' then 'DD'
			when teamcode in ( 'HPR PCC', 'HPR PU' ) then 'PCC'
			when teamcode = 'HPR PS' then 'PS'
			when teamcode = 'HPR HQ' then 'CI'
			when teamcode = 'HPR VD' then 'VD'			
			else 'CI'
		 end as cpc_code
		,parentcode
		,hubgroup
		,deskrequired
		,[Jan-20]
		,[Feb-20]
		,[Mar-20]
		,[Apr-20]
		,[May-20]
		,[Jun-20]
		,[Jul-20]
		,[Aug-20]
		,[Sep-20]
		,[Oct-20]
		,[Nov-20]
		,[Dec-20]
		,[Jan-21]
		,[Feb-21]
		,[Mar-21]
		,[Apr-21]
		,[May-21]
		,[Jun-21]
		,[Jul-21]
		,[Aug-21]
		,[Sep-21]
		,[Oct-21]
		,[Nov-21]
		,[Dec-21]
		,[Jan-22]
		,[Feb-22]
		,[Mar-22]
		,[Apr-22]
		,[May-22]
		,[Jun-22]
		,[Jul-22]
		,[Aug-22]
		,[Sep-22]
		,[Oct-22]
		,[Nov-22]
		,[Dec-22]
		,[Jan-23]
		,[Feb-23]
		,[Mar-23]
		,[Apr-23]
		,[May-23]
		,[Jun-23]
		,[Jul-23]
		,[Aug-23]
		,[Sep-23]
		,[Oct-23]
		,[Nov-23]
		,[Dec-23]
		,[Jan-24]
		,[Feb-24]
		,[Mar-24]
		,[Apr-24]
		,[May-24]
		,[Jun-24]
		,[Jul-24]
		,[Aug-24]
		,[Sep-24]
		,[Oct-24]
		,[Nov-24]
		,[Dec-24]
		,[Jan-25]
		,[Feb-25]
		,[Mar-25]
		,[Apr-25]
		,[May-25]
		,[Jun-25]
		,[Jul-25]
		,[Aug-25]
		,[Sep-25]
		,[Oct-25]
		,[Nov-25]
		,[Dec-25]
		,[Jan-26]
		,[Feb-26]
		,[Mar-26]
		,[Apr-26]
		,[May-26]
		,[Jun-26]
		,[Jul-26]
		,[Aug-26]
		,[Sep-26]
		,[Oct-26]
		,[Nov-26]
		,[Dec-26]
		,[Jan-27]
		,[Feb-27]
		,[Mar-27]
		,[Apr-27]
		,[May-27]
		,[Jun-27]
		,[Jul-27]
		,[Aug-27]
		,[Sep-27]
		,[Oct-27]
		,[Nov-27]
		,[Dec-27]
		,[Jan-28]
		,[Feb-28]
		,[Mar-28]
		,[Apr-28]
		,[May-28]
		,[Jun-28]
		,[Jul-28]
		,[Aug-28]
		,[Sep-28]
		,[Oct-28]
		,[Nov-28]
		,[Dec-28]
		,[Jan-29]
		,[Feb-29]
		,[Mar-29]
		,[Apr-29]
		,[May-29]
		,[Jun-29]
		,[Jul-29]
		,[Aug-29]
		,[Sep-29]
		,[Oct-29]
		,[Nov-29]
		,[Dec-29]
		,[Jan-30]
		,[Feb-30]
		,[Mar-30]
		,[Apr-30]
		,[May-30]
		,[Jun-30]	
	  from stg.stg_PRP_Dept
	  where 1=1
		and teamcode in ( 'HPR CO', 'HPR DD', 'HPR PCC', 'HPR PS', 'HPR CI', 'HPR HQ', 'HPR PU', 'HPR VD' )
		and teamtrade like 'Total%'
		) core
group by cpc_code
go

if object_id('stg.stg_PRP_Dept', 'U') is not
	drop table stg.stg_PRP_Dept
go
CREATE TABLE [stg].[stg_PRP_Dept](
	[Department] [nvarchar](255) NULL,
	[TeamTrade] [nvarchar](255) NULL,
	[TeamCode] [nvarchar](255) NULL,
	[ParentCode] [nvarchar](255) NULL,
	[HuBGroup] [nvarchar](255) NULL,
	[DeskRequired] [nvarchar](255) NULL,
	[Jan-20] [float] NULL,
	[Feb-20] [float] NULL,
	[Mar-20] [float] NULL,
	[Apr-20] [float] NULL,
	[May-20] [float] NULL,
	[Jun-20] [float] NULL,
	[Jul-20] [float] NULL,
	[Aug-20] [float] NULL,
	[Sep-20] [float] NULL,
	[Oct-20] [float] NULL,
	[Nov-20] [float] NULL,
	[Dec-20] [float] NULL,
	[Jan-21] [float] NULL,
	[Feb-21] [float] NULL,
	[Mar-21] [float] NULL,
	[Apr-21] [float] NULL,
	[May-21] [float] NULL,
	[Jun-21] [float] NULL,
	[Jul-21] [float] NULL,
	[Aug-21] [float] NULL,
	[Sep-21] [float] NULL,
	[Oct-21] [float] NULL,
	[Nov-21] [float] NULL,
	[Dec-21] [float] NULL,
	[Jan-22] [float] NULL,
	[Feb-22] [float] NULL,
	[Mar-22] [float] NULL,
	[Apr-22] [float] NULL,
	[May-22] [float] NULL,
	[Jun-22] [float] NULL,
	[Jul-22] [float] NULL,
	[Aug-22] [float] NULL,
	[Sep-22] [float] NULL,
	[Oct-22] [float] NULL,
	[Nov-22] [float] NULL,
	[Dec-22] [float] NULL,
	[Jan-23] [float] NULL,
	[Feb-23] [float] NULL,
	[Mar-23] [float] NULL,
	[Apr-23] [float] NULL,
	[May-23] [float] NULL,
	[Jun-23] [float] NULL,
	[Jul-23] [float] NULL,
	[Aug-23] [float] NULL,
	[Sep-23] [float] NULL,
	[Oct-23] [float] NULL,
	[Nov-23] [float] NULL,
	[Dec-23] [float] NULL,
	[Jan-24] [float] NULL,
	[Feb-24] [float] NULL,
	[Mar-24] [float] NULL,
	[Apr-24] [float] NULL,
	[May-24] [float] NULL,
	[Jun-24] [float] NULL,
	[Jul-24] [float] NULL,
	[Aug-24] [float] NULL,
	[Sep-24] [float] NULL,
	[Oct-24] [float] NULL,
	[Nov-24] [float] NULL,
	[Dec-24] [float] NULL,
	[Jan-25] [float] NULL,
	[Feb-25] [float] NULL,
	[Mar-25] [float] NULL,
	[Apr-25] [float] NULL,
	[May-25] [float] NULL,
	[Jun-25] [float] NULL,
	[Jul-25] [float] NULL,
	[Aug-25] [float] NULL,
	[Sep-25] [float] NULL,
	[Oct-25] [float] NULL,
	[Nov-25] [float] NULL,
	[Dec-25] [float] NULL,
	[Jan-26] [float] NULL,
	[Feb-26] [float] NULL,
	[Mar-26] [float] NULL,
	[Apr-26] [float] NULL,
	[May-26] [float] NULL,
	[Jun-26] [float] NULL,
	[Jul-26] [float] NULL,
	[Aug-26] [float] NULL,
	[Sep-26] [float] NULL,
	[Oct-26] [float] NULL,
	[Nov-26] [float] NULL,
	[Dec-26] [float] NULL,
	[Jan-27] [float] NULL,
	[Feb-27] [float] NULL,
	[Mar-27] [float] NULL,
	[Apr-27] [float] NULL,
	[May-27] [float] NULL,
	[Jun-27] [float] NULL,
	[Jul-27] [float] NULL,
	[Aug-27] [float] NULL,
	[Sep-27] [float] NULL,
	[Oct-27] [float] NULL,
	[Nov-27] [float] NULL,
	[Dec-27] [float] NULL,
	[Jan-28] [float] NULL,
	[Feb-28] [float] NULL,
	[Mar-28] [float] NULL,
	[Apr-28] [float] NULL,
	[May-28] [float] NULL,
	[Jun-28] [float] NULL,
	[Jul-28] [float] NULL,
	[Aug-28] [float] NULL,
	[Sep-28] [float] NULL,
	[Oct-28] [float] NULL,
	[Nov-28] [float] NULL,
	[Dec-28] [float] NULL,
	[Jan-29] [float] NULL,
	[Feb-29] [float] NULL,
	[Mar-29] [float] NULL,
	[Apr-29] [float] NULL,
	[May-29] [float] NULL,
	[Jun-29] [float] NULL,
	[Jul-29] [float] NULL,
	[Aug-29] [float] NULL,
	[Sep-29] [float] NULL,
	[Oct-29] [float] NULL,
	[Nov-29] [float] NULL,
	[Dec-29] [float] NULL,
	[Jan-30] [float] NULL,
	[Feb-30] [float] NULL,
	[Mar-30] [float] NULL,
	[Apr-30] [float] NULL,
	[May-30] [float] NULL,
	[Jun-30] [float] NULL
) ON [PRIMARY]
GO


if object_id('stg.stg_prp_dept_v', 'V') is not null
	drop view stg.stg_prp_dept_v
go 
create view stg.stg_prp_dept_v
as
select
	 teamcode as pc_code
	,count(*) as cnt
	,coalesce( sum( [Jan-20] ), 0 ) as jan_20
	,coalesce( sum( [Feb-20] ), 0 ) as feb_20
	,coalesce( sum( [Mar-20] ), 0 ) as mar_20
	,coalesce( sum( [Apr-20] ), 0 ) as apr_20
	,coalesce( sum( [May-20] ), 0 ) as may_20
	,coalesce( sum( [Jun-20] ), 0 ) as jun_20
	,coalesce( sum( [Jul-20] ), 0 ) as jul_20
	,coalesce( sum( [Aug-20] ), 0 ) as aug_20
	,coalesce( sum( [Sep-20] ), 0 ) as sep_20
	,coalesce( sum( [Oct-20] ), 0 ) as oct_20
	,coalesce( sum( [Nov-20] ), 0 ) as nov_20
	,coalesce( sum( [Dec-20] ), 0 ) as dec_20
	,coalesce( sum( [Jan-21] ), 0 ) as jan_21
	,coalesce( sum( [Feb-21] ), 0 ) as feb_21
	,coalesce( sum( [Mar-21] ), 0 ) as mar_21
	,coalesce( sum( [Apr-21] ), 0 ) as apr_21
	,coalesce( sum( [May-21] ), 0 ) as may_21
	,coalesce( sum( [Jun-21] ), 0 ) as jun_21
	,coalesce( sum( [Jul-21] ), 0 ) as jul_21
	,coalesce( sum( [Aug-21] ), 0 ) as aug_21
	,coalesce( sum( [Sep-21] ), 0 ) as sep_21
	,coalesce( sum( [Oct-21] ), 0 ) as oct_21
	,coalesce( sum( [Nov-21] ), 0 ) as nov_21
	,coalesce( sum( [Dec-21] ), 0 ) as dec_21
	,coalesce( sum( [Jan-22] ), 0 ) as jan_22
	,coalesce( sum( [Feb-22] ), 0 ) as feb_22
	,coalesce( sum( [Mar-22] ), 0 ) as mar_22
	,coalesce( sum( [Apr-22] ), 0 ) as apr_22
	,coalesce( sum( [May-22] ), 0 ) as may_22
	,coalesce( sum( [Jun-22] ), 0 ) as jun_22
	,coalesce( sum( [Jul-22] ), 0 ) as jul_22
	,coalesce( sum( [Aug-22] ), 0 ) as aug_22
	,coalesce( sum( [Sep-22] ), 0 ) as sep_22
	,coalesce( sum( [Oct-22] ), 0 ) as oct_22
	,coalesce( sum( [Nov-22] ), 0 ) as nov_22
	,coalesce( sum( [Dec-22] ), 0 ) as dec_22
	,coalesce( sum( [Jan-23] ), 0 ) as jan_23
	,coalesce( sum( [Feb-23] ), 0 ) as feb_23
	,coalesce( sum( [Mar-23] ), 0 ) as mar_23
	,coalesce( sum( [Apr-23] ), 0 ) as apr_23
	,coalesce( sum( [May-23] ), 0 ) as may_23
	,coalesce( sum( [Jun-23] ), 0 ) as jun_23
	,coalesce( sum( [Jul-23] ), 0 ) as jul_23
	,coalesce( sum( [Aug-23] ), 0 ) as aug_23
	,coalesce( sum( [Sep-23] ), 0 ) as sep_23
	,coalesce( sum( [Oct-23] ), 0 ) as oct_23
	,coalesce( sum( [Nov-23] ), 0 ) as nov_23
	,coalesce( sum( [Dec-23] ), 0 ) as dec_23
	,coalesce( sum( [Jan-24] ), 0 ) as jan_24
	,coalesce( sum( [Feb-24] ), 0 ) as feb_24
	,coalesce( sum( [Mar-24] ), 0 ) as mar_24
	,coalesce( sum( [Apr-24] ), 0 ) as apr_24
	,coalesce( sum( [May-24] ), 0 ) as may_24
	,coalesce( sum( [Jun-24] ), 0 ) as jun_24
	,coalesce( sum( [Jul-24] ), 0 ) as jul_24
	,coalesce( sum( [Aug-24] ), 0 ) as aug_24
	,coalesce( sum( [Sep-24] ), 0 ) as sep_24
	,coalesce( sum( [Oct-24] ), 0 ) as oct_24
	,coalesce( sum( [Nov-24] ), 0 ) as nov_24
	,coalesce( sum( [Dec-24] ), 0 ) as dec_24
	,coalesce( sum( [Jan-25] ), 0 ) as jan_25
	,coalesce( sum( [Feb-25] ), 0 ) as feb_25
	,coalesce( sum( [Mar-25] ), 0 ) as mar_25
	,coalesce( sum( [Apr-25] ), 0 ) as apr_25
	,coalesce( sum( [May-25] ), 0 ) as may_25
	,coalesce( sum( [Jun-25] ), 0 ) as jun_25
	,coalesce( sum( [Jul-25] ), 0 ) as jul_25
	,coalesce( sum( [Aug-25] ), 0 ) as aug_25
	,coalesce( sum( [Sep-25] ), 0 ) as sep_25
	,coalesce( sum( [Oct-25] ), 0 ) as oct_25
	,coalesce( sum( [Nov-25] ), 0 ) as nov_25
	,coalesce( sum( [Dec-25] ), 0 ) as dec_25
	,coalesce( sum( [Jan-26] ), 0 ) as jan_26
	,coalesce( sum( [Feb-26] ), 0 ) as feb_26
	,coalesce( sum( [Mar-26] ), 0 ) as mar_26
	,coalesce( sum( [Apr-26] ), 0 ) as apr_26
	,coalesce( sum( [May-26] ), 0 ) as may_26
	,coalesce( sum( [Jun-26] ), 0 ) as jun_26
	,coalesce( sum( [Jul-26] ), 0 ) as jul_26
	,coalesce( sum( [Aug-26] ), 0 ) as aug_26
	,coalesce( sum( [Sep-26] ), 0 ) as sep_26
	,coalesce( sum( [Oct-26] ), 0 ) as oct_26
	,coalesce( sum( [Nov-26] ), 0 ) as nov_26
	,coalesce( sum( [Dec-26] ), 0 ) as dec_26
	,coalesce( sum( [Jan-27] ), 0 ) as jan_27
	,coalesce( sum( [Feb-27] ), 0 ) as feb_27
	,coalesce( sum( [Mar-27] ), 0 ) as mar_27
	,coalesce( sum( [Apr-27] ), 0 ) as apr_27
	,coalesce( sum( [May-27] ), 0 ) as may_27
	,coalesce( sum( [Jun-27] ), 0 ) as jun_27
	,coalesce( sum( [Jul-27] ), 0 ) as jul_27
	,coalesce( sum( [Aug-27] ), 0 ) as aug_27
	,coalesce( sum( [Sep-27] ), 0 ) as sep_27
	,coalesce( sum( [Oct-27] ), 0 ) as oct_27
	,coalesce( sum( [Nov-27] ), 0 ) as nov_27
	,coalesce( sum( [Dec-27] ), 0 ) as dec_27
	,coalesce( sum( [Jan-28] ), 0 ) as jan_28
	,coalesce( sum( [Feb-28] ), 0 ) as feb_28
	,coalesce( sum( [Mar-28] ), 0 ) as mar_28
	,coalesce( sum( [Apr-28] ), 0 ) as apr_28
	,coalesce( sum( [May-28] ), 0 ) as may_28
	,coalesce( sum( [Jun-28] ), 0 ) as jun_28
	,coalesce( sum( [Jul-28] ), 0 ) as jul_28
	,coalesce( sum( [Aug-28] ), 0 ) as aug_28
	,coalesce( sum( [Sep-28] ), 0 ) as sep_28
	,coalesce( sum( [Oct-28] ), 0 ) as oct_28
	,coalesce( sum( [Nov-28] ), 0 ) as nov_28
	,coalesce( sum( [Dec-28] ), 0 ) as dec_28
	,coalesce( sum( [Jan-29] ), 0 ) as jan_29
	,coalesce( sum( [Feb-29] ), 0 ) as feb_29
	,coalesce( sum( [Mar-29] ), 0 ) as mar_29
	,coalesce( sum( [Apr-29] ), 0 ) as apr_29
	,coalesce( sum( [May-29] ), 0 ) as may_29
	,coalesce( sum( [Jun-29] ), 0 ) as jun_29
	,coalesce( sum( [Jul-29] ), 0 ) as jul_29
	,coalesce( sum( [Aug-29] ), 0 ) as aug_29
	,coalesce( sum( [Sep-29] ), 0 ) as sep_29
	,coalesce( sum( [Oct-29] ), 0 ) as oct_29
	,coalesce( sum( [Nov-29] ), 0 ) as nov_29
	,coalesce( sum( [Dec-29] ), 0 ) as dec_29	
	,coalesce( sum( [Jan-30] ), 0 ) as jan_30
	,coalesce( sum( [Feb-30] ), 0 ) as feb_30
	,coalesce( sum( [Mar-30] ), 0 ) as mar_30	
	,coalesce( sum( [Apr-30] ), 0 ) as apr_30
	,coalesce( sum( [May-30] ), 0 ) as may_30	
	,coalesce( sum( [Jun-30] ), 0 ) as jun_30	
from
	( select 
		 department
		,teamtrade
		,replace( teamcode, ' ',  '-' ) as teamcode
		,parentcode
		,hubgroup
		,deskrequired
		,[Jan-20]
		,[Feb-20]
		,[Mar-20]
		,[Apr-20]
		,[May-20]
		,[Jun-20]
		,[Jul-20]
		,[Aug-20]
		,[Sep-20]
		,[Oct-20]
		,[Nov-20]
		,[Dec-20]
		,[Jan-21]
		,[Feb-21]
		,[Mar-21]
		,[Apr-21]
		,[May-21]
		,[Jun-21]
		,[Jul-21]
		,[Aug-21]
		,[Sep-21]
		,[Oct-21]
		,[Nov-21]
		,[Dec-21]
		,[Jan-22]
		,[Feb-22]
		,[Mar-22]
		,[Apr-22]
		,[May-22]
		,[Jun-22]
		,[Jul-22]
		,[Aug-22]
		,[Sep-22]
		,[Oct-22]
		,[Nov-22]
		,[Dec-22]
		,[Jan-23]
		,[Feb-23]
		,[Mar-23]
		,[Apr-23]
		,[May-23]
		,[Jun-23]
		,[Jul-23]
		,[Aug-23]
		,[Sep-23]
		,[Oct-23]
		,[Nov-23]
		,[Dec-23]
		,[Jan-24]
		,[Feb-24]
		,[Mar-24]
		,[Apr-24]
		,[May-24]
		,[Jun-24]
		,[Jul-24]
		,[Aug-24]
		,[Sep-24]
		,[Oct-24]
		,[Nov-24]
		,[Dec-24]
		,[Jan-25]
		,[Feb-25]
		,[Mar-25]
		,[Apr-25]
		,[May-25]
		,[Jun-25]
		,[Jul-25]
		,[Aug-25]
		,[Sep-25]
		,[Oct-25]
		,[Nov-25]
		,[Dec-25]
		,[Jan-26]
		,[Feb-26]
		,[Mar-26]
		,[Apr-26]
		,[May-26]
		,[Jun-26]
		,[Jul-26]
		,[Aug-26]
		,[Sep-26]
		,[Oct-26]
		,[Nov-26]
		,[Dec-26]
		,[Jan-27]
		,[Feb-27]
		,[Mar-27]
		,[Apr-27]
		,[May-27]
		,[Jun-27]
		,[Jul-27]
		,[Aug-27]
		,[Sep-27]
		,[Oct-27]
		,[Nov-27]
		,[Dec-27]
		,[Jan-28]
		,[Feb-28]
		,[Mar-28]
		,[Apr-28]
		,[May-28]
		,[Jun-28]
		,[Jul-28]
		,[Aug-28]
		,[Sep-28]
		,[Oct-28]
		,[Nov-28]
		,[Dec-28]
		,[Jan-29]
		,[Feb-29]
		,[Mar-29]
		,[Apr-29]
		,[May-29]
		,[Jun-29]
		,[Jul-29]
		,[Aug-29]
		,[Sep-29]
		,[Oct-29]
		,[Nov-29]
		,[Dec-29]
		,[Jan-30]
		,[Feb-30]
		,[Mar-30]
		,[Apr-30]
		,[May-30]
		,[Jun-30]
	  from stg.stg_PRP_Dept
	  where 1=1
		--and teamcode like 'HPR DD%'
		and ParentCode is not null 
		and teamtrade not like 'Total%'
		and teamtrade not like 'Subtotal%'		
		) core
group by teamcode
go


if object_id('stg.stg_prp_v', 'V') is not null
	drop view stg.stg_prp_v
go 
create view stg.stg_prp_v
as
select
	 d.hpr_dept_key
	,d.cpc_code
	,d.dept_name + ' - ' + d.Work_Group_Name as hub_dept_name
	,d.dept_name
	,d.work_group_name
	,d.pc_category
	,d.pc_code
	,prp.cnt as prp_cnt
	,coalesce( prp.jan_20, 0 ) as jan_20
	,coalesce( prp.feb_20, 0 ) as feb_20
	,coalesce( prp.mar_20, 0 ) as mar_20
	,coalesce( prp.apr_20, 0 ) as apr_20
	,coalesce( prp.may_20, 0 ) as may_20
	,coalesce( prp.jun_20, 0 ) as jun_20
	,coalesce( prp.jul_20, 0 ) as jul_20
	,coalesce( prp.aug_20, 0 ) as aug_20
	,coalesce( prp.sep_20, 0 ) as sep_20
	,coalesce( prp.oct_20, 0 ) as oct_20
	,coalesce( prp.nov_20, 0 ) as nov_20
	,coalesce( prp.dec_20, 0 ) as dec_20
	,coalesce( prp.jan_21, 0 ) as jan_21
	,coalesce( prp.feb_21, 0 ) as feb_21
	,coalesce( prp.mar_21, 0 ) as mar_21
	,coalesce( prp.apr_21, 0 ) as apr_21
	,coalesce( prp.may_21, 0 ) as may_21
	,coalesce( prp.jun_21, 0 ) as jun_21
	,coalesce( prp.jul_21, 0 ) as jul_21
	,coalesce( prp.aug_21, 0 ) as aug_21
	,coalesce( prp.sep_21, 0 ) as sep_21
	,coalesce( prp.oct_21, 0 ) as oct_21
	,coalesce( prp.nov_21, 0 ) as nov_21
	,coalesce( prp.dec_21, 0 ) as dec_21
	,coalesce( prp.jan_22, 0 ) as jan_22
	,coalesce( prp.feb_22, 0 ) as feb_22
	,coalesce( prp.mar_22, 0 ) as mar_22
	,coalesce( prp.apr_22, 0 ) as apr_22
	,coalesce( prp.may_22, 0 ) as may_22
	,coalesce( prp.jun_22, 0 ) as jun_22
	,coalesce( prp.jul_22, 0 ) as jul_22
	,coalesce( prp.aug_22, 0 ) as aug_22
	,coalesce( prp.sep_22, 0 ) as sep_22
	,coalesce( prp.oct_22, 0 ) as oct_22
	,coalesce( prp.nov_22, 0 ) as nov_22
	,coalesce( prp.dec_22, 0 ) as dec_22
	,coalesce( prp.jan_23, 0 ) as jan_23
	,coalesce( prp.feb_23, 0 ) as feb_23
	,coalesce( prp.mar_23, 0 ) as mar_23
	,coalesce( prp.apr_23, 0 ) as apr_23
	,coalesce( prp.may_23, 0 ) as may_23
	,coalesce( prp.jun_23, 0 ) as jun_23
	,coalesce( prp.jul_23, 0 ) as jul_23
	,coalesce( prp.aug_23, 0 ) as aug_23
	,coalesce( prp.sep_23, 0 ) as sep_23
	,coalesce( prp.oct_23, 0 ) as oct_23
	,coalesce( prp.nov_23, 0 ) as nov_23
	,coalesce( prp.dec_23, 0 ) as dec_23
	,coalesce( prp.jan_24, 0 ) as jan_24
	,coalesce( prp.feb_24, 0 ) as feb_24
	,coalesce( prp.mar_24, 0 ) as mar_24
	,coalesce( prp.apr_24, 0 ) as apr_24
	,coalesce( prp.may_24, 0 ) as may_24
	,coalesce( prp.jun_24, 0 ) as jun_24
	,coalesce( prp.jul_24, 0 ) as jul_24
	,coalesce( prp.aug_24, 0 ) as aug_24
	,coalesce( prp.sep_24, 0 ) as sep_24
	,coalesce( prp.oct_24, 0 ) as oct_24
	,coalesce( prp.nov_24, 0 ) as nov_24
	,coalesce( prp.dec_24, 0 ) as dec_24
	,coalesce( prp.jan_25, 0 ) as jan_25
	,coalesce( prp.feb_25, 0 ) as feb_25
	,coalesce( prp.mar_25, 0 ) as mar_25
	,coalesce( prp.apr_25, 0 ) as apr_25
	,coalesce( prp.may_25, 0 ) as may_25
	,coalesce( prp.jun_25, 0 ) as jun_25
	,coalesce( prp.jul_25, 0 ) as jul_25
	,coalesce( prp.aug_25, 0 ) as aug_25
	,coalesce( prp.sep_25, 0 ) as sep_25
	,coalesce( prp.oct_25, 0 ) as oct_25
	,coalesce( prp.nov_25, 0 ) as nov_25
	,coalesce( prp.dec_25, 0 ) as dec_25
	,coalesce( prp.jan_26, 0 ) as jan_26
	,coalesce( prp.feb_26, 0 ) as feb_26
	,coalesce( prp.mar_26, 0 ) as mar_26
	,coalesce( prp.apr_26, 0 ) as apr_26
	,coalesce( prp.may_26, 0 ) as may_26
	,coalesce( prp.jun_26, 0 ) as jun_26
	,coalesce( prp.jul_26, 0 ) as jul_26
	,coalesce( prp.aug_26, 0 ) as aug_26
	,coalesce( prp.sep_26, 0 ) as sep_26
	,coalesce( prp.oct_26, 0 ) as oct_26
	,coalesce( prp.nov_26, 0 ) as nov_26
	,coalesce( prp.dec_26, 0 ) as dec_26
	,coalesce( prp.jan_27, 0 ) as jan_27
	,coalesce( prp.feb_27, 0 ) as feb_27
	,coalesce( prp.mar_27, 0 ) as mar_27
	,coalesce( prp.apr_27, 0 ) as apr_27
	,coalesce( prp.may_27, 0 ) as may_27
	,coalesce( prp.jun_27, 0 ) as jun_27
	,coalesce( prp.jul_27, 0 ) as jul_27
	,coalesce( prp.aug_27, 0 ) as aug_27
	,coalesce( prp.sep_27, 0 ) as sep_27
	,coalesce( prp.oct_27, 0 ) as oct_27
	,coalesce( prp.nov_27, 0 ) as nov_27
	,coalesce( prp.dec_27, 0 ) as dec_27
	,coalesce( prp.jan_28, 0 ) as jan_28
	,coalesce( prp.feb_28, 0 ) as feb_28
	,coalesce( prp.mar_28, 0 ) as mar_28
	,coalesce( prp.apr_28, 0 ) as apr_28
	,coalesce( prp.may_28, 0 ) as may_28
	,coalesce( prp.jun_28, 0 ) as jun_28
	,coalesce( prp.jul_28, 0 ) as jul_28
	,coalesce( prp.aug_28, 0 ) as aug_28
	,coalesce( prp.sep_28, 0 ) as sep_28
	,coalesce( prp.oct_28, 0 ) as oct_28
	,coalesce( prp.nov_28, 0 ) as nov_28
	,coalesce( prp.dec_28, 0 ) as dec_28
	,coalesce( prp.jan_29, 0 ) as jan_29
	,coalesce( prp.feb_29, 0 ) as feb_29
	,coalesce( prp.mar_29, 0 ) as mar_29
	,coalesce( prp.apr_29, 0 ) as apr_29
	,coalesce( prp.may_29, 0 ) as may_29
	,coalesce( prp.jun_29, 0 ) as jun_29
	,coalesce( prp.jul_29, 0 ) as jul_29
	,coalesce( prp.aug_29, 0 ) as aug_29
	,coalesce( prp.sep_29, 0 ) as sep_29
	,coalesce( prp.oct_29, 0 ) as oct_29
	,coalesce( prp.nov_29, 0 ) as nov_29
	,coalesce( prp.dec_29, 0 ) as dec_29	
	,coalesce( prp.jan_30, 0 ) as jan_30
	,coalesce( prp.feb_30, 0 ) as feb_30
	,coalesce( prp.mar_30, 0 ) as mar_30
	,coalesce( prp.apr_30, 0 ) as apr_30	
	,coalesce( prp.may_30, 0 ) as may_30
	,coalesce( prp.jun_30, 0 ) as jun_30		
from dbo.hpr_dept d
left join stg.stg_prp_dept_v prp
	on d.pc_code_full = prp.pc_code
where 1=1
	and d.active_flag = 'Y'
	and d.NYC_Flag = 'N'
go


if object_id('stg.Volunteer_Cong_Hist_Ranking_v', 'V') is not null
	drop view stg.Volunteer_Cong_Hist_Ranking_v
go 
create view stg.Volunteer_Cong_Hist_Ranking_v
as
select person_id, min( start_date ) as min_dt
from (
	select 
		 *
		,datediff( d, end_date, prior_start_date ) as diff
		,case when end_date is null or datediff(d,end_date,prior_start_date) = 1 then 'Y' else 'N' end as continuous
	from (	
		select 
			 person_id
			,congregation_number
			,congregation_name
			,local_flag
			,start_date
			,end_date
			,first_value( start_date ) over ( partition by person_id order by start_date ) as first_start_date
			,first_value( start_date ) over ( partition by person_id order by start_date desc ) as latest_start_date
			,lag( start_date ) over  (partition by person_id order by start_date desc ) as prior_start_date
			,lag( end_date ) over ( partition by person_id order by start_date desc ) as prior_end_date
			,lead( start_date ) over ( partition by person_id order by start_date desc ) as next_start_date
			,lead( end_date ) over ( partition by person_id order by start_date desc ) as next_end_date
			,rank() over( partition by person_id order by start_date desc ) as rnk
		from stg.stg_app_congregation_history h
		inner join dbo.cong c
			on h.congregation_number = c.cong_number
		inner join dbo.postal_code pc
			on c.postal_code_key = pc.postal_code_key
			and pc.local_flag = 'Y'
		where 1=1
			--and person_id in ( 29396,978438,858089,498691 )
			) x 
		) xx
		--order by person_id, start_date desc
		where 1=1
			and continuous = 'Y'
		group by person_id
go
