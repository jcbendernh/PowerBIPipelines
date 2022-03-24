# PowerBIPipelines
In this repo, I will walk you through three options available with regards to utilizing Power BI Pipelines:
1. Manually through the Power BI Web Service
2. Utilize Powershell commands via the Power BI Rest API
3. Utilize Azure DevOps

## Key Concepts

### Understanding Permissions

Permissions for utilizing Power Bi Pipelines are twofold:
1. <B>Power BI Pipeline Permissions</B> - For a pipeline you can only choose to be an Admin and that gives you the ability to run the pipelines.
2. <B>Power BI Workspace Permissions</B> - For a user to effectively interact with Power BI pipelines, they will need proper permissions to the underlying workspaces within the pipeline.  The following online documentation describes the various workspace roles and how they correspond to pipeline permissions. [Understand the deployment process - Permissions](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-process?WT.mc_id=access_pane#permissions).

### Other Important Items

For more information on pipelines check out [Introduction to deployment pipelines](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-overview)

Also check out Deployment pipelines best practices](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-best-practices)

## Deployment Options

### Manually through the Power BI Web Service

This is done manually through the Power BI Workspace via a web browser.  There are some really good tutorials for this on Microsoft Docs:
- [Get started with deployment pipelines](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-get-started)
- [Assign a workspace to a deployment pipeline](https://docs.microsoft.com/en-us/power-bi/create-reports/deployment-pipelines-assign)

