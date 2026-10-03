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

    // NavigatorObserver callbacks (didPush/didReplace/didPop) can fire while
    // the framework is still in the middle of building/mounting widgets
    // (e.g. during initial route restoration). Calling notifyListeners()
    // synchronously in that window throws "setState() or markNeedsBuild()
    // called during build." Deferring to a post-frame callback runs this
    // safely once the current frame has finished building.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final provider = context.read<MenuProvider>();

      if (provider.selectedRoute != route) {
        provider.selectRoute(route);
      }
    });
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
  if (isMobile) {
    return Column(
      children: [
        Container(
          height: 86,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE2E8F0),
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFD9E0E7),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Color(0xFF263746),
                    size: 25,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Image.asset(
                  'assets/stackly_logo.png',
                  height: 34,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                ),
              ),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFD9E0E7),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No new notifications',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                      },
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Color(0xFF536576),
                        size: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 2,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE63946),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'settings') {
                    _navigateContent(AppRoutes.settings);
                  } else if (value == 'logout') {
                    _logout();
                  }
                },
                itemBuilder: (context) => const [
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
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF72C7A9),
                        Color(0xFF367FA0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            18,
            16,
            18,
            14,
          ),
          color: Colors.white,
          child: SizedBox(
            height: 52,
            child: TextField(
              onSubmitted: _search,
              decoration: InputDecoration(
                hintText: 'Search tenants, users, settings...',
                hintStyle: const TextStyle(
                  color: Color(0xFF777F87),
                  fontSize: 16,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF617589),
                  size: 24,
                ),
                filled: true,
                fillColor: const Color(0xFFF3F5F6),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(
                    color: Color(0xFFDCE2E6),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(
                    color: Color(0xFFDCE2E6),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(
                    color: Color(0xFF3B5DE8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

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
            color: const Color(0xFF0B1220),
            size: 24,
          ),
          tooltip: 'Menu',
        ),
        const SizedBox(width: 10),
        if (!isMobile) ...[
          SizedBox(
            width: 420,
            height: 37,
            child: TextField(
              onSubmitted: _search,
              style: const TextStyle(fontSize: 12.5),
              decoration: InputDecoration(
                hintText:
                    'Search tenants, users, settings, audit logs...',
                hintStyle: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11.5,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF94A3B8),
                  size: 18,
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
                    color: Color(0xFF3B5DE8),
                  ),
                ),
              ),
            ),
          ),
        ],
        const Spacer(),
        Stack(
          clipBehavior: Clip.none,
          children: [
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
                size: 23,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () => _navigateContent(AppRoutes.settings),
          icon: const Icon(
            Icons.settings_outlined,
            color: Color(0xFF475569),
            size: 22,
          ),
        ),
        const SizedBox(width: 4),
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'settings') {
              _navigateContent(AppRoutes.settings);
            } else if (value == 'logout') {
              _logout();
            }
          },
          itemBuilder: (context) => const [
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
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEAF0FE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF3B5DE8),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin User',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0B1220),
                      ),
                    ),
                    Text(
                      'Super Admin',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF64748B),
                  size: 18,
                ),
              ],
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