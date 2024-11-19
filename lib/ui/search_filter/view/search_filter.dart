import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/models/real_estates_constants/real_estate_constants.dart';
import 'package:hodhod/data/models/real_estates_types/real_estates_types.dart';
import 'package:hodhod/ui/search_filter/controller/search_filter_controller.dart';

class SearchFilter extends StatelessWidget {
  SearchFilter({super.key});

  SearchFilterController controller = Get.put(SearchFilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(LangKeys.advancedSearch.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: SingleChildScrollView(
        child: Padding(
            padding:
                EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 16.h),
            child: Column(
              children: [
                GetBuilder<SearchFilterController>(
                  id: 'selectedType',
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
                              value:
                                  controller.selectedType.value.name!.isNotEmpty
                                      ? controller.selectedType.value
                                      : null,
                              icon: Icon(Icons.expand_more_outlined,
                                  color: AppColors.text1),
                              iconSize: 24.0.r,
                              elevation: 0,
                              hint: Text(LangKeys.propertySale.tr,
                                  style: AppTextStyles.regularTextStyle
                                      .copyWith(
                                          color: AppColors.text1,
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
                                controller.selectedType.value = data!;
                                controller.update(['selectedType']);
                              },
                              items: controller.typeList
                                  .map<DropdownMenuItem<RealEstateConstants>>(
                                      (RealEstateConstants value) {
                                return DropdownMenuItem<RealEstateConstants>(
                                  value: value,
                                  child: Text(value.name ?? ""),
                                );
                              }).toList(),
                            ),
                          )
                        : LoadingView();
                  },
                ),
                SizedBox(height: 16.0.h),
                GetBuilder<SearchFilterController>(
                    id: 'selectedRealEstateType',
                    builder: (controller) {
                      return controller.isLoadingRealEstatesConstants.isFalse
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
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color: AppColors.text1,
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
                                  controller.selectedRealEstatesTypes.value =
                                      data!;
                                  controller.update(['selectedRealEstateType']);
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
                GetBuilder<SearchFilterController>(
                  id: 'selectedSortBy',
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
                              value:
                                  controller.selectedSort.value.name!.isNotEmpty
                                      ? controller.selectedSort.value
                                      : null,
                              icon: Icon(Icons.expand_more_outlined,
                                  color: AppColors.grey9),
                              iconSize: 24.0.r,
                              elevation: 0,
                              hint: Text(LangKeys.sorting.tr,
                                  style: AppTextStyles.regularTextStyle
                                      .copyWith(
                                          color: AppColors.text1,
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
                                controller.selectedSort.value = data!;
                                controller.update(['selectedSortBy']);
                              },
                              items: controller.sortList
                                  .map<DropdownMenuItem<RealEstateConstants>>(
                                      (RealEstateConstants value) {
                                return DropdownMenuItem<RealEstateConstants>(
                                  value: value,
                                  child: Text(value.name ?? ""),
                                );
                              }).toList(),
                            ),
                          )
                        : LoadingView();
                  },
                ),
                SizedBox(height: 16.0.h),
                TextFormField(
                    controller: controller.numberRooms,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: CommonStyle.textFieldSStyle(
                        hintTextStr: LangKeys.numberRooms.tr)),
                SizedBox(height: 16.0.h),
                TextFormField(
                    controller: controller.numberBathrooms,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: CommonStyle.textFieldSStyle(
                        hintTextStr: LangKeys.numberBathrooms.tr)),
                SizedBox(height: 16.0.h),
                TextFormField(
                    controller: controller.numberFloors,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: CommonStyle.textFieldSStyle(
                        hintTextStr: LangKeys.numberOfFloors.tr)),
                // SizedBox(height: 16.0.h),
                // GetBuilder<SearchFilterController>(
                //   id: 'selectedRooms',
                //   builder: (controller) {
                //     return controller.isLoadingRealEstatesConstants.isFalse
                //         ? Container(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 10.0.w, vertical: 10.0.h),
                //             decoration: BoxDecoration(
                //                 border: Border.all(
                //                     width: 0.3.w, color: AppColors.divider1),
                //                 borderRadius: BorderRadius.circular(6.0.r)),
                //             child: DropdownButton<int>(
                //               value: controller.selectRooms.value != 0
                //                   ? controller.selectRooms.value
                //                   : null,
                //               icon: Icon(Icons.expand_more_outlined,
                //                   color: AppColors.grey9),
                //               iconSize: 24.0.r,
                //               elevation: 0,
                //               hint: Text(LangKeys.numberRooms.tr,
                //                   style: AppTextStyles.regularTextStyle
                //                       .copyWith(
                //                           color: AppColors.text1,
                //                           fontSize: 14.0.sp)),
                //               isExpanded: true,
                //               dropdownColor: AppColors.grey15,
                //               style: AppTextStyles.regularTextStyle.copyWith(
                //                   color: AppColors.hintTextInput,
                //                   fontSize: 14.0.sp),
                //               autofocus: true,
                //               isDense: true,
                //               underline: const SizedBox(),
                //               onChanged: (data) {
                //                 controller.selectRooms.value = data!;
                //                 controller.update(['selectedRooms']);
                //               },
                //               items: controller.roomsList
                //                   .map<DropdownMenuItem<int>>((int value) {
                //                 return DropdownMenuItem<int>(
                //                   value: value,
                //                   child: Text(value.toString() ?? ""),
                //                 );
                //               }).toList(),
                //             ),
                //           )
                //         : const LoadingView();
                //   },
                // ),
                // SizedBox(height: 16.0.h),
                // GetBuilder<SearchFilterController>(
                //   id: 'selectedBathrooms',
                //   builder: (controller) {
                //     return controller.isLoadingRealEstatesConstants.isFalse
                //         ? Container(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 10.0.w, vertical: 10.0.h),
                //             decoration: BoxDecoration(
                //                 border: Border.all(
                //                     width: 0.3.w, color: AppColors.divider1),
                //                 borderRadius: BorderRadius.circular(6.0.r)),
                //             child: DropdownButton<int>(
                //               value: controller.selectBathRooms.value != 0
                //                   ? controller.selectBathRooms.value
                //                   : null,
                //               icon: Icon(Icons.expand_more_outlined,
                //                   color: AppColors.grey9),
                //               iconSize: 24.0.r,
                //               elevation: 0,
                //               hint: Text(LangKeys.numberBathrooms.tr,
                //                   style: AppTextStyles.regularTextStyle
                //                       .copyWith(
                //                           color: AppColors.text1,
                //                           fontSize: 14.0.sp)),
                //               isExpanded: true,
                //               dropdownColor: AppColors.grey15,
                //               style: AppTextStyles.regularTextStyle.copyWith(
                //                   color: AppColors.hintTextInput,
                //                   fontSize: 14.0.sp),
                //               autofocus: true,
                //               isDense: true,
                //               underline: const SizedBox(),
                //               onChanged: (data) {
                //                 controller.selectBathRooms.value = data!;
                //                 controller.update(['selectedBathrooms']);
                //               },
                //               items: controller.bathRoomsList
                //                   .map<DropdownMenuItem<int>>((int value) {
                //                 return DropdownMenuItem<int>(
                //                   value: value,
                //                   child: Text(value.toString() ?? ""),
                //                 );
                //               }).toList(),
                //             ),
                //           )
                //         : LoadingView();
                //   },
                // ),
                SizedBox(height: 16.0.h),
                TextFormField(
                    controller: controller.propertyFeatures,
                    textInputAction: TextInputAction.next,
                    canRequestFocus: false,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    readOnly: true,
                    onTap: () {
                      Get.toNamed(AppRoutes.propertyFeaturesSearch);
                    },
                    maxLines: null,
                    decoration: CommonStyle.textFieldStyle(
                            hintTextStr: LangKeys.selectPropertyFeatures.tr)
                        .copyWith(
                            hintStyle: AppTextStyles.regularTextStyle
                                .copyWith(color: AppColors.text1))),
                SizedBox(height: 16.0.h),
                Container(
                  width: ScreenUtil().screenWidth,
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 16.w, vertical: 13.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey, width: 1.w),
                      borderRadius: BorderRadius.all(Radius.circular(10.0.r))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LangKeys.propertyArea.tr,
                            style: AppTextStyles.regularTextStyle.copyWith(
                                fontSize: 14.0.sp, color: AppColors.text1)),
                        Obx(() => RangeSlider(
                              min: 0,
                              max: 50000,
                              activeColor: AppColors.bgSplash,
                              inactiveColor: AppColors.grey8,
                              divisions: 50000,
                              labels: RangeLabels(
                                  controller.startSpaceValue.value
                                      .round()
                                      .toString(),
                                  controller.endSpaceValue.value
                                      .round()
                                      .toString()),
                              values: RangeValues(
                                  controller.startSpaceValue.value,
                                  controller.endSpaceValue.value),
                              onChanged: (values) {
                                controller.startSpaceValue.value = values.start;
                                controller.endSpaceValue.value = values.end;
                                controller.minSpacePriceController.text =
                                    controller.startSpaceValue.value
                                        .floor()
                                        .toString();
                                controller.maxSpacePriceController.text =
                                    controller.endSpaceValue.value
                                        .floor()
                                        .toString();
                              },
                            )),
                        SizedBox(height: 30.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.minimum.tr,
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
                            controller: controller.minSpacePriceController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // if(double.parse(value) > 1000){
                              if (value.isNotEmpty) {
                                if (double.parse(value) > 1000 &&
                                    double.parse(value) <= 1000000000) {
                                  controller.startValue.value =
                                      double.parse(value);
                                }
                              }

                              // }else{
                              //
                              // }
                            },
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.minimum.tr)),
                        SizedBox(height: 16.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.maximum.tr,
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
                            controller: controller.maxSpacePriceController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // if(double.parse(value) > 1000){
                              if (value.isNotEmpty) {
                                if (double.parse(value) > 1000 &&
                                    double.parse(value) <= 1000000000) {
                                  controller.endValue.value =
                                      double.parse(value);
                                }
                              }

                              // }else{
                              //
                              // }
                            },
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.minimum.tr)),
                      ]),
                ),
                SizedBox(height: 16.0.h),
                Container(
                  width: ScreenUtil().screenWidth,
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 16.w, vertical: 13.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey, width: 1.w),
                      borderRadius: BorderRadius.all(Radius.circular(10.0.r))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LangKeys.price.tr,
                            style: AppTextStyles.regularTextStyle.copyWith(
                                fontSize: 14.0.sp, color: AppColors.text1)),
                        Obx(() => RangeSlider(
                              min: 1000,
                              max: 1000000000.0,
                              activeColor: AppColors.bgSplash,
                              inactiveColor: AppColors.grey8,
                              divisions: 1000000000,
                              labels: RangeLabels(
                                  controller.startValue.value
                                      .round()
                                      .toString(),
                                  controller.endValue.value.round().toString()),
                              values: RangeValues(controller.startValue.value,
                                  controller.endValue.value),
                              onChanged: (values) {
                                controller.startValue.value = values.start;
                                controller.endValue.value = values.end;
                                controller.minPriceController.text = controller
                                    .startValue.value
                                    .floor()
                                    .toString();
                                controller.maxPriceController.text = controller
                                    .endValue.value
                                    .floor()
                                    .toString();
                              },
                            )),
                        SizedBox(height: 30.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.minimum.tr,
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
                            controller: controller.minPriceController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // if(double.parse(value) > 1000){
                              if (value.isNotEmpty) {
                                if (double.parse(value) > 1000 &&
                                    double.parse(value) <= 1000000000) {
                                  controller.startValue.value =
                                      double.parse(value);
                                }
                              }

                              // }else{
                              //
                              // }
                            },
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.minimum.tr)),
                        SizedBox(height: 16.0.h),
                        Row(
                          children: [
                            Text(
                              LangKeys.maximum.tr,
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
                            controller: controller.maxPriceController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // if(double.parse(value) > 1000){
                              if (value.isNotEmpty) {
                                if (double.parse(value) > 1000 &&
                                    double.parse(value) <= 1000000000) {
                                  controller.endValue.value =
                                      double.parse(value);
                                }
                              }

                              // }else{
                              //
                              // }
                            },
                            decoration: CommonStyle.textFieldStyle(
                                hintTextStr: LangKeys.minimum.tr)),
                      ]),
                ),
                SizedBox(height: 30.0.h),
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
                    Map<String, dynamic> result = {
                      "from_price": min.isNotEmpty
                          ? (double.parse(min) *
                              double.parse(controller.storage
                                      .getCountry()
                                      ?.currency
                                      ?.exchangeRate ??
                                  "1"))
                          : "0".toString(),
                      "to_price": max.isNotEmpty
                          ? (double.parse(max) *
                              double.parse(controller.storage
                                      .getCountry()
                                      ?.currency
                                      ?.exchangeRate ??
                                  "1"))
                          : "".toString(),
                      "sort_by": controller.selectedSort.value.key ?? "",
                      "real_estate_type_id":
                          controller.selectedRealEstatesTypes.value.id ?? 0,
                      "number_of_rooms": controller.numberRooms.text.isNotEmpty
                          ? controller.numberRooms.text
                          : "0",
                      "number_of_bathrooms":
                          controller.numberBathrooms.text.isNotEmpty
                              ? controller.numberBathrooms.text
                              : "0",
                      "number_of_floors":
                          controller.numberFloors.text.isNotEmpty
                              ? controller.numberFloors.text
                              : "0",
                      "space_from": controller
                              .minSpacePriceController.text.isNotEmpty
                          ? controller.minSpacePriceController.text.isNotEmpty
                          : "0",
                      "space_to":
                          controller.maxSpacePriceController.text.isNotEmpty
                              ? controller.maxSpacePriceController.text
                              : "0",
                      "type": controller.selectedType.value.key ?? "",
                      "features_ids": controller.realEstatesFeaturesSelectedList
                    };
                    Get.back(result: result);
                  },
                  height: 47.0.h,
                  borderRadius: BorderRadius.circular(6.0.r),
                  child: Text(LangKeys.search.tr,
                      style: AppTextStyles.semiBoldTextStyle
                          .copyWith(color: Colors.white, fontSize: 16.sp)),
                ),
                SizedBox(height: 25.0.h),
              ],
            )),
      ),
    );
  }
}
