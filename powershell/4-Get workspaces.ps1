$url = "groups?$filter=contains(name,'COVID')" 
$deployResult = Invoke-PowerBIRestMethod -Url $url -Method Get 
$deployResult 