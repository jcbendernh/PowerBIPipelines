$devbody = @{ 

    workspaceId = "f47ffdf0-f1be-44d5-93a9-9faffcd8e4be"

} | ConvertTo-Json

$devurl = "pipelines/321ae3ef-0f78-4936-aa89-21503c50d9e8/stages/0/assignWorkspace" 
$devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Post -Body $devbody | ConvertFrom-Json
$devdeployResult | Format-List


$testbody = @{ 

    workspaceId = "072d1087-6a43-4e93-8d79-1ebf36b9c03d"

} | ConvertTo-Json

$testurl = "pipelines/321ae3ef-0f78-4936-aa89-21503c50d9e8/stages/1/assignWorkspace" 
$testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Post -Body $testbody | ConvertFrom-Json
$testdeployResult | Format-List


$body = @{ 

    workspaceId = "0580ddc8-dd96-4021-bcb6-71001298039d"

} | ConvertTo-Json

$url = "pipelines/321ae3ef-0f78-4936-aa89-21503c50d9e8/stages/2/assignWorkspace" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json
$deployResult | Format-List



