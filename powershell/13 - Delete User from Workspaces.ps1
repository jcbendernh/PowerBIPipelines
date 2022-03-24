$devurl = "groups/f47ffdf0-f1be-44d5-93a9-9faffcd8e4be/users/jordanbean@microsoft.com" 
$devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Delete  | ConvertFrom-Json


$testurl = "groups/072d1087-6a43-4e93-8d79-1ebf36b9c03d/users/jordanbean@microsoft.com" 
$testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Delete  | ConvertFrom-Json


$url = "groups/0580ddc8-dd96-4021-bcb6-71001298039d/users/jordanbean@microsoft.com" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Delete | ConvertFrom-Json

