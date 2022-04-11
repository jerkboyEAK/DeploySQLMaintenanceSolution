#
# Module manifest for module 'dbatools'
#
# Generated by: Chrissy LeMaire
#
# Generated on: 9/8/2015
#
@{

    # Script module or binary module file associated with this manifest.
    RootModule             = 'dbatools.psm1'

    # Version number of this module.
    ModuleVersion          = '1.1.11'

    # ID used to uniquely identify this module
    GUID                   = '9d139310-ce45-41ce-8e8b-d76335aa1789'

    # Author of this module
    Author                 = 'the dbatools team'

    # Company or vendor of this module
    CompanyName            = 'dbatools.io'

    # Copyright statement for this module
    Copyright              = 'Copyright (c) 2021 by dbatools, licensed under MIT'

    # Description of the functionality provided by this module
    Description            = "The community module that enables SQL Server Pros to automate database development and server administration"

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion      = '3.0'

    # Name of the Windows PowerShell host required by this module
    PowerShellHostName     = ''

    # Minimum version of the Windows PowerShell host required by this module
    PowerShellHostVersion  = ''

    # Minimum version of the .NET Framework required by this module
    DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module
    CLRVersion             = ''

    # Processor architecture (None, X86, Amd64, IA64) required by this module
    ProcessorArchitecture  = ''

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules        = @()

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies     = @()

    # Script files () that are run in the caller's environment prior to importing this module
    ScriptsToProcess       = @()

    # Type files (xml) to be loaded when importing this module
    TypesToProcess         = @("xml\dbatools.Types.ps1xml")

    # Format files (xml) to be loaded when importing this module
    # "xml\dbatools.Format.ps1xml"
    FormatsToProcess       = @("xml\dbatools.Format.ps1xml")

    # Modules to import as nested modules of the module specified in ModuleToProcess
    NestedModules          = @()

    # Functions to export from this module
    # Specific functions to export for Core, etc are also found in psm1
    # FunctionsToExport specifically helps with AUTO-LOADING so do not remove
    FunctionsToExport      = @(
        'Add-DbaAgDatabase',
        'Add-DbaAgListener',
        'Add-DbaAgReplica',
        'Add-DbaComputerCertificate',
        'Add-DbaDbMirrorMonitor',
        'Add-DbaDbRoleMember',
        'Add-DbaPfDataCollectorCounter',
        'Add-DbaRegServer',
        'Add-DbaRegServerGroup',
        'Add-DbaServerRoleMember',
        'Backup-DbaComputerCertificate',
        'Backup-DbaDatabase',
        'Backup-DbaDbCertificate',
        'Backup-DbaDbMasterKey',
        'Backup-DbaServiceMasterKey',
        'Clear-DbaConnectionPool',
        'Clear-DbaLatchStatistics',
        'Clear-DbaPlanCache',
        'Clear-DbaWaitStatistics',
        'Connect-DbaInstance',
        'ConvertTo-DbaDataTable',
        'ConvertTo-DbaTimeline',
        'ConvertTo-DbaXESession',
        'Copy-DbaAgentAlert',
        'Copy-DbaAgentJob',
        'Copy-DbaAgentJobCategory',
        'Copy-DbaAgentOperator',
        'Copy-DbaAgentProxy',
        'Copy-DbaAgentSchedule',
        'Copy-DbaAgentServer',
        'Copy-DbaBackupDevice',
        'Copy-DbaCredential',
        'Copy-DbaCustomError',
        'Copy-DbaDatabase',
        'Copy-DbaDataCollector',
        'Copy-DbaDbAssembly',
        'Copy-DbaDbMail',
        'Copy-DbaDbQueryStoreOption',
        'Copy-DbaDbTableData',
        'Copy-DbaDbViewData',
        'Copy-DbaEndpoint',
        'Copy-DbaInstanceAudit',
        'Copy-DbaInstanceAuditSpecification',
        'Copy-DbaInstanceTrigger',
        'Copy-DbaLinkedServer',
        'Copy-DbaLogin',
        'Copy-DbaPolicyManagement',
        'Copy-DbaRegServer',
        'Copy-DbaResourceGovernor',
        'Copy-DbaSpConfigure',
        'Copy-DbaStartupProcedure',
        'Copy-DbaSysDbUserObject',
        'Copy-DbaXESession',
        'Copy-DbaXESessionTemplate',
        'Disable-DbaAgHadr',
        'Disable-DbaFilestream',
        'Disable-DbaForceNetworkEncryption',
        'Disable-DbaHideInstance',
        'Disable-DbaStartupProcedure',
        'Disable-DbaTraceFlag',
        'Dismount-DbaDatabase',
        'Enable-DbaAgHadr',
        'Enable-DbaFilestream',
        'Enable-DbaForceNetworkEncryption',
        'Enable-DbaHideInstance',
        'Enable-DbaStartupProcedure',
        'Enable-DbaTraceFlag',
        'Expand-DbaDbLogFile',
        'Export-DbaCredential',
        'Export-DbaDacPackage',
        'Export-DbaDbRole',
        'Export-DbaDbTableData',
        'Export-DbaDiagnosticQuery',
        'Export-DbaExecutionPlan',
        'Export-DbaInstance',
        'Export-DbaLinkedServer',
        'Export-DbaLogin',
        'Export-DbaPfDataCollectorSetTemplate',
        'Export-DbaRegServer',
        'Export-DbaRepServerSetting',
        'Export-DbaScript',
        'Export-DbaServerRole',
        'Export-DbaSpConfigure',
        'Export-DbaSysDbUserObject',
        'Export-DbatoolsConfig',
        'Export-DbaUser',
        'Export-DbaXECsv',
        'Export-DbaXESession',
        'Export-DbaXESessionTemplate',
        'Find-DbaAgentJob',
        'Find-DbaBackup',
        'Find-DbaCommand',
        'Find-DbaDatabase',
        'Find-DbaDbDisabledIndex',
        'Find-DbaDbDuplicateIndex',
        'Find-DbaDbGrowthEvent',
        'Find-DbaDbUnusedIndex',
        'Find-DbaInstance',
        'Find-DbaLoginInGroup',
        'Find-DbaOrphanedFile',
        'Find-DbaSimilarTable',
        'Find-DbaStoredProcedure',
        'Find-DbaTrigger',
        'Find-DbaUserObject',
        'Find-DbaView',
        'Format-DbaBackupInformation',
        'Get-DbaAgBackupHistory',
        'Get-DbaAgDatabase',
        'Get-DbaAgentAlert',
        'Get-DbaAgentAlertCategory',
        'Get-DbaAgentJob',
        'Get-DbaAgentJobCategory',
        'Get-DbaAgentJobHistory',
        'Get-DbaAgentJobOutputFile',
        'Get-DbaAgentJobStep',
        'Get-DbaAgentLog',
        'Get-DbaAgentOperator',
        'Get-DbaAgentProxy',
        'Get-DbaAgentSchedule',
        'Get-DbaAgentServer',
        'Get-DbaAgHadr',
        'Get-DbaAgListener',
        'Get-DbaAgReplica',
        'Get-DbaAvailabilityGroup',
        'Get-DbaAvailableCollation',
        'Get-DbaBackupDevice',
        'Get-DbaBackupInformation',
        'Get-DbaBuild',
        'Get-DbaClientAlias',
        'Get-DbaClientProtocol',
        'Get-DbaCmConnection',
        'Get-DbaCmObject',
        'Get-DbaComputerCertificate',
        'Get-DbaComputerSystem',
        'Get-DbaConnection',
        'Get-DbaCpuRingBuffer',
        'Get-DbaCpuUsage',
        'Get-DbaCredential',
        'Get-DbaCustomError',
        'Get-DbaDatabase',
        'Get-DbaDbAssembly',
        'Get-DbaDbAsymmetricKey',
        'Get-DbaDbBackupHistory',
        'Get-DbaDbccHelp',
        'Get-DbaDbccMemoryStatus',
        'Get-DbaDbccProcCache',
        'Get-DbaDbccSessionBuffer',
        'Get-DbaDbccStatistic',
        'Get-DbaDbccUserOption',
        'Get-DbaDbCertificate',
        'Get-DbaDbCheckConstraint',
        'Get-DbaDbCompatibility',
        'Get-DbaDbCompression',
        'Get-DbaDbDbccOpenTran',
        'Get-DbaDbDetachedFileInfo',
        'Get-DbaDbEncryption',
        'Get-DbaDbExtentDiff',
        'Get-DbaDbFeatureUsage',
        'Get-DbaDbFile',
        'Get-DbaDbFileGroup',
        'Get-DbaDbFileGrowth',
        'Get-DbaDbFileMapping',
        'Get-DbaDbForeignKey',
        'Get-DbaDbIdentity',
        'Get-DbaDbLogShipError',
        'Get-DbaDbLogSpace',
        'Get-DbaDbMail',
        'Get-DbaDbMailAccount',
        'Get-DbaDbMailConfig',
        'Get-DbaDbMailHistory',
        'Get-DbaDbMailLog',
        'Get-DbaDbMailProfile',
        'Get-DbaDbMailServer',
        'Get-DbaDbMasterKey',
        'Get-DbaDbMemoryUsage',
        'Get-DbaDbMirror',
        'Get-DbaDbMirrorMonitor',
        'Get-DbaDbObjectTrigger',
        'Get-DbaDbOrphanUser',
        'Get-DbaDbPageInfo',
        'Get-DbaDbPartitionFunction',
        'Get-DbaDbPartitionScheme',
        'Get-DbaDbQueryStoreOption',
        'Get-DbaDbRecoveryModel',
        'Get-DbaDbRestoreHistory',
        'Get-DbaDbRole',
        'Get-DbaDbRoleMember',
        'Get-DbaDbSchema',
        'Get-DbaDbSequence',
        'Get-DbaDbServiceBrokerService',
        'Get-DbaDbSharePoint',
        'Get-DbaDbSnapshot',
        'Get-DbaDbSpace',
        'Get-DbaDbState',
        'Get-DbaDbStoredProcedure',
        'Get-DbaDbSynonym',
        'Get-DbaDbTable',
        'Get-DbaDbTrigger',
        'Get-DbaDbUdf',
        'Get-DbaDbUser',
        'Get-DbaDbUserDefinedTableType',
        'Get-DbaDbView',
        'Get-DbaDbVirtualLogFile',
        'Get-DbaDefaultPath',
        'Get-DbaDependency',
        'Get-DbaDeprecatedFeature',
        'Get-DbaDiskSpace',
        'Get-DbaDump',
        'Get-DbaEndpoint',
        'Get-DbaErrorLog',
        'Get-DbaErrorLogConfig',
        'Get-DbaEstimatedCompletionTime',
        'Get-DbaExecutionPlan',
        'Get-DbaExtendedProtection',
        'Get-DbaExternalProcess',
        'Get-DbaFeature',
        'Get-DbaFile',
        'Get-DbaFilestream',
        'Get-DbaFirewallRule',
        'Get-DbaForceNetworkEncryption',
        'Get-DbaHelpIndex',
        'Get-DbaHideInstance',
        'Get-DbaInstanceAudit',
        'Get-DbaInstanceAuditSpecification',
        'Get-DbaInstalledPatch',
        'Get-DbaInstanceInstallDate',
        'Get-DbaInstanceProperty',
        'Get-DbaInstanceProtocol',
        'Get-DbaInstanceTrigger',
        'Get-DbaInstanceUserOption',
        'Get-DbaIoLatency',
        'Get-DbaKbUpdate',
        'Get-DbaLastBackup',
        'Get-DbaLastGoodCheckDb',
        'Get-DbaLatchStatistic',
        'Get-DbaLinkedServer',
        'Get-DbaLocaleSetting',
        'Get-DbaLogin',
        'Get-DbaMaintenanceSolutionLog',
        'Get-DbaManagementObject',
        'Get-DbaMaxMemory',
        'Get-DbaMemoryCondition',
        'Get-DbaMemoryUsage',
        'Get-DbaModule',
        'Get-DbaMsdtc',
        'Get-DbaNetworkActivity',
        'Get-DbaNetworkCertificate',
        'Get-DbaNetworkConfiguration',
        'Get-DbaOpenTransaction',
        'Get-DbaOperatingSystem',
        'Get-DbaPageFileSetting',
        'Get-DbaPbmCategory',
        'Get-DbaPbmCategorySubscription',
        'Get-DbaPbmCondition',
        'Get-DbaPbmObjectSet',
        'Get-DbaPbmPolicy',
        'Get-DbaPbmStore',
        'Get-DbaPermission',
        'Get-DbaPfAvailableCounter',
        'Get-DbaPfDataCollector',
        'Get-DbaPfDataCollectorCounter',
        'Get-DbaPfDataCollectorCounterSample',
        'Get-DbaPfDataCollectorSet',
        'Get-DbaPfDataCollectorSetTemplate',
        'Get-DbaPlanCache',
        'Get-DbaPowerPlan',
        'Get-DbaPrivilege',
        'Get-DbaProcess',
        'Get-DbaProductKey',
        'Get-DbaQueryExecutionTime',
        'Get-DbaRandomizedDataset',
        'Get-DbaRandomizedDatasetTemplate',
        'Get-DbaRandomizedType',
        'Get-DbaRandomizedValue',
        'Get-DbaRegistryRoot',
        'Get-DbaRegServer',
        'Get-DbaRegServerGroup',
        'Get-DbaRegServerStore',
        'Get-DbaRepDistributor',
        'Get-DbaRepPublication',
        'Get-DbaRepServer',
        'Get-DbaResourceGovernor',
        'Get-DbaRgClassifierFunction',
        'Get-DbaRgResourcePool',
        'Get-DbaRgWorkloadGroup',
        'Get-DbaRunningJob',
        'Get-DbaSchemaChangeHistory',
        'Get-DbaServerRole',
        'Get-DbaServerRoleMember',
        'Get-DbaService',
        'Get-DbaSpConfigure',
        'Get-DbaSpinLockStatistic',
        'Get-DbaSpn',
        'Get-DbaSsisExecutionHistory',
        'Get-DbaStartupParameter',
        'Get-DbaStartupProcedure',
        'Get-DbaSuspectPage',
        'Get-DbaTcpPort',
        'Get-DbaTempdbUsage',
        'Get-DbatoolsChangeLog',
        'Get-DbatoolsConfig',
        'Get-DbatoolsConfigValue',
        'Get-DbatoolsError',
        'Get-DbatoolsLog',
        'Get-DbatoolsPath',
        'Get-DbaTopResourceUsage',
        'Get-DbaTrace',
        'Get-DbaTraceFlag',
        'Get-DbaUptime',
        'Get-DbaUserPermission',
        'Get-DbaWaitingTask',
        'Get-DbaWaitResource',
        'Get-DbaWaitStatistic',
        'Get-DbaWindowsLog',
        'Get-DbaWsfcAvailableDisk',
        'Get-DbaWsfcCluster',
        'Get-DbaWsfcDisk',
        'Get-DbaWsfcNetwork',
        'Get-DbaWsfcNetworkInterface',
        'Get-DbaWsfcNode',
        'Get-DbaWsfcResource',
        'Get-DbaWsfcResourceType',
        'Get-DbaWsfcRole',
        'Get-DbaWsfcSharedVolume',
        'Get-DbaXEObject',
        'Get-DbaXESession',
        'Get-DbaXESessionTarget',
        'Get-DbaXESessionTargetFile',
        'Get-DbaXESessionTemplate',
        'Get-DbaXESmartTarget',
        'Get-DbaXEStore',
        'Grant-DbaAgPermission',
        'Import-DbaCsv',
        'Import-DbaPfDataCollectorSetTemplate',
        'Import-DbaRegServer',
        'Import-DbaSpConfigure',
        'Import-DbatoolsConfig',
        'Import-DbaXESessionTemplate',
        'Install-DbaDarlingData',
        'Install-DbaFirstResponderKit',
        'Install-DbaInstance',
        'Install-DbaMaintenanceSolution',
        'Install-DbaMultiTool',
        'Install-DbaSqlWatch',
        'Install-DbatoolsWatchUpdate',
        'Install-DbaWhoIsActive',
        'Invoke-DbaAdvancedInstall',
        'Invoke-DbaAdvancedRestore',
        'Invoke-DbaAdvancedUpdate',
        'Invoke-DbaAgFailover',
        'Invoke-DbaBalanceDataFiles',
        'Invoke-DbaCycleErrorLog',
        'Invoke-DbaDbccDropCleanBuffer',
        'Invoke-DbaDbccFreeCache',
        'Invoke-DbaDbClone',
        'Invoke-DbaDbDataGenerator',
        'Invoke-DbaDbDataMasking',
        'Invoke-DbaDbDbccCheckConstraint',
        'Invoke-DbaDbDbccCleanTable',
        'Invoke-DbaDbDbccUpdateUsage',
        'Invoke-DbaDbDecryptObject',
        'Invoke-DbaDbLogShipping',
        'Invoke-DbaDbLogShipRecovery',
        'Invoke-DbaDbMirrorFailover',
        'Invoke-DbaDbMirroring',
        'Invoke-DbaDbPiiScan',
        'Invoke-DbaDbShrink',
        'Invoke-DbaDbTransfer',
        'Invoke-DbaDbUpgrade',
        'Invoke-DbaDiagnosticQuery',
        'Invoke-DbaPfRelog',
        'Invoke-DbaQuery',
        'Invoke-DbatoolsFormatter',
        'Invoke-DbatoolsRenameHelper',
        'Invoke-DbaWhoIsActive',
        'Invoke-DbaXEReplay',
        'Join-DbaAvailabilityGroup',
        'Join-DbaPath',
        'Measure-DbaBackupThroughput',
        'Measure-DbaDbVirtualLogFile',
        'Measure-DbaDiskSpaceRequirement',
        'Measure-DbatoolsImport',
        'Mount-DbaDatabase',
        'Move-DbaDbFile',
        'Move-DbaRegServer',
        'Move-DbaRegServerGroup',
        'New-DbaAgentAlertCategory',
        'New-DbaAgentJob',
        'New-DbaAgentJobCategory',
        'New-DbaAgentJobStep',
        'New-DbaAgentOperator',
        'New-DbaAgentProxy',
        'New-DbaAgentSchedule',
        'New-DbaAvailabilityGroup',
        'New-DbaAzAccessToken',
        'New-DbaClientAlias',
        'New-DbaCmConnection',
        'New-DbaComputerCertificate',
        'New-DbaComputerCertificateSigningRequest',
        'New-DbaConnectionString',
        'New-DbaConnectionStringBuilder',
        'New-DbaCredential',
        'New-DbaCustomError',
        'New-DbaDacOption',
        'New-DbaDacProfile',
        'New-DbaDatabase',
        'New-DbaDbAsymmetricKey',
        'New-DbaDbCertificate',
        'New-DbaDbDataGeneratorConfig',
        'New-DbaDbFileGroup',
        'New-DbaDbMailAccount',
        'New-DbaDbMailProfile',
        'New-DbaDbMaskingConfig',
        'New-DbaDbMasterKey',
        'New-DbaDbRole',
        'New-DbaDbSchema',
        'New-DbaDbSequence',
        'New-DbaDbSnapshot',
        'New-DbaDbSynonym',
        'New-DbaDbTable',
        'New-DbaDbTransfer',
        'New-DbaDbUser',
        'New-DbaDiagnosticAdsNotebook',
        'New-DbaDirectory',
        'New-DbaEndpoint',
        'New-DbaFirewallRule',
        'New-DbaLogin',
        'New-DbaScriptingOption',
        'New-DbaServerRole',
        'New-DbaServiceMasterKey',
        'New-DbaSqlParameter',
        'New-DbatoolsSupportPackage',
        'New-DbaXESession',
        'New-DbaXESmartCsvWriter',
        'New-DbaXESmartEmail',
        'New-DbaXESmartQueryExec',
        'New-DbaXESmartReplay',
        'New-DbaXESmartTableWriter',
        'Publish-DbaDacPackage',
        'Read-DbaAuditFile',
        'Read-DbaBackupHeader',
        'Read-DbaTraceFile',
        'Read-DbaTransactionLog',
        'Read-DbaXEFile',
        'Register-DbatoolsConfig',
        'Remove-DbaAgDatabase',
        'Remove-DbaAgentAlertCategory',
        'Remove-DbaAgentJob',
        'Remove-DbaAgentJobCategory',
        'Remove-DbaAgentJobStep',
        'Remove-DbaAgentOperator',
        'Remove-DbaAgentSchedule',
        'Remove-DbaAgListener',
        'Remove-DbaAgReplica',
        'Remove-DbaAvailabilityGroup',
        'Remove-DbaBackup',
        'Remove-DbaClientAlias',
        'Remove-DbaCmConnection',
        'Remove-DbaComputerCertificate',
        'Remove-DbaCustomError',
        'Remove-DbaDatabase',
        'Remove-DbaDatabaseSafely',
        'Remove-DbaDbAsymmetricKey',
        'Remove-DbaDbBackupRestoreHistory',
        'Remove-DbaDbCertificate',
        'Remove-DbaDbData',
        'Remove-DbaDbFileGroup',
        'Remove-DbaDbLogShipping',
        'Remove-DbaDbMasterKey',
        'Remove-DbaDbMirror',
        'Remove-DbaDbMirrorMonitor',
        'Remove-DbaDbOrphanUser',
        'Remove-DbaDbRole',
        'Remove-DbaDbRoleMember',
        'Remove-DbaDbSchema',
        'Remove-DbaDbSequence',
        'Remove-DbaDbSnapshot',
        'Remove-DbaDbSynonym',
        'Remove-DbaDbTableData',
        'Remove-DbaDbUser',
        'Remove-DbaDbView',
        'Remove-DbaEndpoint',
        'Remove-DbaFirewallRule',
        'Remove-DbaLinkedServer',
        'Remove-DbaLogin',
        'Remove-DbaNetworkCertificate',
        'Remove-DbaPfDataCollectorCounter',
        'Remove-DbaPfDataCollectorSet',
        'Remove-DbaRegServer',
        'Remove-DbaRegServerGroup',
        'Remove-DbaServerRole',
        'Remove-DbaSpn',
        'Remove-DbaTrace',
        'Remove-DbaXESession',
        'Remove-DbaXESmartTarget',
        'Rename-DbaDatabase',
        'Rename-DbaLogin',
        'Repair-DbaDbMirror',
        'Repair-DbaDbOrphanUser',
        'Repair-DbaInstanceName',
        'Reset-DbaAdmin',
        'Reset-DbatoolsConfig',
        'Resolve-DbaNetworkName',
        'Resolve-DbaPath',
        'Restart-DbaService',
        'Restore-DbaDatabase',
        'Restore-DbaDbCertificate',
        'Restore-DbaDbSnapshot',
        'Resume-DbaAgDbDataMovement',
        'Revoke-DbaAgPermission',
        'Save-DbaDiagnosticQueryScript',
        'Save-DbaKbUpdate',
        'Select-DbaBackupInformation',
        'Select-DbaDbSequenceNextValue',
        'Set-DbaAgentAlert',
        'Set-DbaAgentJob',
        'Set-DbaAgentJobCategory',
        'Set-DbaAgentJobOutputFile',
        'Set-DbaAgentJobOwner',
        'Set-DbaAgentJobStep',
        'Set-DbaAgentSchedule',
        'Set-DbaAgentServer',
        'Set-DbaAgListener',
        'Set-DbaAgReplica',
        'Set-DbaAvailabilityGroup',
        'Set-DbaCmConnection',
        'Set-DbaDbCompatibility',
        'Set-DbaDbCompression',
        'Set-DbaDbFileGroup',
        'Set-DbaDbFileGrowth',
        'Set-DbaDbIdentity',
        'Set-DbaDbMirror',
        'Set-DbaDbOwner',
        'Set-DbaDbQueryStoreOption',
        'Set-DbaDbRecoveryModel',
        'Set-DbaDbSchema',
        'Set-DbaDbSequence',
        'Set-DbaDbState',
        'Set-DbaEndpoint',
        'Set-DbaErrorLogConfig',
        'Set-DbaExtendedProtection',
        'Set-DbaLogin',
        'Set-DbaMaxDop',
        'Set-DbaMaxMemory',
        'Set-DbaNetworkCertificate',
        'Set-DbaNetworkConfiguration',
        'Set-DbaPowerPlan',
        'Set-DbaPrivilege',
        'Set-DbaSpConfigure',
        'Set-DbaSpn',
        'Set-DbaStartupParameter',
        'Set-DbaTcpPort',
        'Set-DbaTempDbConfig',
        'Set-DbatoolsPath',
        'Show-DbaDbList',
        'Show-DbaInstanceFileSystem',
        'Start-DbaAgentJob',
        'Start-DbaEndpoint',
        'Start-DbaMigration',
        'Start-DbaPfDataCollectorSet',
        'Start-DbaService',
        'Start-DbaTrace',
        'Start-DbaXESession',
        'Start-DbaXESmartTarget',
        'Stop-DbaAgentJob',
        'Stop-DbaEndpoint',
        'Stop-DbaExternalProcess',
        'Stop-DbaPfDataCollectorSet',
        'Stop-DbaProcess',
        'Stop-DbaService',
        'Stop-DbaTrace',
        'Stop-DbaXESession',
        'Stop-DbaXESmartTarget',
        'Suspend-DbaAgDbDataMovement',
        'Sync-DbaAvailabilityGroup',
        'Sync-DbaLoginPermission',
        'Test-DbaAgentJobOwner',
        'Test-DbaAvailabilityGroup',
        'Test-DbaBackupInformation',
        'Test-DbaBuild',
        'Test-DbaCmConnection',
        'Test-DbaComputerCertificateExpiration',
        'Test-DbaConnection',
        'Test-DbaConnectionAuthScheme',
        'Test-DbaDbCollation',
        'Test-DbaDbCompatibility',
        'Test-DbaDbCompression',
        'Test-DbaDbDataGeneratorConfig',
        'Test-DbaDbDataMaskingConfig',
        'Test-DbaDbLogShipStatus',
        'Test-DbaDbOwner',
        'Test-DbaDbQueryStore',
        'Test-DbaDbRecoveryModel',
        'Test-DbaDeprecatedFeature',
        'Test-DbaDiskAlignment',
        'Test-DbaDiskAllocation',
        'Test-DbaDiskSpeed',
        'Test-DbaEndpoint',
        'Test-DbaIdentityUsage',
        'Test-DbaInstanceName',
        'Test-DbaLastBackup',
        'Test-DbaLinkedServerConnection',
        'Test-DbaLoginPassword',
        'Test-DbaManagementObject',
        'Test-DbaMaxDop',
        'Test-DbaMaxMemory',
        'Test-DbaMigrationConstraint',
        'Test-DbaNetworkLatency',
        'Test-DbaOptimizeForAdHoc',
        'Test-DbaPath',
        'Test-DbaPowerPlan',
        'Test-DbaRepLatency',
        'Test-DbaSpn',
        'Test-DbaTempDbConfig',
        'Test-DbaWindowsLogin',
        'Uninstall-DbaSqlWatch',
        'Uninstall-DbatoolsWatchUpdate',
        'Unregister-DbatoolsConfig',
        'Update-DbaBuildReference',
        'Update-DbaInstance',
        'Update-DbaServiceAccount',
        'Update-Dbatools',
        'Watch-DbaDbLogin',
        'Watch-DbatoolsUpdate',
        'Watch-DbaXESession',
        'Write-DbaDbTableData',
        'Set-DbaAgentOperator',
        'Remove-DbaExtendedProperty',
        'Get-DbaExtendedProperty',
        'Set-DbaExtendedProperty',
        'Add-DbaExtendedProperty',
        'Get-DbaOleDbProvider',
        'Get-DbaConnectedInstance',
        'Disconnect-DbaInstance',
        'Set-DbaDefaultPath',
        'Remove-DbaDbUdf',
        'Save-DbaCommunitySoftware',
        'Update-DbaMaintenanceSolution'
    )

    # Cmdlets to export from this module
    CmdletsToExport        = @(
        'Select-DbaObject',
        'Set-DbatoolsConfig'
    )

    # Variables to export from this module
    VariablesToExport      = ''

    # Aliases to export from this module
    # Aliases are stored in dbatools.psm1
    # The five listed below are intentional
    AliasesToExport        = @(
        'Get-DbaRegisteredServer',
        'Attach-DbaDatabase',
        'Detach-DbaDatabase',
        'Start-SqlMigration',
        'Write-DbaDataTable',
        'Get-DbaDbModule',
        'Get-DbaBuildReference'
    )

    # List of all modules packaged with this module
    ModuleList             = @()

    # List of all files packaged with this module
    FileList               = ''

    PrivateData            = @{
        # PSData is module packaging and gallery metadata embedded in PrivateData
        # It's for rebuilding PowerShellGet (and PoshCode) NuGet-style packages
        # We had to do this because it's the only place we're allowed to extend the manifest
        # https://connect.microsoft.com/PowerShell/feedback/details/421837
        PSData = @{
            # The primary categorization of this module (from the TechNet Gallery tech tree).
            Category     = "Databases"

            # Keyword tags to help users find this module via navigations and search.
            Tags         = @('sqlserver', 'migrations', 'sql', 'dba', 'databases', 'mac', 'linux', 'core')

            # The web address of an icon which can be used in galleries to represent this module
            IconUri      = "https://dbatools.io/logo.png"

            # The web address of this module's project or support homepage.
            ProjectUri   = "https://dbatools.io"

            # The web address of this module's license. Points to a page that's embeddable and linkable.
            LicenseUri   = "https://opensource.org/licenses/MIT"

            # Release notes for this particular version of the module
            ReleaseNotes = "https://dbatools.io/changelog"

            # If true, the LicenseUrl points to an end-user license (not just a source license) which requires the user agreement before use.
            # RequireLicenseAcceptance = ""

            # Indicates this is a pre-release/testing version of the module.
            IsPrerelease = 'True'
        }
    }
}

