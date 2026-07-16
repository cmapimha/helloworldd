@description('Name of the Azure Container Apps Environment')
param environmentName string

@description('Deployment location for the ACA environment')
param location string = resourceGroup().location

@description('Resource ID of the Log Analytics Workspace')
param logAnalyticsWorkspaceId string

// FIX: Add the existing Log Analytics resource with API version
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' existing = {
  name: last(split(logAnalyticsWorkspaceId, '/'))
}

resource containerAppEnv 'Microsoft.App/managedEnvironments@2023-05-01' = {
  name: environmentName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalytics.properties.customerId
        sharedKey: listKeys(logAnalyticsWorkspaceId, '2021-12-01-preview').primarySharedKey
      }
    }
  }
}

output environmentId string = containerAppEnv.id

