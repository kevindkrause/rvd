﻿Clear-Host
. C:\src\hub-shell-scripts\Global\Templates\Common.ps1

# adjust these variables
$HuB = Get-HuBServer -InstanceCode "us" -EnvironmentCode Deliver
$logfile = "UpdatedApplicantAttributesLog.csv"
"Sep=;" | Out-File $logfile
"app_attribute_hist_key;Status;DateTime"|Out-File $logfile -Append
$VerbosePreference = "SilentlyContinue" #disable verbose logging
#$VerbosePreference = "Continue" #enable verbose logging
$todayDateTime= Get-Date -Format 'yyyy-MM-dd hh:mm:ss'

# Reading data from SQL Server View. Select only new attributes that need to be created.
$rrex = Invoke-Sqlcmd -ServerInstance "USSQLRVD" -Database "rvd" -Query "SELECT [app_attribute_hist_key], [applicant_id], [applicant_attribute_id], [attribute_id], [attribute], [attribute_value] FROM [data_xchg].[App_Attribute_Pending_v] WHERE [applicant_attribute_id] IS NULL ORDER BY [load_date]"
Write-Host "Processing ApplicantId IS NULL: Creating" -ForegroundColor Cyan
foreach ($rrec in $rrex)
{
   $Id= $rrec.app_attribute_hist_key
   $ApplicantId=$rrec.applicant_id
   $ItemAttributeId=$rrec.applicant_attribute_id
   $AttributeId=$rrec.attribute_id
   $AttributeValue=$rrec.attribute_value
      
    #Create request if $rrec.applicant_attribute_id is $null 
    $updatedata= 
    @{
       CreateRequests  = @(
        @{
           ItemAttributeId= -4 
           AttributeId= $AttributeId
           AttributeValue= $AttributeValue 
           IsDefault= $false 
           IsValueRequired= $false 
           WarnIfEmptyValue= $false 
           ShowOnJobOrder= $false 
           IsUserField= $false 
           #StageId= $null
        }
                           ) 
       ApplicantId= $ApplicantId
    }
    #Send the CreateRequest
    $null= PostHttp -Uri "$($HuB)/ApplicantAttributesChangeRequest"-Data $updatedata -ErrorVariable ErrorMessage -ContinueOnError

    If ($ErrorMessage){ Write-Host "Error: Update not completed" -ForegroundColor DarkRed
        "$Id;Update not completed;$todayDateTime" | Out-File $($logfile) -Append 
                      }
    else {Write-Host "Update completed" -ForegroundColor Green
         "$Id;Upated;$todayDateTime" | Out-File $($logfile) -Append 
    # Confirmation routine executes the stored procedure that will set Status complete
    $procudurevalue= "EXEC dbo.Pursued_By_Set_Complete_proc @p_app_attribute_hist_key="+$Id
    Invoke-Sqlcmd -ServerInstance "USSQLRVD" -Database "rvd" -Query $procudurevalue
         }
} 

# Reading data from SQL Server View. Select existing attributes that need to be updated.
$rrexupdate= Invoke-Sqlcmd -ServerInstance "USSQLRVD" -Database "rvd" -Query "SELECT [app_attribute_hist_key], [applicant_id], [applicant_attribute_id], [attribute_id], [attribute], [attribute_value] FROM [data_xchg].[App_Attribute_Pending_v] WHERE [applicant_attribute_id] IS NOT NULL AND [attribute] IS NOT NULL ORDER BY [load_date]"
Write-Host "Processing ApplicantId IS NOT NULL: Updating" -ForegroundColor Cyan

