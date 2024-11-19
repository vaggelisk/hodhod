import 'package:hodhod/data/models/countries/countries.dart';
import 'package:hodhod/data/models/global_model.dart';

class CountriesModel extends GlobalModel {
  CountriesModel({this.data});

  List<Countries>? data;

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
        data: List<Countries>.from(
            json["data"].map((x) => Countries.fromJson(x))),
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
