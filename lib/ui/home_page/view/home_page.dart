import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/empty_status_view.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/home/controller/home_controller.dart';
import 'package:hodhod/ui/home_page/controller/home_page_controller.dart';
import 'package:hodhod/ui/home_page/view/shimmer_ads_list.dart';
import 'package:hodhod/ui/home_page/view/widget/item_home_ads.dart';
import 'package:hodhod/ui/home_page/view/widget/item_home_real_estate.dart';
import 'package:hodhod/ui/public_controller.dart';
import 'package:hodhod/ui/shimmer_list.dart';

import 'widget/item_home_famous_real_estate.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          GetBuilder<HomePageController>(
            id: "updateInfo",
            builder: (controller) {
              return Container(
                  margin: EdgeInsetsDirectional.only(
                      start: 16.w, end: 16.w, bottom: 28.h, top: 13.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if (controller.storage.isAuth()) {
                            Get.toNamed(AppRoutes.profile);
                          } else {
                            confirmBottomSheet();
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.user?.image != null &&
                                    controller.user?.image != ""
                                ? CircleAvatar(
                                    radius: 24.r,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                        controller.user?.image ?? ""),
                                  )
                                : const SizedBox(),
                            SizedBox(width: 14.w),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LangKeys.welcome.tr,
                                  style: AppTextStyles.mediumTextStyle.copyWith(
                                      color: HexColor("AEAEAE"),
                                      fontSize: 16.0.sp),
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    Text(
                                      controller.user?.name ?? "",
                                      style: AppTextStyles.semiBoldTextStyle
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14.0.sp),
                                    ),
                                    controller.companyProfile != null &&
                                            controller.companyProfile != null &&
                                            controller.companyProfile!
                                                    .statusKey ==
                                                "approved"
                                        ? Row(
                                            children: [
                                              SizedBox(width: 8.w),
                                              SvgPicture.asset(
                                                  Utils.getIconPath(
                                                      "ic_check_blue"),
                                                  width: 16.w,
                                                  height: 16.h)
                                            ],
                                          )
                                        : SizedBox()
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(width: 14),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 50.w,
                        height: 50.h,
                        alignment: AlignmentDirectional.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            IconButton(
                                icon: SvgPicture.asset(
                                    Utils.getIconPath("ic_bell"),
                                    width: 24.w,
                                    height: 24.h),
                                onPressed: () {
                                  if (controller.storage.isAuth()) {
                                    Get.toNamed(AppRoutes.notifications);
                                  } else {
                                    confirmBottomSheet();
                                  }
                                }),
                            Obx(() =>
                                Get.find<PublicController>().notCount.value != 0
                                    ? PositionedDirectional(
                                        start: 9.w,
                                        top: 5.h,
                                        child: Container(
                                          padding: EdgeInsets.all(2.r),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: HexColor("F3F3F3"),
                                              width: 1.0.w,
                                            ),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 14.w,
                                            minHeight: 14.h,
                                          ),
                                          child: Text(
                                            '${Get.find<PublicController>().notCount.value}',
                                            style: AppTextStyles
                                                .semiBoldTextStyle
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 10.0.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : SizedBox())
                          ],
                        ),
                      ),
                    ],
                  ));
            },
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                start: 16.w, end: 16.w, bottom: 17.h),
            child: TextFormField(
                // controller: controller.dateRange,
                readOnly: true,
                onTap: () {
                  Get.toNamed(AppRoutes.search);
                },
                keyboardType: TextInputType.text,
                style: AppTextStyles.regularTextStyle
                    .copyWith(fontSize: 14.0.sp, color: Colors.black),
                decoration: CommonStyle.textFieldSearchStyle(
                        hintTextStr: LangKeys.searchHere.tr)
                    .copyWith(
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child:
                              SvgPicture.asset(Utils.getIconPath("ic_search")),
                        ),
                        suffixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child:
                              SvgPicture.asset(Utils.getIconPath("ic_filter")),
                        ))),
          ),
          Expanded(
              child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getHome();
                  },
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: GetBuilder<HomePageController>(
                        id: 'updateHome',
                        builder: (controller) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.isLoadingHome.isTrue
                                  ? const ShimmerAdsList()
                                  : controller.adsList.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 16.w,
                                              end: 16.w,
                                              bottom: 21.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                LangKeys.trustedCompanies.tr,
                                                style: AppTextStyles
                                                    .semiBoldTextStyle
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 16.0.sp),
                                              ),
                                              SizedBox(height: 12.h),
                                              SizedBox(
                                                height: 140.h,
                                                child: ListView.builder(
                                                    itemCount: controller
                                                        .adsList.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ItemHomeAds(
                                                          data: controller
                                                              .adsList[index],
                                                          onTap: () {
                                                            Get.toNamed(
                                                                AppRoutes
                                                                    .viewRealEstateUser,
                                                                arguments: {
                                                                  "isSort":
                                                                      false,
                                                                  "userId": controller
                                                                      .adsList[
                                                                          index]
                                                                      .userId
                                                                });
                                                          });
                                                    }),
                                              )
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                              // controller.isLoadingHome.isTrue
                              //     ? ShimmerCatList()
                              //     : controller.categoriesList.isNotEmpty
                              //         ? Padding(
                              //             padding: EdgeInsetsDirectional.only(
                              //                 start: 16.w,
                              //                 end: 16.w,
                              //                 bottom: 10.h),
                              //             child: SizedBox(
                              //               height: 85.h,
                              //               child: ListView.builder(
                              //                   itemCount: controller
                              //                       .categoriesList.length,
                              //                   scrollDirection:
                              //                       Axis.horizontal,
                              //                   itemBuilder: (context, index) {
                              //                     return ItemHomeCategory(
                              //                         data: controller
                              //                                 .categoriesList[
                              //                             index],
                              //                         selectId: index,
                              //                         onTap: () {});
                              //                   }),
                              //             ),
                              //           )
                              //         : const SizedBox(),
                              controller.isLoadingHome.isTrue
                                  ? SizedBox(
                                      width: ScreenUtil().screenWidth,
                                      height: 250.h,
                                      child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.all(10.r),
                                          child: ShimmerList(size: 2)))
                                  : controller
                                          .realEstatesFinancierList.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 16.w,
                                              end: 16.w,
                                              bottom: 0.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    LangKeys.featured.tr,
                                                    style: AppTextStyles
                                                        .semiBoldTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 16.0.sp),
                                                  )),
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            AppRoutes
                                                                .viewRealEstateUser,
                                                            arguments: {
                                                              "isSort": true,
                                                              "financing": true,
                                                              "userId": "0",
                                                              "sortKey":
                                                                  "most_requested",
                                                              "title": "المميزة"
                                                            });
                                                      },
                                                      child: Text(
                                                        LangKeys.viewAll.tr,
                                                        style: AppTextStyles
                                                            .regularTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bgSplash,
                                                                fontSize:
                                                                    14.0.sp,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(height: 12.h),
                                              ListView.builder(
                                                  itemCount: controller
                                                      .realEstatesFinancierList
                                                      .length,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ItemHomeRealEstate(
                                                        data: controller
                                                                .realEstatesFinancierList[
                                                            index],
                                                        onTap: () {
                                                          Get.toNamed(
                                                              AppRoutes
                                                                  .realStateDetails,
                                                              arguments: {
                                                                "id": controller
                                                                    .realEstatesFinancierList[
                                                                        index]
                                                                    .id
                                                              });
                                                        });
                                                  })
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                              controller.isLoadingHome.isTrue
                                  ? SizedBox(
                                      width: ScreenUtil().screenWidth,
                                      height: 250.h,
                                      child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.all(10.r),
                                          child: ShimmerList(size: 2)))
                                  : controller.realEstatesMostRequestedList
                                          .isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 16.w,
                                              end: 16.w,
                                              bottom: 0.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    LangKeys.mostWanted.tr,
                                                    style: AppTextStyles
                                                        .semiBoldTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 16.0.sp),
                                                  )),
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            AppRoutes
                                                                .viewRealEstateUser,
                                                            arguments: {
                                                              "isSort": true,
                                                              "userId": "0",
                                                              "sortKey":
                                                                  "most_requested",
                                                              "title": LangKeys
                                                                  .mostWanted.tr
                                                            });
                                                      },
                                                      child: Text(
                                                        LangKeys.viewAll.tr,
                                                        style: AppTextStyles
                                                            .regularTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bgSplash,
                                                                fontSize:
                                                                    14.0.sp,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(height: 12.h),
                                              ListView.builder(
                                                  itemCount: controller
                                                      .realEstatesMostRequestedList
                                                      .length,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ItemHomeRealEstate(
                                                        data: controller
                                                                .realEstatesMostRequestedList[
                                                            index],
                                                        onTap: () {
                                                          Get.toNamed(
                                                              AppRoutes
                                                                  .realStateDetails,
                                                              arguments: {
                                                                "id": controller
                                                                    .realEstatesMostRequestedList[
                                                                        index]
                                                                    .id
                                                              });
                                                        });
                                                  })
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                              controller.isLoadingHome.isTrue
                                  ? SizedBox(
                                      width: ScreenUtil().screenWidth,
                                      height: 130.h,
                                      child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.all(10.r),
                                          child: ShimmerList()))
                                  : controller
                                          .realEstatesMostViewedList.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 16.w,
                                              end: 16.w,
                                              bottom: 10.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    LangKeys.famous.tr,
                                                    style: AppTextStyles
                                                        .semiBoldTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 16.0.sp),
                                                  )),
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            AppRoutes
                                                                .viewRealEstateUser,
                                                            arguments: {
                                                              "isSort": true,
                                                              "userId": "0",
                                                              "sortKey":
                                                                  "most_viewed",
                                                              "title": LangKeys
                                                                  .famous.tr
                                                            });
                                                      },
                                                      child: Text(
                                                        LangKeys.viewAll.tr,
                                                        style: AppTextStyles
                                                            .regularTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bgSplash,
                                                                fontSize:
                                                                    14.0.sp,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(height: 12.h),
                                              SizedBox(
                                                height: 180.h,
                                                child: ListView.builder(
                                                    itemCount: controller
                                                        .realEstatesMostViewedList
                                                        .length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ItemHomeFamousRealEstate(
                                                          data: controller
                                                                  .realEstatesMostViewedList[
                                                              index],
                                                          onTap: () {
                                                            Get.toNamed(
                                                                AppRoutes
                                                                    .realStateDetails,
                                                                arguments: {
                                                                  "id": controller
                                                                      .realEstatesMostRequestedList[
                                                                          index]
                                                                      .id
                                                                });
                                                          });
                                                    }),
                                              )
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),

                              controller.realEstatesMostViewedList.isEmpty &&
                                      controller.realEstatesMostRequestedList
                                          .isEmpty &&
                                      controller
                                          .realEstatesFinancierList.isEmpty
                                  ? SizedBox(
                                      height: ScreenUtil().screenHeight / 2,
                                      child: EmptyStatusView(
                                        img: "ic_no_real_estate",
                                        msg: LangKeys
                                            .noRealEstateAvailableMsg.tr,
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          );
                        },
                      ))))
        ],
      ),
    );
  }
}
