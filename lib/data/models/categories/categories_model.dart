import 'package:hodhod/data/models/categories/categories.dart';
import 'package:hodhod/data/models/global_model.dart';

class CategoriesModel extends GlobalModel {
  CategoriesModel({this.data});

  List<Categories>? data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        data: List<Categories>.from(
            json["data"].map((x) => Categories.fromJson(x))),
      )
        ..status = json['status']
        ..message = json['message'];


  @override
  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
