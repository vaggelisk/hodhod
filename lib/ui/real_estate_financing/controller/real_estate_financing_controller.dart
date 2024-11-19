import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/finance/finance.dart';
import 'package:hodhod/data/models/finance/finance_model.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:dio/dio.dart' as d;
import 'package:hodhod/ui/my_real_estate/controller/my_real_estate_controller.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

class RealEstateFinancingController extends BaseController {
  var isLoading = false.obs;
  RealEstates? data;
  Finance? finance;
  var financeSelected = -1.obs;
  var errorMsg = "";
  String paymentId = "";
  var financeList = <Finance>[];
  var testApiKey = "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

 var liveApiKey = "Lo-rG_fsOR1Yt8HWMHsfzdoPCHQjo7WNAprI1kM1cYQPk3XHrFz78ymncuY-rHSaJQiCnGdUMMERS9QBI8OzWB6y-CjurBGLsW0uBkUjZeu-HdfQX5ekswWoxngF8auFL0YjKcjHubI34ieHVDaoz250gdBexvMhUAf7u8GxkDNWEZGzelTwyr7c5k9yreOuOmWOVrlsGn9nYNptt9nOzCgDvSUg3xvuU3pIcqQyg8UOwHVOuznZTdL93PWpTNsFS-gOjaJKAft3QJA9sYKDQz5K9TLnx2lbZuDdP44OrT0J7ED1-VjCYzDaZPv3qwJLyis13N9_RPft75VYlLGRzUZ72IZrnuLdGrtF9oDQ1MCuLnYaPB4PRKwbqdmF-w35djCGWYYgP4454kdZAb-n-EF_dKUhptyKokB66zh-o3aSOTBv9K-atyo1etWgHN8gPuDHKIGtg0jdVS-9MO6ZmpA5aR2jHpFR3D1RlU1-FCTaQKDnKvMcELInPNm-KfipnLFVYeT8G5nzUn1fOt8QU5Edcyr79QRlPXNZi8r1hRLQAJwscrOu5qV-vbQjMN9F0Y_nYCAbqn0IpeabiIuO5iFkO1UfTpzCvT-_2xcB_k0jCT-Q1yAswGzzg178QWogaNGx2kFtkVA8NF3jnTUvmqBI3suIsJl28IzacZF-FtlpWXvRfbephWdKBZq2uwAlm2uhTg";

  @override
  onInit() {
    super.onInit();
    data = Get.arguments['data'];
    // MFSDK.init(testAPIKey, MFCountry.UAE, MFEnvironment.TEST);
    // setUpActionBar();
    getPreFinanceRealEstates();
  }

  Future<void> getPreFinanceRealEstates() async {
    try {
      isLoading(true);
      final result = await httpService.request(
          url: "${ApiConstant.preFinanceRealEstates}/${data?.id ?? 0}",
          method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = FinanceModel.fromJson(result.data);
          if (resp.data != null) {
            finance = resp.data!;
            financeList.clear();
            if (finance?.typeKey == "free") {
              financeList.add(Finance(
                  cost: 0,
                  days: finance?.days,
                  total: 0,
                  packageId: finance?.packageId,
                  type: finance?.type,
                  typeKey: finance?.typeKey));
            } else {
              for (var i = 0; i < 6; i++) {
                financeList.add(Finance(
                    cost: (((i + 1) *
                            (double.parse(finance!.cost!.toString()) /
                                double.parse(
                                    finance?.currency?.exchangeRate ?? "0")))
                        .toStringAsFixed(2)),
                    days: (i + 1) * int.parse(finance!.days!.toString()),
                    oCost: ((i + 1) * double.parse(finance!.cost!.toString())),
                    total: 0,
                    packageId: finance?.packageId,
                    type: finance?.type,
                    usdToAed: finance?.usdToAed,
                    currency: finance?.currency,
                    typeKey: finance?.typeKey));
              }
            }
          }
        }
      }
    } finally {
      isLoading(false);
      update(['updateUi']);
    }
  }

  Future<void> validation(BuildContext context) async {
    if (financeSelected == -1) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.selectDuration.tr);
      return;
    }
    var finance = financeList[financeSelected];
    if (finance.typeKey != "free") {
      // print('Log mobile ${storage.getUser()?.mobile?.replaceAll(storage.getUser()?.countryCode?.replaceAll("+", "") ?? "", "").replaceAll("+", "") ?? ""}');
      // print('Log countryCode ${storage.getUser()?.countryCode}');
      // print('Log mobile ${storage.getUser()?.mobile}');
      var response = await MyFatoorah.startPayment(
        context: context,
        errorChild: Icon(Icons.error, color: Colors.red, size: 120.r),
        successChild:
            Icon(Icons.check_circle, color: Colors.green, size: 120.r),
        request: MyfatoorahRequest.live(
          currencyIso: Country.UAE,
          mobileCountryCode: storage.getUser()?.countryCode,
          customerName: storage.getUser()?.name ?? "",
          customerMobile: storage.getUser()?.mobile?.replaceAll(storage.getUser()?.countryCode?.replaceAll("+", "") ?? "", "").replaceAll("+", "") ?? "",
          customerEmail: storage.getUser()?.email ?? "",
          successUrl:
              'https://www.clipartmax.com/png/middle/270-2707415_confirm-icon-payment-success.png',
          errorUrl: 'https://www.google.com/',
          invoiceAmount:(financeList[financeSelected].oCost!  * double.parse(financeList[financeSelected].usdToAed)),
          language: ApiLanguage.Arabic,
          token: liveApiKey,
        ),
      );

      log(response.status.toString());
      log(response.status.name);
      log(response.paymentId.toString());
      if (response.status.name == "Success") {
        paymentId = response.paymentId.toString();
        print("Log 11paymentId $paymentId");
        financeRealEstates(finance);
      }
    } else {
      financeRealEstates(finance);
    }

    // financeRealEstates();
  }

  Future<void> financeRealEstates(Finance finance) async {
    try {
      Map<String, dynamic> body = {
        'type': finance.typeKey ?? "",
      };
      if (finance.typeKey != "free") {
        body['transaction_id'] = paymentId;
        body['period_count'] = financeSelected + 1;
        body['package_id'] = finance.packageId;
      } else {
        body['transaction_id'] = "free";
        body['period_count'] = 1;
      }
      EasyLoading.show();
      final result = await httpService.request(
          url: "${ApiConstant.financeRealEstates}/${data?.id ?? 0}",
          method: Method.POST,
          params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            if (Get.isRegistered<MyRealEstateController>()) {
              Get.find<MyRealEstateController>().pagingController.refresh();
            }
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
