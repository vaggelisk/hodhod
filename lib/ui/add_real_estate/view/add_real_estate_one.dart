import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_constants.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/data/models/categories/categories.dart';
import 'package:hodhod/data/models/cities/cities.dart';
import 'package:hodhod/data/models/countries/countries.dart';
import 'package:hodhod/ui/add_real_estate/controller/add_real_estate_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../data/models/real_estates_constants/real_estate_constants.dart';
import '../../../data/models/real_estates_types/real_estates_types.dart';
import '../../../data/models/regions/regions.dart';

class AddRealEstateOne extends StatelessWidget {
  AddRealEstateOne({super.key});

  AddRealEstateController controller = Get.put(AddRealEstateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(
              controller.isEdit == true
                  ? LangKeys.editRealEstate.tr
                  : LangKeys.addRealEstate.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 16.h),
          child: Column(children: [
            /*
            Row(
              children: [
                Text(
                  LangKeys.category.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            GetBuilder<AddRealEstateController>(
              id: 'selectedCategory',
              builder: (controller) {
                return controller.isLoadingCategory.isFalse
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w, vertical: 10.0.h),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.3.w, color: AppColors.divider1),
                            borderRadius: BorderRadius.circular(6.0.r)),
                        child: DropdownButton<Categories>(
                          value:
                              controller.selectedCategory.value.name!.isNotEmpty
                                  ? controller.selectedCategory.value
                                  : null,
                          icon: Icon(Icons.expand_more_outlined,
                              color: AppColors.grey9),
                          iconSize: 24.0.r,
                          elevation: 0,
                          hint: Text(LangKeys.chooseCategory.tr,
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: Colors.black.withOpacity(0.30),
                                  fontSize: 14.0.sp)),
                          isExpanded: true,
                          dropdownColor: AppColors.grey15,
                          style: AppTextStyles.regularTextStyle.copyWith(
                              color: AppColors.hintTextInput,
                              fontSize: 14.0.sp),
                          autofocus: true,
                          isDense: true,
                          underline: const SizedBox(),
                          onChanged: (data) {
                            controller.selectedCategory.value = data!;
                            controller.update(['selectedCategory']);
                            controller.getSubCategories(data.id ?? 0);
                            controller.update(['selectedSubCategory']);
                          },
                          items: controller.categoryList
                              .map<DropdownMenuItem<Categories>>(
                                  (Categories value) {
                            return DropdownMenuItem<Categories>(
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
             */
            GetBuilder<AddRealEstateController>(
              id: 'selectedSubCategory',
              builder: (controller) {
                return controller.isLoadingSubCategory.isFalse &&
                        controller.subCategoryList.isNotEmpty
                    ? Column(children: [
                        Row(
                          children: [
                            Text(
                              LangKeys.propertyCategory.tr,
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
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0.w, vertical: 10.0.h),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.3.w, color: AppColors.divider1),
                              borderRadius: BorderRadius.circular(6.0.r)),
                          child: DropdownButton<Categories>(
                            value: controller
                                    .selectedSubCategory.value.name!.isNotEmpty
                                ? controller.selectedSubCategory.value
                                : null,
                            icon: Icon(Icons.expand_more_outlined,
                                color: AppColors.grey9),
                            iconSize: 24.0.r,
                            elevation: 0,
                            hint: Text(LangKeys.choosePropertyCategory.tr,
                                style: AppTextStyles.regularTextStyle.copyWith(
                                    color: Colors.black.withOpacity(0.30),
                                    fontSize: 14.0.sp)),
                            isExpanded: true,
                            dropdownColor: AppColors.grey15,
                            style: AppTextStyles.regularTextStyle.copyWith(
                                color: AppColors.hintTextInput,
                                fontSize: 14.0.sp),
                            autofocus: true,
                            isDense: true,
                            underline: const SizedBox(),
                            onChanged: (data) {
                              controller.selectedSubCategory.value = data!;
                              controller.update(['selectedSubCategory']);
                            },
                            items: controller.subCategoryList
                                .map<DropdownMenuItem<Categories>>(
                                    (Categories value) {
                              return DropdownMenuItem<Categories>(
                                value: value,
                                child: Text(value.name ?? ""),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 16.0.h),
                      ])
                    : const LoadingView();
              },
            ),
            Row(
              children: [
                Text(
                  LangKeys.propertyType.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            GetBuilder<AddRealEstateController>(
                id: 'selectedRealEstatesTypes',
                builder: (controller) {
                  return controller.isLoadingRealEstatesTypes.isFalse
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0.w, vertical: 10.0.h),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.3.w, color: AppColors.divider1),
                              borderRadius: BorderRadius.circular(6.0.r)),
                          child: DropdownButton<RealEstatesTypes>(
                            value: controller.selectedRealEstatesTypes.value
                                    .name!.isNotEmpty
                                ? controller.selectedRealEstatesTypes.value
                                : null,
                            icon: Icon(Icons.expand_more_outlined,
                                color: AppColors.grey9),
                            iconSize: 24.0.r,
                            elevation: 0,
                            hint: Text(LangKeys.choosePropertyType.tr,
                                style: AppTextStyles.regularTextStyle.copyWith(
                                    color: Colors.black.withOpacity(0.30),
                                    fontSize: 14.0.sp)),
                            isExpanded: true,
                            dropdownColor: AppColors.grey15,
                            style: AppTextStyles.regularTextStyle.copyWith(
                                color: AppColors.hintTextInput,
                                fontSize: 14.0.sp),
                            autofocus: true,
                            isDense: true,
                            underline: const SizedBox(),
                            onChanged: (data) {
                              controller.selectedRealEstatesTypes.value = data!;
                              controller.update(['selectedRealEstatesTypes']);
                            },
                            items: controller.realEstatesTypesList
                                .map<DropdownMenuItem<RealEstatesTypes>>(
                                    (RealEstatesTypes value) {
                              return DropdownMenuItem<RealEstatesTypes>(
                                value: value,
                                child: Text(value.name ?? ""),
                              );
                            }).toList(),
                          ),
                        )
                      : const LoadingView();
                }),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.propertySpecificationsAndFeatures.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.propertyFeatures,
                textInputAction: TextInputAction.next,
                canRequestFocus: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                readOnly: true,
                onTap: () {
                  Get.toNamed(AppRoutes.propertyFeatures);
                },
                maxLines: null,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr:
                        LangKeys.choosePropertySpecificationsAndFeatures.tr)),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.thisPropertyIs.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            GetBuilder<AddRealEstateController>(
              id: 'selectedRealEstateActionType',
              builder: (controller) {
                return controller.isLoadingRealEstatesConstants.isFalse
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w, vertical: 10.0.h),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.3.w, color: AppColors.divider1),
                            borderRadius: BorderRadius.circular(6.0.r)),
                        child: DropdownButton<RealEstateConstants>(
                          value: controller.selectedRealEstateActionType.value
                                  .name!.isNotEmpty
                              ? controller.selectedRealEstateActionType.value
                              : null,
                          icon: Icon(Icons.expand_more_outlined,
                              color: AppColors.grey9),
                          iconSize: 24.0.r,
                          elevation: 0,
                          hint: Text(LangKeys.chooseThisPropertyIs.tr,
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: Colors.black.withOpacity(0.30),
                                  fontSize: 14.0.sp)),
                          isExpanded: true,
                          dropdownColor: AppColors.grey15,
                          style: AppTextStyles.regularTextStyle.copyWith(
                              color: AppColors.hintTextInput,
                              fontSize: 14.0.sp),
                          autofocus: true,
                          isDense: true,
                          underline: const SizedBox(),
                          onChanged: (data) {
                            controller.selectedRealEstateActionType.value =
                                data!;
                            controller.update(['selectedRealEstateActionType']);
                            controller
                                .update(['selectedRealEstateCompleteStatus']);
                          },
                          items: controller.realEstateActionTypeList
                              .map<DropdownMenuItem<RealEstateConstants>>(
                                  (RealEstateConstants value) {
                            return DropdownMenuItem<RealEstateConstants>(
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
            GetBuilder<AddRealEstateController>(
              id: 'selectedRealEstateCompleteStatus',
              builder: (controller) {
                return controller.isLoadingRealEstatesConstants.isFalse
                    ? controller.selectedRealEstateActionType.value.key ==
                            "sale"
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    LangKeys.propertyStatus.tr,
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
                                    borderRadius: BorderRadius.circular(6.0.r)),
                                child: DropdownButton<RealEstateConstants>(
                                  value: controller
                                          .selectedRealEstateCompleteStatus
                                          .value
                                          .name!
                                          .isNotEmpty
                                      ? controller
                                          .selectedRealEstateCompleteStatus
                                          .value
                                      : null,
                                  icon: Icon(Icons.expand_more_outlined,
                                      color: AppColors.grey9),
                                  iconSize: 24.0.r,
                                  elevation: 0,
                                  hint: Text(LangKeys.choosePropertyStatus.tr,
                                      style: AppTextStyles.regularTextStyle
                                          .copyWith(
                                              color: Colors.black
                                                  .withOpacity(0.30),
                                              fontSize: 14.0.sp)),
                                  isExpanded: true,
                                  dropdownColor: AppColors.grey15,
                                  style: AppTextStyles.regularTextStyle
                                      .copyWith(
                                          color: AppColors.hintTextInput,
                                          fontSize: 14.0.sp),
                                  autofocus: true,
                                  isDense: true,
                                  underline: const SizedBox(),
                                  onChanged: (data) {
                                    controller.selectedRealEstateCompleteStatus
                                        .value = data!;
                                    controller.update(
                                        ['selectedRealEstateCompleteStatus']);
                                  },
                                  items: controller.realEstateCompleteStatusList
                                      .map<
                                              DropdownMenuItem<
                                                  RealEstateConstants>>(
                                          (RealEstateConstants value) {
                                    return DropdownMenuItem<
                                        RealEstateConstants>(
                                      value: value,
                                      child: Text(value.name ?? ""),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 16.0.h),
                            ],
                          )
                        : SizedBox()
                    : const LoadingView();
              },
            ),
            Row(
              children: [
                Text(
                  LangKeys.propertyArea.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.propertyArea,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterPropertyArea.tr)),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.propertyPrice.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            Container(
              height: 50.h,
              margin: EdgeInsetsDirectional.only(bottom: 16.h),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.3.w, color: AppColors.divider1),
                  borderRadius: BorderRadius.circular(8.0.r)),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: controller.price,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        ThousandsFormatter(allowFraction: false)
                      ],
                      decoration: InputDecoration(
                          hintText: LangKeys.enterPropertyPrice.tr,
                          hintStyle: AppTextStyles.regularTextStyle.copyWith(
                              fontSize: 12.0.sp,
                              color: Colors.black.withOpacity(0.30)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0.w, vertical: 10.0.h),
                          border: InputBorder.none),
                    ),
                  ),
                  Obx(() => Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          controller.selectedCountries.value.currency?.name ??
                              "",
                          style: AppTextStyles.semiBoldTextStyle
                              .copyWith(color: Colors.black, fontSize: 14.0.sp),
                        ),
                      )),
                  SizedBox(width: 16.0.w)
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  LangKeys.propertyName.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.nameRealEstateArabic,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterPropertyName.tr)),
            /*
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.nameRealEstateEnglish.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.nameRealEstateEnglish,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterNameRealEstateEnglish.tr)),

             */
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.realEstateTransactions.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            GetBuilder<AddRealEstateController>(
              id: 'selectedRealEstateTransactionType',
              builder: (controller) {
                return controller.isLoadingRealEstatesConstants.isFalse
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w, vertical: 10.0.h),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.3.w, color: AppColors.divider1),
                            borderRadius: BorderRadius.circular(6.0.r)),
                        child: DropdownButton<RealEstateConstants>(
                          value: controller.selectedRealEstateTransactionType
                                  .value.name!.isNotEmpty
                              ? controller
                                  .selectedRealEstateTransactionType.value
                              : null,
                          icon: Icon(Icons.expand_more_outlined,
                              color: AppColors.grey9),
                          iconSize: 24.0.r,
                          elevation: 0,
                          hint: Text(LangKeys.selectPropertyTransaction.tr,
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: Colors.black.withOpacity(0.30),
                                  fontSize: 14.0.sp)),
                          isExpanded: true,
                          dropdownColor: AppColors.grey15,
                          style: AppTextStyles.regularTextStyle.copyWith(
                              color: AppColors.hintTextInput,
                              fontSize: 14.0.sp),
                          autofocus: true,
                          isDense: true,
                          underline: const SizedBox(),
                          onChanged: (data) {
                            controller.selectedRealEstateTransactionType.value =
                                data!;
                            controller
                                .update(['selectedRealEstateTransactionType']);
                          },
                          items: controller.realEstateTransactionTypeList
                              .map<DropdownMenuItem<RealEstateConstants>>(
                                  (RealEstateConstants value) {
                            return DropdownMenuItem<RealEstateConstants>(
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
            Row(
              children: [
                Text(
                  LangKeys.phoneNumber.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3.w, color: AppColors.divider1),
                    borderRadius: BorderRadius.circular(8.0.r)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: controller.mobile,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0.w),
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
                            controller.phoneCode(country.phoneCode);
                            controller.countryCode(country.countryCode);
                          },
                          countryListTheme: CountryListThemeData(
                            flagSize: 24.0.r,
                            backgroundColor: Colors.white,
                            textStyle: TextStyle(fontSize: 12.0.sp),
                            bottomSheetHeight: ScreenUtil().screenHeight / 2,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0.r),
                              topRight: Radius.circular(10.0.r),
                            ),
                            inputDecoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0.r),
                              labelText: "بحث",
                              labelStyle: TextStyle(fontSize: 14.0.sp),
                              hintText: "ابدأ الكتابة للبحث'",
                              prefixIcon: Icon(Icons.search, size: 24.0.r),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primary.withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.keyboard_arrow_down_rounded, size: 24.0.r),
                          Obx(() => Text("+${controller.phoneCode.value}",
                              textDirection: TextDirection.ltr,
                              style: AppTextStyles.mediumTextStyle.copyWith(
                                  color: AppColors.primary,
                                  fontSize: 14.0.sp))),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0.w)
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.0.h),
            PrimaryButton(
              width: ScreenUtil().screenWidth,
              onPressed: () {
                controller.validationOne();
              },
              height: 47.0.h,
              borderRadius: BorderRadius.circular(6.0.r),
              child: Text(LangKeys.next.tr,
                  style: AppTextStyles.semiBoldTextStyle
                      .copyWith(color: Colors.white, fontSize: 16.sp)),
            ),
            SizedBox(height: 25.h),
          ]),
        ),
      ),
    );
  }
}
