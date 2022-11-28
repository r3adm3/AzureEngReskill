#login to Azure
Login-AzAccount

#get all vms in a particular resource group, and put them into an array
$VMS = get-azvm | where-object -Property ResourceGroupName -Value ENGRESKILL_RG -eq 

#iterate through all of the VMs, and stop them
$VMS | foreach-object -parallel { stop-azvm -Name $_.Name -ResourceGroupName engreskill_rg -force }

