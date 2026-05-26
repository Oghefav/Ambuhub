/// Shared helpers for notification list / unread-count API payloads.
List<Map<String, dynamic>> parseNotificationList(dynamic raw) {
  if (raw is List) {
    return raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
  if (raw is Map<String, dynamic>) {
    for (final key in ['notifications', 'data', 'items']) {
      final list = raw[key];
      if (list is List) {
        return list
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }
    }
  }
  return [];
}

int parseUnreadNotificationCount(dynamic raw) {
  if (raw is num) return raw.toInt();
  if (raw is Map<String, dynamic>) {
    for (final key in ['unreadCount', 'count', 'unread', 'total']) {
      final value = raw[key];
      if (value is num) return value.toInt();
    }
  }
  return 0;
}
