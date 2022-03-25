$url = "pipelines/{0}/users/john@contoso.com" -f "insert pipeline ID"
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Delete 
$deployResult 