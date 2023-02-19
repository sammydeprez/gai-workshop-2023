param location string
param name string
param tags object
param storageAccountId string
param keyvaultId string
param containerRegistryId string
param applicationInsightsId string

resource workspaceName 'Microsoft.MachineLearningServices/workspaces@2022-01-01-preview' = {
  tags: tags
  name: name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    tier: 'Basic'
    name: 'Basic'
  }
  properties: {
    friendlyName: name
    storageAccount: storageAccountId
    keyVault: keyvaultId
    applicationInsights: applicationInsightsId
    containerRegistry: containerRegistryId

  }
}

resource compute 'Microsoft.MachineLearningServices/workspaces/computes@2022-10-01' = {
  name: '${workspaceName.name}/${substring(uniqueString(workspaceName.name), 0, 5)}'
  location: location
  properties: {
    computeType: 'ComputeInstance'
    properties: {
      vmSize: 'Standard_DS3_v2'
    }
  }
}
