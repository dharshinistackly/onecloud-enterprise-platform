// ignore: uri_does_not_exist
import 'package:flutter/material.dart';

import '../auth/login_page.dart';
import '../auth/forgot_password_page.dart';
import '../auth/signup_page.dart';
import '../auth/social_login_page.dart';
import '../auth/mobile_welcome_page.dart';

import '../pages/dashboard/home_page.dart';
import '../pages/platform_administration/super_admin_dashboard_page.dart';

import '../pages/platform_administration/global_settings_page.dart';
import '../pages/platform_administration/platform_config_page.dart';
import '../pages/platform_administration/license_management_page.dart';
import '../pages/platform_administration/feature_management_page.dart';
import '../pages/platform_administration/system_health_page.dart';
import '../pages/platform_administration/platform_branding_page.dart';
import '../pages/platform_administration/global_dashboard_page.dart';

import '../pages/hrms/employee_management_page.dart';
import '../pages/hrms/attendance_page.dart';
import '../pages/hrms/leave_page.dart';
import '../pages/hrms/payroll_page.dart';
import '../pages/hrms/recruitment_page.dart';
import '../pages/hrms/performance_page.dart';
import '../pages/hrms/learning_page.dart';
import '../pages/hrms/ess_mss_page.dart';
import '../pages/hrms/asset_management_page.dart' as hrms;

import '../pages/crm/leads_page.dart';
import '../pages/crm/opportunities_page.dart';
import '../pages/crm/accounts_page.dart';
import '../pages/crm/contacts_page.dart';
import '../pages/crm/activities_page.dart';
import '../pages/crm/pipeline_page.dart';
import '../pages/crm/quotations_page.dart';
import '../pages/crm/campaigns_page.dart';
import '../pages/crm/customer_support_page.dart';

import '../pages/erp/inventory_page.dart';
import '../pages/erp/procurement_page.dart';
import '../pages/erp/production_page.dart';
import '../pages/erp/sales_orders_page.dart';
import '../pages/erp/dispatch_page.dart';
import '../pages/erp/asset_management_page.dart';
import '../pages/erp/maintenance_page.dart';
import '../pages/erp/vendors_page.dart';

import '../pages/finance/accounts_payable_page.dart';
import '../pages/finance/accounts_receivable_page.dart';
import '../pages/finance/budgeting_page.dart';
import '../pages/finance/costing_page.dart';
import '../pages/finance/financial_reports_page.dart';
import '../pages/finance/general_ledger_page.dart';
import '../pages/finance/multi_currency_page.dart';
import '../pages/finance/reconciliation_page.dart';
import '../pages/finance/tax_management_page.dart';

import '../pages/workflow/approvals_page.dart';
import '../pages/workflow/business_rules_page.dart';
import '../pages/workflow/process_automation_page.dart';
import '../pages/workflow/process_monitoring_page.dart';
import '../pages/workflow/slas_escalations_page.dart';
import '../pages/workflow/task_management_page.dart';
import '../pages/workflow/triggers_page.dart';
import '../pages/workflow/workflow_builder_page.dart';
import '../pages/workflow/workflow_templates_page.dart';

import '../pages/document_management/access_control_page.dart';
import '../pages/document_management/audit_trails_page.dart';
import '../pages/document_management/document_repository_page.dart';
import '../pages/document_management/document_templates_page.dart';
import '../pages/document_management/file_upload_download_page.dart';
import '../pages/document_management/ocr_integration_page.dart';
import '../pages/document_management/retention_policies_page.dart';
import '../pages/document_management/tagging_search_page.dart';
import '../pages/document_management/versioning_page.dart';

import '../pages/subscription/billing_integration_page.dart';
import '../pages/subscription/license_allocation_page.dart';
import '../pages/subscription/license_keys_page.dart';
import '../pages/subscription/payment_tracking_page.dart';
import '../pages/subscription/plans_features_page.dart';
import '../pages/subscription/renewals_page.dart';
import '../pages/subscription/tenant_subscriptions_page.dart';
import '../pages/subscription/trial_management_page.dart';
import '../pages/subscription/usage_quotas_page.dart';

