$dataseturl = "groups/072d1087-6a43-4e93-8d79-1ebf36b9c03d/datasets" 
$datasetdeployResult = Invoke-PowerBIRestMethod -Url $dataseturl  -Method Get 
$datasetdeployResult 

$reporturl = "groups/072d1087-6a43-4e93-8d79-1ebf36b9c03d/reports" 
$reportdeployResult = Invoke-PowerBIRestMethod -Url $reporturl  -Method Get 
$reportdeployResult 