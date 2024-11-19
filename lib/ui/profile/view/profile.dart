import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:hodhod/ui/profile/controller/profile_controller.dart';

class Profile extends StatelessWidget {
  var isHome = false;

  Profile({super.key, this.isHome = false});

  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: !isHome
              ? CustomAppBar(
                  title: Text(LangKeys.profile.tr,
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
                  SizedBox(height: 23.0.h),
                  Text(
                    LangKeys.personalInformation.tr,
                    style: AppTextStyles.semiBoldTextStyle
                        .copyWith(color: HexColor("0F0A0A"), fontSize: 16.0.sp),
                  ),
                  SizedBox(height: 2.0.h),
                  Text(
                    LangKeys.personalInformationMsg.tr,
                    style: AppTextStyles.regularTextStyle
                        .copyWith(color: AppColors.grey4, fontSize: 14.0.sp),
                  ),
                  SizedBox(height: 27.0.h),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        GetBuilder<ProfileController>(
                            id: 'selectImg',
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
                                            File(controller.image?.path ?? ""),
                                            fit: BoxFit.cover,
                                            width: 80.0.w,
                                            height: 80.0.h,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: controller.user?.image ?? "",
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
                            controller.selectImage();
                          },
                          child: SvgPicture.asset(
                              Utils.getIconPath("ic_edit_img"),
                              width: 30.0.w,
                              height: 30.0.h),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 31.0.h),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              LangKeys.fullName.tr,
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
                        SizedBox(height: 4.0.h),
                        TextFormField(
                            controller: controller.fullName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: CommonStyle.textFieldStyle(
                                    hintTextStr: LangKeys.enterFullName.tr)
                                .copyWith(
                                    suffixIcon: Align(
                              widthFactor: 2.0,
                              heightFactor: 2.0,
                              child: SvgPicture.asset(
                                  Utils.getIconPath("ic_full_name"),
                                  width: 24.0.w,
                                  height: 24.0.h),
                            ))),
                        SizedBox(height: 16.0.h),
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
                            enabled: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: CommonStyle.textFieldStyle(
                                    hintTextStr: LangKeys.enterEmail.tr)
                                .copyWith(
                                    suffixIcon: Align(
                              widthFactor: 2.0,
                              heightFactor: 2.0,
                              child: SvgPicture.asset(
                                  Utils.getIconPath("ic_email"),
                                  width: 24.0.w,
                                  height: 24.0.h),
                            ))),
                        SizedBox(height: 16.0.h),
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
                        TextFormField(
                            controller: controller.mobile,
                            enabled: false,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            decoration: CommonStyle.textFieldStyle(
                                    hintTextStr: LangKeys.enterMobileNumber.tr)
                                .copyWith(
                                    suffixIcon: Align(
                              widthFactor: 2.0,
                              heightFactor: 2.0,
                              child: SvgPicture.asset(
                                  Utils.getIconPath("ic_phone_in"),
                                  width: 24.0.w,
                                  height: 24.0.h),
                            ))),
                        SizedBox(height: 16.0.h),
                        PrimaryButton(
                          width: ScreenUtil().screenWidth,
                          onPressed: () {
                            controller.validation();
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
