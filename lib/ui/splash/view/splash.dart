import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/splash/controller/splash_controller.dart';

import '../../../app/components/primary_button.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/translations/lang_keys.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSplash,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: LoadingView(),
          );
        } else if (!controller.hasInternet.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Utils.getIconPath("no_internet"),
                    width: 80.w, height: 80.h),
                24.verticalSpace,
                Text(
                  LangKeys.notInternetConnection.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.white, fontSize: 15.0.sp),
                ),
                24.verticalSpace,
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 40.w),
                  child: PrimaryButton(
                    width: ScreenUtil().screenWidth,
                    onPressed: () {
                      controller.retryConnection();
                    },
                    height: 47.0.h,
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: Text(LangKeys.retry.tr,
                        style: AppTextStyles.semiBoldTextStyle
                            .copyWith(color: Colors.white, fontSize: 16.sp)),
                  ),
                ),
              ],
            ),
          );
        } else {
          controller.checkAuth();
          if (controller.storage.isAuth()) {
            if (!controller.storage.isLangFirst()) {
              controller.updateLanguage();
            }
          }
          return Center(
            child: Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              delay: 1300.ms,
              child: SvgPicture.asset(Utils.getIconPath("ic_logo_sp"),
                  width: 146.w, height: 143.h),
            ),
          ); // Empty screen while navigating
        }
      }),
    );
  }
}
