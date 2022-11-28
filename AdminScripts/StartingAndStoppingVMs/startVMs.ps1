#login to azure
Login-AzAccount

#get all VMs in a particular resource group and put them in a list. 
$VMS = get-azvm | where-object -Property ResourceGroupName -Value ENGRESKILL_RG -eq 

#iterate through list of VMs and start them all in parallel
$VMS | foreach-object -parallel { start-azvm -Name $_.Name -ResourceGroupName engreskill_rg }

