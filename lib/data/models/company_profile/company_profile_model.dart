import 'package:hodhod/data/models/company_profile/company_profile.dart';
import 'package:hodhod/data/models/global_model.dart';

class CompanyProfileModel extends GlobalModel {
  CompanyProfileModel({this.data});

  CompanyProfile? data;

  factory CompanyProfileModel.fromJson(Map<String, dynamic> json) =>
      CompanyProfileModel(
        data:
            json["data"] != null ? CompanyProfile.fromJson(json["data"]) : null,
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}
