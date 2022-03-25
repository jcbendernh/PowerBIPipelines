$body = @{ 

    identifier = "john@contoso.com"
    accessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$url = "pipelines/insert pipeline ID/users" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json