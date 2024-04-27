set identity_insert dbo.App_Metadata on
go
insert into dbo.App_Metadata(
	App_Metadata_Key 		,
	App_Metadata_Type_Code 	,
	Attribute_Name 			,
	Attribute_Value	,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.App_Metadata
go
set identity_insert dbo.App_Metadata off
go


set identity_insert dbo.App_Status on
go
insert into dbo.App_Status(
	App_Status_Key 		,
	App_Status_Code 	,
	App_Status 			,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.App_Status
go
set identity_insert dbo.App_Status off
go


set identity_insert dbo.App_Type on
go
insert into dbo.App_Type(
App_Type_Key 		,
App_Type_Code 	,
App_Type_Name 			,
HUB_App_Type_ID,
Active_Flag 			,
Load_Date 				,
Update_Date 			)
select * from rvdrehearsal.dbo.App_Type
go
set identity_insert dbo.App_Type off
go


set identity_insert dbo.App_Version on
go
insert into dbo.App_Version(
App_Version_Key 		,
App_Version_Number 	,
App_Version_Name 			,
Notes,
Active_Flag 			,
Load_Date 				,
Update_Date 			)
select * from rvdrehearsal.dbo.App_Version
go
set identity_insert dbo.App_Version off
go


set identity_insert dbo.Attribute_Data_Type on
go
insert into dbo.Attribute_Data_Type(
Attribute_Data_Type_Key 		,
Attribute_Data_Type 	,
Data_Format 			,
Attribute_Data_Type_Desc,
Active_Flag 			,
Load_Date 				,
Update_Date 			)
select * from rvdrehearsal.dbo.Attribute_Data_Type
go
set identity_insert dbo.Attribute_Data_Type off
go


set identity_insert dbo.Attribute_LOV on
go
insert into dbo.Attribute_LOV(
Attribute_LOV_Key 		,
Attribute_LOV 	,
Attribute_LOV_Value 			,
Active_Flag 			,
Load_Date 				,
Update_Date 			)
select * from rvdrehearsal.dbo.Attribute_LOV
go
set identity_insert dbo.Attribute_LOV off
go


set identity_insert dbo.Cong on
go
insert into dbo.Cong(
Cong_Key 				,
Cong_Number 			,
Cong 					,
Cong_Fullname 			,
City 					,
State_Key 				,
Postal_Code_Key			,
Country_Key				,
Circuit 				,
Language_Code 			,
KH_Address1 			,
KH_Address2 			,
KH_City 				,
KH_State_Code 			,
KH_Postal_Code			,
KH_Country_Code			,
COBE_Volunteer_Key		,
COBE_Person_ID			,
COBE_First_Name 		,
COBE_Last_Name 			,
COBE_Email 				,
COBE_Mobile_Phone		,
Sec_Volunteer_Key		,
Sec_Person_ID			,
Sec_First_Name 			,
Sec_Last_Name 			,
Sec_Email 				,
Sec_Mobile_Phone		,
CO_Volunteer_Key		,
CO_Person_ID			,
CO_First_Name 			,
CO_Last_Name 			,
CO_Email 				,
CO_Mobile_Phone			,
Driving_Distance_Flag 	,
Dissolved_Date 			,
Active_Flag 			,
Load_Date 				,
Update_Date 			)
select * from rvdrehearsal.dbo.Cong
go
set identity_insert dbo.Cong off
go


set identity_insert dbo.Country on
go
insert into dbo.Country(
	Country_Key 		,
	Country_Code 	,
	Country 			,
	Country_VID,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Country
go
set identity_insert dbo.Country off
go


set identity_insert dbo.Enrollment on
go
insert into dbo.Enrollment(
	Enrollment_Key,
	Enrollment_Code,
	Enrollment 	,
	Enrollment_Desc,
	Rank_Num 		,
	Primary_Flag 	,
	FTS_Flag 		,
	SFTS_Flag 		,
	Bethel_Flag 	,
	Bethel_Family_Flag ,
	Regular_Bethel_Flag ,
	Foreign_Service_Flag ,
	Transition_Flag 	,
	Start_Date 			,
	End_Date 			,
	Active_Flag 			,
	Enrollment_VID 		,
	Load_Date 				,
	Update_Date 			)
select Enrollment_Key,
	Enrollment_Code,
	Enrollment 	,
	Enrollment_Desc,
	Rank_Num 		,
	Primary_Flag 	,
	FTS_Flag 		,
	SFTS_Flag 		,
	Bethel_Flag 	,
	Bethel_Family_Flag ,
	Regular_Bethel_Flag ,
	Foreign_Service_Flag ,
	Transition_Flag 	,
	Start_Date 			,
	End_Date 			,
	Active_Flag 			,
	Enrollment_VID 		,
	Load_Date 				,
	Update_Date 
from rvdrehearsal.dbo.Enrollment
go
set identity_insert dbo.Enrollment off
go


set identity_insert dbo.ETL_Table_Run on
go
insert into dbo.ETL_Table_Run(
	ETL_Table_Run_Key 		,
	ETL_Table 	,
	Status_Code 			,
	Rows_Inserted,
	Rows_Updated 			,
	Rows_Deleted 				,
	Start_Time,
	End_Time 			)
select * from rvdrehearsal.dbo.ETL_Table_Run
go
set identity_insert dbo.ETL_Table_Run off
go


set identity_insert dbo.Event on
go
insert into dbo.Event(
	Event_Key 			,
	Event_Type_Key 		,
	Event_System_Key 	,
	Event 				,
	Event_Description 	,
	Tracking_Code 		,
	Coor_User_Key 		,
	Start_Date 			,
	End_Date 			,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Event
go
set identity_insert dbo.Event off
go


set identity_insert dbo.Event_Attribute on
go
insert into dbo.Event_Attribute(
	Event_Attribute_Key 	,
	Event_Key 				,
	Event_Attribute 		,
	Event_Attribute_Group 	,
	Crew_Key 				,
	Attribute_Data_Type_Key ,
	Attribute_LOV_Key 		,
	Column_Number 			,
	TO_Profile_Active_Flag 	,
	WRK_Event_Attribute_Key,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Event_Attribute
go
set identity_insert dbo.Event_Attribute off
go


set identity_insert dbo.Event_System on
go
insert into dbo.Event_System(
	Event_System_Key 	,
	Event_System 				,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Event_System
go
set identity_insert dbo.Event_System off
go


set identity_insert dbo.Event_Type on
go
insert into dbo.Event_Type(
	Event_Type_Key 	,
	Event_Type 				,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Event_Type
go
set identity_insert dbo.Event_Type off
go


set identity_insert dbo.Marital_Status on
go
insert into dbo.Marital_Status(
	Marital_Status_Key 	,
	Marital_Status_Code 				,
	Marital_Status,
	Marital_Status_VID,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Marital_Status
go
set identity_insert dbo.Marital_Status off
go


set identity_insert dbo.Postal_Code on
go
insert into dbo.Postal_Code(
	Postal_Code_Key 	,
	Postal_Code 				,
	City,
	State_Key,
	Local_Flag,
	Driving_Distance_Flag,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Postal_Code
go
set identity_insert dbo.Postal_Code off
go


set identity_insert dbo.Skill on
go
insert into dbo.Skill(
	Skill_Key 	,
	Skill 				,
	HUB_Skill_ID,
	HUB_Flag,
	BA_Skill_GUID,
	BA_Flag,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Skill
go
set identity_insert dbo.Skill off
go


set identity_insert dbo.Skill_Level on
go
insert into dbo.Skill_Level(
	Skill_Level_Key 	,
	Skill_Level_Code 				,
	Skill_Level,
	Skill_Level_Desc,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Skill_Level
go
set identity_insert dbo.Skill_Level off
go


set identity_insert dbo.Skill_Speciality on
go
insert into dbo.Skill_Speciality(
	Skill_Speciality_Key 	,
	Skill_Key 				,
	Skill_Speciality,
	HUB_Skill_Speciality_ID,
	HUB_Flag,
	BA_Subskill_GUID,
	BA_Flag,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Skill_Speciality
go
set identity_insert dbo.Skill_Speciality off
go


set identity_insert dbo.Source_System on
go
insert into dbo.Source_System(
	Source_System_Key 	,
	Source_System_Code 				,
	Source_System,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Source_System
go
set identity_insert dbo.Source_System off
go


set identity_insert dbo.State on
go
insert into dbo.State(
	State_Key 	,
	State_Code	,
	State,
	Country_Key,
	State_VID,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.State
go
set identity_insert dbo.State off
go


set identity_insert dbo.Tracking_Status on
go
insert into dbo.Tracking_Status(
	Tracking_Status_Key 	,
	Tracking_Status,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Tracking_Status
go
set identity_insert dbo.Tracking_Status off
go


set identity_insert dbo.[User] on
go
insert into dbo.[User](
	User_Key,
	First_Name,
	Last_Name,
	Email,
	AD_User_Name,
	PC_Name,
	User_Access_Level_Code,
	Refresh_Flag,
	Admin_Flag,
	Active_Flag,
	Load_Date,
	Update_Date )
select * from rvdrehearsal.dbo.[User]
go
set identity_insert dbo.[User] off
go


insert into dbo.User_Access_Level(
	User_Access_Level_Code,
	User_Access_Level,
	Active_Flag,
	Load_Date,
	Update_Date )
select * from rvdrehearsal.dbo.User_Access_Level
go


set identity_insert dbo.User_Activity on
go
insert into dbo.User_Activity(
	User_Activity_Key,
	User_Key,
	User_Computer_Name,
	Login_Datetime,
	Logoff_Datetime )
select * from rvdrehearsal.dbo.User_Activity
go
set identity_insert dbo.User_Activity off
go


set identity_insert dbo.User_List on
go
insert into dbo.User_List(
	User_List_Key 	,
	User_Key,
	User_List,
	User_List_Description,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.User_List
go
set identity_insert dbo.User_List off
go


set identity_insert dbo.User_List_Volunteer on
go
insert into dbo.User_List_Volunteer(
	User_List_Volunteer_Key 	,
	User_List_Key,
	Volunteer_Key,
	Sort_Order,
	User_List_Volunteer_Status_Key,
	Status_Date,
	Notes,
	Last_Changed_User_Key,
	Start_Date,
	End_Date,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.User_List_Volunteer
go
set identity_insert dbo.User_List_Volunteer off
go


set identity_insert dbo.User_List_Volunteer_Status on
go
insert into dbo.User_List_Volunteer_Status(
	User_List_Volunteer_Status_Key 	,
	User_List_Volunteer_Status,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.User_List_Volunteer_Status
go
set identity_insert dbo.User_List_Volunteer_Status off
go


set identity_insert dbo.Volunteer on
go
insert into dbo.Volunteer(
	Volunteer_Key 					
	,Full_Name 						
	,Last_Name 						
	,First_Name 						
	,Middle_Name 					
	,Preferred_Name 					
	,Suffix 							
	,Maiden_Name 					
	,Address 						
	,Address2 						
	,City 							
	,Postal_Code_Key 				
	,State_Key 						
	,Country_Key 					
	,Preferred_Phone 				
	,Preferred_Phone_Type 			
	,Preferred_Phone_Formatted 		
	,Home_Phone 						
	,Mobile_Phone 					
	,Email 							
	,Alt_Email 						
	,Birth_Date 						
	,Baptism_Date 					
	,Gender_Code 					
	,Marital_Status_Key 				
	,Cong_Servant_Code 				
	,Pioneer_Flag 					
	,Cong_Key 						
	,Trade_Contact_Group_Key 		
	,Crew_Key 						
	,Vol_Desk_User_Key 				
	,Tracking_Status_Key 			
	,Tracking_Status_Date 			
	,TCG_Contact 					
	,TCG_Contact_Notes 				
	,TCG_Contact_Status_Notes	 	
	,TCG_Contact_Date 				
	,Vol_Desk_Notes 					
	,Trade_Ovsr_Notes 				
	,Avail_Short_Notice_Flag 		
	,Avail_Times_Yr 
	,BA_Volunteer_ID
	,BA_Volunteer_Num 				
	,BA_Active_Flag 					
	,BA_Profile_Created_Flag 		
	,BA_Profile_Create_Date 			
	,HUB_Person_ID 
	,HUB_Person_GUID
	,HUB_Volunteer_Num				
	,HUB_Tracking_Flag				
	,JW_User_Code 					
	,JW_Username 					
	,Mate_BA_Volunteer_ID
	,Mate_BA_Volunteer_Num 			
	,Mate_HUB_Person_ID 
	,Mate_HUB_Person_GUID	
	,A8_Approved_Flag 				
	,A8_App_Status_Key 				
	,A8_App_Date 					
	,A19_Approved_Flag 				
	,A19_App_Status_Key 				
	,A19_App_Date 					
	,Current_Enrollment_Key 			
	,Current_Enrollment_Start_Date	
	,Current_Enrollment_End_Date 	
	,Load_Date 				
	,Update_Date 			)
select * from rvdrehearsal.dbo.Volunteer
go
set identity_insert dbo.Volunteer off
go


set identity_insert dbo.Volunteer_App on
go
insert into dbo.Volunteer_App(
	Volunteer_App_Key ,			
	Volunteer_Key 		,		
	App_Type_Key 		,		
	App_Status_Key 		,		
	App_Date 			,		
	Expiration_Date 	,		
	Status_Notes 		,		
	App_Notes 			,		
	Review_Status_Submitted_Date,
	Review_Stage_Elders_Date 	,
	Review_Stage_CO_Date 		,
	Attrib_Approval_Level 		,
	Attrib_Pursued_By 			,
	Attrib_Contacted 			,
	Attrib_SKE 					,
	Attrib_Other 				,
	Applicant_ID 				,
	Expired_Flag 				,
	Active_Flag, 	
	Load_Date, 				
	Update_Date 			)
select 
	Volunteer_App_Key ,			
	Volunteer_Key 		,		
	App_Type_Key 		,		
	App_Status_Key 		,		
	App_Date 			,		
	Expiration_Date 	,		
	Status_Notes 		,		
	App_Notes 			,		
	Review_Status_Submitted_Date,
	Review_Stage_Elders_Date 	,
	Review_Stage_CO_Date 		,
	Attrib_Approval_Level 		,
	Attrib_Pursued_By 			,
	Attrib_Contacted 			,
	Attrib_SKE 					,
	Attrib_Other 				,
	Applicant_ID 				,
	Expired_Flag 				,
	Active_Flag, 	
	Load_Date, 				
	Update_Date
from rvdrehearsal.dbo.Volunteer_App
go
set identity_insert dbo.Volunteer_App off
go


set identity_insert dbo.Volunteer_Availability on
go
insert into dbo.Volunteer_Availability(
	Volunteer_Availability_Key ,			
	Volunteer_Key 		,		
	Avail_As_Consultant_Flag			,
	Avail_As_Commuter_Flag 				,
	Avail_As_Commuter_As_Needed_Flag	,
	Avail_As_Commuter_Closest_Site 		,
	Avail_As_Commuter_Days_Per_Wk 		,
	Avail_As_Commuter_Weekly_Flag		,
	Avail_As_Commuter_Notes 			,
	Avail_As_Commuter_Mon_AM_Flag		,
	Avail_As_Commuter_Mon_PM_Flag		,
	Avail_As_Commuter_Tue_AM_Flag		,
	Avail_As_Commuter_Tue_PM_Flag		,
	Avail_As_Commuter_Wed_AM_Flag		,
	Avail_As_Commuter_Wed_PM_Flag		,
	Avail_As_Commuter_Thu_AM_Flag		,
	Avail_As_Commuter_Thu_PM_Flag		,
	Avail_As_Commuter_Fri_AM_Flag		,
	Avail_As_Commuter_Fri_PM_Flag		,
	Avail_As_Commuter_Sat_AM_Flag		,
	Avail_As_Commuter_Sat_PM_Flag		,
	Avail_As_Commuter_Sun_AM_Flag		,
	Avail_As_Commuter_Sun_PM_Flag		,
	Avail_As_Remote_Vol_Flag			,
	Avail_As_Remote_Vol_Days_Per_Wk 	,
	Avail_As_Remote_Vol_Notes 			,
	Avail_As_Vol_Flag 					,
	Avail_As_Vol_Anytime_Flag			,
	Avail_As_Vol_Start_Date 			,
	Avail_As_Vol_End_Date 				,
	Avail_As_Vol_Date_Notes 			,
	Avail_As_Vol_Date_Short_Term_Days 	,
	Avail_As_Vol_Long_Term_Flag 		,
	Avail_As_Vol_Notes					,	
	Active_Flag, 	
	Load_Date, 				
	Update_Date 			)
select 
	Volunteer_Availability_Key ,			
	Volunteer_Key 		,		
	Avail_As_Consultant_Flag			,
	Avail_As_Commuter_Flag 				,
	Avail_As_Commuter_As_Needed_Flag	,
	Avail_As_Commuter_Closest_Site 		,
	Avail_As_Commuter_Days_Per_Wk 		,
	Avail_As_Commuter_Weekly_Flag		,
	Avail_As_Commuter_Notes 			,
	Avail_As_Commuter_Mon_AM_Flag		,
	Avail_As_Commuter_Mon_PM_Flag		,
	Avail_As_Commuter_Tue_AM_Flag		,
	Avail_As_Commuter_Tue_PM_Flag		,
	Avail_As_Commuter_Wed_AM_Flag		,
	Avail_As_Commuter_Wed_PM_Flag		,
	Avail_As_Commuter_Thu_AM_Flag		,
	Avail_As_Commuter_Thu_PM_Flag		,
	Avail_As_Commuter_Fri_AM_Flag		,
	Avail_As_Commuter_Fri_PM_Flag		,
	Avail_As_Commuter_Sat_AM_Flag		,
	Avail_As_Commuter_Sat_PM_Flag		,
	Avail_As_Commuter_Sun_AM_Flag		,
	Avail_As_Commuter_Sun_PM_Flag		,
	Avail_As_Remote_Vol_Flag			,
	Avail_As_Remote_Vol_Days_Per_Wk 	,
	Avail_As_Remote_Vol_Notes 			,
	Avail_As_Vol_Flag 					,
	Avail_As_Vol_Anytime_Flag			,
	Avail_As_Vol_Start_Date 			,
	Avail_As_Vol_End_Date 				,
	Avail_As_Vol_Date_Notes 			,
	Avail_As_Vol_Date_Short_Term_Days 	,
	Avail_As_Vol_Long_Term_Flag 		,
	Avail_As_Vol_Notes					,
	Active_Flag, 	
	Load_Date, 				
	Update_Date
from rvdrehearsal.dbo.Volunteer_Availability
go
set identity_insert dbo.Volunteer_Availability off
go


set identity_insert dbo.Volunteer_Dept on
go
insert into dbo.Volunteer_Dept(
	Volunteer_Dept_Key 		,
	Volunteer_Key 			,
	Person_ID				,
	Site_Code 				,
	Parent_Dept_Name		,
	Dept_Name 				,
	Temp_Flag 				,
	Primary_Flag			,
	Enrollment_Code 		,
	Start_Date 				,
	End_Date 				,
	Notes					,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Volunteer_Dept
go
set identity_insert dbo.Volunteer_Dept off
go


set identity_insert dbo.Volunteer_Enrollment on
go
insert into dbo.Volunteer_Enrollment(
	Volunteer_Enrollment_Key 		,
	Volunteer_Key 			,
	Enrollment_Key				,
	Geo_Name,
	Site_Code 				,
	Dept_Code		,
	Dept_Name 				,
	Notes 				,
	Start_Date 				,
	End_Date 				,
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Volunteer_Enrollment
go
set identity_insert dbo.Volunteer_Enrollment off
go


set identity_insert dbo.Volunteer_Event on
go
insert into dbo.Volunteer_Event(
	Volunteer_Event_Key 		,
	Volunteer_Key 			,
	Event_Key				,
	Vol_Desk_User_Key,
	Notes 				,
	File_URL		,
	Start_Date 				,
	Response_Date 				,
	WRK_Volunteer_Event_Key 				,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Volunteer_Event
go
set identity_insert dbo.Volunteer_Event off
go


set identity_insert dbo.Volunteer_Event_Data on
go
insert into dbo.Volunteer_Event_Data(
	Volunteer_Event_Data_Key 		,
	Volunteer_Event_Key 			,
	Event_Attribute_Key				,
	Event_Data,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Volunteer_Event_Data
go
set identity_insert dbo.Volunteer_Event_Data off
go


set identity_insert dbo.Volunteer_ID_Xref on
go
insert into dbo.Volunteer_ID_Xref(
	Volunteer_Key 		,
	HUB_Person_ID 			,
	HUB_Volunteer_Num				,
	VAX_Volunteer_VID,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Volunteer_ID_Xref
go
set identity_insert dbo.Volunteer_ID_Xref off
go


set identity_insert dbo.Volunteer_Search_Save on
go
insert into dbo.Volunteer_Search_Save(
	Volunteer_Search_Save_Key 	,
	User_Key 					,
	Search_Time 				,
	Description 				,
	cmbSkill_Key 				,
	cmbSkill_Speciality_Key 	,
	cmbSkill_Level_Key 			,
	cmbSkill_Key_2 				,
	cmbSkill_Speciality_Key_2 	,
	cmbSkill_Level_Key_2		,
	cmbSkill_Key_3 				,
	cmbSkill_Speciality_Key_3 	,
	cmbSkill_Level_Key_3		,
	cmbSkill_Key_4 				,
	cmbSkill_Speciality_Key_4 	,
	cmbSkill_Level_Key_4		,
	cmbSkill_Key_5 				,
	cmbSkill_Speciality_Key_5 	,
	cmbSkill_Level_Key_5		,
	txtAvailDate 				,
	cmbGender 					,
	cmbServant 					,
	cmbMaritalStatus 			,
	cmbPioneer 					,
	cmbAgeFrom 					,
	cmbAgeTo 					,
	cmbLocal 					,
	cmbDrivingDistance 			,
	txtTCGDate 					,
	cmbCurrEnrl 				,
	cmbVolDeskUser 				,
	cmbTracking_Status 			,
	txtTrackingDate 			,
	cmbEvent 					,
	cmbList 					,
	cmbFormstackQuestion1 		,
	cmbFormstackResp1 			,
	cmbFormstackQuestion2 		,
	cmbFormstackResp2 			,
	cmbFormstackQuestion3 		,
	cmbFormstackResp3 			,
	cmbFormstackQuestion4 		,
	cmbFormstackResp4 			,
	cmbFormstackQuestion5 		,
	cmbFormstackResp5 			,
	A8_Status 					,
	A19_Status 					,
	txtAppFrom 					,
	txtAppThru 					,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Volunteer_Search_Save
go
set identity_insert dbo.Volunteer_Search_Save off
go


set identity_insert dbo.Volunteer_Skill on
go
insert into dbo.Volunteer_Skill(
	Volunteer_Skill_Key 	,
	Volunteer_Key 			,
	Skill_Speciality_Key	,
	Skill_Level_Key 		,
	Source_System_Key		,
	Skill_Description 		,
	Yrs_Exp 				,
	Personal_Notes 			, 
	Ovsr_Assessment_Name	,
	Ovsr_Assessment_Skill_Level_Key,
	Ovsr_Assessment_Notes	,
	Ovsr_Assessment_Date 	,	
	Active_Flag 			,
	Load_Date 				,
	Update_Date 			)
select * from rvdrehearsal.dbo.Volunteer_Skill
go
set identity_insert dbo.Volunteer_Skill off
go
