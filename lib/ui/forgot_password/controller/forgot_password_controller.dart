import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:libphonenumber/libphonenumber.dart';

class ForgotPasswordController extends BaseController {
  var phoneCode = "971".obs;
  var countryCode = 'AE'.obs;
  final mobile = TextEditingController();
  final email = TextEditingController();

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

    sendVerificationCode();
  }

  Future<void> sendVerificationCode() async {
    try {
      Map<String, String> body = {
        'email': email.text,
        'type': "email",
        // 'mobile': fullMobile ?? "",
        // "country_code": "+${phoneCode.value}",
        // "country_iso": countryCode.value,
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
            Get.toNamed(AppRoutes.verificationCode, arguments: {
              'email': email.text,
              // "mobile": fullMobile,
              // "country_code": "+${phoneCode.value}",
              // "country_iso": countryCode.value,
              "from": AppRoutes.forgotPassword
            });
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

  Future<void> login() async {
    // try {
    //   Map<String, String> body = {
    //     'email': email.text.trim(),
    //     "password": password.text
    //   };
    //   EasyLoading.show();
    //   final result = await httpService.request(
    //       url: ApiConstant.login, method: Method.POST, params: body);
    //   if (result != null) {
    //     if (result is d.Response) {
    //       var data = UserModel.fromJson(result.data);
    //       if (data.success == true) {
    //         if (data.data!.isVerified == 1) {
    //           storage.setUser(data.data!);
    //           storage.setUserToken(data.data!.token!);
    //           Get.offAndToNamed(AppRoutes.cHome);
    //         } else {
    //           resendVerificationCode();
    //         }
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

  Future<void> loginMobile() async {
    //   try {
    //     Map<String, String> body = {
    //       'mobile': fullMobile!,
    //       "password": password.text
    //     };
    //     EasyLoading.show();
    //     final result = await httpService.request(
    //         url: ApiConstant.loginMobile, method: Method.POST, params: body);
    //     if (result != null) {
    //       if (result is d.Response) {
    //         var data = UserModel.fromJson(result.data);
    //         if (data.success == true) {
    //           if (data.data!.user!.activity == 1) {
    //             storage.setUser(data.data!.user!);
    //             storage.setUserToken(data.data!.token!);
    //             Get.find<PublicController>().getCurrentBalance();
    //             FirebaseMessaging.instance
    //                 .subscribeToTopic(data.data!.user!.userKey ?? "");
    //             Get.offAllNamed(AppRoutes.home,arguments: {'isRegister': false});
    //           } else {
    //             sendAccountVerification(
    //                 data.data!.user!.mobile!, data.data!.user!.email!);
    //           }
    //         } else {
    //           UiErrorUtils.customSnackbar(
    //               title: LangKeys.error.tr, msg: data.message!);
    //         }
    //       }
    //     }
    //   } finally {
    //     EasyLoading.dismiss(animation: true);
    //   }
  }
}
