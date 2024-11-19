import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/gender_model.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as d;

class ContactBrokerController extends BaseController {
  var phoneCode = "971".obs;
  var countryCode = 'AE'.obs;
  final email = TextEditingController();
  final message = TextEditingController();
  final fullName = TextEditingController();
  final mobile = TextEditingController();


  String? fullMobile;

  Future<bool?> isMobileValid() async {
    bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    fullMobile = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    // print("Log fullMobile $fullMobile");
    return isValid;
  }
  RealEstates? data;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments['data'];
  }

  Future<void> validation() async {
    if (fullName.text.isEmpty) {
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
    if (message.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.writeMessage.tr);
      return;
    }


    addRealEstateAction();

  }

  Future<void> addRealEstateAction() async {
    try {
      Map<String, dynamic> body = {
        'real_estate_id': data?.id ?? 0,
        'type': "emailContact",
        'name': fullName.text,
        'email': email.text,
        'mobile': fullMobile ?? "",
        "country_code": "+${phoneCode.value}",
        "country_iso": countryCode.value,
        'message': message.text,
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.addRealEstateAction, method: Method.POST, params: body);
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
