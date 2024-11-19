import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/my_outlined_button.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/sign_in/controller/sign_in_controller.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  SignInController controller = Get.put(SignInController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 26.h),
                SvgPicture.asset(Utils.getIconPath("ic_sign_in"),
                    width: 127.0.w, height: 118.0.h),
                SizedBox(height: 17.0.h),
                Text(
                  LangKeys.welcomeAgain.tr,
                  style: AppTextStyles.semiBoldTextStyle
                      .copyWith(color: AppColors.primary, fontSize: 15.0.sp),
                ),
                SizedBox(height: 3.0.h),
                Text(
                  LangKeys.pleaseFillOutTheFollowingFields.tr,
                  style: AppTextStyles.semiBoldTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.93), fontSize: 17.0.sp),
                ),
                SizedBox(height: 3.0.h),
                Text(
                  LangKeys.toContinueLogIn.tr,
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: HexColor("000B12").withOpacity(0.93),
                      fontSize: 14.0.sp),
                ),
                SizedBox(height: 38.0.h),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

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
                  /*
                  Row(
                    children: [
                      Text(
                        LangKeys.phoneNumber.tr,
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
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0.w),
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
                                  controller.countryCode(country.countryCode);
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
                                    contentPadding: EdgeInsets.all(10.0.r),
                                    labelText: "بحث",
                                    labelStyle: TextStyle(fontSize: 14.0.sp),
                                    hintText: "ابدأ الكتابة للبحث'",
                                    prefixIcon:
                                        Icon(Icons.search, size: 24.0.r),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.primary.withOpacity(0.2),
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
                                Obx(() => Text("+${controller.phoneCode.value}",
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
                  SizedBox(height: 12.0.h),
                  Row(
                    children: [
                      Text(
                        LangKeys.password.tr,
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
                  SizedBox(height: 4.0.h),
                  Obx(() => TextFormField(
                      controller: controller.password,
                      obscureText: controller.obscureText.value,
                      obscuringCharacter: "*",
                      decoration: CommonStyle.textFieldStyle(
                              hintTextStr: LangKeys.enterPassword.tr)
                          .copyWith(
                              suffixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(end: 8.0.w),
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
                            controller
                                .obscureText(!controller.obscureText.value);
                          },
                        ),
                      )))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Obx(() => SizedBox(
                      //       height: 24.0.h,
                      //       width: 24.0.w,
                      //       child: Checkbox(
                      //         value: controller.isRememberMe.value,
                      //         activeColor: AppColors.primary,
                      //         side: BorderSide(color: AppColors.primary),
                      //         materialTapTargetSize:
                      //             MaterialTapTargetSize.shrinkWrap,
                      //         onChanged: (value) {
                      //           controller.isRememberMe(value);
                      //           // setState(() {
                      //           //   this.value = value;
                      //           // });
                      //         },
                      //       ),
                      //     )),
                      // SizedBox(width: 8.w), //SizedBox
                      // Text(
                      //   LangKeys.rememberMe.tr,
                      //   style: AppTextStyles.regularTextStyle
                      //       .copyWith(color: Colors.black, fontSize: 14.0.sp),
                      // ),
                      // const Spacer(),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.forgotPassword);
                          },
                          child: Text(
                            LangKeys.forgotPassword.tr,
                            style: AppTextStyles.mediumTextStyle.copyWith(
                                color: Colors.black.withOpacity(0.50),
                                fontSize: 12.0.sp,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                  SizedBox(height: 40.0.h),
                  PrimaryButton(
                    width: ScreenUtil().screenWidth,
                    onPressed: () {
                      controller.validation();
                      // Get.toNamed(AppRoutes.home);
                    },
                    height: 47.0.h,
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: Text(LangKeys.signIn.tr,
                        style: AppTextStyles.semiBoldTextStyle
                            .copyWith(color: Colors.white, fontSize: 16.sp)),
                  ),
                  SizedBox(height: 10.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LangKeys.doNotHaveAnAccount.tr,
                        style: AppTextStyles.regularTextStyle.copyWith(
                            color: Colors.black.withOpacity(0.70),
                            fontSize: 14.0.sp),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.signUp);
                          },
                          child: Text(
                            LangKeys.signUp.tr,
                            style: AppTextStyles.semiBoldTextStyle.copyWith(
                                color: Colors.black, fontSize: 16.0.sp),
                          ))
                    ],
                  ),
                  SizedBox(height: 39.h),
                  MyOutlinedButton(
                    width: ScreenUtil().screenWidth,
                    onPressed: () {
                      if (controller.storage.getCountry() == null ||
                          controller.storage.getCity() == null ||
                          controller.storage.getPrice() == null) {
                        Get.offAllNamed(AppRoutes.selectCountry);
                      } else {
                        Get.offAllNamed(AppRoutes.home);
                      }
                    },
                    height: 48.0.h,
                    color: AppColors.bgSplash,
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: Text(LangKeys.continueAsGuest.tr,
                        style: AppTextStyles.regularTextStyle.copyWith(
                            fontSize: 17.0.sp, color: AppColors.bgSplash)),
                  ),
                  SizedBox(height: 50.h),
                ])
              ],
            ),
          ),
        )));
  }
}
