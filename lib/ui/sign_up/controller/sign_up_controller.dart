import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/user/user_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:libphonenumber/libphonenumber.dart';

class SignUpController extends BaseController {
  var isAgreeTerms = false.obs;
  var obscureText = true.obs;
  var phoneCode = "971".obs;
  var countryCode = 'AE'.obs;
  final mobile = TextEditingController();
  final email = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  String? fullMobile;

  Future<bool?> isMobileValid() async {
    bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    fullMobile = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    // print("Log fullMobile $fullMobile");
    return isValid;
  }

  Future<void> validation() async {
    // print("Log ff ${ Utils.removeLeadingZeros(mobile.text.replaceAll(" ", '').trim())}");

    if (userName.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterFullName.tr);
      return;
    }
    if (mobile.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterMobileNumber.tr);
      return;
    }
    bool? isValid = await isMobileValid();
    if (!isValid!) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.mobileNumberInvalid.tr);
      return;
    }
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
    if (confirmPassword.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterConfirmNewPassword.tr);
      return;
    }
    if (password.text != confirmPassword.text) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.passwordNotMatch.tr);
      return;
    }
    if (isAgreeTerms.isFalse) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.iAgree.tr);
      return;
    }
    register();
  }

  Future<void> register() async {
    try {
      Map<String, String> body = {
        'name': userName.text.trim(),
        'email': email.text.trim(),
        'mobile': fullMobile ?? "",
        "country_code": "+${phoneCode.value}",
        "country_iso": countryCode.value,
        "password": password.text
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.register, method: Method.POST, params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = UserModel.fromJson(result.data);
          if (data.status == true) {
            Get.toNamed(AppRoutes.verificationCode, arguments: {
              "email": email.text,
              // "mobile": fullMobile,
              // "country_code": "+${phoneCode.value}",
              // "country_iso": countryCode.value,
              "from": AppRoutes.signUp
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
}
