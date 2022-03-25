$dataseturl = "groups/{0}/datasets" -f "insert test workspace ID"
$datasetdeployResult = Invoke-PowerBIRestMethod -Url $dataseturl  -Method Get 
$datasetdeployResult 

$reporturl = "groups/{0}/reports" -f "insert test workspace ID"
$reportdeployResult = Invoke-PowerBIRestMethod -Url $reporturl  -Method Get 
$reportdeployResult 

$dashboardsurl = "groups/{0}/dashboards" -f "insert test workspace ID"
$dashboardsdeployResult = Invoke-PowerBIRestMethod -Url $dashboardsurl  -Method Get 
$dashboardsdeployResult 