import '../pages/revenue/revenue_tracking_page.dart';
import '../pages/revenue/usage_analytics_page.dart';
import '../pages/revenue/forecasting_page.dart';
import '../pages/revenue/revenue_reports_page.dart';
import '../pages/revenue/revenue_recognition_page.dart';
import '../pages/revenue/commission_management_page.dart';
import '../pages/revenue/financial_analytics_page.dart';
import '../pages/revenue/invoicing_page.dart';
import '../pages/revenue/integration_page.dart';

import '../pages/reporting/standard_reports_page.dart';
import '../pages/reporting/adhoc_reports_page.dart';
import '../pages/reporting/data_exploration_page.dart';
import '../pages/reporting/bi_management_page.dart';
import '../pages/reporting/data_export_page.dart';
import '../pages/reporting/scheduled_reports_page.dart';
import '../pages/reporting/data_visualization_page.dart';
import '../pages/reporting/self_service_analytics_page.dart';

import '../pages/enterprise_ai/ai_models_page.dart';
import '../pages/enterprise_ai/ai_chat_copilot_page.dart';
import '../pages/enterprise_ai/document_ai_ocr_page.dart';
import '../pages/enterprise_ai/predictive_analytics_page.dart';
import '../pages/enterprise_ai/recommendations_page.dart';
import '../pages/enterprise_ai/ai_workflows_page.dart';
import '../pages/enterprise_ai/model_management_page.dart';
import '../pages/enterprise_ai/prompt_engineering_page.dart';
import '../pages/enterprise_ai/ai_usage_logs_page.dart';

import '../pages/notification/in_app_notifications_page.dart';
import '../pages/notification/email_notifications_page.dart';
import '../pages/notification/sms_notifications_page.dart';
import '../pages/notification/push_notifications_page.dart';
import '../pages/notification/templates_page.dart';
import '../pages/notification/preferences_page.dart';
import '../pages/notification/schedules_page.dart';
import '../pages/notification/delivery_tracking_page.dart';
import '../pages/notification/multi_channel_page.dart';

import '../pages/calendar/user_calendars_page.dart';
import '../pages/calendar/team_calendars_page.dart';
import '../pages/calendar/meeting_scheduler_page.dart';
import '../pages/calendar/resource_booking_page.dart';
import '../pages/calendar/reminders_page.dart';
import '../pages/calendar/notifications_page.dart';
import '../pages/calendar/availability_page.dart';
import '../pages/calendar/event_notifications_page.dart';
import '../pages/calendar/shared_calendars_page.dart';

import '../pages/integration/api_management_page.dart';
import '../pages/integration/third_party_integrations_page.dart';
import '../pages/integration/webhooks_page.dart';
import '../pages/integration/event_streaming_page.dart';
import '../pages/integration/data_transformation_page.dart';
import '../pages/integration/etl_data_sync_page.dart';
import '../pages/integration/connectors_page.dart';
import '../pages/integration/integration_logs_page.dart';

import '../pages/search/global_search_page.dart';
import '../pages/search/index_management_page.dart';
import '../pages/search/search_analytics_page.dart';
import '../pages/search/autocomplete_page.dart';
import '../pages/search/relevance_ranking_page.dart';
import '../pages/search/saved_searches_page.dart';
import '../pages/search/multi_tenant_index_page.dart';
import '../pages/search/synonyms_page.dart';
import '../pages/search/suggestion_engine_page.dart';

import '../pages/security_compliance/audit_logs_page.dart';
import '../pages/security_compliance/activity_tracking_page.dart';
import '../pages/security_compliance/compliance_reports_page.dart';
import '../pages/security_compliance/data_retention_page.dart';
import '../pages/security_compliance/policy_management_page.dart';
import '../pages/security_compliance/threat_detection_page.dart';
import '../pages/security_compliance/vulnerability_management_page.dart';
import '../pages/security_compliance/encryption_key_management_page.dart';
import '../pages/security_compliance/security_alerts_page.dart';

