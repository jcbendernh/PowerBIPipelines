$devbody = @{ 

    workspaceId = "[insert development workspace ID]"

} | ConvertTo-Json

$devurl = "pipelines/[insert pipeline ID]/stages/0/assignWorkspace" 
$devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Post -Body $devbody | ConvertFrom-Json
$devdeployResult | Format-List


$testbody = @{ 

    workspaceId = "[insert test workspace ID]"

} | ConvertTo-Json

$testurl = "pipelines/[insert pipeline ID]/stages/1/assignWorkspace" 
$testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Post -Body $testbody | ConvertFrom-Json
$testdeployResult | Format-List


$body = @{ 

    workspaceId = "[insert production workspace ID]"

} | ConvertTo-Json

$url = "pipelines/[insert pipeline ID]/stages/2/assignWorkspace" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json
$deployResult | Format-List



