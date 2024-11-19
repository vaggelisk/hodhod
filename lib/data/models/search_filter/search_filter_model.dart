import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/search_filter/search_filter.dart';

class SearchFilterModel extends GlobalModel{
  SearchFilterModel({this.data});

  SearchFilter? data;

  factory SearchFilterModel.fromJson(Map<String, dynamic> json) =>
      SearchFilterModel(
        data: json["data"] != null
            ? SearchFilter.fromJson(json["data"])
            : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}