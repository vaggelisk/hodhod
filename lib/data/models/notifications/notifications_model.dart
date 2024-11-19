// final notification.Notification data;
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/notifications/notification_data.dart';

class NotificationsModel extends GlobalModel{
  NotificationsModel({this.data});

  NotificationData? data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        data:
        json["data"] != null ? NotificationData.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}