# SIG # Begin signature block
# MIIZewYJKoZIhvcNAQcCoIIZbDCCGWgCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUge3RYA5SZ94vP96/PxDF1Tvf
# yrGgghSJMIIE/jCCA+agAwIBAgIQDUJK4L46iP9gQCHOFADw3TANBgkqhkiG9w0B
# AQsFADByMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
# VQQLExB3d3cuZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFz
# c3VyZWQgSUQgVGltZXN0YW1waW5nIENBMB4XDTIxMDEwMTAwMDAwMFoXDTMxMDEw
# NjAwMDAwMFowSDELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMu
# MSAwHgYDVQQDExdEaWdpQ2VydCBUaW1lc3RhbXAgMjAyMTCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBAMLmYYRnxYr1DQikRcpja1HXOhFCvQp1dU2UtAxQ
# tSYQ/h3Ib5FrDJbnGlxI70Tlv5thzRWRYlq4/2cLnGP9NmqB+in43Stwhd4CGPN4
# bbx9+cdtCT2+anaH6Yq9+IRdHnbJ5MZ2djpT0dHTWjaPxqPhLxs6t2HWc+xObTOK
# fF1FLUuxUOZBOjdWhtyTI433UCXoZObd048vV7WHIOsOjizVI9r0TXhG4wODMSlK
# XAwxikqMiMX3MFr5FK8VX2xDSQn9JiNT9o1j6BqrW7EdMMKbaYK02/xWVLwfoYer
# vnpbCiAvSwnJlaeNsvrWY4tOpXIc7p96AXP4Gdb+DUmEvQECAwEAAaOCAbgwggG0
# MA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMBAf8EAjAAMBYGA1UdJQEB/wQMMAoGCCsG
# AQUFBwMIMEEGA1UdIAQ6MDgwNgYJYIZIAYb9bAcBMCkwJwYIKwYBBQUHAgEWG2h0
# dHA6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzAfBgNVHSMEGDAWgBT0tuEgHf4prtLk
# YaWyoiWyyBc1bjAdBgNVHQ4EFgQUNkSGjqS6sGa+vCgtHUQ23eNqerwwcQYDVR0f
# BGowaDAyoDCgLoYsaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL3NoYTItYXNzdXJl
# ZC10cy5jcmwwMqAwoC6GLGh0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9zaGEyLWFz
# c3VyZWQtdHMuY3JsMIGFBggrBgEFBQcBAQR5MHcwJAYIKwYBBQUHMAGGGGh0dHA6
# Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBPBggrBgEFBQcwAoZDaHR0cDovL2NhY2VydHMu
# ZGlnaWNlcnQuY29tL0RpZ2lDZXJ0U0hBMkFzc3VyZWRJRFRpbWVzdGFtcGluZ0NB
# LmNydDANBgkqhkiG9w0BAQsFAAOCAQEASBzctemaI7znGucgDo5nRv1CclF0CiNH
# o6uS0iXEcFm+FKDlJ4GlTRQVGQd58NEEw4bZO73+RAJmTe1ppA/2uHDPYuj1UUp4
# eTZ6J7fz51Kfk6ftQ55757TdQSKJ+4eiRgNO/PT+t2R3Y18jUmmDgvoaU+2QzI2h
# F3MN9PNlOXBL85zWenvaDLw9MtAby/Vh/HUIAHa8gQ74wOFcz8QRcucbZEnYIpp1
# FUL1LTI4gdr0YKK6tFL7XOBhJCVPst/JKahzQ1HavWPWH1ub9y4bTxMd90oNcX6X
# t/Q/hOvB46NJofrOp79Wz7pZdmGJX36ntI5nePk2mOHLKNpbh6aKLzCCBRowggQC
# oAMCAQICEAMFu4YhsKFjX7/erhIE520wDQYJKoZIhvcNAQELBQAwcjELMAkGA1UE
# BhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2lj
# ZXJ0LmNvbTExMC8GA1UEAxMoRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElEIENvZGUg
# U2lnbmluZyBDQTAeFw0yMDA1MTIwMDAwMDBaFw0yMzA2MDgxMjAwMDBaMFcxCzAJ
# BgNVBAYTAlVTMREwDwYDVQQIEwhWaXJnaW5pYTEPMA0GA1UEBxMGVmllbm5hMREw
# DwYDVQQKEwhkYmF0b29sczERMA8GA1UEAxMIZGJhdG9vbHMwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQC8v2N7q+O/vggBtpjmteofFo140k73JXQ5sOD6
# QLzjgija+scoYPxTmFSImnqtjfZFWmucAWsDiMVVro/6yGjsXmJJUA7oD5BlMdAK
# fuiq4558YBOjjc0Bp3NbY5ZGujdCmsw9lqHRAVil6P1ZpAv3D/TyVVq6AjDsJY+x
# rRL9iMc8YpD5tiAj+SsRSuT5qwPuW83ByRHqkaJ5YDJ/R82ZKh69AFNXoJ3xCJR+
# P7+pa8tbdSgRf25w4ZfYPy9InEvsnIRVZMeDjjuGvqr0/Mar73UI79z0NYW80yN/
# 7VzlrvV8RnniHWY2ib9ehZligp5aEqdV2/XFVPV4SKaJs8R9AgMBAAGjggHFMIIB
# wTAfBgNVHSMEGDAWgBRaxLl7KgqjpepxA8Bg+S32ZXUOWDAdBgNVHQ4EFgQU8MCg
# +7YDgENO+wnX3d96scvjniIwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsG
# AQUFBwMDMHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNv
# bS9zaGEyLWFzc3VyZWQtY3MtZzEuY3JsMDWgM6Axhi9odHRwOi8vY3JsNC5kaWdp
# Y2VydC5jb20vc2hhMi1hc3N1cmVkLWNzLWcxLmNybDBMBgNVHSAERTBDMDcGCWCG
# SAGG/WwDATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2VydC5jb20v
# Q1BTMAgGBmeBDAEEATCBhAYIKwYBBQUHAQEEeDB2MCQGCCsGAQUFBzABhhhodHRw
# Oi8vb2NzcC5kaWdpY2VydC5jb20wTgYIKwYBBQUHMAKGQmh0dHA6Ly9jYWNlcnRz
# LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFNIQTJBc3N1cmVkSURDb2RlU2lnbmluZ0NB
# LmNydDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQCPzflwlQwf1jak
# EqymPOc0nBxiY7F4FwcmL7IrTLhub6Pjg4ZYfiC79Akz5aNlqO+TJ0kqglkfnOsc
# jfKQzzDwcZthLVZl83igzCLnWMo8Zk/D2d4ZLY9esFwqPNvuuVDrHvgh7H6DJ/zP
# Vm5EOK0sljT0UQ6HQEwtouH5S8nrqCGZ8jKM/+DeJlm+rCAGGf7TV85uqsAn5JqD
# En/bXE1AlyG1Q5YiXFGS5Sf0qS4Nisw7vRrZ6Qc4NwBty4cAYjzDPDixorWI8+FV
# OUWKMdL7tV8i393/XykwsccCstBCp7VnSZN+4vgzjEJQql5uQfysjcW9rrb/qixp
# csPTKYRHMIIFMDCCBBigAwIBAgIQBAkYG1/Vu2Z1U0O1b5VQCDANBgkqhkiG9w0B
# AQsFADBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
# VQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVk
# IElEIFJvb3QgQ0EwHhcNMTMxMDIyMTIwMDAwWhcNMjgxMDIyMTIwMDAwWjByMQsw
# CQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu
# ZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQg
# Q29kZSBTaWduaW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
# +NOzHH8OEa9ndwfTCzFJGc/Q+0WZsTrbRPV/5aid2zLXcep2nQUut4/6kkPApfmJ
# 1DcZ17aq8JyGpdglrA55KDp+6dFn08b7KSfH03sjlOSRI5aQd4L5oYQjZhJUM1B0
# sSgmuyRpwsJS8hRniolF1C2ho+mILCCVrhxKhwjfDPXiTWAYvqrEsq5wMWYzcT6s
# cKKrzn/pfMuSoeU7MRzP6vIK5Fe7SrXpdOYr/mzLfnQ5Ng2Q7+S1TqSp6moKq4Tz
# rGdOtcT3jNEgJSPrCGQ+UpbB8g8S9MWOD8Gi6CxR93O8vYWxYoNzQYIH5DiLanMg
# 0A9kczyen6Yzqf0Z3yWT0QIDAQABo4IBzTCCAckwEgYDVR0TAQH/BAgwBgEB/wIB
# ADAOBgNVHQ8BAf8EBAMCAYYwEwYDVR0lBAwwCgYIKwYBBQUHAwMweQYIKwYBBQUH
# AQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYI
# KwYBBQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFz
# c3VyZWRJRFJvb3RDQS5jcnQwgYEGA1UdHwR6MHgwOqA4oDaGNGh0dHA6Ly9jcmw0
# LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwOqA4oDaG
# NGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
# QS5jcmwwTwYDVR0gBEgwRjA4BgpghkgBhv1sAAIEMCowKAYIKwYBBQUHAgEWHGh0
# dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwCgYIYIZIAYb9bAMwHQYDVR0OBBYE
# FFrEuXsqCqOl6nEDwGD5LfZldQ5YMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
# IZ3zbcgPMA0GCSqGSIb3DQEBCwUAA4IBAQA+7A1aJLPzItEVyCx8JSl2qB1dHC06
# GsTvMGHXfgtg/cM9D8Svi/3vKt8gVTew4fbRknUPUbRupY5a4l4kgU4QpO4/cY5j
# DhNLrddfRHnzNhQGivecRk5c/5CxGwcOkRX7uq+1UcKNJK4kxscnKqEpKBo6cSgC
# PC6Ro8AlEeKcFEehemhor5unXCBc2XGxDI+7qPjFEmifz0DLQESlE/DmZAwlCEIy
# sjaKJAL+L3J+HNdJRZboWR3p+nRka7LrZkPas7CM1ekN3fYBIM6ZMWM9CBoYs4Gb
# T8aTEAb8B4H6i9r5gkn3Ym6hU/oSlBiFLpKR6mhsRDKyZqHnGKSaZFHvMIIFMTCC
# BBmgAwIBAgIQCqEl1tYyG35B5AXaNpfCFTANBgkqhkiG9w0BAQsFADBlMQswCQYD
# VQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGln
# aWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgQ0Ew
# HhcNMTYwMTA3MTIwMDAwWhcNMzEwMTA3MTIwMDAwWjByMQswCQYDVQQGEwJVUzEV
# MBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
# MTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgVGltZXN0YW1waW5n
# IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvdAy7kvNj3/dqbqC
# mcU5VChXtiNKxA4HRTNREH3Q+X1NaH7ntqD0jbOI5Je/YyGQmL8TvFfTw+F+CNZq
# FAA49y4eO+7MpvYyWf5fZT/gm+vjRkcGGlV+Cyd+wKL1oODeIj8O/36V+/OjuiI+
# GKwR5PCZA207hXwJ0+5dyJoLVOOoCXFr4M8iEA91z3FyTgqt30A6XLdR4aF5FMZN
# JCMwXbzsPGBqrC8HzP3w6kfZiFBe/WZuVmEnKYmEUeaC50ZQ/ZQqLKfkdT66mA+E
# f58xFNat1fJky3seBdCEGXIX8RcG7z3N1k3vBkL9olMqT4UdxB08r8/arBD13ays
# 6Vb/kwIDAQABo4IBzjCCAcowHQYDVR0OBBYEFPS24SAd/imu0uRhpbKiJbLIFzVu
# MB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3zbcgPMBIGA1UdEwEB/wQIMAYB
# Af8CAQAwDgYDVR0PAQH/BAQDAgGGMBMGA1UdJQQMMAoGCCsGAQUFBwMIMHkGCCsG
# AQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
# MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNl
# cnRBc3N1cmVkSURSb290Q0EuY3J0MIGBBgNVHR8EejB4MDqgOKA2hjRodHRwOi8v
# Y3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMDqg
# OKA2hjRodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
# b290Q0EuY3JsMFAGA1UdIARJMEcwOAYKYIZIAYb9bAACBDAqMCgGCCsGAQUFBwIB
# FhxodHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BTMAsGCWCGSAGG/WwHATANBgkq
# hkiG9w0BAQsFAAOCAQEAcZUS6VGHVmnN793afKpjerN4zwY3QITvS4S/ys8DAv3F
# p8MOIEIsr3fzKx8MIVoqtwU0HWqumfgnoma/Capg33akOpMP+LLR2HwZYuhegiUe
# xLoceywh4tZbLBQ1QwRostt1AuByx5jWPGTlH0gQGF+JOGFNYkYkh2OMkVIsrymJ
# 5Xgf1gsUpYDXEkdws3XVk4WTfraSZ/tTYYmo9WuWwPRYaQ18yAGxuSh1t5ljhSKM
# Ycp5lH5Z/IwP42+1ASa2bKXuh1Eh5Fhgm7oMLSttosR+u8QlK0cCCHxJrhO24XxC
# QijGGFbPQTS2Zl22dHv1VjMiLyI2skuiSpXY9aaOUjGCBFwwggRYAgEBMIGGMHIx
# CzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3
# dy5kaWdpY2VydC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJ
# RCBDb2RlIFNpZ25pbmcgQ0ECEAMFu4YhsKFjX7/erhIE520wCQYFKw4DAhoFAKB4
# MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQB
# gjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkE
# MRYEFDAgb8NkFt4QbIyTmeSMeKaPJQDoMA0GCSqGSIb3DQEBAQUABIIBAAAn8f8I
# vL7p5475rxSeFlJPuiG0nmsTqaIOBPjcI71CRA7adlMyuHbJYPVdbwmW5kJjii5S
# wf2/GjTeIKJVLXNjt5fqqsg5wnFwcsj9YqTXQ5GjNb/PZpB7KBbMNv695ybKXccP
# zZ3GYcjLokoh6uOuOwKHxPYuLdTyh9rd6K7B+6hammgLTzu5SXG2YrU9ABXPZIUk
# EKnZAYuWdsuvrGVaqGszCGyLl8gTEMFd7x7PNYwsKNAnyThkPv84IvX3+i/m/3g5
# iuueMs22qlqARKpsGSQXhg1CXP+/74vygBx9gZWRt5jCZGtEeE5ricWeAE/XHh2G
# fGTV1bPvXDMvq7mhggIwMIICLAYJKoZIhvcNAQkGMYICHTCCAhkCAQEwgYYwcjEL
# MAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3
# LmRpZ2ljZXJ0LmNvbTExMC8GA1UEAxMoRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElE
# IFRpbWVzdGFtcGluZyBDQQIQDUJK4L46iP9gQCHOFADw3TANBglghkgBZQMEAgEF
# AKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
# MDgxMTA4MjYzMFowLwYJKoZIhvcNAQkEMSIEIITsvJzRyah5l+skV466244vf3JZ
# S4hL9Qecnei/2zKVMA0GCSqGSIb3DQEBAQUABIIBAC8JzWWTlzxfNaUXl/ucbIut
# z0hct5Ml30cxEZP+NxLHH3gPcbQ5x+09pXI2NqSU2Oq1Smdf8/j/UXKQ+rUTei9j
# KE7X76mXNdJwDmrXMT+8CM5081hCxm1FtHdaWmxCJRYA4u7hTddHwXcae/ZY2paf
# XD9gLXOjjJWBV+iq5UlWRhuv3tg9alHis5UOqu7Y7pWII2TQMlKbeMIsqG/It7yh
# bIrrob7dPB4O1QPcrwLC7CRm/Vv/tnWbc5uQ/zomT9VhrT7zO4h4ctDMGdatoZ33
# p2qPlYQ6DXbmW2qOGpn9tIPNHsmT/LT/rkwXreBJbNHaVnbplZSTVE21T2Cayh0=
# SIG # End signature block