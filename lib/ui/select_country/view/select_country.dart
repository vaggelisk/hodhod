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
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/cities/cities.dart';
import 'package:hodhod/data/models/countries/countries.dart';
import 'package:hodhod/ui/budget/controller/country_budget_controller.dart';

class SelectCountry extends StatelessWidget {
  SelectCountry({super.key});

  var controller = Get.put(CountryBudgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: const Text(""),
          isShowBack: false,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.0.h),
                SvgPicture.asset(Utils.getIconPath("ic_select_country"),
                    width: 73.0.w, height: 89.0.h),
                SizedBox(height: 11.0.h),
                Text(
                  LangKeys.whereBuyOrRent.tr,
                  style: AppTextStyles.semiBoldTextStyle
                      .copyWith(color: HexColor("4D4D4D"), fontSize: 16.0.sp),
                ),
                SizedBox(height: 34.0.h),
                Row(
                  children: [
                    Text(
                      LangKeys.country.tr,
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
                GetBuilder<CountryBudgetController>(
                  id: 'selectedCountry',
                  builder: (controller) {
                    return controller.isLoadingCountry.isFalse
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0.w, vertical: 10.0.h),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.3.w, color: AppColors.divider1),
                                borderRadius: BorderRadius.circular(6.0.r)),
                            child: DropdownButton<Countries>(
                              value: controller
                                      .selectedCountry.value.name!.isNotEmpty
                                  ? controller.selectedCountry.value
                                  : null,
                              icon: Icon(Icons.expand_more_outlined,
                                  color: AppColors.text1),
                              iconSize: 24.0.r,
                              elevation: 0,
                              hint: Text(LangKeys.selectedCountry.tr,
                                  style: AppTextStyles.regularTextStyle
                                      .copyWith(
                                          color: AppColors.text1,
                                          fontSize: 14.0.sp)),
                              isExpanded: true,
                              dropdownColor: AppColors.grey15,
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: AppColors.text1, fontSize: 14.0.sp),
                              autofocus: true,
                              isDense: true,
                              underline: const SizedBox(),
                              onChanged: (data) {
                                controller.selectedCountry.value = data!;
                                controller.update(['selectedCountry']);
                                controller.selectedCity.value =
                                    Cities(name: "");
                                controller.getCity(data.id ?? 0);
                                controller.update(['selectedCity']);
                              },
                              items: controller.countryList
                                  .map<DropdownMenuItem<Countries>>(
                                      (Countries value) {
                                return DropdownMenuItem<Countries>(
                                  value: value,
                                  child: Text(value.name ?? ""),
                                );
                              }).toList(),
                            ),
                          )
                        : const LoadingView();
                  },
                ),
                SizedBox(height: 16.0.h),
                GetBuilder<CountryBudgetController>(
                  id: 'selectedCity',
                  builder: (controller) {
                    return controller.isLoadingCity.isFalse
                        ? controller.cityList.isNotEmpty
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        LangKeys.city.tr,
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
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0.w, vertical: 10.0.h),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.3.w,
                                            color: AppColors.divider1),
                                        borderRadius:
                                            BorderRadius.circular(6.0.r)),
                                    child: DropdownButton<Cities>(
                                      value: controller.selectedCity.value.name!
                                              .isNotEmpty
                                          ? controller.selectedCity.value
                                          : null,
                                      icon: Icon(Icons.expand_more_outlined,
                                          color: AppColors.text1),
                                      iconSize: 24.0.r,
                                      elevation: 0,
                                      hint: Text(LangKeys.selectedCity.tr,
                                          style: AppTextStyles.regularTextStyle
                                              .copyWith(
                                                  color: AppColors.text1,
                                                  fontSize: 14.0.sp)),
                                      isExpanded: true,
                                      dropdownColor: AppColors.grey15,
                                      style: AppTextStyles.regularTextStyle
                                          .copyWith(
                                              color: AppColors.text1,
                                              fontSize: 14.0.sp),
                                      autofocus: true,
                                      isDense: true,
                                      underline: const SizedBox(),
                                      onChanged: (data) {
                                        controller.selectedCity.value = data!;
                                        controller.update(['selectedCity']);
                                      },
                                      items: controller.cityList
                                          .map<DropdownMenuItem<Cities>>(
                                              (Cities value) {
                                        return DropdownMenuItem<Cities>(
                                          value: value,
                                          child: Text(value.name ?? ""),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],

                              )
                            : controller.selectedCountry.value.name!.isNotEmpty
                                ? Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(top: 20.h),
                                    child: EmptyStatusView(
                                        img: "ic_not_city",
                                        msg: LangKeys.noRealEstateAvailableMsg.tr),
                                  )
                                : const SizedBox()
                        : const LoadingView();
                  },
                ),
                SizedBox(height: 36.0.h),
                Obx(() => controller.selectedCity.value.name!.isNotEmpty
                    ? PrimaryButton(
                        width: ScreenUtil().screenWidth,
                        onPressed: () {
                          controller.storage.setCountry(controller.selectedCountry.value);
                          controller.storage.setCity(controller.selectedCity.value);
                          Get.toNamed(AppRoutes.budget);
                        },
                        height: 47.0.h,
                        borderRadius: BorderRadius.circular(6.0.r),
                        child: Text(LangKeys.continueText.tr,
                            style: AppTextStyles.semiBoldTextStyle.copyWith(
                                color: Colors.white, fontSize: 16.sp)),
                      )
                    : const SizedBox()),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        )));
  }
}
