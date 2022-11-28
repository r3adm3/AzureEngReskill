
#needs nic to change its IP to point to domain controller. 
set-dnsclientserveraddress -interfaceIndex 5 -ServerAddresses 10.0.1.33

#join domain
add-computer –domainname "myforest.local"  -restart