import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/on_boarding/on_boarding.dart';
import 'package:hodhod/data/models/on_boarding/on_boarding_model.dart';
import 'package:hodhod/data/models/slider_model.dart';
import 'package:hodhod/ui/base_controller.dart';

import 'package:dio/dio.dart' as d;

class OnBoardingController extends BaseController {
  var currentIndex = 0.obs;
  var isLoading = false.obs;
  late PageController controller;
  var splashScreensList = <OnBoarding>[];
  var sliderList = <SliderModel>[];

  @override
  void onInit() {
    super.onInit();
    controller = PageController(initialPage: 0);
    getWelcomePage();
  }

  Future<void> getWelcomePage() async {
    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiConstant.onBoarding, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = OnBoardingModel.fromJson(result.data);
          splashScreensList.clear();
          sliderList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            splashScreensList.addAll(resp.data!);
          }
          for (var element in splashScreensList) {
            sliderList.add(SliderModel(
                title: element.title ?? "",
                description: element.content ?? "",
                image: element.image ?? ""));
          }
        }
      }
    } finally {
      update(['update']);
      isLoading(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
