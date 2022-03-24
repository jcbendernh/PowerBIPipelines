$body = @{ 
    sourceStageOrder = 0 # The order of the source stage. Development (0), Test (1).   
    datasets = @(
        @{sourceId = "00618dab-79d5-4538-a14a-704e0704440d" }
    )      
    reports = @(
        @{sourceId = "761a3847-4523-43e8-b1e6-4c44f79f5861" }
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