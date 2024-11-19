import 'package:hodhod/data/models/cities/cities.dart';
import 'package:hodhod/data/models/global_model.dart';

class CitiesModel extends GlobalModel {
  CitiesModel({this.data});

  List<Cities>? data;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        data: List<Cities>.from(json["data"].map((x) => Cities.fromJson(x))),
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