import '../pages/settings/settings_page.dart';



class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String forgotPassword = '/forgot-password';
  static const String signup = '/signup';
  static const String socialLogin = '/social-login';
  static const String userManagement = '/user-management';
  static const String mobileWelcome = '/mobile-welcome';

  static const String globalSettings = '/global-settings';
  static const String platformConfig = '/platform-config';
  static const String licenseManagement = '/license-management';
  static const String featureManagement = '/feature-management';
  static const String systemHealth = '/system-health';
  static const String platformBranding = '/platform-branding';
  static const String globalDashboard = '/global-dashboard';
  static const String superAdminDashboard = '/super-admin-dashboard';

  static const String employeeManagement = '/employee-management';
  static const String attendance = '/attendance';
  static const String leave = '/leave';
  static const String payroll = '/payroll';
  static const String recruitment = '/recruitment';
  static const String performance = '/performance';
  static const String learning = '/learning';
  static const String essMss = '/ess-mss';
  static const String hrmsAssetManagement = '/hrms-asset-management';

  static const String leads = '/leads';
static const String opportunities = '/opportunities';
static const String accounts = '/accounts';
static const String contacts = '/contacts';
static const String activities = '/activities';
static const String pipeline = '/pipeline';
static const String quotations = '/quotations';
static const String campaigns = '/campaigns';
static const String customerSupport = '/customer-support';

static const String inventory = '/inventory';
static const String procurement = '/procurement';
static const String production = '/production';
static const String salesOrders = '/sales-orders';
static const String dispatch = '/dispatch';
static const String erpAssetManagement = '/erp-asset-management';
static const String maintenance = '/maintenance';
static const String vendors = '/vendors';

static const String accountsPayable = '/accounts-payable';
static const String accountsReceivable = '/accounts-receivable';
static const String budgeting = '/budgeting';
static const String costing = '/costing';
static const String financialReports = '/financial-reports';
static const String generalLedger = '/general-ledger';
static const String multiCurrency = '/multi-currency';
static const String reconciliation = '/reconciliation';
static const String taxManagement = '/tax-management';

static const String approvals = '/approvals';
static const String businessRules = '/business-rules';
static const String processAutomation = '/process-automation';
static const String processMonitoring = '/process-monitoring';
static const String slasEscalations = '/slas-escalations';
static const String taskManagement = '/task-management';
static const String triggers = '/triggers';
static const String workflowBuilder = '/workflow-builder';
static const String workflowTemplates = '/workflow-templates';

static const String accessControl = '/access-control';
static const String auditTrails = '/audit-trails';
static const String documentRepository = '/document-repository';
static const String documentTemplates = '/document-templates';
static const String fileUploadDownload = '/file-upload-download';
static const String ocrIntegration = '/ocr-integration';
static const String retentionPolicies = '/retention-policies';
static const String taggingSearch = '/tagging-search';
static const String versioning = '/versioning';

static const String billingIntegration = '/billing-integration';
static const String licenseAllocation = '/license-allocation';
static const String licenseKeys = '/license-keys';
static const String paymentTracking = '/payment-tracking';
static const String plansFeatures = '/plans-features';
static const String renewals = '/renewals';
static const String tenantSubscriptions = '/tenant-subscriptions';
static const String trialManagement = '/trial-management';
static const String usageQuotas = '/usage-quotas';

static const String revenueTracking = '/revenue-tracking';
static const String usageAnalytics = '/usage-analytics';
static const String forecasting = '/forecasting';
static const String revenueReports = '/revenue-reports';
static const String revenueRecognition = '/revenue-recognition';
static const String commissionManagement = '/commission-management';
static const String financialAnalytics = '/financial-analytics';
static const String invoicing = '/invoicing';
static const String revenueIntegration = '/revenue-integration';

