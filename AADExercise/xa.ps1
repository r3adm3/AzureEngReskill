#clearing connection
Disconnect-MgGraph

#Login to Microsoft Graph API (user/pass details in doc)
Connect-MgGraph

get-mguser -userid readuser@blanknessplc.onmicrosoft.com | Format-List

