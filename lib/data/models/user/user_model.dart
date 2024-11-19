import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/user/user.dart';

import 'user_data.dart';

class UserModel extends GlobalModel {
  UserModel({this.data});

  UserData? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: json["data"] != null ? UserData.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "user": data?.toJson(),
      };
}
