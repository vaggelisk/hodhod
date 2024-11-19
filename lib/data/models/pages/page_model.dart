import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/pages/pages.dart';

class PageModel extends GlobalModel {
  PageModel({this.data});

  Pages? data;

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
        data: json["data"] != null ? Pages.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "page": data?.toJson(),
      };
}
