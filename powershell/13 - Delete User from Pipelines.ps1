$url = "groups/0580ddc8-dd96-4021-bcb6-71001298039d/users/jordanbean@microsoft.com" 
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Delete | ConvertFrom-Json

