import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/real_estates/real_estate_data.dart';

class RealEstateModel extends GlobalModel {
  RealEstateModel({this.data});

  RealEstateData? data;

  factory RealEstateModel.fromJson(Map<String, dynamic> json) =>
      RealEstateModel(
        data:
            json["data"] != null ? RealEstateData.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}
