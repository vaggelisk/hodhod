import 'package:hodhod/data/models/global_model.dart';

import 'notification_d.dart';

class NotificationsDetailsModel extends GlobalModel {
  NotificationsDetailsModel({this.data});

  NotificationD? data;

  factory NotificationsDetailsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsDetailsModel(
        data:
            json["data"] != null ? NotificationD.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}
