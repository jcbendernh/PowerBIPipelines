$body = @{ 
    sourceStageOrder = 0 # The order of the source stage. Development (0), Test (1).   
    datasets = @(
        @{sourceId = "Insert dataset ID " }
    )      
    reports = @(
        @{sourceId = "Insert report ID" }
    )            
    dashboards = @(
        @{sourceId = "Insert dashboard ID" }
    )        

    options = @{
        # Allows creating new artifact if needed on the Test stage workspace
        allowCreateArtifact = $TRUE

        # Allows overwriting existing artifact if needed on the Test stage workspace
        allowOverwriteArtifact = $TRUE
    }
} | ConvertTo-Json


$url = "pipelines/{0}/Deploy" -f "insert pipeline ID"
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json