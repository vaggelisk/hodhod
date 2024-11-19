import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/languages/language.dart';

class LanguagesModel extends GlobalModel {
  LanguagesModel({this.data});

  List<Language>? data;

  factory LanguagesModel.fromJson(Map<String, dynamic> json) => LanguagesModel(
        data:
            List<Language>.from(json["data"].map((x) => Language.fromJson(x))),
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
