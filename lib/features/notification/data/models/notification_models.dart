class NotificationItemModel {
  final int id;
  final String type;
  final String title;
  final String body;
  final String? data;
  final bool isRead;
  final DateTime? readAt;
  final DateTime createdAt;

  NotificationItemModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.data,
    required this.isRead,
    required this.readAt,
    required this.createdAt,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      data: json['data'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['createdAt'] as String),
    );
  }

  NotificationItemModel copyWith({
    bool? isRead,
    DateTime? readAt,
  }) {
    return NotificationItemModel(
      id: id,
      type: type,
      title: title,
      body: body,
      data: data,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt,
    );
  }
}

class UnreadCountModel {
  final int count;

  UnreadCountModel({required this.count});

  factory UnreadCountModel.fromJson(Map<String, dynamic> json) {
    return UnreadCountModel(count: (json['count'] as num?)?.toInt() ?? 0);
  }
}
