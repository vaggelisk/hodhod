import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodhod/ui/base_controller.dart';

class PaymentPageController extends BaseController {
  double? amount;
  String testAPIKey = "";
  @override
  void onInit() {
    super.onInit();
    amount = Get.arguments['amount'];
    print("Log amount $amount");

  }


}
