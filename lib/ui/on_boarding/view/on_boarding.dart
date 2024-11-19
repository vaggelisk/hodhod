import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/data/models/slider_model.dart';
import 'package:hodhod/ui/on_boarding/controller/on_boarding_controller.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  OnBoardingController controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<OnBoardingController>(
        id: "update",
        builder: (controller) => SafeArea(
          child: controller.isLoading.isFalse
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),
                    Expanded(
                      child: PageView.builder(
                          controller: controller.controller,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value) {
                            // setState(() {
                            controller.currentIndex.value = value;
                            controller.update(['update']);
                            // });
                          },
                          itemCount: controller.sliderList.length,
                          itemBuilder: (context, index) {
                            // contents of slider
                            return Slider(
                              data: controller.sliderList[index],
                            );
                          }),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.sliderList.length,
                        (index) => buildDot(index, context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: 16.0.w, end: 16.w, bottom: 1.h, top: 16.h),
                      child: PrimaryButton(
                        width: ScreenUtil().screenWidth,
                        onPressed: () async {
                          if (controller.currentIndex.value ==
                              controller.sliderList.length - 1) {
                            controller.storage.setIntro(true);
                            Get.offAllNamed(AppRoutes.signIn);
                          } else {
                            controller.controller.nextPage(
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.bounceIn);
                          }
                        },
                        height: 48.0.h,
                        borderRadius: BorderRadius.circular(6.0.r),
                        child: Text(
                            controller.currentIndex.value ==
                                    controller.sliderList.length - 1
                                ? LangKeys.continueText.tr
                                : LangKeys.next.tr,
                            style: AppTextStyles.semiBoldTextStyle.copyWith(
                                fontSize: 16.0.sp, color: Colors.white)),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.storage.setIntro(true);
                          Get.offAllNamed(AppRoutes.signIn);
                        },
                        child: Text(
                          LangKeys.skip.tr,
                          style: AppTextStyles.mediumTextStyle.copyWith(
                              color: Colors.black.withOpacity(0.60),
                              decoration: TextDecoration.underline,
                              fontSize: 15.0.sp),
                        )),
                    SizedBox(height: 20.h),
                  ],
                )
              : const LoadingView(),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: controller.currentIndex.value == index ? 10.h : 8.h,
      width: controller.currentIndex.value == index ? 10.w : 8.w,
      margin: EdgeInsetsDirectional.only(start: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: controller.currentIndex.value == index
            ? HexColor("104C5B")
            : Colors.black.withOpacity(0.30),
      ),
    );
  }
}

class Slider extends StatelessWidget {
  SliderModel data;

  Slider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            displayImageFromNetwork(
                data.image, BoxFit.contain, 343.w, 285.h, 0),
            SizedBox(height: 16.h),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.boldTextStyle
                  .copyWith(color: Colors.black, fontSize: 16.0.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              data.description,
              textAlign: TextAlign.center,
              style: AppTextStyles.regularTextStyle
                  .copyWith(color: HexColor("7D7D7D"), fontSize: 14.0.sp),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
