$devurl = "groups/nsert development workspace ID/users/john@contoso.com" 
$devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Delete  | ConvertFrom-Json


$testurl = "groups/nsert test workspace ID/users/john@contoso.com" 
$testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Delete  | ConvertFrom-Json


$url = "groups/nsert production workspace ID/users/john@contoso.com" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Delete | ConvertFrom-Json

