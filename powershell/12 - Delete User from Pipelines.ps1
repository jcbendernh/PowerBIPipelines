$url = "pipelines/321ae3ef-0f78-4936-aa89-21503c50d9e8/users/jordanbean@microsoft.com" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Delete 
$deployResult 