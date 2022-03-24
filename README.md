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

`code(Install-Module -Name MicrosoftPowerBIMgmt)`

