targetScope = 'subscription'

param rgName string = 'rg-kannadi-prod'
param rgLocation string = 'centralus'
param storageAccountName string
param containerName string

// 1. Create the Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: rgName
  location: rgLocation
}

// 2. Deploy Storage Module inside the Resource Group
module storage 'main.bicep' = {
  scope: rg
  name: 'storageModule'
  params: {
    location: rg.location
    storageAccountName: storageAccountName
    containerName: containerName
  }
}