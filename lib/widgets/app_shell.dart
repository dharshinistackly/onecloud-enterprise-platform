import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/menu_provider.dart';
import '../routes/app_routes.dart';
import 'sidebar.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  final String title;
  final String subtitle;
  final VoidCallback? onLogout;

  const AppShell({
    super.key,
    required this.child,
    this.title = 'Dashboard',
    this.subtitle = 'OneCloud Enterprise',
    this.onLogout,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> _contentNavigatorKey =
      GlobalKey<NavigatorState>();

  bool _desktopSidebarOpen = true;

  void _logout() {
    if (widget.onLogout != null) {
      widget.onLogout!();
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }

  void _search(String value) {
    final text = value.trim();
    if (text.isEmpty) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Searching for: $text'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _navigateContent(String route) {
    final navigator = _contentNavigatorKey.currentState;
    if (navigator == null) return;

    if (route == AppRoutes.home) {
      navigator.popUntil(
        (page) => page.settings.name == AppRoutes.home,
      );
      return;
    }

    if (!AppRoutes.routes.containsKey(route)) {
      return;
    }

    navigator.popUntil(
      (page) => page.settings.name == AppRoutes.home,
    );

    navigator.pushNamed(route);
  }

  Route<dynamic> _buildContentRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.home) {
      return MaterialPageRoute(
        settings: const RouteSettings(name: AppRoutes.home),
        builder: (_) => widget.child,
      );
    }

    final builder = AppRoutes.routes[settings.name];

    if (builder != null) {
      return MaterialPageRoute(
        settings: settings,
        builder: builder,
      );
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
            'Page not found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  void _syncSelectedRoute(String? route) {
    if (route == null) return;

    final provider = context.read<MenuProvider>();

    if (provider.selectedRoute != route) {
      provider.selectRoute(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        final isTablet =
            constraints.maxWidth >= 700 && constraints.maxWidth < 1050;
        final useDrawer = isMobile || isTablet;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xFFF4F8FC),
          drawer: useDrawer
              ? Drawer(
                  width: isMobile ? 280 : 300,
                  child: SafeArea(
                    child: Sidebar(
                      onLogout: _logout,
                      onItemSelected: () {
                        Navigator.of(context).pop();
                      },
                      onRouteSelected: _navigateContent,
                    ),
                  ),
                )
              : null,
          body: SafeArea(
            child: Row(
              children: [
                if (!useDrawer && _desktopSidebarOpen)
                  SizedBox(
                    width: 260,
                    child: Sidebar(
                      onLogout: _logout,
                      onRouteSelected: _navigateContent,
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      _buildHeader(
                        isMobile: isMobile,
                        isTablet: isTablet,
                      ),
                      Expanded(
                        child: Navigator(
                          key: _contentNavigatorKey,
                          initialRoute: AppRoutes.home,
                          onGenerateRoute: _buildContentRoute,
                          observers: [
                            _ContentRouteObserver(
                              onRouteChanged: _syncSelectedRoute,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader({
    required bool isMobile,
    required bool isTablet,
  }) {
    final searchWidth = isTablet ? 145.0 : 210.0;

    return Container(
      height: 76,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (isMobile || isTablet) {
                _scaffoldKey.currentState?.openDrawer();
              } else {
                setState(() {
                  _desktopSidebarOpen = !_desktopSidebarOpen;
                });
              }
            },
            icon: Icon(
              isMobile || isTablet
                  ? Icons.menu
                  : (_desktopSidebarOpen
                      ? Icons.menu_open
                      : Icons.menu),
              color: const Color(0xFF0F3D66),
              size: 27,
            ),
            tooltip: 'Menu',
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F3D66),
                  ),
                ),
                if (widget.subtitle.isNotEmpty)
                  Text(
                    widget.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          if (!isMobile) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFD6E8FA),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_done_outlined,
                    size: 17,
                    color: Color(0xFF1677C8),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Cloud Connected',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1677C8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: searchWidth,
              height: 40,
              child: TextField(
                onSubmitted: _search,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF64748B),
                    size: 19,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF4F8FC),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFF1677C8),
                    ),
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(width: 4),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('No new notifications'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF475569),
              size: 25,
            ),
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 2),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Profile selected'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              } else if (value == 'settings') {
                _navigateContent(AppRoutes.settings);
              } else if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person_outline),
                    SizedBox(width: 10),
                    Text('Profile'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined),
                    SizedBox(width: 10),
                    Text('Settings'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FC),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD5E8F7),
                ),
              ),
              child: const Icon(
                Icons.person_outline,
                color: Color(0xFF1677C8),
                size: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentRouteObserver extends NavigatorObserver {
  final ValueChanged<String?> onRouteChanged;

  _ContentRouteObserver({
    required this.onRouteChanged,
  });

  void _notify(Route<dynamic>? route) {
    onRouteChanged(route?.settings.name);
  }

  @override
  void didPush(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    _notify(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({
    Route<dynamic>? newRoute,
    Route<dynamic>? oldRoute,
  }) {
    _notify(newRoute);
    super.didReplace(
      newRoute: newRoute,
      oldRoute: oldRoute,
    );
  }

  @override
  void didPop(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    _notify(previousRoute);
    super.didPop(route, previousRoute);
  }
}
