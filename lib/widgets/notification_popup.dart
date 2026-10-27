import 'package:flutter/material.dart';

import '../pages/notification/notification_store.dart';
import '../theme/app_theme.dart';

const _ink = AppColors.ink;
const _muted = AppColors.muted;
const _hint = AppColors.hint;
const _border = AppColors.border;
const _blue = AppColors.blue;

// ---------------------------------------------------------------------------
// Shared widgets (also used by the Notifications page)
// ---------------------------------------------------------------------------

/// "4 unread" pill.
class UnreadBadge extends StatelessWidget {
  final int count;
  const UnreadBadge(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EEFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$count unread',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _blue,
        ),
      ),
    );
  }
}

/// One notification.
///
/// * [compact]    -> small version used in the bell pop-up
/// * [timeInline] -> (phones) show the time next to the category label
class NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;
  final bool compact;
  final bool timeInline;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
    this.compact = false,
    this.timeInline = false,
  });

  @override
  Widget build(BuildContext context) {
    final n = notification;
    final kind = n.kind;

    final icon = Container(
      width: compact ? 30 : 34,
      height: compact ? 30 : 34,
      decoration: BoxDecoration(color: kind.background, shape: BoxShape.circle),
      child: Icon(kind.icon, size: compact ? 15 : 17, color: kind.color),
    );

    final dot = Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(color: _blue, shape: BoxShape.circle),
    );

    if (compact) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      n.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: n.read ? FontWeight.w500 : FontWeight.w700,
                        color: _ink,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      n.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _muted,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      n.time,
                      style: const TextStyle(fontSize: 10, color: _hint),
                    ),
                  ],
                ),
              ),
              if (!n.read)
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: dot,
                ),
            ],
          ),
        ),
      );
    }

    final timeText = Text(
      n.time,
      style: const TextStyle(fontSize: 11, color: _hint),
    );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          kind.label,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppFonts.mono,
                            fontSize: 9.5,
                            letterSpacing: .8,
                            fontWeight: FontWeight.w700,
                            color: kind.color,
                          ),
                        ),
                      ),
                      if (timeInline) ...[
                        const Spacer(),
                        timeText,
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    n.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: n.read ? FontWeight.w500 : FontWeight.w700,
                      color: _ink,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    n.message,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _muted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (!timeInline) ...[
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  timeText,
                  const SizedBox(height: 8),
                  if (!n.read) dot,
                ],
              ),
            ] else if (!n.read)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 6),
                child: dot,
              ),
          ],
        ),
      ),
    );
  }
}

/// "No Notifications" state.
class NotificationEmptyState extends StatelessWidget {
  final bool compact;
  final VoidCallback? onCheckUpdates;
  final VoidCallback? onSettings;

  const NotificationEmptyState({
    super.key,
    this.compact = false,
    this.onCheckUpdates,
    this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final ring = compact ? 64.0 : 96.0;
    final inner = compact ? 40.0 : 60.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: compact ? 22 : 44,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ring,
              height: ring,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF3FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: inner,
                  height: inner,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFDCE4F5)),
                  ),
                  child: Icon(
                    compact
                        ? Icons.notifications_off_outlined
                        : Icons.notifications_none_rounded,
                    size: compact ? 20 : 28,
                    color: _blue,
                  ),
                ),
              ),
            ),
            SizedBox(height: compact ? 12 : 18),
            Text(
              'No Notifications',
              style: TextStyle(
                fontSize: compact ? 13 : 16,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: compact ? 230 : 340),
              child: Text(
                "You're all caught up! When there are new alerts or updates, they'll show up here.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: compact ? 11 : 12.5,
                  height: 1.5,
                  color: _muted,
                ),
              ),
            ),
            if (!compact && (onCheckUpdates != null || onSettings != null)) ...[
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  if (onCheckUpdates != null)
                    SizedBox(
                      height: 36,
                      child: OutlinedButton.icon(
                        onPressed: onCheckUpdates,
                        icon: const Icon(Icons.refresh, size: 15),
                        label: const Text(
                          'Check for updates',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _ink,
                          side: const BorderSide(color: Color(0xFFD8E0E8)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  if (onSettings != null)
                    SizedBox(
                      height: 36,
                      child: ElevatedButton.icon(
                        onPressed: onSettings,
                        icon: const Icon(Icons.notifications_none, size: 15),
                        label: const Text(
                          'Notification Settings',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _blue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bell pop-up
// ---------------------------------------------------------------------------

/// Opens the notification drop-down under the bell icon.
///
/// [onViewAll] runs when "View all notifications" is pressed (the shell passes
/// a callback that opens the Notifications page inside the content area).
Future<void> showNotificationPopup(
  BuildContext context, {
  VoidCallback? onViewAll,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Notifications',
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: (_, animation, __, child) =>
        FadeTransition(opacity: animation, child: child),
    pageBuilder: (dialogContext, _, __) {
      final size = MediaQuery.of(dialogContext).size;
      final phone = size.width < 700;

      // Distance from the right edge so the pop-up sits under the bell.
      // Change this number if your header layout moves the bell.
      const desktopRightOffset = 190.0;

      return SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: phone ? 62 : 70,
              left: phone ? 12 : 0,
              right: phone ? 12 : desktopRightOffset,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 380,
                maxHeight: size.height - 110,
              ),
              child: _NotificationPopup(
                onViewAll: () {
                  Navigator.of(dialogContext).pop();
                  onViewAll?.call();
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _NotificationPopup extends StatefulWidget {
  final VoidCallback onViewAll;
  const _NotificationPopup({required this.onViewAll});

  @override
  State<_NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<_NotificationPopup> {
  final _store = NotificationStore.instance;
  int _tab = 0; // 0 = all, 1 = unread

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: ListenableBuilder(
        listenable: _store,
        builder: (context, _) {
          final all = _store.all;
          final unread = _store.unread;
          // the pop-up only shows the latest few
          final shown = (_tab == 0 ? all : unread).take(4).toList();

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
                child: Row(
                  children: [
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _ink,
                      ),
                    ),
                    const SizedBox(width: 8),
                    UnreadBadge(unread.length),
                    const Spacer(),
                    InkWell(
                      onTap: all.isEmpty ? null : _store.markAllRead,
                      child: Text(
                        'Mark all as read',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: all.isEmpty ? _hint : _blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
                child: Row(
                  children: [
                    _tabChip('All (${all.length})', 0),
                    const SizedBox(width: 8),
                    _tabChip('Unread (${unread.length})', 1),
                  ],
                ),
              ),
              const Divider(height: 1, color: _border),
              Flexible(
                child: shown.isEmpty
                    ? const NotificationEmptyState(compact: true)
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: shown.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          color: Color(0xFFF0F3F7),
                        ),
                        itemBuilder: (_, i) => NotificationTile(
                          notification: shown[i],
                          compact: true,
                          onTap: () => _store.markRead(shown[i].id),
                        ),
                      ),
              ),
              const Divider(height: 1, color: _border),
              InkWell(
                onTap: widget.onViewAll,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View all notifications',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _blue,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 14, color: _blue),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tabChip(String label, int index) {
    final on = _tab == index;

    return InkWell(
      onTap: () => setState(() => _tab = index),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: on ? _blue : const Color(0xFFF1F4F8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: on ? Colors.white : _muted,
          ),
        ),
      ),
    );
  }
}