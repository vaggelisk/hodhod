import 'package:hodhod/data/models/global_model.dart';

import 'real_estates_types.dart';

class RealEstatesTypesModel extends GlobalModel {
  RealEstatesTypesModel({this.data});

  List<RealEstatesTypes>? data;

  factory RealEstatesTypesModel.fromJson(Map<String, dynamic> json) =>
      RealEstatesTypesModel(
        data: List<RealEstatesTypes>.from(
            json["data"].map((x) => RealEstatesTypes.fromJson(x))),
      )
        ..status = json['ok']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
