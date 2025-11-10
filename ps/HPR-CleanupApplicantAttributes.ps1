Clear-Host
. C:\src\hub-shell-scripts\Global\Templates\Common.ps1

# adjust these variables
$HuB = Get-HuBServer -InstanceCode "us" -EnvironmentCode Deliver
$logfile = "UpdatedApplicantAttributesLog.csv"
"Sep=;" | Out-File $logfile
"app_attribute_hist_key;Status;DateTime"|Out-File $logfile -Append
$VerbosePreference = "SilentlyContinue" #disable verbose logging
#$VerbosePreference = "Continue" #enable verbose logging
$todayDateTime= Get-Date -Format 'yyyy-MM-dd hh:mm:ss'

# Reading data from SQL Server View. Select existing attributes that need to be deleted.
$rrexdelete = Invoke-Sqlcmd -ServerInstance "USSQLRVD" -Database "rvd" -Query "SELECT [app_attribute_hist_key], [applicant_id], [applicant_attribute_id], [attribute_id], [attribute] FROM [data_xchg].[tmp_cleanup] ORDER BY 1"
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
    $data= $datas.where({$_.AttributeId -eq $AttributeId})

     $updatedata= 
     @{     DeleteRequests= 
            @(@{
              ItemAttributeId= $data.ItemAttributeId
              ConcurrencyTokens= @($data.ConcurrencyTokens)
             })
          ApplicantId= $ApplicantId
       }
    #Send the DeleteRequest
    $null= PostHTTP -Uri "$($HuB)/ApplicantAttributesChangeRequest"-Data $updatedata -ErrorVariable ErrorMessage -ContinueOnError

    If ($ErrorMessage){ Write-Host "Error: Update not completed" -ForegroundColor DarkRed
        "$Id;Update not completed;$todayDateTime" | Out-File $($logfile) -Append
                      }
        else {Write-Host "Update completed" -ForegroundColor Green
        "$Id;Upated;$todayDateTime" | Out-File $($logfile) -Append
              }
}
