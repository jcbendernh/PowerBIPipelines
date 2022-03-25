$url = "pipelines/insert pipeline ID/users/john@contoso.com" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Delete 
$deployResult 