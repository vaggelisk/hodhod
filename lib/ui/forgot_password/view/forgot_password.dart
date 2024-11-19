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
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/forgot_password/controller/forgot_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  var controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(title: const Text("")),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 26.0.h),
                  SvgPicture.asset(Utils.getIconPath("ic_forgot_password"),
                      width: 273.0.w, height: 273.0.h),
                  SizedBox(height: 16.0.h),
                  Text(
                    LangKeys.checkConfirmationCode.tr,
                    style: AppTextStyles.semiBoldTextStyle
                        .copyWith(color: Colors.black, fontSize: 16.0.sp),
                  ),
                  SizedBox(height: 10.0.h),
                  Text(
                    LangKeys.forgotPasswordMsg.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regularTextStyle
                        .copyWith(color: HexColor("B2B2B2"), fontSize: 13.0.sp),
                  ),
                  SizedBox(height: 36.0.h),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*
                        Row(
                          children: [
                            Text(
                              LangKeys.phoneNumber.tr,
                              style: AppTextStyles.mediumTextStyle.copyWith(
                                  color: Colors.black, fontSize: 15.0.sp),
                            ),
                            Text(
                              "*",
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: AppColors.redColor1,
                                  fontSize: 15.0.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0.h),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.3.w, color: AppColors.divider1),
                                borderRadius: BorderRadius.circular(8.0.r)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: controller.mobile,
                                    textDirection: TextDirection.ltr,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        hintText: "",
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0.w),
                                        border: InputBorder.none),
                                  ),
                                ),
                                // SizedBox(width: 5.0.w),
                                VerticalDivider(
                                  color: AppColors.divider1,
                                  thickness: 0.3.w,
                                  width: 0,
                                ),
                                // SizedBox(width: 5.0.w),
                                InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      favorite: <String>[
                                        'AE',
                                        'SA',
                                      ],
                                      // countryFilter: <String>['SA', 'YE'],
                                      showPhoneCode: true,
                                      searchAutofocus: false,
                                      onSelect: (Country country) {
                                        controller.phoneCode(country.phoneCode);
                                        controller
                                            .countryCode(country.countryCode);
                                        print(
                                            "Log countryCode ${country.countryCode}");
                                      },
                                      countryListTheme: CountryListThemeData(
                                        flagSize: 24.0.r,
                                        backgroundColor: Colors.white,
                                        textStyle: TextStyle(fontSize: 12.0.sp),
                                        bottomSheetHeight:
                                            ScreenUtil().screenHeight / 2,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0.r),
                                          topRight: Radius.circular(10.0.r),
                                        ),
                                        inputDecoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.all(10.0.r),
                                          labelText: "بحث",
                                          labelStyle:
                                              TextStyle(fontSize: 14.0.sp),
                                          hintText: "ابدأ الكتابة للبحث'",
                                          prefixIcon:
                                              Icon(Icons.search, size: 24.0.r),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.primary
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.keyboard_arrow_down_rounded,
                                          size: 24.0.r, color: Colors.black),
                                      Obx(() => Text(
                                          "+${controller.phoneCode.value}",
                                          textDirection: TextDirection.ltr,
                                          style: AppTextStyles.regularTextStyle
                                              .copyWith(
                                                  color: AppColors.primary,
                                                  fontSize: 14.0.sp))),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.0.w)
                              ],
                            ),
                          ),
                        ),

                         */

                        Row(
                          children: [
                            Text(
                              LangKeys.email.tr,
                              style: AppTextStyles.mediumTextStyle.copyWith(
                                  color: Colors.black, fontSize: 15.0.sp),
                            ),
                            Text(
                              "*",
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: AppColors.redColor1,
                                  fontSize: 15.0.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0.h),
                        TextFormField(
                            controller: controller.email,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.enterEmail.tr)),
                        SizedBox(height: 36.0.h),
                        PrimaryButton(
                          width: ScreenUtil().screenWidth,
                          onPressed: () {
                            controller.validation();
                          },
                          height: 47.0.h,
                          borderRadius: BorderRadius.circular(6.0.r),
                          child: Text(LangKeys.sendCode.tr,
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: Colors.white, fontSize: 16.sp)),
                        ),
                        SizedBox(height: 25.h),
                      ])
                ],
              ),
            ),
          )),
    );
  }
}
