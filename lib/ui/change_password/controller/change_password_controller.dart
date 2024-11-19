import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/ui/base_controller.dart';

class ChangePasswordController extends BaseController {
  var obscureText = true.obs;
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  Future<void> validation() async {
    if (currentPassword.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterCurrentPassword.tr);
      return;
    }
    if (newPassword.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.newPassword.tr);
      return;
    }
    if (confirmNewPassword.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterConfirmNewPassword.tr);
      return;
    }
    if (newPassword.text != confirmNewPassword.text) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.passwordNotMatch.tr);
      return;
    }

    changePassword();
  }

  Future<void> changePassword() async {
    try {
      Map<String, String> body = {
        "old_password": currentPassword.text.trim(),
        "password": newPassword.text.trim(),
        "password_confirmation": confirmNewPassword.text.trim(),
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.changePassword, method: Method.POST, params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            Get.back();
            UiErrorUtils.customSnackbar(
                title: LangKeys.success.tr, msg: data.message ?? "");
            //
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
}
