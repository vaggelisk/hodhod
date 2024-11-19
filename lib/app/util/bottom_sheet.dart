import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/my_elevated_button2.dart';
import 'package:hodhod/app/components/my_outlined_button.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/ui/language_controller.dart';
import 'package:hodhod/ui/settings_page/controller/settings_page_controller.dart';
import '../services/storage_service.dart';
import 'utils.dart';

showErrorBottomSheet(String message, {VoidCallback? onClick, String? textBtn}) {
  if (Get.isBottomSheetOpen != null && !Get.isBottomSheetOpen!) {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              start: 9.w, end: 9.w, top: 30.h, bottom: 30.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(Utils.getIconPath("ic_error"),
                  width: 60.0.w, height: 60.h),
              SizedBox(height: 16.0.h),
              Text(
                LangKeys.error.tr,
                style: AppTextStyles.semiBoldTextStyle
                    .copyWith(color: HexColor("ED3A3A"), fontSize: 18.0.sp),
              ),
              SizedBox(height: 16.0.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.mediumTextStyle
                    .copyWith(color: AppColors.text17, fontSize: 15.0.sp),
              ),
              SizedBox(height: 30.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                child: MyElevatedButton2(
                  width: ScreenUtil().screenWidth,
                  onPressed: onClick ??
                      () {
                        Get.back();
                      },
                  height: 46.0.h,
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.0.r),
                  child: Text(textBtn ?? LangKeys.ok.tr,
                      style: AppTextStyles.semiBoldTextStyle
                          .copyWith(fontSize: 16.0.sp, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0.r),
            topRight: Radius.circular(16.0.r)),
      ),
    );
  }
}

showLogoutBottomSheet(String message) {
  if (Get.isBottomSheetOpen != null && !Get.isBottomSheetOpen!) {
    Get.bottomSheet(
      SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.0.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 25.0.h),
              SvgPicture.asset(Utils.getIconPath("ic_error"),
                  width: 130.0.w, height: 90.h),
              SizedBox(height: 20.0.h),
              Text(
                message,
                style: AppTextStyles.lightTextStyle
                    .copyWith(color: Colors.black, fontSize: 15.0.sp),
              ),
              SizedBox(height: 30.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: MyElevatedButton2(
                  width: ScreenUtil().screenWidth,
                  onPressed: () {
                    Get.back();
                    Get.find<StorageService>().clearApp();
                    Get.offAllNamed(AppRoutes.signIn);
                  },
                  height: 48.0.h,
                  borderRadius: BorderRadius.circular(10.0.r),
                  child: Text(LangKeys.ok.tr,
                      style: AppTextStyles.boldTextStyle
                          .copyWith(fontSize: 16.0.sp, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      isDismissible: false,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0.r),
            topRight: Radius.circular(20.0.r)),
      ),
    );
  }
}