static const String standardReports = '/standard-reports';
static const String adhocReports = '/adhoc-reports';
static const String dataExploration = '/data-exploration';
static const String biManagement = '/bi-management';
static const String dataExport = '/data-export';
static const String scheduledReports = '/scheduled-reports';
static const String dataVisualization = '/data-visualization';
static const String selfServiceAnalytics = '/self-service-analytics';

static const String aiModels = '/ai-models';
static const String aiChatCopilot = '/ai-chat-copilot';
static const String documentAiOcr = '/document-ai-ocr';
static const String predictiveAnalytics = '/predictive-analytics';
static const String recommendations = '/recommendations';
static const String aiWorkflows = '/ai-workflows';
static const String modelManagement = '/model-management';
static const String promptEngineering = '/prompt-engineering';
static const String aiUsageLogs = '/ai-usage-logs';

static const String inAppNotifications = '/in-app-notifications';
static const String emailNotifications = '/email-notifications';
static const String smsNotifications = '/sms-notifications';
static const String pushNotifications = '/push-notifications';
static const String notificationTemplates = '/notification-templates';
static const String notificationPreferences = '/notification-preferences';
static const String notificationSchedules = '/notification-schedules';
static const String deliveryTracking = '/delivery-tracking';
static const String multiChannel = '/multi-channel';

static const String userCalendars = '/user-calendars';
static const String teamCalendars = '/team-calendars';
static const String meetingScheduler = '/meeting-scheduler';
static const String resourceBooking = '/resource-booking';
static const String reminders = '/reminders';
static const String calendarNotifications = '/calendar-notifications';
static const String availability = '/availability';
static const String eventNotifications = '/event-notifications';
static const String sharedCalendars = '/shared-calendars';

static const String apiManagement = '/api-management';
static const String thirdPartyIntegrations = '/third-party-integrations';
static const String webhooks = '/webhooks';
static const String eventStreaming = '/event-streaming';
static const String dataTransformation = '/data-transformation';
static const String etlDataSync = '/etl-data-sync';
static const String connectors = '/connectors';
static const String integrationLogs = '/integration-logs';

static const String globalSearch = '/global-search';
static const String indexManagement = '/index-management';
static const String searchAnalytics = '/search-analytics';
static const String autocomplete = '/autocomplete';
static const String relevanceRanking = '/relevance-ranking';
static const String savedSearches = '/saved-searches';
static const String multiTenantIndex = '/multi-tenant-index';
static const String synonyms = '/synonyms';
static const String suggestionEngine = '/suggestion-engine';

static const String auditLogs = '/audit-logs';
static const String activityTracking = '/activity-tracking';
static const String complianceReports = '/compliance-reports';
static const String dataRetention = '/data-retention';
static const String policyManagement = '/policy-management';
static const String threatDetection = '/threat-detection';
static const String vulnerabilityManagement = '/vulnerability-management';
static const String encryptionKeyManagement = '/encryption-key-management';
static const String securityAlerts = '/security-alerts';

static const String settings = '/settings';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    home: (context) => const HomePage(),
    forgotPassword: (context) => const ForgotPasswordPage(),
    signup: (context) => const SignupPage(),
    socialLogin: (context) => const SocialLoginPage(),
    mobileWelcome: (context) => const MobileWelcomePage(),
    

    globalSettings: (context) => const GlobalSettingsPage(),
    platformConfig: (context) => const PlatformConfigPage(),
    licenseManagement: (context) => const LicenseManagementPage(),
    featureManagement: (context) => const FeatureManagementPage(),
    systemHealth: (context) => const SystemHealthPage(),
    platformBranding: (context) => const PlatformBrandingPage(),
    globalDashboard: (context) => const GlobalDashboardPage(),
    superAdminDashboard: (context) => const SuperAdminDashboardPage(),

    employeeManagement: (context) => const EmployeeManagementPage(),
    attendance: (context) => const AttendancePage(),
    leave: (context) => const LeavePage(),
    payroll: (context) => const PayrollPage(),
    recruitment: (context) => const RecruitmentPage(),
    performance: (context) => const PerformancePage(),
    learning: (context) => const LearningPage(),
    essMss: (context) => const EssMssPage(),
   hrmsAssetManagement: (context) => const hrms.AssetManagementPage(),



    leads: (context) => const LeadsPage(),
