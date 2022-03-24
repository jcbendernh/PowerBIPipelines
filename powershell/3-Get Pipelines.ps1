$url = "pipelines" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Get 
$deployResult 