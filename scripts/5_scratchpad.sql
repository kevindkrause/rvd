select ul.user_list, ul.ad_user_name, ulv.* from dbo.User_List_Volunteer_v ulv
inner join dbo.User_List_v ul on ulv.user_list_key = ul.user_list_key where sort_order is not null
order by 2