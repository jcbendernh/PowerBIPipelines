$devbody = @{ 

    emailAddress = "john@contoso.com"
    groupUserAccessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$devurl = "groups/insert development workspace ID/users" 
$devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Post -Body $devbody | ConvertFrom-Json

$testbody = @{ 

    emailAddress = "john@contoso.com"
    groupUserAccessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$testurl = "groups/insert test workspace ID/users" 
$testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Post -Body $testbody | ConvertFrom-Json

$body = @{ 

    emailAddress = "john@contoso.com"
    groupUserAccessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$url = "groups/insert production workspace ID/users" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json

