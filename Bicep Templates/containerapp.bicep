@description('Name of the Azure Container App')
param containerAppName string

@description('Deployment location for the Container App')
param location string = resourceGroup().location

@description('Fully qualified container image name (e.g., myacr.azurecr.io/app:latest)')
param containerImage string

@description('Resource ID of the Container Apps Environment')
param environmentId string

@description('Login server of the Azure Container Registry')
param acrLoginServer string

resource containerApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: containerAppName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    managedEnvironmentId: environmentId
    configuration: {
      ingress: {
        external: true
        targetPort: 3000
      }
      registries: [
        {
          server: acrLoginServer
          identity: 'systemAssigned'
        }
      ]
    }
    template: {
      containers: [
        {
          name: containerAppName
          image: containerImage
          resources: {
            cpu: 1
            memory: '1Gi'
          }
        }
      ]
    }
  }
}

output containerAppId string = containerApp.id
output containerAppUrl string = containerApp.properties.configuration.ingress.fqdn

