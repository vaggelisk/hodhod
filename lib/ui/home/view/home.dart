import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_home_app_bar.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/home/controller/home_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomHomeAppBar(
      //     title: Text("",
      //         style: AppTextStyles.boldTextStyle
      //             .copyWith(color: Colors.black, fontSize: 16.sp))),
      backgroundColor: AppColors.bgColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          if (controller.storage.isAuth()) {
            Get.toNamed(AppRoutes.addRealEstateOne, arguments: {"isEdit": false});
          } else {
            confirmBottomSheet();
          }
        },
        backgroundColor: AppColors.primary,
        child: SvgPicture.asset(Utils.getIconPath("ic_add"),
            width: 30.0.w, height: 30.0.h),
      ),
      bottomNavigationBar: Obx(() => SafeArea(
              child: BottomAppBar(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const CircularNotchedRectangle(),
            padding: EdgeInsetsDirectional.zero,
            child: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: Colors.white, primaryColor: Colors.red),
              child: BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: (index) {
                  if (index == 1 || index == 2) {
                    if (controller.storage.isAuth()) {
                      controller.currentIndex(index);
                    } else {
                      confirmBottomSheet();
                    }
                  } else {
                    controller.currentIndex(index);
                  }
                },
                selectedLabelStyle:
                    AppTextStyles.mediumTextStyle.copyWith(fontSize: 11.0.sp),
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.grey1,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      Utils.getIconPath("ic_home_nav"),
                      width: 24.0.w,
                      height: 24.0.h,
                      colorFilter:
                          ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    icon: SvgPicture.asset(
                      Utils.getIconPath("ic_home_nav"),
                      width: 24.0.w,
                      height: 24.0.h,
                      colorFilter:
                          ColorFilter.mode(AppColors.grey1, BlendMode.srcIn),
                    ),
                    label: LangKeys.home.tr,
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      Utils.getIconPath("ic_my_real_estate"),
                      width: 24.0.w,
                      height: 24.0.h,
                      colorFilter:
                          ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    icon: SvgPicture.asset(
                      Utils.getIconPath("ic_my_real_estate"),
                      width: 24.0.w,
                      height: 24.0.h,
                      colorFilter:
                          ColorFilter.mode(AppColors.grey1, BlendMode.srcIn),
                    ),
                    label: LangKeys.myRealEstate.tr,
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      Utils.getIconPath("ic_fav_nav"),
                      width: 24.0.w,
                      height: 24.0.h,
                      colorFilter:
                          ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    icon: SvgPicture.asset(
                      Utils.getIconPath("ic_fav_nav"),
                      width: 24.0.w,
                      height: 24.0.h,
                      colorFilter:
                          ColorFilter.mode(AppColors.grey1, BlendMode.srcIn),
                    ),
                    label: LangKeys.favorite.tr,
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      Utils.getIconPath("ic_settings_nav"),
                      width: 24.0.w,
                      height: 24.0.h,
                      colorFilter:
                          ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    icon: SvgPicture.asset(
                      Utils.getIconPath("ic_settings_nav"),
                      width: 24.0.w,
                      height: 24.0.h,
                      colorFilter:
                          ColorFilter.mode(AppColors.grey1, BlendMode.srcIn),
                    ),
                    label: LangKeys.settings.tr,
                  ),
                ],
              ),
            ),
          ))),

      body: SafeArea(
          child: Obx(() => controller.screens[controller.currentIndex.value])),
    );
  }
}
