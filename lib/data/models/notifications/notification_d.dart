class NotificationD{
  String? id;
  String? title;
  String? details;
  String? type;
  String? seen;
  String? readAt;
  String? createdAt;
  String? createdAtDiff;

  NotificationD({
    this.id,
    this.title,
    this.details,
    this.type,
    this.seen,
    this.readAt,
    this.createdAt,
    this.createdAtDiff,
  });

  factory NotificationD.fromJson(Map<String, dynamic> json) => NotificationD(
    id: json["id"],
    title: json["title"],
    details: json["details"],
    type: json["type"],
    seen: json["seen"],
    readAt: json["read_at"],
    createdAt: json["created_at"],
    createdAtDiff: json["created_at_diff"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "details": details,
    "type": type,
    "seen": seen,
    "read_at": readAt,
    "created_at": createdAt,
    "created_at_diff": createdAtDiff,
  };
}