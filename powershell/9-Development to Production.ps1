$body = @{ 
    sourceStageOrder = 1 # The order of the source stage. Test (1), Production (2).   
    datasets = @(
        @{sourceId = "94a99d74-1206-4f6a-bda6-285085f4fca1" }
    )      
    reports = @(
        @{sourceId = "11f81ae8-3579-4924-8b12-efff375b6b8b" }
    )            

    options = @{
        # Allows creating new artifact if needed on the Test stage workspace
        allowCreateArtifact = $TRUE

        # Allows overwriting existing artifact if needed on the Test stage workspace
        allowOverwriteArtifact = $TRUE
    }
} | ConvertTo-Json


$url = "pipelines/{0}/Deploy" -f "321ae3ef-0f78-4936-aa89-21503c50d9e8"
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json