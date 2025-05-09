// Module to deploy resources in a single region
param location string
param workspaceName string
param adxClusterName string
param adxDatabaseName string
param adxSkuName string
param adxCapacity int
param logRetentionDays int
param adxRetentionDays int
param tags object

// Log Analytics Workspace
module logAnalytics './log-analytics.bicep' = {
  name: '${workspaceName}-log-analytics'
  params: {
    workspaceName: workspaceName
    location: location
    logRetentionDays: logRetentionDays
    tags: tags
  }
}

// ADX Cluster and Database
module adxCluster './adx-cluster.bicep' = {
  name: '${adxClusterName}-adx'
  params: {
    clusterName: adxClusterName
    databaseName: adxDatabaseName
    location: location
    skuName: adxSkuName
    capacity: adxCapacity
    retentionDays: adxRetentionDays
    tags: tags
  }
}

// Diagnostic Settings
module diagnostics './diagnostics.bicep' = {
  name: '${adxClusterName}-diagnostics'
  params: {
    clusterId: adxCluster.outputs.clusterId
    workspaceId: logAnalytics.outputs.workspaceId
    logRetentionDays: logRetentionDays
  }
  dependsOn: [logAnalytics, adxCluster]
}

// Role Assignments
module roleAssignments './role-assignments.bicep' = {
  name: '${adxClusterName}-roles'
  params: {
    clusterId: adxCluster.outputs.clusterId
    workspaceId: logAnalytics.outputs.workspaceId
  }
  dependsOn: [logAnalytics, adxCluster]
}

// Outputs
output logAnalyticsWorkspaceId string = logAnalytics.outputs.workspaceId
output adxClusterId string = adxCluster.outputs.clusterId
output adxClusterUri string = adxCluster.outputs.clusterUri
output adxDatabaseName string = adxCluster.outputs.databaseName
