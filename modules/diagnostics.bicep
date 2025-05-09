// Module to configure diagnostic settings
param adxCluster string
param workspaceId string
param logRetentionDays int

resource adxDiagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'adxDiagnostics'
  scope: adxCluster
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'Operation'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: logRetentionDays
        }
      }
      {
        category: 'Ingestion'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: logRetentionDays
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: logRetentionDays
        }
      }
    ]
  }
}
