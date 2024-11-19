import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/verification_code/controller/verification_code_controller.dart';
import 'package:pinput/pinput.dart';

class VerificationCode extends StatelessWidget {
  VerificationCode({super.key});

  // var controller = Get.find<VerificationCodeController>();
  var controller = Get.put(VerificationCodeController());

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    const borderColor = Color.fromRGBO(30, 60, 87, 1);

    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: AppTextStyles.regularTextStyle
          .copyWith(fontSize: 20.0.sp, color: AppColors.primary),
      decoration: const BoxDecoration(),
    );
    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: HexColor("B9B9B9"),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    // final defaultPinTheme = PinTheme(
    //   width: 60.0.w,
    //   height: 60.0.h,
    //   textStyle: AppTextStyles.regularTextStyle
    // .copyWith(fontSize: 20.0.sp, color: AppColors.primary),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(6.0.r),
    //     border: Border.all(color: AppColors.grey),
    //   ),
    // );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            title: Text("",
                style: AppTextStyles.semiBoldTextStyle.copyWith(
                    color: Colors.black, fontSize: 18.sp, height: 1.h))),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 27.0.h),
                SvgPicture.asset(Utils.getIconPath("ic_verification_code"),
                    width: 180.0.w, height: 260.0.h),
                SizedBox(height: 36.0.h),
                Text(
                  LangKeys.checkConfirmationCode.tr,
                  style: AppTextStyles.semiBoldTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Text(
                  LangKeys.verificationCodeMsg.tr,
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.hintColor, fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      Get.arguments['email'],
                      style: AppTextStyles.semiBoldTextStyle.copyWith(
                          color: AppColors.bgSplash, fontSize: 16.0.sp),
                    )),
                SizedBox(height: 25.0.h),
                SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 4,
                      pinAnimationType: PinAnimationType.slide,
                      controller: controller.pinController,
                      focusNode: focusNode,
                      defaultPinTheme: defaultPinTheme,
                      showCursor: false,
                      keyboardType: TextInputType.number,
                      cursor: cursor,
                      preFilledWidget: preFilledWidget,
                    ),
                  ),
                ),
                Obx(() => Column(
                      children: [
                        SizedBox(height: 41.0.h),
                        controller.start.value != 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    LangKeys.didNotReceiveCode.tr,
                                    style: AppTextStyles.semiBoldTextStyle
                                        .copyWith(
                                            color: HexColor("9F9F9F"),
                                            fontSize: 14.0.sp),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        controller.sendVerificationCode();
                                        // Get.toNamed(AppRoutes.signUp);
                                      },
                                      child: Text(
                                        LangKeys.reSend.tr,
                                        style: AppTextStyles.mediumTextStyle
                                            .copyWith(
                                                color: AppColors.primary,
                                                fontSize: 14.0.sp),
                                      ))
                                ],
                              ),
                        controller.start.value != 0
                            ? SizedBox(height: 20.h)
                            : const SizedBox(),
                        controller.start.value != 0
                            ? Text(
                                controller.timeStr.value,
                                style: AppTextStyles.mediumTextStyle.copyWith(
                                    color: HexColor("675B5B"),
                                    fontSize: 14.0.sp,
                                    decoration: TextDecoration.underline),
                              )
                            : const SizedBox(),
                      ],
                    )),
                SizedBox(height: 54.0.h),
                PrimaryButton(
                  width: ScreenUtil().screenWidth,
                  onPressed: () {
                    if (controller.pinController.text.length != 4) {
                      UiErrorUtils.customSnackbar(
                          title: LangKeys.error.tr,
                          msg: LangKeys.enterCompleteVerificationCode.tr);
                      return;
                    }
                    controller.verifyMobile();
                    // Get.toNamed(AppRoutes.newPassword);
                  },
                  height: 47.0.h,
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Text(LangKeys.verify.tr,
                      style: AppTextStyles.semiBoldTextStyle
                          .copyWith(color: Colors.white, fontSize: 16.sp)),
                ),
                SizedBox(height: 25.0.h),
              ],
            ),
          ),
        ));
  }

// @override
// void dispose() {
//   // controller.dispose();
//   focusNode.dispose();
//   super.dispose();
// }
}
