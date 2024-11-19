import 'package:hodhod/data/models/global_model.dart';

import 'on_boarding.dart';

class OnBoardingModel extends GlobalModel {
  OnBoardingModel({this.data});

  List<OnBoarding>? data;

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) =>
      OnBoardingModel(
        data: List<OnBoarding>.from(
            json["data"].map((x) => OnBoarding.fromJson(x))),
      )
        ..status = json['status']
        ..message = json['message'];

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