showLogOutBottomSheet(BuildContext context, Function()? function) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0.r),
            topRight: Radius.circular(16.0.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
                start: 17.w, end: 17.w, top: 16.h, bottom: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30.0.h,
                ),
                SvgPicture.asset(
                  Utils.getIconPath("ic_log_out_bh"),
                  width: 135.44.w,
                  height: 101.6.h,
                  placeholderBuilder: (BuildContext context) =>
                      const CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                Text(
                  LangKeys.sureLoggedOut.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0.sp, color: Colors.black),
                ),
                SizedBox(
                  height: 22.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        height: 45.0.h,
                        onPressed: function,
                        color: AppColors.primary,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0.r),
                        ),
                        child: Text(
                          LangKeys.logOut.tr,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBoldTextStyle
                              .copyWith(color: Colors.white, fontSize: 15.0.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.0.w,
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        height: 45.0.h,
                        onPressed: () {
                          Get.back();
                        },
                        elevation: 0,
                        color: Colors.white,
                        textColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0.r),
                            side: BorderSide(
                                width: 1.0.w, color: AppColors.primary)),
                        child: Text(
                          LangKeys.cancel.tr,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBoldTextStyle.copyWith(
                              color: AppColors.primary, fontSize: 15.0.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

//accountDeactivateMsg
showAccountDeactivateBottomSheet(BuildContext context, Function()? function) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0.r),
            topRight: Radius.circular(16.0.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
                start: 17.w, end: 17.w, top: 16.h, bottom: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30.0.h,
                ),
                SvgPicture.asset(
                  Utils.getIconPath("ic_delete_account_bh"),
                  width: 98.82.w,
                  height: 90.h,
                  placeholderBuilder: (BuildContext context) =>
                      const CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                Text(
                  LangKeys.accountDeactivateMsg.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0.sp, color: Colors.black),
                ),
                SizedBox(
                  height: 22.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        height: 45.0.h,
                        onPressed: function,
                        color: AppColors.primary,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0.r),
                        ),
                        child: Text(
                          LangKeys.delete.tr,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBoldTextStyle
                              .copyWith(color: Colors.white, fontSize: 15.0.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.0.w,
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        height: 45.0.h,
                        onPressed: () {
                          Get.back();
                        },
                        elevation: 0,
                        color: Colors.white,
                        textColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0.r),
                            side: BorderSide(
                                width: 1.0.w, color: AppColors.primary)),
                        child: Text(
                          LangKeys.cancel.tr,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBoldTextStyle.copyWith(
                              color: AppColors.primary, fontSize: 15.0.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

changeLanguageBottomSheet(BuildContext context) {
  var controller = Get.find<StorageService>();
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0.r),
            topRight: Radius.circular(16.0.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
                start: 24.w, end: 24.w, top: 16.h, bottom: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LangKeys.language.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(fontSize: 16.0.sp, color: Colors.black),
                ),
                SizedBox(height: 30.0.h),
                MyOutlinedButton(
                  width: ScreenUtil().screenWidth,
                  onPressed: () {
                    Get.back();
                    if (controller.getLanguageCode() != "ar") {
                      if(controller.isAuth()){
                        Get.find<SettingsPageController>().updateLanguage("ar");
                      }else{
                        Get.find<LanguageController>().updateLocale("ar");
                      }
                    }
                  },
                  height: 48.0.h,
                  color: controller.getLanguageCode() == "ar"
                      ? AppColors.primary
                      : Colors.black.withOpacity(.50),
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Text(LangKeys.arabic.tr,
                      style: AppTextStyles.regularTextStyle.copyWith(
                          fontSize: 14.0.sp,
                          color: controller.getLanguageCode() == "ar"
                              ? AppColors.primary
                              : Colors.black.withOpacity(.50))),
                ),
                SizedBox(height: 22.0.h),
                MyOutlinedButton(
                  width: ScreenUtil().screenWidth,
                  onPressed: () {
                    Get.back();
                    if (controller.getLanguageCode() != "en") {
                      if(controller.isAuth()){
                        Get.find<SettingsPageController>().updateLanguage("en");
                      }else{
                        Get.find<LanguageController>().updateLocale("en");
                      }
                    }
                  },
                  height: 48.0.h,
                  color: controller.getLanguageCode() == "en"
                      ? AppColors.primary
                      : Colors.black.withOpacity(.50),
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Text(LangKeys.english.tr,
                      style: AppTextStyles.regularTextStyle.copyWith(
                          fontSize: 14.0.sp,
                          color: controller.getLanguageCode() == "en"
                              ? AppColors.primary
                              : Colors.black.withOpacity(.50))),
                ),
                SizedBox(height: 22.0.h),
                MyOutlinedButton(
                  width: ScreenUtil().screenWidth,
                  onPressed: () {
                    Get.back();
                    if (controller.getLanguageCode() != "el") {
                      if(controller.isAuth()){
                        Get.find<SettingsPageController>().updateLanguage("el");
                      }else{
                        Get.find<LanguageController>().updateLocale("el");
                      }
                    }
                  },
                  height: 48.0.h,
                  color: controller.getLanguageCode() == "el"
                      ? AppColors.primary
                      : Colors.black.withOpacity(.50),
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Text(LangKeys.greek1.tr,
                      style: AppTextStyles.regularTextStyle.copyWith(
                          fontSize: 14.0.sp,
                          color: controller.getLanguageCode() == "en"
                              ? AppColors.primary
                              : Colors.black.withOpacity(.50))),
                ),
                SizedBox(height: 30.0.h),
                // PrimaryButton(
                //   width: ScreenUtil().screenWidth,
                //   onPressed: () {},
                //   height: 47.0.h,
                //   borderRadius: BorderRadius.circular(6.0.r),
                //   child: Text(LangKeys.save.tr,
                //       style: AppTextStyles.semiBoldTextStyle
                //           .copyWith(color: Colors.white, fontSize: 16.sp)),
                // ),
              ],
            ),
          ),
        );
      });
}

