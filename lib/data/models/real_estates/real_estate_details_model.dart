import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/real_estates/real_estate_data.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';

class RealEstateDetailsModel extends GlobalModel {
  RealEstateDetailsModel({this.data});

  RealEstates? data;

  factory RealEstateDetailsModel.fromJson(Map<String, dynamic> json) =>
      RealEstateDetailsModel(
        data: json["data"] != null ? RealEstates.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}
