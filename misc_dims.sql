DECLARE @StartDate  date = '20200101';

DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 10, @StartDate));

;WITH seq(n) AS 
	( SELECT 0 UNION ALL SELECT n + 1 FROM seq WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
	),
d(d) AS 
	( SELECT DATEADD(DAY, n, @StartDate) FROM seq ),
src AS
	( SELECT
		TheDate         = CONVERT(date, d),
		TheDay          = DATEPART(DAY,       d),
		TheDayName      = DATENAME(WEEKDAY,   d),
		TheWeek         = DATEPART(WEEK,      d),
		TheISOWeek      = DATEPART(ISO_WEEK,  d),
		TheDayOfWeek    = DATEPART(WEEKDAY,   d),
		TheMonth        = DATEPART(MONTH,     d),
		TheMonthName    = DATENAME(MONTH,     d),
		TheQuarter      = DATEPART(Quarter,   d),
		TheYear         = DATEPART(YEAR,      d),
		TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
		TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
		TheDayOfYear    = DATEPART(DAYOFYEAR, d)
	  FROM d ),
dim AS
	( SELECT
		TheDate, 
		TheDay,
		TheDaySuffix = CONVERT(char(2), CASE WHEN TheDay / 10 = 1 THEN 'th' ELSE 
							CASE RIGHT(TheDay, 1) WHEN '1' THEN 'st' WHEN '2' THEN 'nd' 
							WHEN '3' THEN 'rd' ELSE 'th' END END) ,
		TheDayName,
		TheDayOfWeek,
		TheDayOfWeekInMonth = CONVERT(tinyint, ROW_NUMBER() OVER 
							(PARTITION BY TheFirstOfMonth, TheDayOfWeek ORDER BY TheDate)),
		TheDayOfYear,
		IsWeekend           = CASE WHEN TheDayOfWeek IN (CASE @@DATEFIRST WHEN 1 THEN 6 WHEN 7 THEN 1 END,7) 
							THEN 1 ELSE 0 END,
		TheWeek,
		TheISOweek,
		TheFirstOfWeek      = DATEADD(DAY, 1 - TheDayOfWeek, TheDate),
		TheLastOfWeek       = DATEADD(DAY, 6, DATEADD(DAY, 1 - TheDayOfWeek, TheDate)),
		TheWeekOfMonth      = CONVERT(tinyint, DENSE_RANK() OVER 
							(PARTITION BY TheYear, TheMonth ORDER BY TheWeek)),
		TheMonth,
		TheMonthName,
		TheFirstOfMonth,
		TheLastOfMonth      = MAX(TheDate) OVER (PARTITION BY TheYear, TheMonth),
		TheFirstOfNextMonth = DATEADD(MONTH, 1, TheFirstOfMonth),
		TheLastOfNextMonth  = DATEADD(DAY, -1, DATEADD(MONTH, 2, TheFirstOfMonth)),
		TheQuarter,
		TheFirstOfQuarter   = MIN(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
		TheLastOfQuarter    = MAX(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
		TheYear,
		TheISOYear          = TheYear - CASE WHEN TheMonth = 1 AND TheISOWeek > 51 THEN 1 
							WHEN TheMonth = 12 AND TheISOWeek = 1  THEN -1 ELSE 0 END,      
		TheFirstOfYear      = DATEFROMPARTS(TheYear, 1,  1),
		TheLastOfYear,
		IsLeapYear          = CONVERT(bit, CASE WHEN (TheYear % 400 = 0) 
							OR (TheYear % 4 = 0 AND TheYear % 100 <> 0) 
							THEN 1 ELSE 0 END),
		Has53Weeks          = CASE WHEN DATEPART(WEEK,     TheLastOfYear) = 53 THEN 1 ELSE 0 END,
		Has53ISOWeeks       = CASE WHEN DATEPART(ISO_WEEK, TheLastOfYear) = 53 THEN 1 ELSE 0 END,
		MMYYYY              = CONVERT(char(2), CONVERT(char(8), TheDate, 101))
							+ CONVERT(char(4), TheYear),
		Style101            = CONVERT(char(10), TheDate, 101),
		Style103            = CONVERT(char(10), TheDate, 103),
		Style112            = CONVERT(char(8),  TheDate, 112),
		Style120            = CONVERT(char(10), TheDate, 120)
	  FROM src )

insert into dbo.cal_dim
select 
	 thedate as cal_dt 
	,thedayname as day_nm
	,thedayofweek as day_of_wk
	,theday as day_of_mth
	,thedaysuffix as day_nm_suffix
	,thedayofweekinmonth as day_of_wk_in_mth
	,thedayofyear day_in_yr
	,isweekend as wknd_ind
	,theweek as wk
	,thefirstofweek as wk_start_dt
	,thelastofweek as wk_end_dt
	,theweekofmonth as wk_in_mth
	,themonth as mth
	,themonthname as mth_nm
	,thefirstofmonth as mth_start_dt
	,thelastofmonth as mth_end_dt
	,thefirstofnextmonth as next_mth_start_dt
	,thelastofnextmonth as next_mth_end_dt
	,thequarter as qtr
	,thefirstofquarter as qtr_start_dt
	,thelastofquarter as qtr_end_dt
	,theyear as yr    
	,thefirstofyear as yr_start_dt
	,thelastofyear as yr_end_dt
	,isleapyear as leap_yr_ind
	,has53weeks as yr_53_wk_ind
from dim
--where thedate = '2023-02-07'
order by thedate
option ( maxrecursion 0 );

