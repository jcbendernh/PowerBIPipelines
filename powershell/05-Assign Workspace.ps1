$devbody = @{ 

    workspaceId = "insert development workspace ID"

} | ConvertTo-Json

$devurl = "pipelines/{0}/stages/0/assignWorkspace" -f "insert pipeline ID"
$devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Post -Body $devbody | ConvertFrom-Json
$devdeployResult | Format-List


$testbody = @{ 

    workspaceId = "insert test workspace ID"

} | ConvertTo-Json

$testurl = "pipelines/{0}/stages/1/assignWorkspace" -f "insert pipeline ID"
$testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Post -Body $testbody | ConvertFrom-Json
$testdeployResult | Format-List


$body = @{ 

    workspaceId = "insert production workspace ID"

} | ConvertTo-Json

$url = "pipelines/{0}/stages/2/assignWorkspace" -f "insert pipeline ID"
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json
$deployResult | Format-List



