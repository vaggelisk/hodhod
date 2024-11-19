import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:libphonenumber/libphonenumber.dart';

class ContactUsController extends BaseController {
  var phoneCode = "971".obs;
  var countryCode = 'AE'.obs;
  final name = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final message = TextEditingController();
  String? fullMobile;

  Future<bool?> isMobileValid() async {
    bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    fullMobile = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    return isValid;
  }

  Future<void> validation() async {
    if (name.text.isEmpty) {
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
          title: LangKeys.error.tr,
          msg: LangKeys.enterMobileNumberCorrectly.tr);
      return;
    }
    if (email.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterEmail.tr);
      return;
    }
    if (!GetUtils.isEmail(email.text)) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.emailNotValid.tr);
      return;
    }

    if (message.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.writeMessage.tr);
      return;
    }

    contactUs();
  }

  Future<void> contactUs() async {
    try {
      Map<String, String> body = {
        'name': name.text,
        'email': email.text,
        'mobile': fullMobile ?? "",
        "country_code": "+${phoneCode.value}",
        "country_iso": countryCode.value,
        'message': message.text,
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.contactUs, method: Method.POST, params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            showSuccessBottomSheet(data.message ?? "", onClick: () {
              Get.back();
              Get.back();
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
