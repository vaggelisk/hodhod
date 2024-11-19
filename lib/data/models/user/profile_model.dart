import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/user/user.dart';

import 'user_data.dart';

class ProfileModel extends GlobalModel {
  ProfileModel({this.data});

  User? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: json["data"] != null ? User.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "user": data?.toJson(),
      };
}
