import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/menu_provider.dart';
import '../routes/app_routes.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback? onLogout;

  const Sidebar({
    super.key,
    this.onLogout,
  });

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
            Color(0xFF071A3A),
            Color(0xFF0F3D66),
          ],
        ),
      ),
      child: Column(
        children: [
          // ----------------------------------------------------------
          // FIXED HEADER
          // ----------------------------------------------------------
          Container(
            height: 82,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Image.asset(
                  'assets/onecloud_logo.jpg',
                  width: 145,
                  height: 48,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),

          // ----------------------------------------------------------
          // FIXED SEARCH BAR
          // ----------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
              child: const TextField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Color(0xFFB8C7D9),
                    fontSize: 13,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFB8C7D9),
                    size: 19,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 9,
                    horizontal: 4,
                  ),
                ),
              ),
            ),
          ),

          // ----------------------------------------------------------
          // SCROLLABLE MENU
          // ----------------------------------------------------------
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                children: [
                  // Dashboard
                  _buildDashboardItem(
                    context,
                    menuProvider,
                  ),

                  const SizedBox(height: 8),

                  // Service Groups
                  ...menuProvider.menuGroups.map(
                    (group) => _buildMenuGroup(
                      context,
                      menuProvider,
                      group,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Bottom Menu
                  ...menuProvider.bottomMenuItems.map(
                    (item) => _buildSingleMenuItem(
                      context,
                      menuProvider,
                      item,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Logout
                  _buildLogoutItem(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // DASHBOARD
  // ================================================================

  Widget _buildDashboardItem(
    BuildContext context,
    MenuProvider provider,
  ) {
    final dashboard = provider.dashboard;
    final isSelected = provider.selectedRoute == dashboard.route;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        provider.selectRoute(dashboard.route);

        Navigator.pushNamedAndRemoveUntil(
          context,
          dashboard.route,
          (route) => false,
        );
      },
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.16)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              dashboard.icon,
              color: dashboard.color,
              size: 21,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                dashboard.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // MENU GROUP
  // ================================================================

  Widget _buildMenuGroup(
    BuildContext context,
    MenuProvider provider,
    MenuGroupModel group,
  ) {
    final expanded = provider.isExpanded(group.title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),

        // Group heading
        InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: () {
            provider.toggleGroup(group.title);
          },
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: expanded
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: group.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    group.icon,
                    color: group.color,
                    size: 18,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    group.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFFB8C7D9),
                  size: 19,
                ),
              ],
            ),
          ),
        ),

        // Subheadings
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

  // ================================================================
  // SUB MENU ITEM
  // ================================================================

  Widget _buildSubMenuItem(
    BuildContext context,
    MenuProvider provider,
    MenuItemModel item,
  ) {
    final isSelected = provider.selectedRoute == item.route;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        provider.selectRoute(item.route);

        // Navigate only when the route has been registered.
        if (AppRoutes.routes.containsKey(item.route)) {
          Navigator.pushNamed(
            context,
            item.route,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${item.title} page will be connected soon.',
              ),
              duration: const Duration(seconds: 1),
              backgroundColor: item.color,
            ),
          );
        }
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 38,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 6,
        ),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? item.color.withValues(alpha: 0.16)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Small colored indicator
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: item.color,
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: 10),

            Icon(
              item.icon,
              color: isSelected
                  ? item.color
                  : const Color(0xFFB8C7D9),
              size: 17,
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFFD5DFEA),
                  fontSize: 12.5,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // SINGLE MENU ITEM
  // ================================================================

  Widget _buildSingleMenuItem(
    BuildContext context,
    MenuProvider provider,
    MenuItemModel item,
  ) {
    final isSelected = provider.selectedRoute == item.route;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        provider.selectRoute(item.route);

        if (AppRoutes.routes.containsKey(item.route)) {
          Navigator.pushNamed(
            context,
            item.route,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${item.title} page will be connected soon.',
              ),
              duration: const Duration(seconds: 1),
              backgroundColor: item.color,
            ),
          );
        }
      },
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: item.color,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // LOGOUT
  // ================================================================

  Widget _buildLogoutItem(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        onLogout?.call();
      },
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.logout_outlined,
              color: Color(0xFFFF8A80),
              size: 20,
            ),
            SizedBox(width: 12),
            Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}