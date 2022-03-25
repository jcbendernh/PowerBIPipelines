$body = @{ 
    sourceStageOrder = 1 # The order of the source stage. Test (1), Production (2).   
       

    options = @{
        # Allows creating new artifact if needed on the Test stage workspace
        allowCreateArtifact = $TRUE

        # Allows overwriting existing artifact if needed on the Test stage workspace
        allowOverwriteArtifact = $TRUE
    }
} | ConvertTo-Json


$url = "pipelines/{0}/deployAll" -f "insert pipeline ID"
$deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json