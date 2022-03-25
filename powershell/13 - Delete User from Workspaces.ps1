$devurl = "groups/{0}/users/john@contoso.com" -f "insert development workspace ID"
$devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Delete  | ConvertFrom-Json


$testurl = "groups/{0}/users/john@contoso.com" -f "insert test workspace ID"
$testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Delete  | ConvertFrom-Json


$url = "groups/{0}/users/john@contoso.com" -f "insert production workspace ID"
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Delete | ConvertFrom-Json

