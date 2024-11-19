import 'package:hodhod/data/models/global_model.dart';

import 'real_estates_features.dart';

class RealEstatesFeaturesModel extends GlobalModel {
  RealEstatesFeaturesModel({this.data});

  List<RealEstatesFeatures>? data;

  factory RealEstatesFeaturesModel.fromJson(Map<String, dynamic> json) =>
      RealEstatesFeaturesModel(
        data: List<RealEstatesFeatures>.from(
            json["data"].map((x) => RealEstatesFeatures.fromJson(x))),
      )
        ..status = json['ok']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
