import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/real_estates_types/real_estates_types.dart';
import 'package:hodhod/ui/add_real_estate/controller/add_real_estate_controller.dart';

import '../../../data/models/cities/cities.dart';
import '../../../data/models/countries/countries.dart';
import '../../../data/models/regions/regions.dart';

class AddRealEstateTwo extends StatelessWidget {
  AddRealEstateTwo({super.key});

  AddRealEstateController controller = Get.find<AddRealEstateController>();

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
            Row(
              children: [
                Text(
                  LangKeys.numberRooms.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.numberRooms,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterNumberRooms.tr)),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.numberBathrooms.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.numberBathrooms,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterNumberBathrooms.tr)),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.numberOfFloors.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.numberFloors,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterNumberOfFloors.tr)),
            SizedBox(height: 16.0.h),
            Visibility(
                visible: controller.isEdit == true,
                child: Column(children: [
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
                  GetBuilder<AddRealEstateController>(
                    id: 'selectedCountries',
                    builder: (controller) {
                      return controller.isLoadingCountries.isFalse
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0.w, vertical: 10.0.h),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.3.w, color: AppColors.divider1),
                                  borderRadius: BorderRadius.circular(6.0.r)),
                              child: DropdownButton<Countries>(
                                value: controller.selectedCountries.value.name!
                                        .isNotEmpty
                                    ? controller.selectedCountries.value
                                    : null,
                                icon: Icon(Icons.expand_more_outlined,
                                    color: AppColors.grey9),
                                iconSize: 24.0.r,
                                elevation: 0,
                                hint: Text(LangKeys.selectedCountry.tr,
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.30),
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
                                  controller.selectedCountries.value = data!;
                                  controller.update(['selectedCountries']);
                                  controller.selectedCities.value =
                                      Cities(name: "");
                                  controller.getCities(data.id ?? 0);
                                  controller.update(['selectedCities']);
                                },
                                items: controller.countriesList
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
                ])),
            // SizedBox(height: 16.0.h),
            GetBuilder<AddRealEstateController>(
              id: 'selectedCities',
              builder: (controller) {
                return controller.isLoadingCities.isFalse
                    ? controller.citiesList.isNotEmpty
                        ? Column(children: [
                            Row(
                              children: [
                                Text(
                                  LangKeys.city.tr,
                                  style: AppTextStyles.mediumTextStyle.copyWith(
                                      color: Colors.black, fontSize: 15.0.sp),
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
                                      width: 0.3.w, color: AppColors.divider1),
                                  borderRadius: BorderRadius.circular(6.0.r)),
                              child: DropdownButton<Cities>(
                                value: controller
                                        .selectedCities.value.name!.isNotEmpty
                                    ? controller.selectedCities.value
                                    : null,
                                icon: Icon(Icons.expand_more_outlined,
                                    color: AppColors.grey9),
                                iconSize: 24.0.r,
                                elevation: 0,
                                hint: Text(LangKeys.selectedCity.tr,
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.30),
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
                                  controller.selectedCities.value = data!;
                                  controller.update(['selectedCities']);
                                  controller.selectedRegions.value =
                                      Regions(name: "");
                                  controller.getRegions(data.id ?? 0);
                                  controller.update(['selectedRegions']);
                                },
                                items: controller.citiesList
                                    .map<DropdownMenuItem<Cities>>(
                                        (Cities value) {
                                  return DropdownMenuItem<Cities>(
                                    value: value,
                                    child: Text(value.name ?? ""),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 16.0.h),
                          ])
                        : const SizedBox()
                    : const LoadingView();
              },
            ),
            GetBuilder<AddRealEstateController>(
              id: 'selectedRegions',
              builder: (controller) {
                return controller.isLoadingRegions.isFalse
                    ? controller.regionsList.isNotEmpty
                        ? Column(children: [
                            Row(
                              children: [
                                Text(
                                  LangKeys.region.tr,
                                  style: AppTextStyles.mediumTextStyle.copyWith(
                                      color: Colors.black, fontSize: 15.0.sp),
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
                                      width: 0.3.w, color: AppColors.divider1),
                                  borderRadius: BorderRadius.circular(6.0.r)),
                              child: DropdownButton<Regions>(
                                value: controller
                                        .selectedRegions.value.name!.isNotEmpty
                                    ? controller.selectedRegions.value
                                    : null,
                                icon: Icon(Icons.expand_more_outlined,
                                    color: AppColors.grey9),
                                iconSize: 24.0.r,
                                elevation: 0,
                                hint: Text(LangKeys.chooseRegion.tr,
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.30),
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
                                  controller.selectedRegions.value = data!;
                                  controller.update(['selectedRegions']);
                                },
                                items: controller.regionsList
                                    .map<DropdownMenuItem<Regions>>(
                                        (Regions value) {
                                  return DropdownMenuItem<Regions>(
                                    value: value,
                                    child: Text(value.name ?? ""),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 16.0.h),
                          ])
                        : const SizedBox()
                    : const LoadingView();
              },
            ),
            Row(
              children: [
                Text(
                  LangKeys.addressDetails.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.addressDetails,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: null,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterAddressDetails.tr)),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.site.tr,
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
            Obx(() => TextFormField(
                controller: controller.locationName,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                readOnly: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlacePicker(
                        apiKey: "AIzaSyDCKrRODi8noc3OQfrBfIWEw1snU0tBkss",
                        hintText: LangKeys.search.tr,

                        onPlacePicked: (result) {
                          controller.locationResult.value = result;
                          controller.locationName.text = controller
                                  .locationResult.value.formattedAddress ??
                              "";
                          Navigator.of(context).pop();
                        },
                        initialPosition: controller.isEdit == true &&
                                controller.estateDetails.value.id != null &&
                                controller.estateDetails.value.latitude != null
                            ? LatLng(double.parse(controller.estateDetails.value.latitude.toString()),
                            double.parse(controller.estateDetails.value.longitude.toString()))
                            : const LatLng(25.276987, 55.296249),
                        useCurrentLocation: controller.isEdit == true &&
                                controller.estateDetails.value.id != null &&
                                controller.estateDetails.value.latitude != null
                            ? false
                            : true,
                        // searchingText: "Please wait ...",
                        selectText: LangKeys.site.tr,
                        ignoreLocationPermissionErrors: true,
                        usePinPointingSearch: true,
                        usePlaceDetailSearch: true,
                        zoomGesturesEnabled: true,
                        enableMyLocationButton: true,
                        selectInitialPosition: true,
                        zoomControlsEnabled: true,
                      ),
                    ),
                  );
                  // controller.showPlacePicker();
                },
                decoration: CommonStyle.textFieldStyle(
                        // hintTextStr: controller.locationResult.value.formattedAddress != null ? controller.locationResult.value.formattedAddress! : LangKeys.locateAdOnTheMap.tr)
                        hintTextStr: controller
                                    .locationResult.value.formattedAddress !=
                                null
                            ? controller.locationResult.value.formattedAddress!
                            : LangKeys.locatePropertyOnMap.tr)
                    .copyWith(
                        suffixIcon: Align(
                  widthFactor: 2.0,
                  heightFactor: 2.0,
                  child: SvgPicture.asset(
                    Utils.getIconPath("ic_location_real"),
                    width: 24.0.w,
                    height: 24.0.h,
                    colorFilter:
                        ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                  ),
                )))),
            SizedBox(height: 29.0.h),
            PrimaryButton(
              width: ScreenUtil().screenWidth,
              onPressed: () {
                controller.validationTwo();
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
