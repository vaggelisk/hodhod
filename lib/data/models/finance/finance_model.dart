import 'package:hodhod/data/models/finance/finance.dart';
import 'package:hodhod/data/models/global_model.dart';

class FinanceModel extends GlobalModel {
  FinanceModel({this.data});

  Finance? data;

  factory FinanceModel.fromJson(Map<String, dynamic> json) => FinanceModel(
        data: json["data"] != null ? Finance.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}
