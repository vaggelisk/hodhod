import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/new_password/controller/new_password_controller.dart';

class NewPassword extends StatelessWidget {
  NewPassword({Key? key}) : super(key: key);
  NewPasswordController controller = Get.put(NewPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            title: Text(LangKeys.newPassword.tr,
                style: AppTextStyles.semiBoldTextStyle.copyWith(
                    color: Colors.black, fontSize: 16.sp, height: 0.h))),
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Text(
                      LangKeys.newPassword.tr,
                      style: AppTextStyles.mediumTextStyle
                          .copyWith(color: Colors.black, fontSize: 15.0.sp),
                    ),
                    Text(
                      "*",
                      style: AppTextStyles.regularTextStyle.copyWith(
                          color: AppColors.redColor1, fontSize: 15.0.sp),
                    ),
                  ],
                ),
                SizedBox(height: 8.0.h),
                Obx(() => TextFormField(
                    controller: controller.password,
                    obscureText: controller.obscureText.value,
                    obscuringCharacter: "*",
                    textInputAction: TextInputAction.next,
                    decoration: CommonStyle.textFieldStyle(
                            hintTextStr: LangKeys.enterNewPassword.tr)
                        .copyWith(
                            suffixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(end: 6.0.w),
                      child: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          controller.obscureText.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 24.0.r,
                          color: controller.obscureText.value
                              ? AppColors.grey
                              : AppColors.primary,
                        ),
                        onPressed: () {
                          controller.obscureText(!controller.obscureText.value);
                        },
                      ),
                    )))),
                SizedBox(height: 16.0.h),
                Row(
                  children: [
                    Text(
                      LangKeys.confirmNewPassword.tr,
                      style: AppTextStyles.mediumTextStyle
                          .copyWith(color: Colors.black, fontSize: 15.0.sp),
                    ),
                    Text(
                      "*",
                      style: AppTextStyles.regularTextStyle.copyWith(
                          color: AppColors.redColor1, fontSize: 15.0.sp),
                    ),
                  ],
                ),
                SizedBox(height: 8.0.h),
                Obx(() => TextFormField(
                    controller: controller.confirmPassword,
                    obscureText: controller.obscureText.value,
                    textInputAction: TextInputAction.done,
                    obscuringCharacter: "*",
                    decoration: CommonStyle.textFieldStyle(
                            hintTextStr: LangKeys.enterConfirmNewPassword.tr)
                        .copyWith(
                            suffixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(end: 6.0.w),
                      child: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          controller.obscureText.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 24.0.r,
                          color: controller.obscureText.value
                              ? AppColors.grey
                              : AppColors.primary,
                        ),
                        onPressed: () {
                          controller.obscureText(!controller.obscureText.value);
                        },
                      ),
                    )))),
                SizedBox(height: 50.0.h),
                PrimaryButton(
                  width: ScreenUtil().screenWidth,
                  onPressed: () {
                    controller.validation();
                    // Get.toNamed(AppRoutes.verificationCode);
                  },
                  height: 47.0.h,
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Text(LangKeys.send.tr,
                      style: AppTextStyles.semiBoldTextStyle
                          .copyWith(color: Colors.white, fontSize: 16.sp)),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        )));
  }
}
