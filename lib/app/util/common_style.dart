import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';

class CommonStyle {
  static InputDecoration textFieldStyle({String hintTextStr = ""}) {
    return InputDecoration(
      hintText: hintTextStr,
      isDense: true,
      hintStyle: AppTextStyles.regularTextStyle
          .copyWith(fontSize: 12.0.sp, color: Colors.black.withOpacity(0.30)),
      errorStyle: AppTextStyles.regularTextStyle.copyWith(
        fontSize: 12.0.sp,
      ),
      labelStyle: AppTextStyles.regularTextStyle.copyWith(fontSize: 12.0.sp),
      contentPadding:
          EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        borderSide:
            BorderSide(width: 0.3.w, color: AppColors.divider1), //<-- SEE HERE
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        borderSide:
            BorderSide(width: 1.w, color: AppColors.primary), //<-- SEE HERE
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        borderSide:
            BorderSide(width: 0.3.w, color: AppColors.divider1), //<-- SEE HERE
      ), //<-- SEE HERE
    );
  }
  static InputDecoration textFieldSStyle({String hintTextStr = ""}) {
    return InputDecoration(
      hintText: hintTextStr,
      isDense: true,
      hintStyle: AppTextStyles.regularTextStyle
          .copyWith(color: AppColors.text1,
          fontSize: 14.0.sp),
      errorStyle: AppTextStyles.regularTextStyle.copyWith(
        fontSize: 12.0.sp,
      ),
      labelStyle: AppTextStyles.regularTextStyle.copyWith(fontSize: 12.0.sp),
      contentPadding:
      EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        borderSide:
        BorderSide(width: 0.3.w, color: AppColors.divider1), //<-- SEE HERE
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        borderSide:
        BorderSide(width: 1.w, color: AppColors.primary), //<-- SEE HERE
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        borderSide:
        BorderSide(width: 0.3.w, color: AppColors.divider1), //<-- SEE HERE
      ), //<-- SEE HERE
    );
  }

  static InputDecoration textFieldSearchStyle({String hintTextStr = ""}) {
    return InputDecoration(
      filled: true,
      isDense: true,
      fillColor: Colors.white,
      hintText: hintTextStr,
      hintStyle: AppTextStyles.regularTextStyle
          .copyWith(fontSize: 14.0.sp, color: HexColor("ADADAD")),
      errorStyle: AppTextStyles.regularTextStyle.copyWith(
        fontSize: 14.0.sp,
      ),
      labelStyle: AppTextStyles.regularTextStyle.copyWith(fontSize: 14.0.sp),
      contentPadding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 11.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.r),
        borderSide:
            BorderSide(width: 1.0.w, color: Colors.white), //<-- SEE HERE
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.r),
        borderSide:
            BorderSide(width: 1.0.w, color: Colors.white), //<-- SEE HERE
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.r),
        borderSide:
            BorderSide(width: 1.0.w, color: Colors.white), //<-- SEE HERE
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.r),
        borderSide:
            BorderSide(width: 1.0.w, color: Colors.white), //<-- SEE HERE
      ), //<-- SEE HERE
    );
  }

  static InputDecoration textFieldSearch2Style({String hintTextStr = ""}) {
    return InputDecoration(
      filled: true,
      isDense: true,
      fillColor: Colors.white,
      hintText: hintTextStr,
      hintStyle: AppTextStyles.regularTextStyle
          .copyWith(fontSize: 14.0.sp, color: HexColor("ADADAD")),
      errorStyle: AppTextStyles.mediumTextStyle.copyWith(
        fontSize: 14.0.sp,
      ),
      labelStyle: AppTextStyles.mediumTextStyle.copyWith(fontSize: 14.0.sp),
      contentPadding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 11.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.r),
        borderSide:
            BorderSide(width: 0.5.w, color: HexColor("969696")), //<-- SEE HERE
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.r),
        borderSide:
            BorderSide(width: 0.5.w, color: HexColor("969696")), //<-- SEE HERE
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.r),
        borderSide:
            BorderSide(width: 0.5.w, color: HexColor("969696")), //<-- SEE HERE
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0.r),
        borderSide:
            BorderSide(width: 0.5.w, color: HexColor("969696")), //<-- SEE HERE
      ), //<-- SEE HERE
    );
  }

  static SnackbarController customSnackbar(
      {String msg = "", String title = ""}) {
    return Get.snackbar(
      title,
      msg,
      colorText: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.5),
      snackPosition: SnackPosition.TOP,
    );
  }

  static defaultDialog({String msg = "", String title = "خطا"}) {
    return Get.defaultDialog(
      title: "خطا",
      middleText: msg,
      cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("الغاء")),
    );
  }
}
