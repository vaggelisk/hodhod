import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/components/my_outlined_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/real_estate_details/controller/real_estate_details_controller.dart';
import 'package:hodhod/ui/real_estate_details/view/full_screen_image.dart';
import 'package:hodhod/ui/real_estate_details/view/widget/item_child_featured.dart';
import 'package:hodhod/ui/shimmer_details.dart';

class RealStateDetails extends StatelessWidget {
  RealStateDetails({super.key});

  RealEstateDetailsController controller =
      Get.put(RealEstateDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(LangKeys.realEstateDetails.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: GetBuilder<RealEstateDetailsController>(
        id: 'updateDetails',
        builder: (controller) {
          if (controller.isLoading.isTrue) {
            return const ShimmerDetails();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                controller.data.value.images != null &&
                        controller.data.value.images!.isNotEmpty
                    ? CarouselSlider.builder(
                        itemCount: controller.data.value.images!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return FullScreenImage(
                                  listImages: controller.data.value.images!,
                                  indexSelected: itemIndex,
                                );
                              }));
                            },
                            child: SizedBox(
                                width: ScreenUtil().screenWidth,
                                height: 193.h,
                                child: displayImageFromNetwork(
                                    controller.data.value.images![itemIndex]
                                            .image ??
                                        "",
                                    BoxFit.cover,
                                    ScreenUtil().screenWidth,
                                    193.h,
                                    0.r)),
                          );
                        },
                        options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              // controller.sliderIndex(index);
                            },
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.2,
                            viewportFraction: 0.8,
                            height: 193.h),
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 16.w, end: 16.w, top: 17.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(controller.data.value.title ?? "",
                                style: AppTextStyles.semiBoldTextStyle.copyWith(
                                    color: AppColors.text18, fontSize: 14.sp)),
                          ),
                          Row(children: [
                            SizedBox(width: 5.w),
                            Text(
                              "${Utils.formatPrice(controller.data.value.price ?? "")} ${controller.data.value.currency?.name ?? ""}",
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: AppColors.primary, fontSize: 15.0.sp),
                            )
                          ]),
                          SizedBox(width: 12.w),
                          InkWell(
                              onTap: () {
                              Utils.share(controller.data.value.uid ?? "");
                              },
                              child: SvgPicture.asset(
                                  Utils.getIconPath("ic_share"),
                                  width: 24.w,
                                  height: 24.w)),
                          SizedBox(width: 8.w),
                          InkWell(
                              onTap: () {
                                if (controller.storage.isAuth()) {
                                  controller.addOrRemoveFavorite();
                                } else {
                                  confirmBottomSheet();
                                }
                              },
                              child: SvgPicture.asset(
                                  Utils.getIconPath(
                                      controller.data.value.isFavorite == true
                                          ? "ic_fav_details"
                                          : "ic_un_fav_details"),
                                  width: 24.w,
                                  height: 24.w))
                        ],
                      ),
                      SizedBox(height: 7.h),
                      Row(children: [
                        Text(
                          "${LangKeys.propertyCategory.tr} :",
                          style: AppTextStyles.semiBoldTextStyle
                              .copyWith(color: Colors.black, fontSize: 14.0.sp),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                            child: Text(
                          // "${controller.data.value.category?.name ?? ""} - ${controller.data.value.subCategory?.name ?? ""}",
                          controller.data.value.subCategory?.name ?? "",
                          // "عقارات",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.mediumTextStyle.copyWith(
                              color: AppColors.grey6, fontSize: 14.0.sp),
                        )),
                      ]),
                      SizedBox(height: 7.h),
                      Row(
                        children: [
                          Expanded(
                              child: Row(children: [
                            Text(
                              "${LangKeys.propertyType.tr} :",
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: Colors.black, fontSize: 14.0.sp),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                                child: Text(
                              "${controller.data.value.realEstateType?.name ?? ""} ",
                              // "عقار للإيجار",
                              textAlign: TextAlign.start,
                              style: AppTextStyles.mediumTextStyle.copyWith(
                                  color: AppColors.grey6, fontSize: 14.0.sp),
                            )),
                          ])),
                          Expanded(
                              child: Row(children: [
                            Text(
                              "${LangKeys.propertyArea.tr} :",
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: Colors.black, fontSize: 14.0.sp),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                                child: Text(
                              "${controller.data.value.space ?? ""} ${LangKeys.m.tr}",
                              textAlign: TextAlign.start,
                              style: AppTextStyles.mediumTextStyle.copyWith(
                                  color: AppColors.grey6, fontSize: 14.0.sp),
                            )),
                          ])),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Visibility(
                          visible: (controller.data.value.numberOfBathrooms !=
                                      null &&
                                  controller.data.value.numberOfBathrooms
                                          .toString() !=
                                      "0") ||
                              (controller.data.value.numberOfRooms != null &&
                                  controller.data.value.numberOfRooms
                                          .toString() !=
                                      "0") ||
                              (controller.data.value.numberOfFloors != null &&
                                  controller.data.value.numberOfFloors
                                          .toString() !=
                                      "0"),
                          child: Row(
                            children: [
                              controller.data.value.numberOfRooms != null &&
                                      controller.data.value.numberOfRooms
                                              .toString() !=
                                          "0"
                                  ? Expanded(
                                      child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            Utils.getIconPath("ic_bedroom"),
                                            width: 14.w,
                                            height: 14.h),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "${controller.data.value.numberOfRooms ?? "0"} ${LangKeys.rooms.tr}",
                                          style: AppTextStyles.regularTextStyle
                                              .copyWith(
                                                  color: HexColor("A9A9A9"),
                                                  fontSize: 12.0.sp),
                                        ),
                                        SizedBox(width: 8.w),
                                      ],
                                    ))
                                  : const Spacer(),
                              controller.data.value.numberOfBathrooms != null &&
                                      controller.data.value.numberOfBathrooms
                                              .toString() !=
                                          "0"
                                  ? Expanded(
                                      child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            Utils.getIconPath("ic_bathroom"),
                                            width: 14.w,
                                            height: 14.h),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "${controller.data.value.numberOfBathrooms ?? "0"} ${LangKeys.bathroom.tr}",
                                          style: AppTextStyles.regularTextStyle
                                              .copyWith(
                                                  color: HexColor("A9A9A9"),
                                                  fontSize: 12.0.sp),
                                        ),
                                        SizedBox(width: 8.w),
                                      ],
                                    ))
                                  : const Spacer(),
                              controller.data.value.numberOfFloors != null &&
                                      controller.data.value.numberOfFloors
                                              .toString() !=
                                          "0"
                                  ? Expanded(
                                      child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            Utils.getIconPath("ic_floors"),
                                            width: 14.w,
                                            height: 14.h),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "${controller.data.value.numberOfFloors ?? "0"} ${LangKeys.floor.tr}",
                                          style: AppTextStyles.regularTextStyle
                                              .copyWith(
                                                  color: HexColor("A9A9A9"),
                                                  fontSize: 12.0.sp),
                                        )
                                      ],
                                    ))
                                  : Spacer()
                            ],
                          )),
                      Column(
                        children: [
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  SvgPicture.asset(
                                      Utils.getIconPath("ic_building"),
                                      width: 18.w,
                                      height: 18.h),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                      child: Text(
                                    controller.data.value.type ?? "",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color: HexColor("A9A9A9"),
                                            fontSize: 12.0.sp),
                                  ))
                                ],
                              )),
                              SizedBox(width: 8.w),
                              Expanded(
                                  child: Row(
                                children: [
                                  SvgPicture.asset(
                                      Utils.getIconPath("ic_building_2"),
                                      width: 18.w,
                                      height: 18.h),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                      child: Text(
                                    controller.data.value.realEstateStatus ??
                                        "",
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color: HexColor("A9A9A9"),
                                            fontSize: 12.0.sp),
                                  ))
                                ],
                              )),
                              SizedBox(width: 8.w),
                              const Spacer()
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Divider(
                        height: 0,
                        thickness: 0.5.h,
                        color: AppColors.grey7,
                      ),
                      SizedBox(height: 13.h),
                      Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 3,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(children: [
                          Container(
                            width: ScreenUtil().screenWidth,
                            height: 165.h,
                            child: ClipRRect(
                              borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(10.r),
                                  topStart: Radius.circular(10.r)),
                              child: SizedBox(
                                width: ScreenUtil().screenWidth,
                                height: 165.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(10.r),
                                      topStart: Radius.circular(10.r)),
                                  child: GoogleMap(
                                    markers: controller.markers,
                                    mapType: MapType.normal,
                                    myLocationEnabled: false,
                                    zoomControlsEnabled: false,
                                    myLocationButtonEnabled: false,
                                    scrollGesturesEnabled: false,
                                    zoomGesturesEnabled: false,
                                    rotateGesturesEnabled: false,
                                    tiltGesturesEnabled: false,
                                    onTap: (la) {
                                      controller.openMap(controller.lat.value,
                                          controller.lng.value);
                                    },
                                    onMapCreated:
                                        (GoogleMapController controller1) {
                                      // todo crash https://stackoverflow.com/questions/59519208/flutter-google-maps-stateerror-bad-state-future-already-completed
                                      // Unhandled Exception: Bad state: Future already completed
                                      controller.googleMapController
                                          .complete(controller1);
                                    },
                                    initialCameraPosition: const CameraPosition(
                                        target: LatLng(0, 0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0.r),
                            child: SizedBox(
                                width: ScreenUtil().screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Visibility(
                                        visible: controller
                                                    .data.value.address !=
                                                null &&
                                            controller.data.value.address != "",
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              Utils.getIconPath(
                                                  "ic_location_real"),
                                              width: 24.0.w,
                                              height: 24.0.h,
                                            ),
                                            SizedBox(width: 8.h),
                                            Expanded(
                                              child: Text(
                                                // "${controller.data.value.country?.name ?? ""} - ${controller.data.value.city?.name ?? ""}",
                                                controller.data.value.address ??
                                                    "",
                                                style: AppTextStyles
                                                    .semiBoldTextStyle
                                                    .copyWith(
                                                        color:
                                                            HexColor("263238"),
                                                        fontSize: 14.0.sp,
                                                        height: 1.h),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Visibility(
                                        visible: controller
                                                    .data.value.address !=
                                                null &&
                                            controller.data.value.address != "",
                                        child: SizedBox(height: 8.h)),
                                    Text(
                                      controller.data.value.description ?? "",
                                      textAlign: TextAlign.start,
                                      style: AppTextStyles.mediumTextStyle
                                          .copyWith(
                                              color: AppColors.text1,
                                              fontSize: 14.0.sp),
                                    ),
                                  ],
                                )),
                          )
                        ]),
                      ),
                      SizedBox(height: 11.h),
                      Divider(
                        height: 0,
                        thickness: 0.5.h,
                        color: AppColors.grey7,
                      ),
                      SizedBox(height: 7.h),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LangKeys.propertyFeatures.tr,
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: Colors.black, fontSize: 14.0.sp),
                            ),
                            SizedBox(height: 11.h),
                            ListView.builder(
                              itemCount: controller.data.value.features!.length,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ItemChildFeatured(
                                    data:
                                        controller.data.value.features![index]);
                              },
                            )
                          ]),
                      SizedBox(height: 15.h),
                      Divider(
                        height: 0,
                        thickness: 0.5.h,
                        color: AppColors.grey7,
                      ),
                      SizedBox(height: 7.h),
                      Visibility(
                          visible: controller.data.value.user != null &&
                              controller.data.value.user!.companyProfile !=
                                  null &&
                              controller.data.value.user!.companyProfile!
                                      .statusKey ==
                                  "approved",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LangKeys.mediator.tr,
                                style: AppTextStyles.semiBoldTextStyle.copyWith(
                                    color: Colors.black, fontSize: 14.0.sp),
                              ),
                              SizedBox(height: 17.h),
                              Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.primary,
                                          width: 1.0.w,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 25.0.r,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: controller.data.value.user
                                                    ?.companyProfile?.logo ??
                                                "",
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
                                      )),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.data.value.user
                                                ?.companyProfile?.name ??
                                            "",
                                        style: AppTextStyles.semiBoldTextStyle
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 13.0.sp),
                                      ),
                                      SizedBox(height: 5.h),
                                      // Text(
                                      //   "UX/UI Designer",
                                      //   style: AppTextStyles.regularTextStyle
                                      //       .copyWith(
                                      //           color: HexColor("737373"),
                                      //           fontSize: 12.0.sp),
                                      // )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 13.h),
                              Row(children: [
                                Text(
                                  "${LangKeys.experience.tr} :",
                                  style: AppTextStyles.semiBoldTextStyle
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: 14.0.sp),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                    child: Text(
                                  "${controller.data.value.user?.companyProfile?.experienceYears ?? ""} ${LangKeys.years.tr}",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.regularTextStyle
                                      .copyWith(
                                          color: AppColors.grey6,
                                          fontSize: 12.0.sp),
                                )),
                              ]),
                              SizedBox(height: 5.h),
                              Row(children: [
                                Text(
                                  "${LangKeys.languages.tr} :",
                                  style: AppTextStyles.semiBoldTextStyle
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: 14.0.sp),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                    child: Text(
                                  controller.getLanguages(controller.data.value
                                          .user?.companyProfile?.languages ??
                                      []),
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.regularTextStyle
                                      .copyWith(
                                          color: AppColors.grey6,
                                          fontSize: 12.0.sp),
                                )),
                              ]),
                              SizedBox(height: 12.h),
                              Text(
                                controller.data.value.user?.companyProfile
                                        ?.about ??
                                    "",
                                style: AppTextStyles.regularTextStyle.copyWith(
                                    color: AppColors.hintTextInput,
                                    fontSize: 14.0.sp),
                              ),
                              SizedBox(height: 17.h),
                              MyOutlinedButton(
                                width: ScreenUtil().screenWidth,
                                onPressed: () {
                                  Get.toNamed(AppRoutes.viewRealEstateUser,
                                      arguments: {
                                        "isSort": false,
                                        "userId": controller.data.value.userId
                                      });
                                },
                                height: 48.0.h,
                                borderRadius: BorderRadius.circular(6.0.r),
                                child: Text(LangKeys.viewRealEstateBroker.tr,
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            fontSize: 17.0.sp,
                                            color: AppColors.primary)),
                              ),
                              SizedBox(height: 15.h),
                              Divider(
                                height: 0,
                                thickness: 0.5.h,
                                color: AppColors.grey7,
                              ),
                              SizedBox(height: 7.h),
                            ],
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LangKeys.backgroundInformation.tr,
                            style: AppTextStyles.semiBoldTextStyle.copyWith(
                                color: Colors.black, fontSize: 14.0.sp),
                          ),
                          SizedBox(height: 13.h),
                          Row(children: [
                            Text(
                              "${LangKeys.propertyReference.tr} :",
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: Colors.black, fontSize: 14.0.sp),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                                child: Text(
                              // "${controller.data.value.category?.name ?? ""} - ${controller.data.value.subCategory?.name ?? ""}",
                              controller.data.value.uid ?? "",
                              textAlign: TextAlign.start,
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: AppColors.text20, fontSize: 12.0.sp),
                            )),
                          ]),
                          SizedBox(height: 18.h),
                          Row(children: [
                            Text(
                              "${LangKeys.datePublication.tr} :",
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: Colors.black, fontSize: 14.0.sp),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                                child: Text(
                              // "${controller.data.value.category?.name ?? ""} - ${controller.data.value.subCategory?.name ?? ""}",
                              controller.data.value.createdAt ?? "",
                              textAlign: TextAlign.start,
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: AppColors.text20, fontSize: 12.0.sp),
                            )),
                          ]),
                          Visibility(
                              visible: controller.data.value.user != null &&
                                  controller.data.value.user!.companyProfile !=
                                      null &&
                                  controller.data.value.user!.companyProfile!
                                          .statusKey ==
                                      "approved",
                              child: Column(
                                children: [
                                  SizedBox(height: 18.h),
                                  Row(children: [
                                    Text(
                                      "${LangKeys.brokerNumberOrn.tr} :",
                                      style: AppTextStyles.semiBoldTextStyle
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14.0.sp),
                                    ),
                                    SizedBox(width: 3.w),
                                    Expanded(
                                        child: Text(
                                      controller.data.value.user?.companyProfile
                                              ?.brokerOrnNumber ??
                                          "",
                                      textAlign: TextAlign.start,
                                      style: AppTextStyles.regularTextStyle
                                          .copyWith(
                                              color: AppColors.text20,
                                              fontSize: 12.0.sp),
                                    )),
                                  ]),
                                ],
                              )),
                          Visibility(
                              visible: controller.data.value.user != null &&
                                  controller.data.value.user!.companyProfile !=
                                      null &&
                                  controller.data.value.user!.companyProfile!
                                          .statusKey ==
                                      "approved",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 18.h),
                                  Text(
                                    "${LangKeys.brokerNumberWithTheRealEstate.tr} :",
                                    style: AppTextStyles.semiBoldTextStyle
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 14.0.sp),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    controller.data.value.user?.companyProfile
                                            ?.brokerNumberRegulatoryAuthority ??
                                        "",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color: AppColors.text20,
                                            fontSize: 12.0.sp),
                                  )
                                ],
                              )),
                          SizedBox(height: 18.h),
                          Row(children: [
                            Text(
                              "${LangKeys.landDepartmentPermitNumber.tr} :",
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: Colors.black, fontSize: 14.0.sp),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                                child: Text(
                              controller.data.value.permitNumber ?? "",
                              textAlign: TextAlign.start,
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: AppColors.text20, fontSize: 12.0.sp),
                            )),
                          ]),
                        ],
                      ),
                      SizedBox(height: 38.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LangKeys.contactAdvertiser.tr,
                            style: AppTextStyles.mediumTextStyle.copyWith(
                                color: Colors.black, fontSize: 16.0.sp),
                          ),

                          SizedBox(height: 13.h),
                          // Divider(
                          //   height: 0,
                          //   thickness: 0.5.h,
                          //   color: AppColors.grey7,
                          // ),
                          // SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                      onTap: () {
                                        if (controller.storage.isAuth()) {
                                          controller.launchWhatsApp(controller
                                                  .data.value.user?.mobile ??
                                              "");
                                        } else {
                                          confirmBottomSheet();
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsetsDirectional.only(
                                            start: 11.w,
                                            top: 5.h,
                                            bottom: 5.h,
                                            end: 11.w),
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.50.w,
                                                color: AppColors.grey9),
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                Utils.getIconPath(
                                                    "ic_whatsapp2"),
                                                width: 18.w,
                                                height: 18.h),
                                            SizedBox(width: 10.w),
                                            Text(
                                              controller
                                                      .data.value.whatsappCount
                                                      .toString() ??
                                                  "0",
                                              style: AppTextStyles
                                                  .mediumTextStyle
                                                  .copyWith(
                                                      color: AppColors.grey9,
                                                      fontSize: 14.0.sp),
                                            ),
                                          ],
                                        ),
                                      ))),
                              SizedBox(width: 22.w),
                              Expanded(
                                  child: InkWell(
                                      onTap: () {
                                        if (controller.storage.isAuth()) {
                                          Get.toNamed(AppRoutes.contactBroker,
                                              arguments: {
                                                "data": controller.data.value
                                              });
                                        } else {
                                          confirmBottomSheet();
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsetsDirectional.only(
                                            start: 11.w,
                                            top: 5.h,
                                            bottom: 5.h,
                                            end: 11.w),
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.50.w,
                                                color: AppColors.grey9),
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                Utils.getIconPath("ic_email3"),
                                                width: 18.w,
                                                height: 18.h),
                                            SizedBox(width: 10.w),
                                            Text(
                                              controller.data.value.emailCount
                                                      .toString() ??
                                                  "0",
                                              style: AppTextStyles
                                                  .mediumTextStyle
                                                  .copyWith(
                                                      color: AppColors.grey9,
                                                      fontSize: 14.0.sp),
                                            ),
                                          ],
                                        ),
                                      ))),
                              SizedBox(width: 22.w),
                              Expanded(
                                  child: InkWell(
                                      onTap: () {
                                        if (controller.storage.isAuth()) {
                                          controller.makePhoneCall(controller
                                                  .data.value.user?.mobile ??
                                              "");
                                        } else {
                                          confirmBottomSheet();
                                        }
                                      },
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        padding: EdgeInsetsDirectional.only(
                                            start: 11.w,
                                            top: 5.h,
                                            bottom: 5.h,
                                            end: 11.w),
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.50.w,
                                                color: AppColors.grey9),
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                Utils.getIconPath("ic_call2"),
                                                width: 18.w,
                                                height: 18.h),
                                            SizedBox(width: 10.w),
                                            Text(
                                              controller.data.value.callsCount
                                                      .toString() ??
                                                  "0",
                                              style: AppTextStyles
                                                  .mediumTextStyle
                                                  .copyWith(
                                                      color: AppColors.grey9,
                                                      fontSize: 14.0.sp),
                                            ),
                                          ],
                                        ),
                                      )))
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     InkWell(
                          //         onTap: () {
                          //           if (controller.storage.isAuth()) {
                          //             controller.makePhoneCall(
                          //                 controller.data.value.user?.mobile ??
                          //                     "");
                          //           } else {
                          //             confirmBottomSheet();
                          //           }
                          //         },
                          //         child: SvgPicture.asset(
                          //             Utils.getIconPath("ic_call"),
                          //             width: 30.w,
                          //             height: 30.w)),
                          //     SizedBox(width: 12.w),
                          //     InkWell(
                          //         onTap: () {
                          //           if (controller.storage.isAuth()) {
                          //             Get.toNamed(AppRoutes.contactBroker,
                          //                 arguments: {
                          //                   "data": controller.data.value
                          //                 });
                          //           } else {
                          //             confirmBottomSheet();
                          //           }
                          //         },
                          //         child: SvgPicture.asset(
                          //             Utils.getIconPath("ic_email_2"),
                          //             width: 30.w,
                          //             height: 30.w)),
                          //     SizedBox(width: 12.w),
                          //     InkWell(
                          //         onTap: () {
                          //           if (controller.storage.isAuth()) {
                          //             controller.launchWhatsApp(
                          //                 controller.data.value.user?.mobile ??
                          //                     "");
                          //           } else {
                          //             confirmBottomSheet();
                          //           }
                          //         },
                          //         child: SvgPicture.asset(
                          //             Utils.getIconPath("ic_whatsapp"),
                          //             width: 30.w,
                          //             height: 30.w)),
                          //   ],
                          // )
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
