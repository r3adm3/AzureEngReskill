#clearing connection
Disconnect-MgGraph

#Login to Microsoft Graph API (user/pass details in doc)
Connect-MgGraph

$PasswordProfile = @{}

$PasswordProfile["Password"]= "!NewPassword2022!"

$PasswordProfile["ForceChangePasswordNextSignIn"] = $false

new-mguser -DisplayName "Test User" `
            -GivenName "Test"  `
            -Surname "User"  `
            -PasswordProfile $PasswordProfile  `
            -AccountEnabled:$true  `
            -mailNickname "doodad"  `
            -UserPrincipalName "testuser@blanknessplc.onmicrosoft.com"

update-mguser -UserId testuser@blanknessplc.onmicrosoft.com -UsageLocation GB

set-mgUserLicense -UserId testuser@blanknessplc.onmicrosoft.com -AddLicenses @{SkuId = "f245ecc8-75af-4f8e-b61f-27d8114de5f3"} -RemoveLicenses @()