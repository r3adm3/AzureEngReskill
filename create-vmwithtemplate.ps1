#login to azure
Login-AzAccount

#use alias short to allow older *AzureRM* cmdlet syntax
Enable-AzureRmAlias

#deploy VM to resource group
New-AzureRmResourceGroupDeployment -ResourceGroup engReskill_rg -TemplateFile .\er-2019\octopus.json