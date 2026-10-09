import 'package:flutter/material.dart';

class MenuItemModel {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const MenuItemModel({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}

class MenuGroupModel {
  final String title;
  final IconData icon;
  final Color color;
  final List<MenuItemModel> items;

  const MenuGroupModel({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class MenuProvider extends ChangeNotifier {
  String _selectedRoute = '/home';

  final Set<String> _expandedGroups = {
    'Platform Administration',
  };

  String get selectedRoute => _selectedRoute;

  bool isExpanded(String groupTitle) {
    return _expandedGroups.contains(groupTitle);
  }

  void selectRoute(String route) {
    _selectedRoute = route;
    notifyListeners();
  }

  void toggleGroup(String groupTitle) {
    if (_expandedGroups.contains(groupTitle)) {
      _expandedGroups.remove(groupTitle);
    } else {
      _expandedGroups.add(groupTitle);
    }

    notifyListeners();
  }

  // Main dashboard item
  MenuItemModel get dashboard => const MenuItemModel(
        title: 'Dashboard',
        icon: Icons.dashboard_outlined,
        color: Color(0xFF1677C8),
        route: '/home',
      );

  // All sidebar groups
  List<MenuGroupModel> get menuGroups => const [

       MenuGroupModel(
  title: 'Platform Administration',
  icon: Icons.admin_panel_settings_outlined,
  color: Color(0xFF1677C8),
  items: [
    // Super Admin Dashboard page
    MenuItemModel(
      title: 'Super Admin Dashboard',
      icon: Icons.space_dashboard_outlined,
      color: Color(0xFF1677C8),
      route: '/super-admin-dashboard',
    ),
    MenuItemModel(
  title: 'Global Dashboard',
  icon: Icons.dashboard_outlined,
  color: Color(0xFF1677C8),
  route: '/global-dashboard',
),
    MenuItemModel(
      title: 'Platform Branding',
      icon: Icons.palette_outlined,
      color: Color(0xFF1677C8),
      route: '/platform-branding',
    ),
    MenuItemModel(
      title: 'Global Settings',
      icon: Icons.settings_outlined,
      color: Color(0xFF1677C8),
      route: '/global-settings',
    ),
    MenuItemModel(
      title: 'Platform Configuration',
      icon: Icons.tune_outlined,
      color: Color(0xFF1677C8),
      route: '/platform-config',
    ),
    MenuItemModel(
      title: 'License Management',
      icon: Icons.card_membership_outlined,
      color: Color(0xFF1677C8),
      route: '/license-management',
    ),
    MenuItemModel(
      title: 'Feature Management',
      icon: Icons.extension_outlined,
      color: Color(0xFF1677C8),
      route: '/feature-management',
    ),
   
    MenuItemModel(
      title: 'Platform Health Overview',
      icon: Icons.health_and_safety_outlined,
      color: Color(0xFF1677C8),
      route: '/system-health',
    ),
   
  ],
),

        
        // HRMS SERVICE
        
        MenuGroupModel(
          title: 'HRMS Service',
          icon: Icons.people_alt_outlined,
          color: Color(0xFF43A047),
          items: [
            MenuItemModel(
              title: 'Employee Management',
              icon: Icons.badge_outlined,
              color: Color(0xFF43A047),
              route: '/employee-management',
            ),
            MenuItemModel(
              title: 'Attendance',
              icon: Icons.access_time_outlined,
              color: Color(0xFF43A047),
              route: '/attendance',
            ),
            MenuItemModel(
              title: 'Leave',
              icon: Icons.event_available_outlined,
              color: Color(0xFF43A047),
              route: '/leave',
            ),
            MenuItemModel(
              title: 'Payroll',
              icon: Icons.payments_outlined,
              color: Color(0xFF43A047),
              route: '/payroll',
            ),
            MenuItemModel(
              title: 'Recruitment',
              icon: Icons.person_add_alt_1_outlined,
              color: Color(0xFF43A047),
              route: '/recruitment',
            ),
            MenuItemModel(
              title: 'Performance',
              icon: Icons.trending_up_outlined,
              color: Color(0xFF43A047),
              route: '/performance',
            ),
            MenuItemModel(
              title: 'Learning',
              icon: Icons.school_outlined,
              color: Color(0xFF43A047),
              route: '/learning',
            ),
            MenuItemModel(
              title: 'ESS / MSS',
              icon: Icons.manage_accounts_outlined,
              color: Color(0xFF43A047),
              route: '/ess-mss',
            ),
            MenuItemModel(
              title: 'Asset Management',
              icon: Icons.devices_outlined,
              color: Color(0xFF43A047),
              route: '/asset-management',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // CRM SERVICE
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'CRM Service',
          icon: Icons.support_agent_outlined,
          color: Color(0xFFE91E63),
          items: [
            MenuItemModel(
              title: 'Leads',
              icon: Icons.person_search_outlined,
              color: Color(0xFFE91E63),
              route: '/leads',
            ),
            MenuItemModel(
              title: 'Opportunities',
              icon: Icons.lightbulb_outline,
              color: Color(0xFFE91E63),
              route: '/opportunities',
            ),
            MenuItemModel(
              title: 'Accounts',
              icon: Icons.account_balance_outlined,
              color: Color(0xFFE91E63),
              route: '/accounts',
            ),
            MenuItemModel(
              title: 'Contacts',
              icon: Icons.contacts_outlined,
              color: Color(0xFFE91E63),
              route: '/contacts',
            ),
            MenuItemModel(
              title: 'Activities',
              icon: Icons.event_note_outlined,
              color: Color(0xFFE91E63),
              route: '/activities',
            ),
            MenuItemModel(
              title: 'Pipeline',
              icon: Icons.account_tree_outlined,
              color: Color(0xFFE91E63),
              route: '/pipeline',
            ),
            MenuItemModel(
              title: 'Quotations',
              icon: Icons.request_quote_outlined,
              color: Color(0xFFE91E63),
              route: '/quotations',
            ),
            MenuItemModel(
              title: 'Campaigns',
              icon: Icons.campaign_outlined,
              color: Color(0xFFE91E63),
              route: '/campaigns',
            ),
            MenuItemModel(
              title: 'Customer Support',
              icon: Icons.headset_mic_outlined,
              color: Color(0xFFE91E63),
              route: '/customer-support',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // ERP SERVICE
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'ERP Service',
          icon: Icons.inventory_2_outlined,
          color: Color(0xFFEF8A24),
          items: [
            MenuItemModel(
              title: 'Inventory',
              icon: Icons.inventory_outlined,
              color: Color(0xFFEF8A24),
              route: '/inventory',
            ),
            MenuItemModel(
              title: 'Procurement',
              icon: Icons.shopping_cart_outlined,
              color: Color(0xFFEF8A24),
              route: '/procurement',
            ),
            MenuItemModel(
              title: 'Production',
              icon: Icons.precision_manufacturing_outlined,
              color: Color(0xFFEF8A24),
              route: '/production',
            ),
            MenuItemModel(
              title: 'Sales Orders',
              icon: Icons.shopping_bag_outlined,
              color: Color(0xFFEF8A24),
              route: '/sales-orders',
            ),
            MenuItemModel(
              title: 'Dispatch',
              icon: Icons.local_shipping_outlined,
              color: Color(0xFFEF8A24),
              route: '/dispatch',
            ),
            MenuItemModel(
              title: 'Asset Management',
              icon: Icons.business_outlined,
              color: Color(0xFFEF8A24),
              route: '/erp-asset-management',
            ),
            MenuItemModel(
              title: 'Maintenance',
              icon: Icons.build_outlined,
              color: Color(0xFFEF8A24),
              route: '/maintenance',
            ),
            MenuItemModel(
              title: 'Vendors',
              icon: Icons.storefront_outlined,
              color: Color(0xFFEF8A24),
              route: '/vendors',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // FINANCE & ACCOUNTING
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'Finance & Accounting',
          icon: Icons.account_balance_outlined,
          color: Color(0xFF008C95),
          items: [
            MenuItemModel(
              title: 'General Ledger',
              icon: Icons.menu_book_outlined,
              color: Color(0xFF008C95),
              route: '/general-ledger',
            ),
            MenuItemModel(
              title: 'Accounts Payable',
              icon: Icons.arrow_circle_down_outlined,
              color: Color(0xFF008C95),
              route: '/accounts-payable',
            ),
            MenuItemModel(
              title: 'Accounts Receivable',
              icon: Icons.arrow_circle_up_outlined,
              color: Color(0xFF008C95),
              route: '/accounts-receivable',
            ),
            MenuItemModel(
              title: 'Tax Management',
              icon: Icons.receipt_long_outlined,
              color: Color(0xFF008C95),
              route: '/tax-management',
            ),
            MenuItemModel(
              title: 'Budgeting',
              icon: Icons.account_balance_wallet_outlined,
              color: Color(0xFF008C95),
              route: '/budgeting',
            ),
            MenuItemModel(
              title: 'Costing',
              icon: Icons.calculate_outlined,
              color: Color(0xFF008C95),
              route: '/costing',
            ),
            MenuItemModel(
              title: 'Financial Reports',
              icon: Icons.bar_chart_outlined,
              color: Color(0xFF008C95),
              route: '/financial-reports',
            ),
            MenuItemModel(
              title: 'Reconciliation',
              icon: Icons.sync_alt_outlined,
              color: Color(0xFF008C95),
              route: '/reconciliation',
            ),
            MenuItemModel(
              title: 'Multi-Currency',
              icon: Icons.currency_exchange_outlined,
              color: Color(0xFF008C95),
              route: '/multi-currency',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // WORKFLOW & AUTOMATION
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'Workflow & Automation',
          icon: Icons.account_tree_outlined,
          color: Color(0xFF6842A5),
          items: [
            MenuItemModel(
              title: 'Workflow Builder',
              icon: Icons.account_tree_outlined,
              color: Color(0xFF6842A5),
              route: '/workflow-builder',
            ),
            MenuItemModel(
              title: 'Approvals',
              icon: Icons.approval_outlined,
              color: Color(0xFF6842A5),
              route: '/approvals',
            ),
            MenuItemModel(
              title: 'Business Rules',
              icon: Icons.rule_outlined,
              color: Color(0xFF6842A5),
              route: '/business-rules',
            ),
            MenuItemModel(
              title: 'Process Automation',
              icon: Icons.auto_mode_outlined,
              color: Color(0xFF6842A5),
              route: '/process-automation',
            ),
            MenuItemModel(
              title: 'Task Management',
              icon: Icons.task_alt_outlined,
              color: Color(0xFF6842A5),
              route: '/task-management',
            ),
            MenuItemModel(
              title: 'Triggers',
              icon: Icons.bolt_outlined,
              color: Color(0xFF6842A5),
              route: '/triggers',
            ),
            MenuItemModel(
              title: 'SLAs & Escalations',
              icon: Icons.priority_high_outlined,
              color: Color(0xFF6842A5),
              route: '/slas-escalations',
            ),
            MenuItemModel(
              title: 'Process Monitoring',
              icon: Icons.monitor_heart_outlined,
              color: Color(0xFF6842A5),
              route: '/process-monitoring',
            ),
            MenuItemModel(
              title: 'Workflow Templates',
              icon: Icons.description_outlined,
              color: Color(0xFF6842A5),
              route: '/workflow-templates',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // DOCUMENT MANAGEMENT
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'Document Management',
          icon: Icons.folder_copy_outlined,
          color: Color(0xFFD6A800),
          items: [
            MenuItemModel(
              title: 'Document Repository',
              icon: Icons.folder_open_outlined,
              color: Color(0xFFD6A800),
              route: '/document-repository',
            ),
            MenuItemModel(
              title: 'Versioning',
              icon: Icons.history_outlined,
              color: Color(0xFFD6A800),
              route: '/versioning',
            ),
            MenuItemModel(
              title: 'File Upload / Download',
              icon: Icons.upload_file_outlined,
              color: Color(0xFFD6A800),
              route: '/file-management',
            ),
            MenuItemModel(
              title: 'Access Control',
              icon: Icons.lock_outline,
              color: Color(0xFFD6A800),
              route: '/document-access-control',
            ),
            MenuItemModel(
              title: 'Document Templates',
              icon: Icons.article_outlined,
              color: Color(0xFFD6A800),
              route: '/document-templates',
            ),
            MenuItemModel(
              title: 'Tagging & Search',
              icon: Icons.local_offer_outlined,
              color: Color(0xFFD6A800),
              route: '/document-search',
            ),
            MenuItemModel(
              title: 'Retention Policies',
              icon: Icons.policy_outlined,
              color: Color(0xFFD6A800),
              route: '/retention-policies',
            ),
            MenuItemModel(
              title: 'Audit Trails',
              icon: Icons.fact_check_outlined,
              color: Color(0xFFD6A800),
              route: '/document-audit-trails',
            ),
            MenuItemModel(
              title: 'OCR Integration',
              icon: Icons.document_scanner_outlined,
              color: Color(0xFFD6A800),
              route: '/ocr-integration',
            ),
          ],
        ),

        // SUBSCRIPTION SERVICE
        MenuGroupModel(
          title: 'Subscription Service',
          icon: Icons.card_membership_outlined,
          color: Color(0xFFE83E8C),
          items: [
            MenuItemModel(
              title: 'Plans & Features',
              icon: Icons.layers_outlined,
              color: Color(0xFFE83E8C),
              route: '/plans-features',
            ),
            MenuItemModel(
              title: 'Tenant Subscriptions',
              icon: Icons.business_center_outlined,
              color: Color(0xFFE83E8C),
              route: '/tenant-subscriptions',
            ),
            MenuItemModel(
              title: 'Usage & Quotas',
              icon: Icons.data_usage_outlined,
              color: Color(0xFFE83E8C),
              route: '/usage-quotas',
            ),
            MenuItemModel(
              title: 'Payment Tracking',
              icon: Icons.payment_outlined,
              color: Color(0xFFE83E8C),
              route: '/payment-tracking',
            ),
            MenuItemModel(
              title: 'License Allocation',
              icon: Icons.assignment_turned_in_outlined,
              color: Color(0xFFE83E8C),
              route: '/license-allocation',
            ),
            MenuItemModel(
              title: 'License Keys',
              icon: Icons.key_outlined,
              color: Color(0xFFE83E8C),
              route: '/license-keys',
            ),
            MenuItemModel(
              title: 'Renewals',
              icon: Icons.autorenew_outlined,
              color: Color(0xFFE83E8C),
              route: '/renewals',
            ),
            MenuItemModel(
              title: 'Trial Management',
              icon: Icons.timer_outlined,
              color: Color(0xFFE83E8C),
              route: '/trial-management',
            ),
            MenuItemModel(
              title: 'Billing Integration',
              icon: Icons.receipt_outlined,
              color: Color(0xFFE83E8C),
              route: '/billing-integration',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // REVENUE SERVICE
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'Revenue Service',
          icon: Icons.trending_up_outlined,
          color: Color(0xFF1976D2),
          items: [
            MenuItemModel(
              title: 'Revenue Tracking',
              icon: Icons.show_chart_outlined,
              color: Color(0xFF1976D2),
              route: '/revenue-tracking',
            ),
            MenuItemModel(
              title: 'Usage Analytics',
              icon: Icons.analytics_outlined,
              color: Color(0xFF1976D2),
              route: '/usage-analytics',
            ),
            MenuItemModel(
              title: 'Forecasting',
              icon: Icons.insights_outlined,
              color: Color(0xFF1976D2),
              route: '/forecasting',
            ),
            MenuItemModel(
              title: 'Revenue Reports',
              icon: Icons.assessment_outlined,
              color: Color(0xFF1976D2),
              route: '/revenue-reports',
            ),
            MenuItemModel(
              title: 'Revenue Recognition',
              icon: Icons.verified_outlined,
              color: Color(0xFF1976D2),
              route: '/revenue-recognition',
            ),
            MenuItemModel(
              title: 'Commission Management',
              icon: Icons.percent_outlined,
              color: Color(0xFF1976D2),
              route: '/commission-management',
            ),
            MenuItemModel(
              title: 'Financial Analytics',
              icon: Icons.query_stats_outlined,
              color: Color(0xFF1976D2),
              route: '/financial-analytics',
            ),
            MenuItemModel(
              title: 'Invoicing',
              icon: Icons.receipt_long_outlined,
              color: Color(0xFF1976D2),
              route: '/invoicing',
            ),
            MenuItemModel(
              title: 'Integration',
              icon: Icons.integration_instructions_outlined,
              color: Color(0xFF1976D2),
              route: '/revenue-integration',
            ),
          ],
        ),

        // REPORTING & BI
        MenuGroupModel(
          title: 'Reporting & BI',
          icon: Icons.bar_chart_outlined,
          color: Color(0xFF6A4FB3),
          items: [
            MenuItemModel(
              title: 'Standard Reports',
              icon: Icons.description_outlined,
              color: Color(0xFF6A4FB3),
              route: '/standard-reports',
            ),
            MenuItemModel(
              title: 'Ad-hoc Reports',
              icon: Icons.edit_document,
              color: Color(0xFF6A4FB3),
              route: '/adhoc-reports',
            ),
            MenuItemModel(
              title: 'Data Exploration',
              icon: Icons.explore_outlined,
              color: Color(0xFF6A4FB3),
              route: '/data-exploration',
            ),
            MenuItemModel(
              title: 'BI Management',
              icon: Icons.dashboard_outlined,
              color: Color(0xFF6A4FB3),
              route: '/bi-management',
            ),
            MenuItemModel(
              title: 'Data Export',
              icon: Icons.file_download_outlined,
              color: Color(0xFF6A4FB3),
              route: '/data-export',
            ),
            MenuItemModel(
              title: 'Scheduled Reports',
              icon: Icons.schedule_outlined,
              color: Color(0xFF6A4FB3),
              route: '/scheduled-reports',
            ),
            MenuItemModel(
              title: 'Data Visualization',
              icon: Icons.pie_chart_outline,
              color: Color(0xFF6A4FB3),
              route: '/data-visualization',
            ),
            MenuItemModel(
              title: 'Self-Service Analytics',
              icon: Icons.insights_outlined,
              color: Color(0xFF6A4FB3),
              route: '/self-service-analytics',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // ENTERPRISE AI SERVICE
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'Enterprise AI Service',
          icon: Icons.psychology_outlined,
          color: Color(0xFF36A05C),
          items: [
            MenuItemModel(
              title: 'AI Models',
              icon: Icons.model_training_outlined,
              color: Color(0xFF36A05C),
              route: '/ai-models',
            ),
            MenuItemModel(
              title: 'AI Chat / Copilot',
              icon: Icons.chat_outlined,
              color: Color(0xFF36A05C),
              route: '/ai-chat',
            ),
            MenuItemModel(
              title: 'Document AI / OCR',
              icon: Icons.document_scanner_outlined,
              color: Color(0xFF36A05C),
              route: '/document-ai',
            ),
            MenuItemModel(
              title: 'Predictive Analytics',
              icon: Icons.auto_graph_outlined,
              color: Color(0xFF36A05C),
              route: '/predictive-analytics',
            ),
            MenuItemModel(
              title: 'Recommendations',
              icon: Icons.recommend_outlined,
              color: Color(0xFF36A05C),
              route: '/recommendations',
            ),
            MenuItemModel(
              title: 'AI Workflows',
              icon: Icons.account_tree_outlined,
              color: Color(0xFF36A05C),
              route: '/ai-workflows',
            ),
            MenuItemModel(
              title: 'Model Management',
              icon: Icons.settings_suggest_outlined,
              color: Color(0xFF36A05C),
              route: '/model-management',
            ),
            MenuItemModel(
              title: 'Prompt Engineering',
              icon: Icons.code_outlined,
              color: Color(0xFF36A05C),
              route: '/prompt-engineering',
            ),
            MenuItemModel(
              title: 'AI Usage Logs',
              icon: Icons.receipt_long_outlined,
              color: Color(0xFF36A05C),
              route: '/ai-usage-logs',
            ),
          ],
        ),

        // NOTIFICATION SERVICE

        MenuGroupModel(
          title: 'Notification Service',
          icon: Icons.notifications_outlined,
          color: Color(0xFFE83E8C),
          items: [
            MenuItemModel(
              title: 'In-App Notifications',
              icon: Icons.notifications_active_outlined,
              color: Color(0xFFE83E8C),
              route: '/in-app-notifications',
            ),
            MenuItemModel(
              title: 'Email Notifications',
              icon: Icons.email_outlined,
              color: Color(0xFFE83E8C),
              route: '/email-notifications',
            ),
            MenuItemModel(
              title: 'SMS Notifications',
              icon: Icons.sms_outlined,
              color: Color(0xFFE83E8C),
              route: '/sms-notifications',
            ),
            MenuItemModel(
              title: 'Push Notifications',
              icon: Icons.phone_android_outlined,
              color: Color(0xFFE83E8C),
              route: '/push-notifications',
            ),
            MenuItemModel(
              title: 'Templates',
              icon: Icons.dashboard_customize_outlined,
              color: Color(0xFFE83E8C),
              route: '/notification-templates',
            ),
            MenuItemModel(
              title: 'Preferences',
              icon: Icons.tune_outlined,
              color: Color(0xFFE83E8C),
              route: '/notification-preferences',
            ),
            MenuItemModel(
              title: 'Schedules',
              icon: Icons.schedule_outlined,
              color: Color(0xFFE83E8C),
              route: '/notification-schedules',
            ),
            MenuItemModel(
              title: 'Delivery Tracking',
              icon: Icons.local_shipping_outlined,
              color: Color(0xFFE83E8C),
              route: '/delivery-tracking',
            ),
            MenuItemModel(
              title: 'Multi-Channel',
              icon: Icons.hub_outlined,
              color: Color(0xFFE83E8C),
              route: '/multi-channel',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // CALENDAR SERVICE
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'Calendar Service',
          icon: Icons.calendar_month_outlined,
          color: Color(0xFF2A9DA3),
          items: [
            MenuItemModel(
              title: 'User Calendars',
              icon: Icons.calendar_today_outlined,
              color: Color(0xFF2A9DA3),
              route: '/user-calendars',
            ),
            MenuItemModel(
              title: 'Team Calendars',
              icon: Icons.groups_outlined,
              color: Color(0xFF2A9DA3),
              route: '/team-calendars',
            ),
            MenuItemModel(
              title: 'Meeting Scheduler',
              icon: Icons.event_outlined,
              color: Color(0xFF2A9DA3),
              route: '/meeting-scheduler',
            ),
            MenuItemModel(
              title: 'Resource Booking',
              icon: Icons.meeting_room_outlined,
              color: Color(0xFF2A9DA3),
              route: '/resource-booking',
            ),
            MenuItemModel(
              title: 'Reminders',
              icon: Icons.alarm_outlined,
              color: Color(0xFF2A9DA3),
              route: '/reminders',
            ),
            MenuItemModel(
              title: 'Notifications',
              icon: Icons.notifications_outlined,
              color: Color(0xFF2A9DA3),
              route: '/calendar-notifications',
            ),
            MenuItemModel(
              title: 'Availability',
              icon: Icons.event_available_outlined,
              color: Color(0xFF2A9DA3),
              route: '/availability',
            ),
            MenuItemModel(
              title: 'Event Notifications',
              icon: Icons.notifications_active_outlined,
              color: Color(0xFF2A9DA3),
              route: '/event-notifications',
            ),
            MenuItemModel(
              title: 'Shared Calendars',
              icon: Icons.share_outlined,
              color: Color(0xFF2A9DA3),
              route: '/shared-calendars',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // INTEGRATION SERVICE
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'Integration Service',
          icon: Icons.integration_instructions_outlined,
          color: Color(0xFFEF8A24),
          items: [
            MenuItemModel(
              title: 'API Management',
              icon: Icons.api_outlined,
              color: Color(0xFFEF8A24),
              route: '/api-management',
            ),
            MenuItemModel(
              title: 'Third-Party Integrations',
              icon: Icons.extension_outlined,
              color: Color(0xFFEF8A24),
              route: '/third-party-integrations',
            ),
            MenuItemModel(
              title: 'Webhooks',
              icon: Icons.webhook_outlined,
              color: Color(0xFFEF8A24),
              route: '/webhooks',
            ),
            MenuItemModel(
              title: 'Event Streaming',
              icon: Icons.stream_outlined,
              color: Color(0xFFEF8A24),
              route: '/event-streaming',
            ),
            MenuItemModel(
              title: 'Data Transformation',
              icon: Icons.transform_outlined,
              color: Color(0xFFEF8A24),
              route: '/data-transformation',
            ),
            MenuItemModel(
              title: 'ETL / Data Sync',
              icon: Icons.sync_outlined,
              color: Color(0xFFEF8A24),
              route: '/etl-data-sync',
            ),
            MenuItemModel(
              title: 'Connectors',
              icon: Icons.link_outlined,
              color: Color(0xFFEF8A24),
              route: '/connectors',
            ),
            MenuItemModel(
              title: 'Integration Logs',
              icon: Icons.receipt_long_outlined,
              color: Color(0xFFEF8A24),
              route: '/integration-logs',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // SEARCH SERVICE
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'Search Service',
          icon: Icons.search_outlined,
          color: Color(0xFF7046B8),
          items: [
            MenuItemModel(
              title: 'Global Search',
              icon: Icons.search_outlined,
              color: Color(0xFF7046B8),
              route: '/global-search',
            ),
            MenuItemModel(
              title: 'Index Management',
              icon: Icons.list_alt_outlined,
              color: Color(0xFF7046B8),
              route: '/index-management',
            ),
            MenuItemModel(
              title: 'Search Analytics',
              icon: Icons.analytics_outlined,
              color: Color(0xFF7046B8),
              route: '/search-analytics',
            ),
            MenuItemModel(
              title: 'AutoComplete',
              icon: Icons.auto_awesome_outlined,
              color: Color(0xFF7046B8),
              route: '/autocomplete',
            ),
            MenuItemModel(
              title: 'Relevance Ranking',
              icon: Icons.sort_outlined,
              color: Color(0xFF7046B8),
              route: '/relevance-ranking',
            ),
            MenuItemModel(
              title: 'Saved Searches',
              icon: Icons.bookmark_border_outlined,
              color: Color(0xFF7046B8),
              route: '/saved-searches',
            ),
            MenuItemModel(
              title: 'Multi-Tenant Index',
              icon: Icons.storage_outlined,
              color: Color(0xFF7046B8),
              route: '/multi-tenant-index',
            ),
            MenuItemModel(
              title: 'Synonyms',
              icon: Icons.compare_arrows_outlined,
              color: Color(0xFF7046B8),
              route: '/synonyms',
            ),
            MenuItemModel(
              title: 'Suggestion Engine',
              icon: Icons.lightbulb_outline,
              color: Color(0xFF7046B8),
              route: '/suggestion-engine',
            ),
          ],
        ),

        // ------------------------------------------------------------
        // SECURITY & COMPLIANCE
        // ------------------------------------------------------------
        MenuGroupModel(
          title: 'Security & Compliance',
          icon: Icons.security_outlined,
          color: Color(0xFF0F4C81),
          items: [
            MenuItemModel(
              title: 'Audit Logs',
              icon: Icons.fact_check_outlined,
              color: Color(0xFF0F4C81),
              route: '/audit-logs',
            ),
            MenuItemModel(
              title: 'Activity Tracking',
              icon: Icons.track_changes_outlined,
              color: Color(0xFF0F4C81),
              route: '/activity-tracking',
            ),
            MenuItemModel(
              title: 'Compliance Reports',
              icon: Icons.assessment_outlined,
              color: Color(0xFF0F4C81),
              route: '/compliance-reports',
            ),
            MenuItemModel(
              title: 'Data Retention',
              icon: Icons.archive_outlined,
              color: Color(0xFF0F4C81),
              route: '/data-retention',
            ),
            MenuItemModel(
              title: 'Policy Management',
              icon: Icons.policy_outlined,
              color: Color(0xFF0F4C81),
              route: '/policy-management',
            ),
            MenuItemModel(
              title: 'Threat Detection',
              icon: Icons.gpp_maybe_outlined,
              color: Color(0xFF0F4C81),
              route: '/threat-detection',
            ),
            MenuItemModel(
              title: 'Vulnerability Management',
              icon: Icons.bug_report_outlined,
              color: Color(0xFF0F4C81),
              route: '/vulnerability-management',
            ),
            MenuItemModel(
              title: 'Encryption & Key Management',
              icon: Icons.key_outlined,
              color: Color(0xFF0F4C81),
              route: '/encryption-key-management',
            ),
            MenuItemModel(
              title: 'Security Alerts',
              icon: Icons.warning_amber_outlined,
              color: Color(0xFF0F4C81),
              route: '/security-alerts',
            ),
          ],
        ),
      ];

  // Items that appear below the service groups
  List<MenuItemModel> get bottomMenuItems => const [
        MenuItemModel(
          title: 'Settings',
          icon: Icons.settings_outlined,
          color: Color(0xFF64748B),
          route: '/settings',
        ),
      ];
}