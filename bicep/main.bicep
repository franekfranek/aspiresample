targetScope = 'resourceGroup'

@minLength(1)
@description('The location of the resource group')
param location string = resourceGroup().location

@minLength(36)
@description('Tenant Id')
param tenantId string

resource keyvault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'kv-crm-dev-${location}'
  location: location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    enableRbacAuthorization: true
    enableSoftDelete: true
    tenantId: tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'goodstorage${location}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

// resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
//   name: 'ai-crm-mlw'
//   location: location
//   kind: 'web'
//   properties: {
//     Application_Type: 'web'
//   }
// }

// module ml_us 'ml.bicep' = {
//   name: 'crm-mlw-eastus'
//   params: {
//     name: 'crm-mlw-eastus'
//     location: 'eastus'
//     keyVaultId: keyvault.id
//     storageAccountId: storageaccount.id
//     appInsightsId: appInsights.id
//   }
// }

// module ml_europe 'ml.bicep' = {
//   name: 'crm-mlw-northeurope'
//   params: {
//     name: 'crm-mlw-northeurope'
//     location: 'northeurope'
//     keyVaultId: keyvault.id
//     storageAccountId: storageaccount.id
//     appInsightsId: appInsights.id
//   }
// }

// module ml_brazil 'ml.bicep' = {
//   name: 'crm-mlw-brazilsouth'
//   params: {
//     name: 'crm-mlw-brazilsouth'
//     location: 'brazilsouth'
//     keyVaultId: keyvault.id
//     storageAccountId: storageaccount.id
//     appInsightsId: appInsights.id
//   }
// }

// module ml_asia 'ml.bicep' = {
//   name: 'crm-mlw-eastasia'
//   params: {
//     name: 'crm-mlw-eastasia'
//     location: 'eastasia'
//     keyVaultId: keyvault.id
//     storageAccountId: storageaccount.id
//     appInsightsId: appInsights.id
//   }
// }

// // speech service
// resource cognitiveService 'Microsoft.CognitiveServices/accounts@2021-10-01' = {
//   name: 'speech-crm-dev-west2'
//   location: 'westus2'
//   sku: {
//     name: 'S0'
//   }
//   properties: {
//     apiProperties: {
//       statisticsEnabled: false
//     }
//   }
//   kind: 'SpeechServices'
// }

// module dec_us 'dataExplorerCluster.bicep' = {
//   name: 'dec-crm-dev-eastus'
//   params: {
//     name: 'dec-crm-dev-eastus'
//     location: 'eastus'
//   }
// }
