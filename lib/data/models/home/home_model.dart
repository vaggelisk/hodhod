import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/home/home_data.dart';

class HomeModel extends GlobalModel {
  HomeModel({this.data});

  HomeData? data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        data: json["data"] != null ? HomeData.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}
