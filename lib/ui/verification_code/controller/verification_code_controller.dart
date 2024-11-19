import 'dart:async';

import 'package:dio/dio.dart' as d;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/user/user_model.dart';
import 'package:hodhod/ui/base_controller.dart';

class VerificationCodeController extends BaseController {
  var pinController = TextEditingController();
  late Timer _timer;
  final RxInt start = 60.obs;
  var timeStr = "00:00".obs;
  String? from;

  @override
  onInit() {
    super.onInit();
    from = Get.arguments['from'];
    if (from == AppRoutes.forgotPassword) {
      startTimer();
    } else {
      sendVerificationCode();
    }
  }

  Future<void> updateProfileSettings() async {
    try {
      Map<String, dynamic> body = {
        'min_budget': storage.getPrice()?.fromPrice ?? "",
        'max_budget': storage.getPrice()?.toPrice ?? "",
        'country_id': storage.getCountry()?.id ?? "",
        'city_id': storage.getCity()?.id != 0 ? storage.getCity()?.id : null,
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.updateProfileSettings,
          method: Method.POST,
          params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            Get.offAllNamed(AppRoutes.home);
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: data.message!);
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  Future<void> verifyMobile() async {
    try {
      Map<String, String> body = {
        'email': Get.arguments['email'],
        // 'mobile': Get.arguments['mobile'],
        // "country_code": Get.arguments['country_code'],
        // "country_iso": Get.arguments['country_iso'],
        "code": pinController.text
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.verifyEmail, method: Method.POST, params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = UserModel.fromJson(result.data);
          if (data.status == true) {
            if (Get.arguments['from'] == AppRoutes.signUp) {
              await FirebaseMessaging.instance
                  .subscribeToTopic('user_${data.data!.user?.id}');
              storage.setUser(data.data!.user!);
              storage.setUserToken(data.data!.token!);
              showSuccessBottomSheet(data.message ?? "",
                  textBtn: LangKeys.continueText.tr, onClick: () {
                Get.back();
                updateLanguage();
              });
            } else if (Get.arguments['from'] == AppRoutes.signIn) {
              await FirebaseMessaging.instance
                  .subscribeToTopic('user_${data.data!.user?.id}');
              storage.setUser(data.data!.user!);
              storage.setUserToken(data.data!.token!);
              showSuccessBottomSheet(data.message ?? "",
                  textBtn: LangKeys.continueText.tr, onClick: () {
                    Get.back();
                    updateLanguage();
                  });
              // storage.setUser(data.data!.user!);
              // storage.setUserToken(data.data!.token!);
              // showSuccessBottomSheet(data.message ?? "",
              //     textBtn: LangKeys.continueText.tr, onClick: () {
              //   Get.back();
              //   if (storage.getCountry() == null ||
              //       storage.getCity() == null ||
              //       storage.getPrice() == null) {
              //     Get.offAllNamed(AppRoutes.selectCountry);
              //   } else {
              //     updateProfileSettings();
              //     // Get.offAllNamed(AppRoutes.home);
              //   }
              // });
            } else if (Get.arguments['from'] == AppRoutes.forgotPassword) {
              storage.setUserToken(data.data!.token!);
              Get.toNamed(AppRoutes.newPassword);
            }
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: data.message!);
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  Future<void> updateLanguage() async {
    try {
      Map<String, dynamic> body = {
        'language': storage.getLanguageCode(),
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.updateLanguage, method: Method.POST, params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            if (storage.getCountry() == null ||
                storage.getCity() == null ||
                storage.getPrice() == null) {
              Get.offAllNamed(AppRoutes.selectCountry);
            } else {
              updateProfileSettings();
              // Get.offAllNamed(AppRoutes.home);
            }
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: data.message!);
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  void startTimer() {
    start.value = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value == start.value--;
        }
        timeStr.value = intToTimeLeft(start.value);
      },
    );
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);
    //
    // String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    String result = "$minuteLeft:$secondsLeft";

    return result;
  }

  Future<void> sendVerificationCode() async {
    try {
      Map<String, String> body = {
        'email': Get.arguments['email'],
        'type': "email",
        // 'mobile': Get.arguments['mobile'],
        // "country_code": Get.arguments['country_code'],
        // "country_iso": Get.arguments['country_iso'],
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.sendVerificationCode,
          method: Method.POST,
          params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            UiErrorUtils.customSnackbar(
                title: LangKeys.success.tr, msg: data.message!);
            startTimer();
            // Get.toNamed(AppRoutes.verificationCode, arguments: [
            //   {
            //     "mobile": fullMobile,
            //     "country_code": "+${phoneCode.value}",
            //     "country_iso": countryCode.value,
            //     "from": AppRoutes.signUp
            //   }
            // ]);
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: data.message!);
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    _timer.cancel();
    super.dispose();
  }
}
