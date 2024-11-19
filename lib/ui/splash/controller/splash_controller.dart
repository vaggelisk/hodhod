import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:dio/dio.dart' as d;

import '../../../app/util/default_firebase_options.dart';
import '../../../app/util/fcm_helper.dart';

class SplashController extends BaseController {
  var hasInternet = false.obs; // Observable for internet status
  var isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
  }

  void checkAuth() async {
    await FcmHelper.initFcm();
    // final notificationHelper = NotificationHelper();
    // notificationHelper.initialize();
    Future.delayed(const Duration(seconds: 3), () {
      if (storage.isIntro()) {
        if (storage.getToken() != null) {
          if (storage.getCountry() == null ||
              storage.getCity() == null ||
              storage.getPrice() == null) {
            Get.offAllNamed(AppRoutes.selectCountry);
          } else {
            Get.offAllNamed(AppRoutes.home);
          }
        } else {
          Get.offAllNamed(AppRoutes.signIn);
        }
      } else {
        Get.offAllNamed(AppRoutes.onBoarding);
      }
    });
  }

  Future<void> updateLanguage() async {
    try {
      Map<String, dynamic> body = {
        'language': storage.getLanguageCode(),
      };
      // EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.updateLanguage,
          method: Method.POST,
          params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            // Get.offAllNamed(AppRoutes.home);
            storage.setLangFirst(true);
          } else {
            // UiErrorUtils.customSnackbar(
            //     title: LangKeys.error.tr, msg: data.message!);
          }
        }
      }
    } finally {
      // EasyLoading.dismiss(animation: true);
    }
  }
  Future<void> checkInternetConnection() async {
    isLoading.value = true; // Show splash screen
    final connectivityResults = await Connectivity().checkConnectivity();
    // Check if any result in the list indicates a connected state
    if (connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.wifi)) {
      hasInternet.value = true;
    } else {
      hasInternet.value = false;
    }

    isLoading.value = false; // Hide splash screen when done
  }


  void retryConnection() {
    checkInternetConnection(); // Retry internet check
  }


}
