$body = @{ 

    displayName = "insert pipeline name here"
    description = "insert pipeline descrition here"

} | ConvertTo-Json

$url = "pipelines" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json
$deployResult | Format-List