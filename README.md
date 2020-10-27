Backup VMs in all Cloud Services using Azure Automation
=======================================================

            



 This runbooks can be scheduled in Azure Automation to backup all VMs in a subscription by cloud service or it can easily be modified to backup specific cloud services.  It is to be used in conjunction with companion runbook
 Backup-AzureCloudServiceVMs that must be dowloaded from the Gallery before using this runbook. You must first create an Azure Automation PowerShell Credential and pass the name of that credential to the runbook parameter -posh_cred_name.  A different
 subscription name can also be passed but it will use the default subscription for the specified credential if -subscriptionname parameter is left blank.




        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
