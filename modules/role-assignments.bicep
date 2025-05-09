// Module to assign roles for ADX and Log Analytics
param clusterId string
param workspaceId string

resource adxContributorRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(clusterId, 'contributor')
  scope: clusterId
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
    principalId: loggedInUser.objectId
  }
}

resource logAnalyticsReaderRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(workspaceId, 'logreader')
  scope: workspaceId
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '73c42c96-874c-492b-b04d-ab87d138a893')
    principalId: loggedInUser.objectId
  }
}
