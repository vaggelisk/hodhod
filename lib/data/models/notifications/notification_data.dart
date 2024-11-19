import 'notification_d.dart';

class NotificationData{
  List<NotificationD>? items;
  // Paginate paginate;
  int? unreadNotificationsCount;

  NotificationData({
    this.items,
    // this.paginate,
    this.unreadNotificationsCount,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    items: List<NotificationD>.from(json["items"].map((x) => NotificationD.fromJson(x))),
    // paginate: Paginate.fromJson(json["paginate"]),
    unreadNotificationsCount: json["unread_notifications_count"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    // "paginate": paginate.toJson(),
    "unread_notifications_count": unreadNotificationsCount,
  };
}