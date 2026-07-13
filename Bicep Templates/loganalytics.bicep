@description('Name of the Log Analytics Workspace')
param workspaceName string

@description('Deployment location for the workspace')
param location string = resourceGroup().location

@description('SKU for the Log Analytics Workspace (PerGB2018 recommended)')
param sku string = 'PerGB2018'

@description('The data retention period in days. 30 days is the minimum.')
@minValue(30)
@maxValue(730)
param retentionInDays int = 30

@description('The maximum daily data ingestion volume limit in GB. Set to -1 for no limit.')
param dailyQuotaGb int = -1

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  sku: {
    name: sku
  }
  properties: {
    retentionInDays: retentionInDays
    dailyQuotaGb: dailyQuotaGb
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

output workspaceId string = logAnalytics.id
output workspaceCustomerId string = logAnalytics.properties.customerId
