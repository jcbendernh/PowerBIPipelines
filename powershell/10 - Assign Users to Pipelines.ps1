$body = @{ 

    identifier = "jordanbean@microsoft.com"
    accessRight = "Admin"
    principalType = "User"

} | ConvertTo-Json

$url = "pipelines/321ae3ef-0f78-4936-aa89-21503c50d9e8/users" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json



