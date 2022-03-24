$body = @{ 

    displayName = "COVID Power BI Pipeline Wed"
    description = "My deployment pipeline description"

} | ConvertTo-Json

$url = "pipelines" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json
$deployResult | Format-List