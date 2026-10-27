import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/notification_popup.dart';
import 'notification_store.dart';

/// Notifications page (route `AppRoutes.notifications`).
///
/// * Desktop (>= 700px): header row, tabs + filter, divided list, pager.
/// * Phone   (<  700px): compact header, scrolling tabs, card-style list.
///
/// Content only (no header / sidebar) - the AppShell provides those.
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

const _ink = AppColors.ink;
const _muted = AppColors.muted;
const _hint = AppColors.hint;
const _border = AppColors.border;
const _blue = AppColors.blue;

class _NotificationsPageState extends State<NotificationsPage> {
  final _store = NotificationStore.instance;

  int _tab = 0; // 0 = All, 1 = Unread, 2 = Read
  NotificationKind? _kind; // category filter (null = all types)
  int _page = 1;

  // TODO: take this from your API (total pages).
  static const _totalPages = 8;

  // ----------------------------- actions ---------------------------------
  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void _back() {
    final nav = Navigator.of(context);

    if (nav.canPop()) {
      nav.pop();
    } else {
      nav.pushReplacementNamed(AppRoutes.home);
    }
  }

  void _openSettings() {
    if (AppRoutes.routes.containsKey(AppRoutes.notificationPreferences)) {
      Navigator.of(context).pushNamed(AppRoutes.notificationPreferences);
    } else {
      _toast('Notification settings will be connected soon.');
    }
  }

  void _checkUpdates() {
    _store.reset();
    setState(() {
      _tab = 0;
      _kind = null;
    });
    _toast('Notifications are up to date');
  }

  List<AppNotification> _visible() {
    final base = _tab == 0
        ? _store.all
        : _tab == 1
            ? _store.unread
            : _store.read;

    if (_kind == null) return base;
    return base.where((n) => n.kind == _kind).toList();
  }

  // ----------------------------- build -----------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListenableBuilder(
        listenable: _store,
        builder: (context, _) {
          return LayoutBuilder(
            builder: (context, c) {
              final mobile = c.maxWidth < 700;
              final items = _visible();

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  mobile ? 16 : 24,
                  mobile ? 16 : 20,
                  mobile ? 16 : 24,
                  28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(mobile),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _toolbar(mobile),
                          const Divider(height: 1, color: _border),
                          if (items.isEmpty)
                            NotificationEmptyState(
                              onCheckUpdates: _checkUpdates,
                              onSettings: _openSettings,
                            )
                          else ...[
                            for (var i = 0; i < items.length; i++) ...[
                              NotificationTile(
                                notification: items[i],
                                timeInline: mobile,
                                onTap: () => _store.markRead(items[i].id),
                              ),
                              if (i != items.length - 1)
                                const Divider(
                                  height: 1,
                                  color: Color(0xFFF0F3F7),
                                ),
                            ],
                            const Divider(height: 1, color: _border),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: _pager(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ----------------------------- header ----------------------------------
  Widget _header(bool mobile) {
    final unread = _store.unreadCount;

    final backButton = InkWell(
      onTap: _back,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFD8E0E8)),
          color: Colors.white,
        ),
        child: const Icon(Icons.arrow_back, size: 17, color: _ink),
      ),
    );

    final markAll = InkWell(
      onTap: _store.all.isEmpty ? null : _store.markAllRead,
      child: Text(
        'Mark all as read',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _store.all.isEmpty ? _hint : _blue,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            backButton,
            const SizedBox(width: 12),
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: mobile ? AppType.pageTitleM : AppType.pageTitleD,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
            const SizedBox(width: 10),
            UnreadBadge(unread),
            const Spacer(),
            if (!mobile) markAll,
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 44),
          child: Text(
            'Stay updated with activities, system alerts, and important updates.',
            style: TextStyle(
              fontSize: mobile ? 12 : AppType.pageSubtitle,
              color: _muted,
            ),
          ),
        ),
        if (mobile) ...[
          const SizedBox(height: 10),
          Align(alignment: Alignment.centerRight, child: markAll),
        ],
      ],
    );
  }

  // ----------------------------- tabs + filter ---------------------------
  Widget _toolbar(bool mobile) {
    final tabs = Row(
      children: [
        _tab_('All (${_store.all.length})', 0),
        const SizedBox(width: 8),
        _tab_('Unread (${_store.unread.length})', 1),
        const SizedBox(width: 8),
        _tab_('Read (${_store.read.length})', 2),
      ],
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(mobile ? 12 : 16, 12, 8, 12),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: tabs,
            ),
          ),
          PopupMenuButton<String>(
            tooltip: 'Filter',
            icon: Icon(
              Icons.filter_alt_outlined,
              size: 20,
              color: _kind == null ? _muted : _blue,
            ),
            onSelected: (value) {
              if (value == '__clear__') {
                _store.clear();
                return;
              }
              setState(() {
                _page = 1;
                _kind = value == '__all__'
                    ? null
                    : NotificationKind.values
                        .firstWhere((k) => k.name == value);
              });
            },
            itemBuilder: (_) => [
              CheckedPopupMenuItem(
                value: '__all__',
                checked: _kind == null,
                child: const Text('All types'),
              ),
              for (final k in NotificationKind.values)
                CheckedPopupMenuItem(
                  value: k.name,
                  checked: _kind == k,
                  child: Text(k.label),
                ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: '__clear__',
                child: Text('Clear all notifications'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tab_(String label, int index) {
    final on = _tab == index;

    return InkWell(
      onTap: () => setState(() {
        _tab = index;
        _page = 1;
      }),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: on ? _blue : const Color(0xFFF1F4F8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: on ? Colors.white : _muted,
          ),
        ),
      ),
    );
  }

  // ----------------------------- pager -----------------------------------
  Widget _pager() {
    Widget box({
      String? text,
      IconData? icon,
      bool selected = false,
      VoidCallback? onTap,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF202A68) : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: selected
                    ? const Color(0xFF202A68)
                    : (icon != null
                        ? const Color(0xFFDDE3E9)
                        : Colors.transparent),
              ),
            ),
            child: icon != null
                ? Icon(
                    icon,
                    size: 16,
                    color: onTap == null ? _hint : const Color(0xFF4F5D6B),
                  )
                : Text(
                    text!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: selected ? Colors.white : const Color(0xFF4F5D6B),
                    ),
                  ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        box(
          icon: Icons.chevron_left,
          onTap: _page > 1 ? () => setState(() => _page--) : null,
        ),
        for (final p in [1, 2, 3])
          box(
            text: '$p',
            selected: _page == p,
            onTap: () => setState(() => _page = p),
          ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text('…', style: TextStyle(color: _hint)),
        ),
        box(
          text: '$_totalPages',
          selected: _page == _totalPages,
          onTap: () => setState(() => _page = _totalPages),
        ),
        box(
          icon: Icons.chevron_right,
          onTap: _page < _totalPages ? () => setState(() => _page++) : null,
        ),
      ],
    );
  }
}