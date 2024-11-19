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
import 'package:hodhod/data/models/support_reasons/support_reasons.dart';
import 'package:hodhod/data/models/support_reasons/support_reasons_model.dart';
import 'package:hodhod/ui/base_controller.dart';

class TechnicalSupportController extends BaseController {
  var isLoading = false.obs;
  final message = TextEditingController();

  var supportReasonsList = <SupportReasons>[].obs;
  Rx<SupportReasons> selectedSupportReasons = SupportReasons(content: "").obs;

  @override
  onInit() {
    super.onInit();
    getSupportReasons();
  }

  Future<void> validation() async {
    if (selectedSupportReasons.value.content == "") {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.chooseReason.tr);
      return;
    }

    if (message.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.messageContent.tr);
      return;
    }

    supportRequest();
  }

  Future<void> getSupportReasons() async {
    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiConstant.supportReasons, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = SupportReasonsModel.fromJson(result.data);
          supportReasonsList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            supportReasonsList.addAll(resp.data!);
          }
        }
      }
    } finally {
      isLoading(false);
      update(['selectedSupportReasons']);
    }
  }

  Future<void> supportRequest() async {
    try {
      Map<String, dynamic> body = {
        'support_reason_id': selectedSupportReasons.value.id ?? 0,
        "message": message.text
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.supportRequest, method: Method.POST, params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            showSuccessBottomSheet(data.message ?? "",onClick: (){
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
