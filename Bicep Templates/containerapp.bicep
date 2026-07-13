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

@description('ACR username for pulling images')
param acrUsername string

@description('ACR password for pulling images')
@secure()
param acrPassword string

resource containerApp 'Microsoft.Web/containerApps@2023-10-01' = {
  name: containerAppName
  location: location
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
          username: acrUsername
          passwordSecretRef: 'acr-password'
        }
      ]
      secrets: [
        {
          name: 'acr-password'
          value: acrPassword
        }
      ]
    }
    template: {
      containers: [
        {
          name: containerAppName
          image: containerImage
          resources: {
            cpu: 0.5
            memory: '1Gi'
          }
        }
      ]
    }
  }
}

output containerAppId string = containerApp.id
output containerAppUrl string = containerApp.properties.configuration.ingress.fqdn