confirmDeleteBottomSheet(String title, String description, Function()? function,
    {String delete = "", String cancel = ""}) {
  if (delete.isEmpty) {
    delete = LangKeys.delete.tr;
  }
  if (cancel.isEmpty) {
    cancel = LangKeys.cancel.tr;
  }
  Get.bottomSheet(
    SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0.r),
          child: Column(
            children: [
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: AppTextStyles.semiBoldTextStyle.copyWith(
                          color: HexColor("ED3A3A"),
                          height: 1.0.h,
                          fontSize: 18.0.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0.h,
              ),
              SvgPicture.asset(
                Utils.getIconPath("ic_delete_confirm"),
                width: 265.0.w,
                height: 148.0.h,
              ),
              SizedBox(
                height: 36.0.h,
              ),
              Text(
                description,
                style: AppTextStyles.mediumTextStyle.copyWith(
                    color: AppColors.text17, height: 1.0.h, fontSize: 16.0.sp),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 43.0.h,
                      onPressed: function,
                      color: AppColors.primary,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      child: Text(
                        delete,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.lightTextStyle
                            .copyWith(color: Colors.white, fontSize: 15.0.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 43.0.h,
                      onPressed: () {
                        Get.back();
                      },
                      elevation: 0,
                      color: Colors.white,
                      textColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                          side: BorderSide(
                              width: 1.0.w, color: AppColors.primary)),
                      child: Text(
                        cancel,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.lightTextStyle.copyWith(
                            color: AppColors.primary, fontSize: 15.0.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    backgroundColor: Colors.white,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r), topRight: Radius.circular(20.0.r)),
    ),
  );
}

confirmBottomSheet() {
  Get.bottomSheet(
    barrierColor: Colors.black.withOpacity(0.70),
    SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0.r),
          child: Column(
            children: [
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      LangKeys.signIn.tr,
                      style: AppTextStyles.mediumTextStyle
                          .copyWith(color: Colors.black, fontSize: 16.0.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0.h,
              ),
              SvgPicture.asset(
                Utils.getIconPath("ic_login"),
                width: 265.0.w,
                height: 160.0.h,
              ),
              SizedBox(
                height: 36.0.h,
              ),
              Text(
                LangKeys.pleaseLoginProcess.tr,
                textAlign: TextAlign.center,
                style: AppTextStyles.mediumTextStyle
                    .copyWith(color: Colors.black, fontSize: 14.0.sp),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 43.0.h,
                      onPressed: () {
                        Get.back();
                        Get.toNamed(AppRoutes.signIn);
                      },
                      color: AppColors.primary,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      child: Text(
                        LangKeys.signIn.tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.mediumTextStyle
                            .copyWith(color: Colors.white, fontSize: 15.0.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 43.0.h,
                      onPressed: () {
                        Get.back();
                      },
                      elevation: 0,
                      color: Colors.white,
                      textColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                          side: BorderSide(
                              width: 1.0.w, color: AppColors.primary)),
                      child: Text(
                        LangKeys.cancel.tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.mediumTextStyle.copyWith(
                            color: AppColors.primary, fontSize: 15.0.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    backgroundColor: Colors.white,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r), topRight: Radius.circular(20.0.r)),
    ),
  );
}

loginBottomSheet(String title, String description, Function()? function) {
  Get.bottomSheet(
    SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0.r),
          child: Column(
            children: [
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: AppTextStyles.lightTextStyle.copyWith(
                          color: AppColors.primary,
                          height: 1.0.h,
                          fontSize: 15.0.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0.h,
              ),
              SvgPicture.asset(
                Utils.getIconPath("ic_login"),
                width: 265.0.w,
                height: 148.0.h,
              ),
              SizedBox(
                height: 36.0.h,
              ),
              Text(
                description,
                style: AppTextStyles.lightTextStyle.copyWith(
                    color: Colors.black, height: 1.0.h, fontSize: 15.0.sp),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 43.0.h,
                      onPressed: function,
                      color: AppColors.primary,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      child: Text(
                        LangKeys.signIn.tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.lightTextStyle
                            .copyWith(color: Colors.white, fontSize: 15.0.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 43.0.h,
                      onPressed: () {
                        Get.back();
                      },
                      elevation: 0,
                      color: Colors.white,
                      textColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                          side: BorderSide(
                              width: 1.0.w, color: AppColors.primary)),
                      child: Text(
                        LangKeys.cancel.tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.lightTextStyle.copyWith(
                            color: AppColors.primary, fontSize: 15.0.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    backgroundColor: Colors.white,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r), topRight: Radius.circular(20.0.r)),
    ),
  );
}

showSuccessBottomSheet(String message,
    {VoidCallback? onClick, String? textBtn}) {
  if (Get.isBottomSheetOpen != null && !Get.isBottomSheetOpen!) {
    Get.bottomSheet(
      PopScope(
          canPop: false,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 9.w, end: 9.w, top: 30.h, bottom: 30.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SvgPicture.asset(Utils.getIconPath("ic_sucsess"),
                      width: 60.0.w, height: 60.h),
                  SizedBox(height: 16.0.h),
                  Text(
                    LangKeys.success.tr,
                    style: AppTextStyles.semiBoldTextStyle
                        .copyWith(color: HexColor("ED3A3A"), fontSize: 18.0.sp),
                  ),
                  SizedBox(height: 16.0.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.mediumTextStyle
                        .copyWith(color: AppColors.text17, fontSize: 15.0.sp),
                  ),
                  SizedBox(height: 30.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                    child: MyElevatedButton2(
                      width: ScreenUtil().screenWidth,
                      onPressed: onClick ??
                          () {
                            Get.back();
                          },
                      height: 46.0.h,
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.0.r),
                      child: Text(textBtn ?? LangKeys.ok.tr,
                          style: AppTextStyles.semiBoldTextStyle.copyWith(
                              fontSize: 16.0.sp, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          )),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0.r),
            topRight: Radius.circular(16.0.r)),
      ),
    );
  }
}
