// Module to deploy ADX cluster and database
param clusterName string
param databaseName string
param location string
param skuName string
param capacity int
param retentionDays int
param tags object

resource adxCluster 'Microsoft.Kusto/clusters@2023-08-15' = {
  name: clusterName
  location: location
  tags: tags
  sku: {
    name: skuName
    capacity: capacity
    tier: 'Standard'
  }
  properties: {
    trustedExternalTenants: []
    enableStreamingIngest: true
    enablePurge: true
    enableDoubleEncryption: true
  }
}

resource adxDatabase 'Microsoft.Kusto/clusters/databases@2023-08-15' = {
  name: '${adxCluster.name}/${databaseName}'
  location: location
  properties: {
    hotCachePeriod: 'P7D'
    softDeletePeriod: 'P${retentionDays}D'
  }
}

output clusterId string = adxCluster.id
output clusterUri string = adxCluster.properties.uri
output databaseName string = adxDatabase.name
