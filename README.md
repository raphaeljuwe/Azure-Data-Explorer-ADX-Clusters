## Azure-Data-Explorer-ADX-Clusters 

Azure Data Explorer (ADX) clusters, Azure Monitor, and Log Analytics for  high-performance real-time data ingestion and analytics solution.

This deployment provides a solid foundation for a high-performance real-time analytics solution that can handle large volumes of telemetry and log data with near real-time processing capabilities.


adx-deployment/
├── modules/
│   ├── log-analytics.bicep        # Log Analytics workspace module
│   ├── adx-cluster.bicep         # ADX cluster and database module
│   ├── diagnostics.bicep         # Diagnostic settings module
│   ├── role-assignments.bicep    # Role assignments module
│   ├── replication.bicep         # Cross-region replication module
├── main.bicep                    # Main template to orchestrate multi-region deployment
├── parameters.json               # Parameter file for deployment

