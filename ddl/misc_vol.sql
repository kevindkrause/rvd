update dbo.volunteer
set race_code = left(src.race,1)
from dbo.volunteer tgt
inner join stg.stg_demo src
	on tgt.HUB_Volunteer_Num = src.id_number