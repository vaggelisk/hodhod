import 'package:dio/dio.dart' as d;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/company_profile/company_profile.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/user/user_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:libphonenumber/libphonenumber.dart';

class SignInController extends BaseController {
  var isMobileSelected = false.obs;
  var isRememberMe = false.obs;
  var obscureText = true.obs;
  var phoneCode = "971".obs;
  var countryCode = 'AE'.obs;
  final mobile = TextEditingController();
  final email = TextEditingController();

  final password = TextEditingController();
  String? fullMobile;

  Future<bool?> isMobileValid() async {
    bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    fullMobile = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    return isValid;
  }

  Future<void> validation() async {
    // if (mobile.text.isEmpty) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.enterMobileNumber.tr);
    //   return;
    // }
    // bool? isValid = await isMobileValid();
    // if (!isValid!) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.mobileNumberInvalid.tr);
    //   return;
    // }
    if (email.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterEmail.tr);
      return;
    }
    if (!GetUtils.isEmail(email.text.trim())) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.emailNotValid.tr);
      return;
    }
    if (password.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterPassword.tr);
      return;
    }
    login();
  }

  Future<void> resendVerificationCode() async {
    // try {
    //   Map<String, String> body = {'email': email.text};
    //   EasyLoading.show();
    //   final result = await httpService.request(
    //       url: ApiConstant.resendVerificationCode,
    //       method: Method.POST,
    //       params: body);
    //   if (result != null) {
    //     if (result is d.Response) {
    //       var data = GlobalModel.fromJson(result.data);
    //       if (data.success == true) {
    //         UiErrorUtils.customSnackbar(
    //             title: LangKeys.success.tr, msg: data.message!);
    //         Get.toNamed(AppRoutes.singleVerification, arguments: [
    //           {"email": email.text.trim(), "from": AppRoutes.signIn}
    //         ]);
    //       } else {
    //         UiErrorUtils.customSnackbar(
    //             title: LangKeys.error.tr, msg: data.message!);
    //       }
    //     }
    //   }
    // } finally {
    //   EasyLoading.dismiss(animation: true);
    // }
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

  Future<void> login() async {
    try {
      Map<String, String> body = {
        'username': email.text,
        // 'mobile': fullMobile ?? "",
        // "country_code": "+${phoneCode.value}",
        // "country_iso": countryCode.value,
        "password": password.text,
        "type": "email",
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.login, method: Method.POST, params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = UserModel.fromJson(result.data);
          if (data.status == true) {
            if (data.data != null) {
              if (data.data?.user?.emailVerifiedAt != null) {
                await FirebaseMessaging.instance
                    .subscribeToTopic('user_${data.data!.user?.id}');
                storage.setUser(data.data!.user!);
                storage.setCompanyProfile(
                    data.data!.user!.companyProfile ?? CompanyProfile());
                storage.setUserToken(data.data!.token!);
                updateLanguage();
              } else {
                Get.toNamed(AppRoutes.verificationCode,
                    arguments: {"email": email.text, "from": AppRoutes.signIn});
              }
            } else {
              UiErrorUtils.customSnackbar(
                  title: LangKeys.error.tr, msg: data.message ?? "");
            }
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: data.message ?? "");
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
}