opportunities: (context) => const OpportunitiesPage(),
accounts: (context) => const AccountsPage(),
contacts: (context) => const ContactsPage(),
activities: (context) => const ActivitiesPage(),
pipeline: (context) => const PipelinePage(),
quotations: (context) => const QuotationsPage(),
campaigns: (context) => const CampaignsPage(),
customerSupport: (context) => const CustomerSupportPage(),

inventory: (context) => const InventoryPage(),
procurement: (context) => const ProcurementPage(),
production: (context) => const ProductionPage(),
salesOrders: (context) => const SalesOrdersPage(),
dispatch: (context) => const DispatchPage(),
erpAssetManagement: (context) => const ErpAssetManagementPage(),
maintenance: (context) => const MaintenancePage(),
vendors: (context) => const VendorsPage(),

accountsPayable: (context) => const AccountsPayablePage(),
accountsReceivable: (context) => const AccountsReceivablePage(),
budgeting: (context) => const BudgetingPage(),
costing: (context) => const CostingPage(),
financialReports: (context) => const FinancialReportsPage(),
generalLedger: (context) => const GeneralLedgerPage(),
multiCurrency: (context) => const MultiCurrencyPage(),
reconciliation: (context) => const ReconciliationPage(),
taxManagement: (context) => const TaxManagementPage(),

approvals: (context) => const ApprovalsPage(),
businessRules: (context) => const BusinessRulesPage(),
processAutomation: (context) => const ProcessAutomationPage(),
processMonitoring: (context) => const ProcessMonitoringPage(),
slasEscalations: (context) => const SlasEscalationsPage(),
taskManagement: (context) => const TaskManagementPage(),
triggers: (context) => const TriggersPage(),
workflowBuilder: (context) => const WorkflowBuilderPage(),
workflowTemplates: (context) => const WorkflowTemplatesPage(),

accessControl: (context) => const AccessControlPage(),
auditTrails: (context) => const AuditTrailsPage(),
documentRepository: (context) => const DocumentRepositoryPage(),
documentTemplates: (context) => const DocumentTemplatesPage(),
fileUploadDownload: (context) => const FileUploadDownloadPage(),
ocrIntegration: (context) => const OcrIntegrationPage(),
retentionPolicies: (context) => const RetentionPoliciesPage(),
taggingSearch: (context) => const TaggingSearchPage(),
versioning: (context) => const VersioningPage(),

billingIntegration: (context) => const BillingIntegrationPage(),
licenseAllocation: (context) => const LicenseAllocationPage(),
licenseKeys: (context) => const LicenseKeysPage(),
paymentTracking: (context) => const PaymentTrackingPage(),
plansFeatures: (context) => const PlansFeaturesPage(),
renewals: (context) => const RenewalsPage(),
tenantSubscriptions: (context) => const TenantSubscriptionsPage(),
trialManagement: (context) => const TrialManagementPage(),
usageQuotas: (context) => const UsageQuotasPage(),

revenueTracking: (context) => const RevenueTrackingPage(),
usageAnalytics: (context) => const UsageAnalyticsPage(),
forecasting: (context) => const ForecastingPage(),
revenueReports: (context) => const RevenueReportsPage(),
revenueRecognition: (context) => const RevenueRecognitionPage(),
commissionManagement: (context) => const CommissionManagementPage(),
financialAnalytics: (context) => const FinancialAnalyticsPage(),
invoicing: (context) => const InvoicingPage(),
revenueIntegration: (context) => const RevenueIntegrationPage(),

