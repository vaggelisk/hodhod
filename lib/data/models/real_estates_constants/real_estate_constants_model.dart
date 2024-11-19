import 'package:hodhod/data/models/global_model.dart';

import 'real_estate_constants_data.dart';

class RealEstateConstantsModel extends GlobalModel {
  RealEstateConstantsModel({this.data});

  RealEstateConstantsData? data;

  factory RealEstateConstantsModel.fromJson(Map<String, dynamic> json) =>
      RealEstateConstantsModel(
        data: json["data"] != null
            ? RealEstateConstantsData.fromJson(json["data"])
            : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}
