<#
.SYNOPSIS
    This Azure Automation runbook provides a way to back up data and OS disks of Azure VMs all Cloud Services using the companion
    runbook Backup-AzureCloudServiceVms

.DESCRIPTION
    The runbook gets the names of all Cloud Services in a Subscription and calls the Backup-AzureCloudService for each Cloud Service.  You must
    first download the Backup-AzureCloudServiceVMs runbook from the gallery before using this runbook.


   You can find more information on configuring Azure so that Azure Automation can manage your
   Azure subscription(s) here: http://aka.ms/Sspv1l

   After configuring Azure and creating the Azure Automation credential asset, you can schedule this directly in Azure using your Credential
   and Subscription Name parameters,
#>

workflow Backup-AllCloudServices
{
[OutputType( [string] )]

Param(      

        [parameter(Mandatory=$true)]
        [String]$poSh_Cred_Name,

        [parameter(Mandatory=$false)]
        [String]$SubscriptionName

      )

    # Grab the credential to use to authenticate to Azure. 
    $Cred = Get-AutomationPSCredential -Name $poSh_Cred_Name 
   
    # Connect to Azure
    Add-AzureAccount -Credential $Cred

    
      # Set Subscription to default if none passed.
    if(! $SubscriptionName) 
      {
        $currentsub = Get-AzureSubscription -Current
        $SubscriptionName = $currentsub.SubscriptionName
      }
    
    # Select the Azure subscription you want to work against
    Select-AzureSubscription -SubscriptionName $SubscriptionName
        
    # Get all cloud services in the subscription
    $cloudServiceNames = (Get-AzureService).servicename
    
    #parallel seems to break the output of the inline runbook Backup-AzureCloudService
    foreach ($name in $cloudServiceNames)
     {
      
        # Invoke a child runbook that has output
        $bOut = Backup-AzureCloudServiceVMs -poSh_Cred_Name $poSh_Cred_Name  -SubscriptionName $SubscriptionName -Cloud_Service_Name $name 
        # with optional parameters
        # $bOut = Backup-AzureCloudServiceVMs -poSh_Cred_Name $poSh_Cred_Name  -SubscriptionName $SubscriptionName  -Cloud_Service_Name $name -DestStorageAcctName 'myOtherStorageAcct' -BackupContainer "my-backups" -ForceShutdown $true -Purge_Old_Backups $false
       
        Write-Output $bOut
       
     }

    
} 