standardReports: (context) => const StandardReportsPage(),
adhocReports: (context) => const AdhocReportsPage(),
dataExploration: (context) => const DataExplorationPage(),
biManagement: (context) => const BiManagementPage(),
dataExport: (context) => const DataExportPage(),
scheduledReports: (context) => const ScheduledReportsPage(),
dataVisualization: (context) => const DataVisualizationPage(),
selfServiceAnalytics: (context) => const SelfServiceAnalyticsPage(),

aiModels: (context) => const AiModelsPage(),
aiChatCopilot: (context) => const AiChatCopilotPage(),
documentAiOcr: (context) => const DocumentAiOcrPage(),
predictiveAnalytics: (context) => const PredictiveAnalyticsPage(),
recommendations: (context) => const RecommendationsPage(),
aiWorkflows: (context) => const AiWorkflowsPage(),
modelManagement: (context) => const ModelManagementPage(),
promptEngineering: (context) => const PromptEngineeringPage(),
aiUsageLogs: (context) => const AiUsageLogsPage(),

inAppNotifications: (context) => const InAppNotificationsPage(),
emailNotifications: (context) => const EmailNotificationsPage(),
smsNotifications: (context) => const SmsNotificationsPage(),
pushNotifications: (context) => const PushNotificationsPage(),
notificationTemplates: (context) => const TemplatesPage(),
notificationPreferences: (context) => const PreferencesPage(),
notificationSchedules: (context) => const SchedulesPage(),
deliveryTracking: (context) => const DeliveryTrackingPage(),
multiChannel: (context) => const MultiChannelPage(),

userCalendars: (context) => const UserCalendarsPage(),
teamCalendars: (context) => const TeamCalendarsPage(),
meetingScheduler: (context) => const MeetingSchedulerPage(),
resourceBooking: (context) => const ResourceBookingPage(),
reminders: (context) => const RemindersPage(),
calendarNotifications: (context) => const CalendarNotificationsPage(),
availability: (context) => const AvailabilityPage(),
eventNotifications: (context) => const EventNotificationsPage(),
sharedCalendars: (context) => const SharedCalendarsPage(),

apiManagement: (context) => const ApiManagementPage(),
thirdPartyIntegrations: (context) => const ThirdPartyIntegrationsPage(),
webhooks: (context) => const WebhooksPage(),
eventStreaming: (context) => const EventStreamingPage(),
dataTransformation: (context) => const DataTransformationPage(),
etlDataSync: (context) => const EtlDataSyncPage(),
connectors: (context) => const ConnectorsPage(),
integrationLogs: (context) => const IntegrationLogsPage(),

globalSearch: (context) => const GlobalSearchPage(),
indexManagement: (context) => const IndexManagementPage(),
searchAnalytics: (context) => const SearchAnalyticsPage(),
autocomplete: (context) => const AutocompletePage(),
relevanceRanking: (context) => const RelevanceRankingPage(),
savedSearches: (context) => const SavedSearchesPage(),
multiTenantIndex: (context) => const MultiTenantIndexPage(),
synonyms: (context) => const SynonymsPage(),
suggestionEngine: (context) => const SuggestionEnginePage(),

auditLogs: (context) => const AuditLogsPage(),
activityTracking: (context) => const ActivityTrackingPage(),
complianceReports: (context) => const ComplianceReportsPage(),
dataRetention: (context) => const DataRetentionPage(),
policyManagement: (context) => const PolicyManagementPage(),
threatDetection: (context) => const ThreatDetectionPage(),
vulnerabilityManagement: (context) => const VulnerabilityManagementPage(),
encryptionKeyManagement: (context) => const EncryptionKeyManagementPage(),
securityAlerts: (context) => const SecurityAlertsPage(),

settings: (context) => const SettingsPage(),
  };
}