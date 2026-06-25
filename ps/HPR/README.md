**1 - Confirm access to the directory**

&#x20;   ls "H:\\HPR\\Personnel Support\\RVD\\app\_dev\\powershell"



**2 - Decide if you want to run using a local version or the centralized version**

&#x20;   if you want a local version, copy the powershell directory to your desired location



**3 - Set the local environment variable**

&#x20;   \[Environment]::SetEnvironmentVariable(

&#x20;       "$PSScriptRoot",

&#x20;       "H:\\HPR\\Personnel Support\\RVD\\app\_dev\\powershell\\hub-shell-scripts\\Global\\Templates",

&#x20;       "User"

&#x20;   )



&#x20;   If you have a local version, point the variable to your target.



**4 - Install the SS libraries**

&#x20;   Install-Module -Name SqlServer -Scope CurrentUser



**5 - Test the script**

&#x20;   powershell .\\HPR-UpdateApplicantAttributes.ps1



**6 - If you need to schedule the script, you can find a sample task in the directory**

&#x20;   Task - App Attributes.xml

