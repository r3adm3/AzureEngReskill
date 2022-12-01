#login to azure
Login-AzAccount

#get all VMs in a particular resource group and put them in a list. 
$VMS = get-azvm | where-object -Property ResourceGroupName -Value ENGRESKILL_RG -eq 

#iterate through list of VMs and run commands
$VMS | foreach-object -parallel { 
    Invoke-AzVMRunCommand -resourcegroupname engreskill_rg -VMName $_.Name -CommandId runpowershellscript -scriptstring "invoke-webrequest -URI `"https://github.com/PowerShell/PowerShell/releases/download/v7.3.0/PowerShell-7.3.0-win-x64.msi`" -outfile c:\users\studentadmin\Downloads\powershell7.msi"
 }

#iterate through list of VMs and run commands
$VMS | foreach-object -parallel { 
    Invoke-AzVMRunCommand -resourcegroupname engreskill_rg -VMName $_.Name -CommandId runpowershellscript -scriptstring "hostname; get-childitem c:\users\studentadmin\Downloads"
}

#iterate through list of VMs and run commands
$VMS | foreach-object -parallel { 
    Invoke-AzVMRunCommand -resourcegroupname engreskill_rg -VMName $_.Name -CommandId runpowershellscript -scriptstring Invoke-AzVMRunCommand -resourcegroupname engreskill_rg -VMName $_.Name -CommandId runpowershellscript -scriptstring "hostname; msiexec /i c:\users\studentadmin\Downloads\Powershell7.msi /q/n"
}