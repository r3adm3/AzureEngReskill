#clearing connection
Disconnect-MgGraph

#Login to Microsoft Graph API (user/pass details in doc)
Connect-MgGraph


#Read a file containing a list of users into a powershell array. (Tutor will provide file) 
$users = get-content .\userlist.txt


#Write a Powershell function to create a “Password Profile”.  
function createPasswordProfile{
   
    $PasswordProfile = @{}

    $PasswordProfile["Password"]= "!NewPassword2022!"
    
    $PasswordProfile["ForceChangePasswordNextSignIn"] = $false  
   
    return $passwordProfile   
}

#Write a Powershell function to check existence of a user in the Azure Active Directory 
function doesMyUserExist{
    param(
        $userPrincipalNameToCheck
    )

    $user = get-mguser -Select Id,DisplayName,Mail,UserPrincipalName,UsageLocation,UserType | `
                where-object { $_.UserPrincipalName -eq $userPrincipalNameToCheck }
    
    if ($null -eq $user){
        return $False
    } else {
        return $True
    }
    
}

#Write a Powershell function to create the user.
function createUser{

    param(
        $funcFirstName,
        $funcSurName,
        $funcPassProfile,
        $funcMailNickName,
        $funcUserUPN
    )

    new-mguser -DisplayName "$funcFirstName $funcSurName" `
        -GivenName $funcFirstName  `
        -Surname $funcSurName  `
        -PasswordProfile $funcPassProfile  `
        -AccountEnabled:$true  `
        -mailNickname $funcMailNickName  `
        -UserPrincipalName $funcUserUPN

    write-output " FUNC: $($funcPassProfile.Password)  $funcFirstName $funcSurName $funcUserUPN"

}

#Write a Powershell script to iterate through the array and display the names.  
foreach ($user in $users){
    #split each line by column so we can make firstname lastname
    $nameArray = $user.Split(",")

    #assign first name and lastname variables so we can use them later
    $firstName = $nameArray[0]
    $lastName = $NameArray[1]
    
    #call my password profile function
    $myPasswordProfile = createPasswordProfile

    #does my user Exist function call (first construct UPN to check, then execute check)
    $userUPN = "$firstname$lastname@blanknessplc.onmicrosoft.com"
    $userExist = doesMyUserExist($userUPN)

    if ($userExist -eq $True){
        #user exists, just tell the script runner that...
        write-output "FOR: $firstName $lastName exists. Skipping."
    } else {
        #call createUserFunction, as user doesn't exist
        createUser -funcFirstName $firstName -funcSurName $lastName -funcPassProfile $myPasswordProfile -funcMailNickName $firstName -funcUserUPN $userUPN
    }

 
    #dump out result
    write-output "FOR: $($myPasswordProfile.Password) $userExist $firstName $lastName $userUPN"
}



