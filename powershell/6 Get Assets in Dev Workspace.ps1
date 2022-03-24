$dataseturl = "groups/f47ffdf0-f1be-44d5-93a9-9faffcd8e4be/datasets" 
$datasetdeployResult = Invoke-PowerBIRestMethod -Url $dataseturl  -Method Get 
$datasetdeployResult 

$reporturl = "groups/f47ffdf0-f1be-44d5-93a9-9faffcd8e4be/reports" 
$reportdeployResult = Invoke-PowerBIRestMethod -Url $reporturl  -Method Get 
$reportdeployResult 