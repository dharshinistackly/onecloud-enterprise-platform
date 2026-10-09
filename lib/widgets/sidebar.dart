import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../routes/app_routes.dart';

class Sidebar extends StatefulWidget {
  final VoidCallback? onLogout;
  final VoidCallback? onItemSelected;
  final ValueChanged<String>? onRouteSelected;
  final VoidCallback? onClose;

  const Sidebar({
    super.key,
    this.onLogout,
    this.onItemSelected,
    this.onRouteSelected,
    this.onClose,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openRoute(
    BuildContext context,
    String route,
  ) {
    if (!AppRoutes.routes.containsKey(route)) {
      return;
    }

    final provider = context.read<MenuProvider>();
    provider.selectRoute(route);

    widget.onItemSelected?.call();
    widget.onRouteSelected?.call(route);
  }

  void _showUnavailable(
    BuildContext context,
    MenuItemModel item,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '${item.title} page will be connected soon.',
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: item.color,
        ),
      );
  }

  void _closeSidebar(BuildContext context) {
    if (widget.onClose != null) {
      widget.onClose!();
      return;
    }

    if (Scaffold.maybeOf(context)?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
      return;
    }

    widget.onItemSelected?.call();
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = context.watch<MenuProvider>();

    return Container(
      width: 260,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0A0F1F),
            Color(0xFF0C1424),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 82,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  // tap the logo -> back to the landing page
                  child: InkWell(
                    onTap: () => _openRoute(context, AppRoutes.home),
                    child: Image.asset(
                    'assets/stackly_logo_light.png',
                    width: 145,
                    height: 48,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return const Text(
                        'OneCloud Enterprise',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: const Color(0xFF27324A),
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _closeSidebar(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFA6B1C7),
                      size: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal:40,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F5E52).withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'ONE ENTERPRISE CLOUD',
                  style: TextStyle(
                    color: Color(0xFF4ADE9C),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: false,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                children: [
                  ...menuProvider.menuGroups.map(
                    (group) => _buildMenuGroup(
                      context,
                      menuProvider,
                      group,
                    ),
                  ),

                  const SizedBox(height: 8),

                  ...menuProvider.bottomMenuItems.map(
                    (item) => _buildSingleMenuItem(
                      context,
                      menuProvider,
                      item,
                    ),
                  ),

                  _buildLanguageItem(context),

                  _buildLogoutItem(context),

                  _buildProfileFooter(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGroup(
    BuildContext context,
    MenuProvider provider,
    MenuGroupModel group,
  ) {
    final expanded = provider.isExpanded(
      group.title,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),

        InkWell(
          onTap: () {
            if (group.title == 'Platform Administration') {
              // Clicking the module opens its landing page (home) and
              // keeps the sub-menu open.
              if (!provider.isExpanded(group.title)) {
                provider.toggleGroup(group.title);
              }
              _openRoute(context, AppRoutes.home);
            } else {
              provider.toggleGroup(group.title);
            }
          },
          canRequestFocus: false,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          child: Container(
            height: 32,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    group.title.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: group.title == 'Platform Administration' &&
                              provider.selectedRoute == AppRoutes.home
                          ? Colors.white
                          : const Color(0xFF5B6883),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
                // The arrow only opens / closes the sub-menu.
                InkWell(
                  onTap: () => provider.toggleGroup(group.title),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xFF5B6883),
                      size: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        if (expanded)
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              top: 3,
              bottom: 4,
            ),
            child: Column(
              children: group.items.map(
                (item) {
                  return _buildSubMenuItem(
                    context,
                    provider,
                    item,
                  );
                },
              ).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildSubMenuItem(
    BuildContext context,
    MenuProvider provider,
    MenuItemModel item,
  ) {
    final isSelected =
        provider.selectedRoute == item.route;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      canRequestFocus: false,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        if (AppRoutes.routes.containsKey(item.route)) {
          _openRoute(context, item.route);
        } else {
          provider.selectRoute(item.route);
          _showUnavailable(context, item);
        }
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 38,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        margin: const EdgeInsets.only(
          bottom: 2,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B5DE8).withValues(alpha: 0.14)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4C7DFF)
                : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: isSelected
                  ? const Color(0xFF6FA1FF)
                  : const Color(0xFF6B7A99),
              size: 17,
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFFA6B1C7),
                  fontSize: 12.5,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleMenuItem(
    BuildContext context,
    MenuProvider provider,
    MenuItemModel item,
  ) {
    final isSelected =
        provider.selectedRoute == item.route;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      canRequestFocus: false,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        if (AppRoutes.routes.containsKey(item.route)) {
          _openRoute(context, item.route);
        } else {
          provider.selectRoute(item.route);
          _showUnavailable(context, item);
        }
      },
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B5DE8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: isSelected
                  ? Colors.white
                  : const Color(0xFF8B96AD),
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFFA6B1C7),
                  fontSize: 12.5,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageItem(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      canRequestFocus: false,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Language settings coming soon.'),
              duration: Duration(seconds: 1),
            ),
          );
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: const Row(
          children: [
            Icon(
              Icons.language_outlined,
              color: Color(0xFF8B96AD),
              size: 17,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Language',
                style: TextStyle(
                  color: Color(0xFFA6B1C7),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              'English',
              style: TextStyle(
                color: Color(0xFF6B7A99),
                fontSize: 11.5,
              ),
            ),
            SizedBox(width: 2),
            Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF4B5873),
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutItem(
    BuildContext context,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      canRequestFocus: false,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        widget.onLogout?.call();
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: const Row(
          children: [
            Icon(
              Icons.logout_outlined,
              color: Color(0xFFEF6461),
              size: 17,
            ),
            SizedBox(width: 12),
            Text(
              'Logout',
              style: TextStyle(
                color: Color(0xFFA6B1C7),
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Container(
              height: 1,
              color: Colors.white.withValues(
                alpha: 0.06,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xFF3B5DE8),
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Admin User',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Super Admin',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF7C8BA8),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}