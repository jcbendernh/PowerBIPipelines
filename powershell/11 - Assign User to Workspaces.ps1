$devbody = @{ 

    emailAddress = "jordanbean@microsoft.com"
    groupUserAccessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$devurl = "groups/f47ffdf0-f1be-44d5-93a9-9faffcd8e4be/users" 
$devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Post -Body $devbody | ConvertFrom-Json

$testbody = @{ 

    emailAddress = "jordanbean@microsoft.com"
    groupUserAccessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$testurl = "groups/072d1087-6a43-4e93-8d79-1ebf36b9c03d/users" 
$testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Post -Body $testbody | ConvertFrom-Json

$body = @{ 

    emailAddress = "jordanbean@microsoft.com"
    groupUserAccessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$url = "groups/0580ddc8-dd96-4021-bcb6-71001298039d/users" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json

