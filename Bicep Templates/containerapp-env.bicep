@description('Name of the Azure Container Apps Environment')
param environmentName string

@description('Deployment location for the ACA environment')
param location string = resourceGroup().location

@description('Resource ID of the Log Analytics Workspace')
param logAnalyticsWorkspaceId string

resource containerAppEnv 'Microsoft.Web/kubeEnvironments@2023-10-01' = {
  name: environmentName
  location: location
  properties: {
    type: 'Managed'
    internalLoadBalancerEnabled: false
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
