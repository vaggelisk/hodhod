import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:hodhod/data/models/gender_model.dart';
import 'package:hodhod/ui/account_verification/controller/account_verification_controller.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class AccountVerificationTwo extends StatelessWidget {
  var isHome = false;

  AccountVerificationTwo({super.key, this.isHome = false});

  AccountVerificationController controller =
      Get.find<AccountVerificationController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: !isHome
              ? CustomAppBar(
                  title: Text(LangKeys.accountVerification.tr,
                      style: AppTextStyles.semiBoldTextStyle.copyWith(
                          color: Colors.black, fontSize: 16.sp, height: 1.h)))
              : null,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 22.0.h),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              LangKeys.experience.tr,
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
                            controller: controller.experience,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.enterExperience.tr)),
                        SizedBox(height: 16.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.language.tr,
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
                        InkWell(
                          onTap: () {},
                          child: TextFormField(
                              controller: controller.language,
                              readOnly: true,
                              canRequestFocus: false,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              textInputAction: TextInputAction.done,
                              onTap: (){
                                Get.toNamed(AppRoutes.languages);
                              },
                              decoration: CommonStyle.textFieldStyle(
                                      hintTextStr: LangKeys.language.tr)
                                  .copyWith(
                                      suffixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(
                                  Icons.expand_more_outlined,
                                  color: AppColors.grey9,
                                  size: 24.r,
                                ),
                              ))),
                        ),
                        SizedBox(height: 16.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.personalProfile.tr,
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
                            controller: controller.personalProfile,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 3,
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.enterPersonalProfile.tr)),
                        SizedBox(height: 16.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.brokerNumberWithTheRealEstate.tr,
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
                            controller: controller.brokerNumberRealEstate,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.enterBrokerNumber.tr)),
                        SizedBox(height: 16.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.brokerNumberOrn.tr,
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
                            controller: controller.brokerNumberOrn,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.enterBrokerNumberOrn.tr)),
                        SizedBox(height: 16.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.licenseNumber.tr,
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
                            controller: controller.licenseNumber,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.enterLicenseNumber.tr)),
                        SizedBox(height: 16.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.licenseExpirationDate.tr,
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
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    cancelText: LangKeys.cancel.tr,
                                    confirmText: LangKeys.ok.tr,
                                    helpText: LangKeys.selectedDate.tr,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100))
                                .then((pickedDate) {
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                controller.licenseExpirationDate.text =
                                    formattedDate;
                                print('Log formattedDate $formattedDate');
                              }
                            });
                          },
                          child: TextFormField(
                              controller: controller.licenseExpirationDate,
                              enabled: false,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              decoration: CommonStyle.textFieldStyle(
                                      hintTextStr: "00/00/0000")
                                  .copyWith(
                                      suffixIcon: Align(
                                widthFactor: 2.0,
                                heightFactor: 2.0,
                                child: SvgPicture.asset(
                                    Utils.getIconPath("ic_calendar_plus"),
                                    width: 24.0.w,
                                    height: 24.0.h),
                              ))),
                        ),
                        SizedBox(height: 21.0.h),
                        GetBuilder<AccountVerificationController>(
                          id: "selectLicenseImg",
                          builder: (controller) {
                            return Stack(
                              clipBehavior: Clip.none,
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.selectImage(false);
                                  },
                                  child: Container(
                                    padding: EdgeInsetsDirectional.symmetric(
                                        vertical: 21.h),
                                    width: ScreenUtil().screenWidth,
                                    alignment: AlignmentDirectional.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColors.divider1,
                                            width: 0.3.w),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Column(children: [
                                      SvgPicture.asset(
                                          Utils.getIconPath("ic_upload"),
                                          width: 29.34.w,
                                          height: 24.h),
                                      SizedBox(height: 10.0.h),
                                      Text(
                                        controller.imageLicense != null
                                            ? controller.imageLicense!.path
                                                .split('/')
                                                .last
                                            : LangKeys.attachTheLicenseHere.tr,
                                        style: AppTextStyles.mediumTextStyle
                                            .copyWith(
                                                color: HexColor("BDBDBD"),
                                                fontSize: 14.0.sp),
                                      )
                                    ]),
                                  ),
                                ),
                                controller.imageLicense != null
                                    ? PositionedDirectional(
                                        top: -20.0.h,
                                        end: -18.0.w,
                                        child: IconButton(
                                            onPressed: () {
                                              controller.imageLicense = null;
                                              controller
                                                  .update(['selectLicenseImg']);
                                            },
                                            icon: Image.asset(
                                                Utils.getImagePath("ic_close"),
                                                width: 25.0.w,
                                                height: 25.0.h)),
                                      )
                                    : const SizedBox()
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 16.0.h),
                        PrimaryButton(
                          width: ScreenUtil().screenWidth,
                          onPressed: () {
                            controller.validationTwo();
                          },
                          height: 47.0.h,
                          borderRadius: BorderRadius.circular(6.0.r),
                          child: Text(LangKeys.save.tr,
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
