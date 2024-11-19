import 'package:hodhod/data/models/global_model.dart';

import 'regions.dart';

class RegionsModel extends GlobalModel {
  RegionsModel({this.data});

  List<Regions>? data;

  factory RegionsModel.fromJson(Map<String, dynamic> json) => RegionsModel(
        data: List<Regions>.from(json["data"].map((x) => Regions.fromJson(x))),
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
