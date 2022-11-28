
#https://blog.netwrix.com/2018/06/07/how-to-create-new-active-directory-users-with-powershell/
#https://www.sqlshack.com/powershell-split-a-string-into-an-array/
#https://www.red-gate.com/simple-talk/sysadmin/powershell/powershell-and-secure-strings/

Function Get-RandomAlphanumericString {
	
	[CmdletBinding()]
	Param (
        [int] $length = 8
	)

	Begin{
	}

	Process{
        Write-Output ( -join ((0x30..0x39) + ( 0x41..0x5A) + ( 0x61..0x7A) | Get-Random -Count $length  | % {[char]$_}) )
	}	
}

$users = get-content .\newusers.txt

foreach ($user in $users){

	$nameArray = $user.Split(" ")
	$username = "$($nameArray[0].SubString(0,1))$($nameArray[1])"
	$pass = "$(Get-RandomAlphanumericString -length 12)1££"
	
	write-output "$user ---------------"
	write-output "  - firstname: $($nameArray[0])"
	write-output "  - givenname: $($nameArray[1])"
	write-output "  - username : $username"
	write-output "  - pass     : $pass" 

	# Create User and set password, stick them in myUsers OU (means I can delete them easier)
	New-ADUser -Name $user -GivenName $nameArray[0] -Surname $nameArray[1] -SamAccountName $username -AccountPassword (ConvertTo-SecureString($pass) -AsPlainText) -Path "OU=MyUsers,DC=myforest,DC=local" -Enabled $true

	# Create User and set password, stick them in default OU
	#New-ADUser -Name $user -GivenName $nameArray[0] -Surname $nameArray[1] -SamAccountName $username -AccountPassword (ConvertTo-SecureString($pass) -AsPlainText) -Enabled $true

}


# Write-Host ("Alfa Beta " | Tee-Object -Variable txt) ($txt.length)

#Write-Host "A: "(Get-RandomAlphanumericString | Tee-Object -variable teeTime ) ("len=$($teeTime.length)")
#Write-Host "B: "(Get-RandomAlphanumericString -length 22 | Tee-Object -variable teeTime ) ("len=$($teeTime.length)")