foreach ($rrec in $rrexupdate)
{
   $Id= $rrec.app_attribute_hist_key
   $ApplicantId=$rrec.applicant_id
   $ItemAttributeId=$rrec.applicant_attribute_id
   $AttributeId=$rrec.attribute_id
   $AttributeValue=$rrec.attribute_value
       
    #Update request If $rrec.applicant_attribute_id is not null 
    $datas= GetHttp -Uri "$($HuB)/ApplicantAttributesRequest?applicantId=$($ApplicantId)"
    $data= $datas.where({$_.ItemAttributeId -eq $ItemAttributeId})

    #Adjust the value
    Set-PropertyValue -Object $data -Key "AttributeId" -Value $AttributeId
    Set-PropertyValue -Object $data -Key "AttributeValue" -Value $AttributeValue

     $updatedata= 
     @{
      UpdateRequests= @( $data
                        )
      ApplicantId= $ApplicantId
      }
    #Send the UpdateRequest
    $null= PostHttp -Uri "$($HuB)/ApplicantAttributesChangeRequest"-Data $updatedata -ErrorVariable ErrorMessage -ContinueOnError

    If ($ErrorMessage){ Write-Host "Error: Update not completed" -ForegroundColor DarkRed
       "$Id;Update not completed;$todayDateTime" | Out-File $($logfile) -Append 
                      }
        else {Write-Host "Update completed" -ForegroundColor Green
        "$Id;Upated;$todayDateTime" | Out-File $($logfile) -Append
        # Confirmation routine executes the stored procedure that will set Status complete 
        $procudurevalue= "EXEC dbo.Pursued_By_Set_Complete_proc @p_app_attribute_hist_key="+$Id
        Invoke-Sqlcmd -ServerInstance "USSQLRVD" -Database "rvd" -Query $procudurevalue
             }
}

# Reading data from SQL Server View. Select existing attributes that need to be deleted.
$rrexdelete = Invoke-Sqlcmd -ServerInstance "USSQLRVD" -Database "rvd" -Query "SELECT [app_attribute_hist_key], [applicant_id], [applicant_attribute_id], [attribute_id], [attribute], [attribute_value] FROM [data_xchg].[App_Attribute_Pending_v] WHERE [attribute] IS NULL AND [attribute_value] IS NULL ORDER BY [load_date]"
Write-Host "Processing Attribute and AttributeValue ARE NULL: Deleting" -ForegroundColor Cyan

foreach ($rrec in $rrexdelete)
{
   $Id= $rrec.app_attribute_hist_key
   $ApplicantId=$rrec.applicant_id
   $ItemAttributeId=$rrec.applicant_attribute_id
   $AttributeId=$rrec.attribute_id
   $AttributeValue=$rrec.attribute_value
       
    #Delete request If $rrec.attribute AND $rrec.attribute_value are null
    $datas= GetHttp -Uri "$($HuB)/ApplicantAttributesRequest?applicantId=$($ApplicantId)"
    $data= $datas.where({$_.ItemAttributeId -eq $ItemAttributeId})

     $updatedata= 
     @{
          DeleteRequests= 
            @{
              ItemAttributeId= $ItemAttributeId
              ConcurrencyTokens= $data.ConcurrencyTokens
             }
          ApplicantId= $ApplicantId
       }
    #Send the DeleteRequest
    $null= PostHttp -Uri "$($HuB)/ApplicantAttributesChangeRequest"-Data $updatedata -ErrorVariable ErrorMessage -ContinueOnError

    If ($ErrorMessage){ Write-Host "Error: Update not completed" -ForegroundColor DarkRed
        "$Id;Update not completed;$todayDateTime" | Out-File $($logfile) -Append
                      }
        else {Write-Host "Update completed" -ForegroundColor Green
        "$Id;Upated;$todayDateTime" | Out-File $($logfile) -Append
        # Confirmation routine executes the stored procedure that will set Status complete
        $procudurevalue= "EXEC dbo.Pursued_By_Set_Complete_proc @p_app_attribute_hist_key="+$Id
        Invoke-Sqlcmd -ServerInstance "USSQLRVD" -Database "rvd" -Query $procudurevalue
              }
}


# UPDATE RVD METADATA TABLE WITH LATEST RUN TIMESTAMP
$sql = "update dbo.app_metadata set attribute_value = format( getdate(), 'MM/dd/yy hh:mm tt' ) where attribute_name = 'HUB_Sync_Datetime'"
Invoke-Sqlcmd -ServerInstance "USSQLRVD" -Database "rvd" -Query $sql
