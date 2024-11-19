import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiErrorUtils {
  static SnackbarController? customSnackbar(
      {String msg = "", String title = ""}) {
    var ss = Get.isDialogOpen ?? false;
    if ( ss ||!Get.isOverlaysOpen) {
      return Get.snackbar(
        title,
        msg,
        colorText: Colors.white,
        duration: Duration(milliseconds: 1500),
        // animationDuration: Duration(milliseconds: 1000),
        backgroundColor: Colors.black.withOpacity(0.5),
        snackPosition: SnackPosition.TOP,
      );
    } else {
      return null;
    }
  }
}
