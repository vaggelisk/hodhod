import 'package:hodhod/data/models/global_model.dart';

import 'support_reasons.dart';

class SupportReasonsModel extends GlobalModel {
  SupportReasonsModel({this.data});

  List<SupportReasons>? data;

  factory SupportReasonsModel.fromJson(Map<String, dynamic> json) =>
      SupportReasonsModel(
        data: List<SupportReasons>.from(
            json["data"].map((x) => SupportReasons.fromJson(x))),
      )
        ..status = json['ok']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
