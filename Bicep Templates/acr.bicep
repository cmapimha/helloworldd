@description('Name of the Azure Container Registry')
param acrName string

@description('Deployment location for the ACR')
param location string = resourceGroup().location

@description('SKU tier for the ACR (Basic, Standard, Premium)')
param sku string = 'Basic'

resource acr 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: acrName
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: true
  }
}

output acrLoginServer string = acr.properties.loginServer
output acrId string = acr.id
