$devbody = @{ 

    emailAddress = "john@contoso.com"
    groupUserAccessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$devurl = "groups/{0}/users" -f "insert development workspace ID"
$devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Post -Body $devbody | ConvertFrom-Json

$testbody = @{ 

    emailAddress = "john@contoso.com"
    groupUserAccessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$testurl = "groups/{0}/users" -f "insert test workspace ID"
$testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Post -Body $testbody | ConvertFrom-Json

$body = @{ 

    emailAddress = "john@contoso.com"
    groupUserAccessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$url = "groups/{0}/users" -f "insert production workspace ID"
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json

