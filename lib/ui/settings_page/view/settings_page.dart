import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/my_elevated_button2.dart';
import 'package:hodhod/app/components/my_outlined_button.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/types/enum.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/settings_page/controller/settings_page_controller.dart';
import 'package:share_plus/share_plus.dart';

import 'widget/item_more.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  SettingsPageController controller = Get.put(SettingsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
          isShowBack: false,
          centerTitle: true,
          title: Text(LangKeys.settings.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(children: [
            Visibility(
                visible: !controller.storage.isAuth(),
                child: Column(children: [
                  SizedBox(height: 15.h),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.0.r),
                        child: Image.asset(
                          Utils.getImagePath("ic_image_settings"),
                          height: 144.0.h,
                          width: ScreenUtil().screenWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 144.0.h,
                        width: ScreenUtil().screenWidth,
                        decoration: BoxDecoration(
                            color: HexColor("D9D9D9").withOpacity(0.8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 16.w, top: 9.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LangKeys.welcomeGuest.tr,
                                style: AppTextStyles.semiBoldTextStyle.copyWith(
                                    color: Colors.black, fontSize: 16.sp)),
                            SizedBox(height: 5.h),
                            Text(LangKeys.loginSettingsMsg.tr,
                                style: AppTextStyles.mediumTextStyle.copyWith(
                                    color: HexColor("7D7D7D"),
                                    fontSize: 14.sp)),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Expanded(
                                    child: PrimaryButton(
                                  width: ScreenUtil().screenWidth,
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.signIn);
                                  },
                                  height: 40.0.h,
                                  borderRadius: BorderRadius.circular(6.0.r),
                                  child: Text(LangKeys.signIn.tr,
                                      style: AppTextStyles.semiBoldTextStyle
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 13.sp)),
                                )),
                                SizedBox(width: 25.w),
                                Expanded(
                                    child: MyOutlinedButton(
                                  width: ScreenUtil().screenWidth,
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.signUp);
                                  },
                                  height: 40.0.h,
                                  borderRadius: BorderRadius.circular(6.0.r),
                                  child: Text(LangKeys.signUp.tr,
                                      style: AppTextStyles.semiBoldTextStyle
                                          .copyWith(
                                              fontSize: 13.0.sp,
                                              color: AppColors.primary)),
                                )),
                                SizedBox(width: 21.w),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Divider(
                    height: 0,
                    color: AppColors.grey3,
                    thickness: 0.5.h,
                  ),
                ])),
            SizedBox(height: 16.h),
            GetBuilder<SettingsPageController>(
              id: 'updateMoreMenuList',
              builder: (controller) {
                return ListView.builder(
                    itemCount: controller.moreList.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ItemMore(
                        langCode: controller.storage.getLanguageCode(),
                        data: controller.moreList[index],
                        isLast: controller.moreList.length - 1 == index,
                        onTap: () {
                          var data = controller.moreList[index];
                          switch (data.key) {
                            case MoreType.profile:
                              Get.toNamed(AppRoutes.profile);
                              break;
                            case MoreType.accountVerification:
                              // TODO: Handle this case.
                              Get.toNamed(AppRoutes.accountVerification);
                              break;
                            case MoreType.addRealEstate:
                              if (controller.storage.isAuth()) {
                                Get.toNamed(AppRoutes.addRealEstateOne,
                                    arguments: {"isEdit": false});
                              } else {
                                confirmBottomSheet();
                              }
                              break;
                            case MoreType.myAds:
                              // TODO: Handle this case.
                              break;
                            case MoreType.changePassword:
                              // TODO: Handle this case.
                              Get.toNamed(AppRoutes.changePassword);
                              break;

                            case MoreType.changeCountryCity:
                              // TODO: Handle this case.
                              Get.toNamed(AppRoutes.selectCountry);
                              break;

                            case MoreType.changeLanguage:
                              changeLanguageBottomSheet(context);
                              break;
                            case MoreType.contactUs:
                              // TODO: Handle this case.
                              Get.toNamed(AppRoutes.contactUs);
                              break;
                            case MoreType.privacyPolicy:
                              // TODO: Handle this case.
                              Get.toNamed(AppRoutes.pageView, arguments: {
                                "title": data.name,
                                "key": "privacy_policy"
                              });
                              break;
                            case MoreType.aboutAs:
                              // TODO: Handle this case.
                              Get.toNamed(AppRoutes.pageView, arguments: {
                                "title": data.name,
                                "key": "about_us"
                              });
                              break;
                            case MoreType.technicalSupport:
                              // TODO: Handle this case.
                              Get.toNamed(AppRoutes.technicalSupport);
                              break;
                            case MoreType.shareApp:
                              if (Platform.isIOS) {
                                Share.share(
                                    'https://apps.apple.com/app/hod-hod/id6618150618');
                              } else {
                                Share.share(
                                    'https://play.google.com/store/apps/details?id=com.ozone.hodhod');
                              }
                              break;
                            case MoreType.deleteAccount:
                              // TODO: Handle this case.
                              showAccountDeactivateBottomSheet(context, () {
                                Get.back(closeOverlays: true);
                                controller.logout(true);
                              });
                              break;
                            case MoreType.signOut:
                              // TODO: Handle this case.
                              showLogOutBottomSheet(context, () {
                                Get.back(closeOverlays: true);
                                controller.logout(false);
                              });
                              break;
                          }
                        },
                      );
                    });
              },
            ),
            SizedBox(height: 33.h),
          ]),
        ),
      ),
    );
  }
}
