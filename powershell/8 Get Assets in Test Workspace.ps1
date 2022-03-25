$dataseturl = "groups/insert test workspace ID/datasets" 
$datasetdeployResult = Invoke-PowerBIRestMethod -Url $dataseturl  -Method Get 
$datasetdeployResult 

$reporturl = "groups/insert test workspace ID/reports" 
$reportdeployResult = Invoke-PowerBIRestMethod -Url $reporturl  -Method Get 
$reportdeployResult 

$dashboardsurl = "groups/insert test workspace ID/dashboards" 
$dashboardsdeployResult = Invoke-PowerBIRestMethod -Url $dashboardsurl  -Method Get 
$dashboardsdeployResult 