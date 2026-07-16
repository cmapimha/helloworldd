@description('Name of the Azure Container Apps Environment')
param environmentName string

@description('Deployment location for the ACA environment')
param location string = resourceGroup().location

@description('Resource ID of the Log Analytics Workspace')
param logAnalyticsWorkspaceId string

resource containerAppEnv 'Microsoft.App/managedEnvironments@2023-05-01' = {
  name: environmentName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: reference(logAnalyticsWorkspaceId).customerId
        sharedKey: listKeys(logAnalyticsWorkspaceId, '2022-10-01').primarySharedKey
      }
    }
  }
}

output environmentId string = containerAppEnv.id
