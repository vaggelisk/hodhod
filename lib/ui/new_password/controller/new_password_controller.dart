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
import 'package:hodhod/ui/base_controller.dart';
import 'package:dio/dio.dart' as d;

class NewPasswordController extends BaseController {
  var obscureText = true.obs;

  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  Future<void> validation() async {
    if (password.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterNewPassword.tr);
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

    resetPassword();
  }

  Future<void> resetPassword() async {
    try {
      Map<String, String> body = {
        "password": password.text,
        "password_confirmation": confirmPassword.text
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.resetPassword, method: Method.POST, params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            storage.clearApp();
            showSuccessBottomSheet(data.message ?? "",
                textBtn: LangKeys.continueText.tr, onClick: () {
              Get.back();
              Get.offAllNamed(AppRoutes.signIn);
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
