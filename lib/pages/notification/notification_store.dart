import 'package:flutter/material.dart';

/// Kinds of notification. Each one has its own label, colour and icon.
enum NotificationKind { billing, onboarding, security, lockout, infrastructure, audit }

extension NotificationKindStyle on NotificationKind {
  String get label {
    switch (this) {
      case NotificationKind.billing:
        return 'BILLING ALERT';
      case NotificationKind.onboarding:
        return 'NEW / IDENTITY';
      case NotificationKind.security:
        return 'SECURITY ALERT';
      case NotificationKind.lockout:
        return 'AUTH LOCKOUT';
      case NotificationKind.infrastructure:
        return 'INFRASTRUCTURE';
      case NotificationKind.audit:
        return 'AUDIT & COMPLIANCE';
    }
  }

  Color get color {
    switch (this) {
      case NotificationKind.billing:
        return const Color(0xFFD98A12);
      case NotificationKind.onboarding:
        return const Color(0xFF16A870);
      case NotificationKind.security:
        return const Color(0xFFE74760);
      case NotificationKind.lockout:
        return const Color(0xFFD98A12);
      case NotificationKind.infrastructure:
        return const Color(0xFF3B5BDB);
      case NotificationKind.audit:
        return const Color(0xFF61758A);
    }
  }

  Color get background {
    switch (this) {
      case NotificationKind.billing:
      case NotificationKind.lockout:
        return const Color(0xFFFFF1D6);
      case NotificationKind.onboarding:
        return const Color(0xFFE5F6EE);
      case NotificationKind.security:
        return const Color(0xFFFFE8EC);
      case NotificationKind.infrastructure:
        return const Color(0xFFE8EEFF);
      case NotificationKind.audit:
        return const Color(0xFFEEF1F5);
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationKind.billing:
        return Icons.warning_amber_rounded;
      case NotificationKind.onboarding:
        return Icons.check_circle_outline;
      case NotificationKind.security:
        return Icons.gpp_maybe_outlined;
      case NotificationKind.lockout:
        return Icons.lock_outline;
      case NotificationKind.infrastructure:
        return Icons.cloud_done_outlined;
      case NotificationKind.audit:
        return Icons.description_outlined;
    }
  }
}

class AppNotification {
  final String id;
  final NotificationKind kind;
  final String title;
  final String message;
  final String time;
  bool read;

  AppNotification({
    required this.id,
    required this.kind,
    required this.title,
    required this.message,
    required this.time,
    this.read = false,
  });
}

/// One shared list used by the bell pop-up and the Notifications page, so
/// "Mark all as read" in one place updates the other.
///
/// TODO: replace [_sample] with data from your API / provider.
class NotificationStore extends ChangeNotifier {
  NotificationStore._() {
    reset();
  }

  static final NotificationStore instance = NotificationStore._();

  List<AppNotification> _items = [];

  List<AppNotification> get all => List.unmodifiable(_items);
  List<AppNotification> get unread =>
      _items.where((n) => !n.read).toList(growable: false);
  List<AppNotification> get read =>
      _items.where((n) => n.read).toList(growable: false);

  int get unreadCount => _items.where((n) => !n.read).length;

  void markRead(String id) {
    for (final n in _items) {
      if (n.id == id && !n.read) {
        n.read = true;
        notifyListeners();
      }
    }
  }

  void markAllRead() {
    for (final n in _items) {
      n.read = true;
    }
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }

  /// Restores the sample data ("Check for updates" in the empty state).
  void reset() {
    _items = _sample();
    notifyListeners();
  }

  static List<AppNotification> _sample() => [
        AppNotification(
          id: '1',
          kind: NotificationKind.billing,
          title: 'Acme Corp enterprise license expires in 5 days',
          message:
              'Review account usage and renewal options before expiry to avoid seat suspension.',
          time: '1 hr ago',
        ),
        AppNotification(
          id: '2',
          kind: NotificationKind.onboarding,
          title: 'NovaTech Solutions completed onboarding and SSO setup',
          message: 'Primary tenant provisioned with SAML / Okta.',
          time: '3 hr ago',
        ),
        AppNotification(
          id: '3',
          kind: NotificationKind.security,
          title: 'Admin login from unrecognized IP (194.26.29.4)',
          message: 'Delta Retail Group — Frankfurt, DE. Geo-fence triggered.',
          time: '4 hr ago',
        ),
        AppNotification(
          id: '4',
          kind: NotificationKind.lockout,
          title: '5 consecutive failed MFA attempts',
          message: 'User j.mehta@acmecorp.com locked (Employees).',
          time: '5 hr ago',
        ),
        AppNotification(
          id: '5',
          kind: NotificationKind.infrastructure,
          title: 'SSL certificate was renewed successfully (2 certs)',
          message: 'Provider rotation completed without downtime.',
          time: 'Yesterday',
          read: true,
        ),
        AppNotification(
          id: '6',
          kind: NotificationKind.audit,
          title: 'Weekly compliance audit log ready for download',
          message: 'Compliance audit export is available in Audit & Compliance.',
          time: '2 days ago',
          read: true,
        ),
      ];
}