$dataseturl = "groups/{0}/datasets" -f "insert dev workspace ID"
$datasetdeployResult = Invoke-PowerBIRestMethod -Url $dataseturl  -Method Get 
$datasetdeployResult 

$reporturl = "groups/{0}/reports" -f "insert dev workspace ID"
$reportdeployResult = Invoke-PowerBIRestMethod -Url $reporturl  -Method Get 
$reportdeployResult 

$dashboardsurl = "groups/{0}/dashboards" -f "insert dev workspace ID"
$dashboardsdeployResult = Invoke-PowerBIRestMethod -Url $dashboardsurl  -Method Get 
$dashboardsdeployResult 