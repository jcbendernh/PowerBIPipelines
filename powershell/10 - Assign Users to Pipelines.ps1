$body = @{ 

    identifier = "john@contoso.com"
    accessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$url = "pipelines/{0}/users" -f "insert pipeline ID" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json