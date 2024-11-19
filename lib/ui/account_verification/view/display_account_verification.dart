import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/image.dart';
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

class DisplayAccountVerification extends StatelessWidget {
  String? languagesStr = "";

  DisplayAccountVerification({super.key});

  AccountVerificationController controller =
      Get.find<AccountVerificationController>();

  @override
  Widget build(BuildContext context) {
    controller.companyProfile.value.languages?.forEach((element) {
      languagesStr = "$languagesStr${element.name},";
    });
    return SafeArea(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.0.h),
            Text(
              LangKeys.accountInformation.tr,
              style: AppTextStyles.semiBoldTextStyle
                  .copyWith(color: Colors.black, fontSize: 16.0.sp),
            ),
            SizedBox(height: 14.0.h),
            Container(
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1.0.w,
                  ),
                ),
                child: CircleAvatar(
                  radius: 45.0.r,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: controller.companyProfile.value.logo ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                )),
            SizedBox(height: 36.0.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.fullName.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.name ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.email.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.email ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.phoneNumber.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.mobile ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.personalPageLink.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.personalPageUrl ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.gender.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.gender ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.dob.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.dateOfBirth ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.experience.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  "${controller.companyProfile.value.experienceYears ?? "0"} ${LangKeys.years.tr}",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.languages.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  languagesStr ?? '',
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.personalProfile.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.about ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.brokerNumberWithTheRealEstate.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value
                          .brokerNumberRegulatoryAuthority ??
                      "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.brokerNumberOrn.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.brokerOrnNumber ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.licenseNumber.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.brokerLicenseNumber ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                SizedBox(height: 10.0.h),
                Divider(
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                  height: 0,
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKeys.licenseExpirationDate.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 16.0.sp),
                ),
                SizedBox(height: 9.0.h),
                Text(
                  controller.companyProfile.value.licenseExpiryDate ?? "",
                  style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.black.withOpacity(0.60), fontSize: 14.0.sp),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 11.h, bottom: 25.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.divider1, width: 0.3.w),
                      borderRadius: BorderRadius.all(Radius.circular(10.0.r))),
                  child: displayImageFromNetwork(
                      controller.companyProfile.value.license ?? "",
                      BoxFit.cover,
                      108.w,
                      108.h,
                      10.r),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
