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
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/search_filter/price.dart';
import 'package:hodhod/ui/budget/controller/country_budget_controller.dart';

class Budget extends StatelessWidget {
  Budget({super.key});

  var controller = Get.find<CountryBudgetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: const Text("")),
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.0.h),
                SvgPicture.asset(Utils.getIconPath("ic_budget"),
                    width: 333.0.w, height: 182.0.h),
                SizedBox(height: 33.0.h),
                Text(
                  LangKeys.whatIsYouBudget.tr,
                  style: AppTextStyles.semiBoldTextStyle
                      .copyWith(color: HexColor("4D4D4D"), fontSize: 16.0.sp),
                ),
                SizedBox(height: 24.0.h),
                Obx(() => RangeSlider(
                      min: 1000,
                      max: 1000000000.0,
                      activeColor: AppColors.bgSplash,
                      inactiveColor: AppColors.grey8,
                      divisions: 100000,
                      labels: RangeLabels(
                          controller.startValue.value.round().toString(),
                          controller.endValue.value.round().toString()),
                      values: RangeValues(controller.startValue.value,
                          controller.endValue.value),
                      onChanged: (values) {
                        controller.startValue.value = values.start;
                        controller.endValue.value = values.end;
                        controller.minPriceController.text =
                            controller.startValue.value.floor().toString();
                        controller.maxPriceController.text =
                            controller.endValue.value.floor().toString();
                      },
                    )),
                SizedBox(height: 30.0.h),
                Row(
                  children: [
                    Text(
                      LangKeys.minimum.tr,
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
                TextFormField(
                    controller: controller.minPriceController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (double.parse(value) > 1000 &&
                          double.parse(value) <= 1000000000) {
                        controller.startValue.value = double.parse(value);
                      }
                    },
                    decoration: CommonStyle.textFieldStyle(
                        hintTextStr: LangKeys.minimum.tr)),
                SizedBox(height: 16.0.h),
                Row(
                  children: [
                    Text(
                      LangKeys.maximum.tr,
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
                TextFormField(
                    controller: controller.maxPriceController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (double.parse(value) > 1000 &&
                          double.parse(value) <= 1000000000) {
                        controller.endValue.value = double.parse(value);
                      }
                    },
                    decoration: CommonStyle.textFieldStyle(
                        hintTextStr: LangKeys.minimum.tr)),
                SizedBox(height: 36.0.h),
                PrimaryButton(
                  width: ScreenUtil().screenWidth,
                  onPressed: () {
                    String min = controller.minPriceController.text;
                    String max = controller.maxPriceController.text;
                    if (min.isNotEmpty && max.isNotEmpty) {
                      double minD = double.parse(min);
                      double maxD = double.parse(max);
                      if (minD > maxD) {
                        UiErrorUtils.customSnackbar(
                            title: LangKeys.error.tr,
                            msg: LangKeys.minimumPriceMsg.tr);
                        return;
                      }
                    }
                    controller.storage.setPrice(Price(
                        fromPrice: double.parse(min) *
                            double.parse(controller.storage
                                    .getCountry()
                                    ?.currency
                                    ?.exchangeRate ??
                                "1"),
                        toPrice: double.parse(max) *
                            double.parse(controller.storage
                                    .getCountry()
                                    ?.currency
                                    ?.exchangeRate ??
                                "1")));
                    if (controller.storage.isAuth()) {
                      controller.updateProfileSettings();
                    } else {
                      Get.offAllNamed(AppRoutes.home);
                    }
                  },
                  height: 47.0.h,
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Text(LangKeys.continueText.tr,
                      style: AppTextStyles.semiBoldTextStyle
                          .copyWith(color: Colors.white, fontSize: 16.sp)),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        )));
  }
}
