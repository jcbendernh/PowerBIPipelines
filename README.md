# PowerBIPipelines
In this repo, we will review three options available with regards to creating and executing Power BI Pipelines:
1. [Manually through the Power BI Web Service](#manually-through-the-power-bi-web-service)
2. [Utilize PowerShell commands via the Power BI Rest API](#utilize-powershell-commands-via-the-power-bi-rest-api)
3. [Utilize Azure DevOps](https://github.com/jcbendernh/PowerBIPipelines#utilize-azure-devops)

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

This is done manually through the Power BI Workspace via a web browser.  There are some great tutorials for this on Microsoft Docs:
- [Get started with deployment pipelines](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-get-started)
- [Assign a workspace to a deployment pipeline](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-assign)

- - - -
###  Utilize PowerShell commands via the Power BI Rest API

This option allows you to interact with the [Power BI REST API](https://docs.microsoft.com/en-us/rest/api/power-bi/) to automate commands via HTTP requests. Below are some example PowerShell scripts you can use that are based on the PowerShell examples at https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-automation#powershell-example.  These scripts are also found in the [powershell folder](./powershell) of this repository.

To utilize this functionality, you must install the Power BI Cmdlets for PowerShell by utilizing the following command in PowerShell.

```powershell
Install-Module -Name MicrosoftPowerBIMgmt
```

For more on this topic check out [Microsoft Power BI Cmdlets for Windows PowerShell and PowerShell Core](https://docs.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps)

To prepare for this section, create 3 workspaces:  Dev, Test, and Production.  Upload a report into the Dev workspace and create a dashboard in the Dev workspace so that you have a dataset, report and dashboard in your Dev workspace.  Do not add any assets to the other workspaces.

1. First we need to connect to the Power BI service.  For the command below we are connecting as the Azure AD user, when running this, it will open an authentication prompt to connect as that user.
    ```powershell
    Connect-PowerBIServiceAccount
    ```
    You can utilize other sign in options.  They are detailed at [Connect-PowerBIServiceAccount](https://docs.microsoft.com/en-us/powershell/module/microsoftpowerbimgmt.profile/connect-powerbiserviceaccount?view=powerbi-ps)

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

3. This is optional, if you ever need to get a listing of the pipelines in your tenant, this will generate a listing with their corresponding Ids as well.
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

5. Now we will assign the Development, Test and Production workspaces to the recently created pipeline.  We will need to insert the workspace Ids and the Pipeline Id into the PowerShell script below.
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

6. In preparation for promoting the assets in the Dev workspace to the Test workspace, let's get a listing of them so that we have their Ids.
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

8. In preparation for promoting the assets in the Test workspace to the Production workspace, let's get a listing of them so that we have their Ids.
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

10. This next command is only needed if you want to add a user to the pipeline.
    ```powershell
    $body = @{ 

        identifier = "john@contoso.com"
        accessRight = "Admin"
        principalType = "User"

    } | ConvertTo-Json

    $url = "pipelines/insert pipeline ID/users" 
    $deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json
    ```

11. If you added a user to a pipeline, you also need to give them the correct permissions to the workspaces within the pipeline.  For this example, we will add the user as a Workspace Admin to all workspaces.
    ```powershell
    $devbody = @{ 

        emailAddress = "john@contoso.com"
        groupUserAccessRight = "Admin"
        principalType = "User"

    } | ConvertTo-Json

    $devurl = "groups/insert development workspace ID/users" 
    $devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Post -Body $devbody | ConvertFrom-Json

    $testbody = @{ 

        emailAddress = "john@contoso.com"
        groupUserAccessRight = "Admin"
        principalType = "User"

    } | ConvertTo-Json

    $testurl = "groups/insert test workspace ID/users" 
    $testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Post -Body $testbody | ConvertFrom-Json

    $body = @{ 

        emailAddress = "john@contoso.com"
        groupUserAccessRight = "Admin"
        principalType = "User"

    } | ConvertTo-Json

    $url = "groups/insert production workspace ID/users" 
    $deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json
    ```

12. This next command is only needed if you want to delete a user from the pipeline.
    ```powershell
    $url = "pipelines/insert pipeline ID/users/john@contoso.com" 
    $deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Delete 
    $deployResult 
    ```

13. Finally if you deleted the user from the pipeline, you may want to also delete them from the workspaces.
    ```powershell
    $devurl = "groups/insert development workspace ID/users/john@contoso.com" 
    $devdeployResult = Invoke-PowerBIRestMethod -Url $devurl  -Method Delete  | ConvertFrom-Json


    $testurl = "groups/insert test workspace ID/users/john@contoso.com" 
    $testdeployResult = Invoke-PowerBIRestMethod -Url $testurl  -Method Delete  | ConvertFrom-Json


    $url = "groups/insert production workspace ID/users/john@contoso.com" 
    $deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Delete | ConvertFrom-Json
    ```

- - - -
###  Utilize Azure DevOps
This allows you to automate the entire process using Azure DevOps.  There is one caveat to utilizing this; For enterprise deployments using multi-factor authentication, you must enable the Power BI service admin settings for a designated service principle.  

This is done in the Power BI web service under the Admin Portal | Tenant Settings.  For more on this topic, check out [Automate deployment pipelines - Use the Power BI automation tools extension](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-automation#use-the-power-bi-automation-tools-extension). 


#### Power BI automation tools
1. To add the [Power BI automation tools](https://marketplace.visualstudio.com/items?itemName=ms-pbi-api.pbi-automation-tools) to your Azure DevOps instance, within Azure DevOps, go to Organizational Settings | Extensions and click Browse marketplace and search for <b>Power BI automation tools</B> and click the <B>Get it Free button</B> and then add it to your organization.

2. Next you will need to add a service connection to your DevOps project under that organization.  To do so, go into the DevOps project you will utilize with the Power BI automation tools.  Under Settings | Service Connections, click New service connection and select Power BI and click Next.  Fill out the appropriate settings under Edit Service Connection and click Save:
    1. Environment: options are Public, US Government, etc.  <i>Most often this is Public.</i>
    2. Service Principle Id = Application (client) ID of the Service Principle in Active Directory
    3. Service principal key = The client secret value under the Service Principle in Active Directory
    4. Tenant ID = Application (client) ID of the Service Principle in Active Directory
    5. Service connection name: descriptive name for your service connection.

3. Next you can add tasks to your pipeline within DevOps by searching under Power BI under Add tasks.  The following tasks are available to utilize:
    1. Delete a deployment pipeline
    2. Create a new deployment pipeline
    3. Assign a workspace to deployment pipeline
    4. Add a user to a workspace
    5. Remove a workspace from a deployment pipeline
    6. Add a user to a deployment pipeline
    7. Deploy content in a deployment pipeline

#### PowerShell commands within Azure DevOps
Alternatively you could utilize PowerShell commands as your tasks within your DevOps pipelines.  However, to do so, you must use an installed certificate to the Public cloud with your Service Principal.  For more on this topic see [Connect-PowerBIServiceAccount](https://docs.microsoft.com/en-us/powershell/module/microsoftpowerbimgmt.profile/connect-powerbiserviceaccount?view=powerbi-ps)

Furthermore, in order for DevOps to keep the PowerBIMgmt library across PowerShell tasks, make sure to utilize the script below as your first task in the pipeline
```javascript
Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser -AcceptLicense -AllowClobber -SkipPublisherCheck -Force

Import-Module -Name MicrosoftPowerBIMgmt
```

After that, you will need to execute the Connect-PowerBIServiceAccount command.  Below is a PowerShell script example.
```javascript
Connect-PowerBIServiceAccount -ServicePrincipal -CertificateThumbprint 38DA4BED389A014E69A6E6D8AE56761E85F0DFA4 -ApplicationId b5fde143-722c-4e8d-8113-5b33a9291468
```




