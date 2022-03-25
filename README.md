# PowerBIPipelines
In this repo, I will walk you through three options available with regards to utilizing Power BI Pipelines:
1. Manually through the Power BI Web Service
2. Utilize PowerShell commands via the Power BI Rest API
3. Utilize Azure DevOps

## Key Concepts

### Understanding Permissions

Permissions for utilizing Power Bi Pipelines are twofold:
1. <B>Power BI Pipeline Permissions</B> - For a pipeline you can only choose to be an Admin and that gives you the ability to interact with the pipelines.
2. <B>Power BI Workspace Permissions</B> - For a user to effectively interact with Power BI pipelines, they will need proper permissions to the underlying workspaces within the pipeline.  The following online documentation describes the various workspace roles and how they correspond to pipeline permissions. [Understand the deployment process - Permissions](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-process?WT.mc_id=access_pane#permissions).

### Other Important Items

For more information on pipelines check out [Introduction to deployment pipelines](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-overview)

Also check out [Deployment pipelines best practices](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-best-practices)

## Deployment Options

### Manually through the Power BI Web Service

This is done manually through the Power BI Workspace via a web browser.  There are some really good tutorials for this on Microsoft Docs:
- [Get started with deployment pipelines](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-get-started)
- [Assign a workspace to a deployment pipeline](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-assign)

###  Utilize PowerShell commands via the Power BI Rest API

This option allows you to interact with the [Power BI REST API](https://docs.microsoft.com/en-us/rest/api/power-bi/) to automate commands via HTTP reqeusts. Below are some example powershell scripts you can use that are based on the Powershell examples at https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-automation#powershell-example.  These scripts are also found in the [powershell folder](./powershell) of this repository.

To utilize this functionality you must install the Power BI Cmdlets for Powershell by utilizing the following command in PowerShell.

```powershell
Install-Module -Name MicrosoftPowerBIMgmt
```

For more on this topic check out [Microsoft Power BI Cmdlets for Windows PowerShell and PowerShell Core](https://docs.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps)

To prepare for this section, create 3 workspaces:  Dev, Test, and Production.  Upload a report into the Dev workspace and create a dsahboard in the Dev workspace so that you have a dataset, report and dashboard in your Dev workspace.  Do not add any assets to the other workspaces.

1. First we need to connect to the Power BI service.  For the command below we are connecting as the Azure AD user, when running this, it will open an authentication prompt to connect as that user.
    ```powershell
    Connect-PowerBIServiceAccount
    ```
    You can utilize other signin options.  They are detailed at [onnect-PowerBIServiceAccount](https://docs.microsoft.com/en-us/powershell/module/microsoftpowerbimgmt.profile/connect-powerbiserviceaccount?view=powerbi-ps)

2. We will now create our pipeline using the code below.  Make sure to capture the id from the results after the script completes successfully.
    ```powershell
    $body = @{ 

        displayName = "insert pipeline name here"
        description = "insert pipeline descrition here"

    } | ConvertTo-Json

    $url = "pipelines" 
    $deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json
    $deployResult | Format-List
    ```

3. This is optional, if you ever need to get a listing of the pipelines in your tenant, this will generate a listing with the Ids as well.
    ```powershell
    $url = "pipelines" 
    $deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Get 
    $deployResult 
    ```

4. In preparation for assigning the workspaces to the pipeline, we need to fetch the workspace Ids.  To do so, we will use the code below
    ```powershell
    $url = "groups" 
    $deployResult = Invoke-PowerBIRestMethod -Url $url -Method Get 
    $deployResult 
    ```
    You can also apply filters to this.  For reference see [Group - Get Groups](https://docs.microsoft.com/en-us/rest/api/power-bi/groups/get-groups)

5. Now we will assign the Development, Test and Production workspaces to the reently created pipeline.  We will need to insert the workspace Ids and the Pipeline Id into the PowerShell script below.
    ```powershell
    $devbody = @{ 

        workspaceId = "insert development workspace ID"

    } | ConvertTo-Json

    $devurl = "pipelines/insert pipeline ID/stages/0/assignWorkspace" 
    $devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Post -Body $devbody | ConvertFrom-Json
    $devdeployResult | Format-List


    $testbody = @{ 

        workspaceId = "insert test workspace ID"

    } | ConvertTo-Json

    $testurl = "pipelines/insert pipeline ID/stages/1/assignWorkspace" 
    $testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Post -Body $testbody | ConvertFrom-Json
    $testdeployResult | Format-List


    $body = @{ 

        workspaceId = "insert production workspace ID"

    } | ConvertTo-Json

    $url = "pipelines/insert pipeline ID/stages/2/assignWorkspace" 
    $deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json
    $deployResult | Format-List
    ```

6. In preparation for promoting the assets in the Dev workspace to the Test workspace, lets get a listing of them so that we have their Ids.
    ```powershell
    $dataseturl = "groups/insert dev workspace ID/datasets" 
    $datasetdeployResult = Invoke-PowerBIRestMethod -Url $dataseturl  -Method Get 
    $datasetdeployResult 

    $reporturl = "groups/insert dev workspace ID/reports" 
    $reportdeployResult = Invoke-PowerBIRestMethod -Url $reporturl  -Method Get 
    $reportdeployResult 

    $dashboardsurl = "groups/insert dev workspace ID/dashboards" 
    $dashboardsdeployResult = Invoke-PowerBIRestMethod -Url $dashboardsurl  -Method Get 
    $dashboardsdeployResult 
    ```

7. Now we are going to selectively promote assets from the Development workspace to the Test workspace using the script below.
    ```powershell
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
    ```

8. In preparation for promoting the assets in the Test workspace to the Prodcution workspace, lets get a listing of them so that we have their Ids.
    ```powershell
    $dataseturl = "groups/insert test workspace ID/datasets" 
    $datasetdeployResult = Invoke-PowerBIRestMethod -Url $dataseturl  -Method Get 
    $datasetdeployResult 

    $reporturl = "groups/insert test workspace ID/reports" 
    $reportdeployResult = Invoke-PowerBIRestMethod -Url $reporturl  -Method Get 
    $reportdeployResult 

    $dashboardsurl = "groups/insert test workspace ID/dashboards" 
    $dashboardsdeployResult = Invoke-PowerBIRestMethod -Url $dashboardsurl  -Method Get 
    $dashboardsdeployResult 
    ```

9. Now we are going to selectively promote assets from the Test workspace to the Production workspace using the script below.
    ```powershell
    $body = @{ 
        sourceStageOrder = 1 # The order of the source stage. Test (1), Production (2).   
        datasets = @(
            @{sourceId = "Insert dataset ID" }
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
    ```