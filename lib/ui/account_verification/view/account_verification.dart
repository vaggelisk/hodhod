import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/empty_status_view.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/gender_model.dart';
import 'package:hodhod/ui/account_verification/controller/account_verification_controller.dart';
import 'package:hodhod/ui/account_verification/view/display_account_verification.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class AccountVerification extends StatelessWidget {
  var isHome = false;

  AccountVerification({super.key, this.isHome = false});

  AccountVerificationController controller =
      Get.put(AccountVerificationController());

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
            body: GetBuilder<AccountVerificationController>(
              id: 'updateUi',
              builder: (controller) {
                if(controller.isLoadingProfile.isTrue){
                  return const LoadingView();
                }
                if(controller.companyProfileStatus.value == "pending"){
                  return EmptyStatusView(msg: LangKeys.underReviewAccountMsg.tr,img: "ic_pending_account");
                }
                if(controller.companyProfileStatus.value == "approved"){
                  return DisplayAccountVerification();
                }
                return SingleChildScrollView(
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
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            GetBuilder<AccountVerificationController>(
                                id: 'selectLogoImg',
                                builder: (controller) {
                                  return CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 40.0.r,
                                    child: CircleAvatar(
                                      radius: 38.0.r,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: (controller.image != null)
                                            ? Image.file(
                                                File(controller.image?.path ??
                                                    ""),
                                                fit: BoxFit.cover,
                                                width: 80.0.w,
                                                height: 80.0.h,
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: "",
                                                // imageUrl: "",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                      ),
                                    ),
                                  );
                                }),
                            InkWell(
                              onTap: () {
                                controller.selectImage(true);
                              },
                              child: SvgPicture.asset(
                                  Utils.getIconPath("ic_edit_img"),
                                  width: 30.0.w,
                                  height: 30.0.h),
                            ),
                          ],
                        ),
                        SizedBox(height: 31.0.h),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    LangKeys.fullName.tr,
                                    style: AppTextStyles.mediumTextStyle
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 15.0.sp),
                                  ),
                                  Text(
                                    "*",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color: AppColors.redColor1,
                                            fontSize: 15.0.sp),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0.h),
                              TextFormField(
                                  controller: controller.fullName,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  decoration: CommonStyle.textFieldStyle(
                                      hintTextStr: LangKeys.enterFullName.tr)),
                              SizedBox(height: 16.0.h),
                              Row(
                                children: [
                                  Text(
                                    LangKeys.email.tr,
                                    style: AppTextStyles.mediumTextStyle
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 15.0.sp),
                                  ),
                                  Text(
                                    "*",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
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
                              SizedBox(height: 16.0.h),
                              Row(
                                children: [
                                  Text(
                                    LangKeys.phoneNumber.tr,
                                    style: AppTextStyles.mediumTextStyle
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 15.0.sp),
                                  ),
                                  Text(
                                    "*",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color: AppColors.redColor1,
                                            fontSize: 15.0.sp),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0.h),
                              Directionality(
                                textDirection: ui.TextDirection.rtl,
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.3.w,
                                          color: AppColors.divider1),
                                      borderRadius:
                                          BorderRadius.circular(8.0.r)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          controller: controller.mobile,
                                          textDirection: ui.TextDirection.ltr,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                              hintText: "",
                                              contentPadding:
                                                  EdgeInsets.symmetric(
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
                                            favorite: <String>['AE', 'SA'],
                                            // countryFilter: <String>['SA', 'YE'],
                                            showPhoneCode: true,
                                            searchAutofocus: false,
                                            onSelect: (Country country) {
                                              controller
                                                  .phoneCode(country.phoneCode);
                                              controller.countryCode(
                                                  country.countryCode);
                                              print(
                                                  "Log countryCode ${country.countryCode}");
                                            },
                                            countryListTheme:
                                                CountryListThemeData(
                                              flagSize: 24.0.r,
                                              backgroundColor: Colors.white,
                                              textStyle:
                                                  TextStyle(fontSize: 12.0.sp),
                                              bottomSheetHeight:
                                                  ScreenUtil().screenHeight / 2,
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(10.0.r),
                                                topRight:
                                                    Radius.circular(10.0.r),
                                              ),
                                              inputDecoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10.0.r),
                                                labelText: "بحث",
                                                labelStyle: TextStyle(
                                                    fontSize: 14.0.sp),
                                                hintText: "ابدأ الكتابة للبحث'",
                                                prefixIcon: Icon(Icons.search,
                                                    size: 24.0.r),
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
                                            Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 24.0.r),
                                            Obx(() => Text(
                                                "+${controller.phoneCode.value}",
                                                textDirection:
                                                    ui.TextDirection.ltr,
                                                style: AppTextStyles
                                                    .mediumTextStyle
                                                    .copyWith(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 14.0.sp))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5.0.w)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.0.h),
                              Row(
                                children: [
                                  Text(
                                    LangKeys.personalPageLink.tr,
                                    style: AppTextStyles.mediumTextStyle
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 15.0.sp),
                                  ),
                                  Text(
                                    "*",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color: AppColors.redColor1,
                                            fontSize: 15.0.sp),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0.h),
                              TextFormField(
                                  controller: controller.personalPageLink,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.url,
                                  decoration: CommonStyle.textFieldStyle(
                                      hintTextStr:
                                          LangKeys.enterPersonalPageLink.tr)),
                              SizedBox(height: 16.0.h),
                              Row(
                                children: [
                                  Text(
                                    LangKeys.gender.tr,
                                    style: AppTextStyles.mediumTextStyle
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 15.0.sp),
                                  ),
                                  Text(
                                    "*",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color: AppColors.redColor1,
                                            fontSize: 15.0.sp),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0.h),
                              GetBuilder<AccountVerificationController>(
                                id: 'updateGender',
                                builder: (controller) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0.w, vertical: 10.0.h),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.3.w,
                                            color: AppColors.divider1),
                                        borderRadius:
                                            BorderRadius.circular(6.0.r)),
                                    child: DropdownButton<GenderModel>(
                                      value: controller.selectedGender.value
                                              .name.isNotEmpty
                                          ? controller.selectedGender.value
                                          : null,
                                      icon: Icon(Icons.expand_more_outlined,
                                          color: AppColors.grey9),
                                      iconSize: 24.0.r,
                                      elevation: 0,
                                      hint: Text(LangKeys.chooseGender.tr,
                                          style: AppTextStyles.regularTextStyle
                                              .copyWith(
                                                  color: Colors.black
                                                      .withOpacity(0.30),
                                                  fontSize: 14.0.sp)),
                                      isExpanded: true,
                                      dropdownColor: AppColors.grey8,
                                      style: AppTextStyles.regularTextStyle
                                          .copyWith(
                                              color: AppColors.hintTextInput,
                                              fontSize: 14.0.sp),
                                      autofocus: false,
                                      isDense: true,
                                      underline: const SizedBox(),
                                      onChanged: (data) {
                                        controller.selectedGender.value = data!;
                                        controller.update(['updateGender']);
                                      },
                                      items: controller.genderList
                                          .map<DropdownMenuItem<GenderModel>>(
                                              (GenderModel value) {
                                        return DropdownMenuItem<GenderModel>(
                                          value: value,
                                          child: Text(value.name ?? ""),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 16.0.h),
                              Row(
                                children: [
                                  Text(
                                    LangKeys.dob.tr,
                                    style: AppTextStyles.mediumTextStyle
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 15.0.sp),
                                  ),
                                  Text(
                                    "*",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
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
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100))
                                      .then((pickedDate) {
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      controller.dob.text = formattedDate;
                                      print('Log formattedDate $formattedDate');
                                    }
                                  });
                                },
                                child: TextFormField(
                                    controller: controller.dob,
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
                              SizedBox(height: 16.0.h),
                              PrimaryButton(
                                width: ScreenUtil().screenWidth,
                                onPressed: () {
                                  controller.validationOne();
                                },
                                height: 47.0.h,
                                borderRadius: BorderRadius.circular(6.0.r),
                                child: Text(LangKeys.next.tr,
                                    style: AppTextStyles.semiBoldTextStyle
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 16.sp)),
                              ),
                              SizedBox(height: 25.h),
                            ])
                      ],
                    ),
                  ),
                );
              },
            )));
  }
}
