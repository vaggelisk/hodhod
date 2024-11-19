import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/view_real_estate_user/controller/view_real_estate_user_controller.dart';

class ItemRealEstateUser extends StatelessWidget {
  final RealEstates data;
  final VoidCallback onTap;

  const ItemRealEstateUser({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    topRight: Radius.circular(4.r)),
                child: displayImageFromNetwork(data.image ?? "",
                    BoxFit.fitWidth, ScreenUtil().screenWidth, 193.h, 0.r),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 10.w, end: 10.w, top: 6.h),
                child: Row(
                  children: [
                    Visibility(
                        visible: data.user != null &&
                            data.user!.companyProfile != null &&
                            data.user!.companyProfile!.statusKey == "approved",
                        child: SvgPicture.asset(
                            Utils.getIconPath("ic_check_ver"),
                            width: 24.w,
                            height: 24.h)),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          if (Get.find<ViewRealEstateUserController>()
                              .storage
                              .isAuth()) {
                            Get.find<ViewRealEstateUserController>()
                                .addOrRemoveFavorite(
                                    data.id ?? 0, data.isFavorite ?? false);
                          } else {
                            confirmBottomSheet();
                          }
                        },
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          padding: EdgeInsetsDirectional.all(4.r),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.20),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            Utils.getIconPath(data.isFavorite == true
                                ? "ic_fav"
                                : "ic_un_fav"),
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsetsDirectional.only(
                start: 10.w, end: 10.w, top: 10.h, bottom: 8.h),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: HexColor("D2D2D2"), width: 0.5.w),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(4.r),
                    bottomLeft: Radius.circular(4.r))),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(data.title ?? "",
                          style: AppTextStyles.semiBoldTextStyle.copyWith(
                              color: AppColors.text18, fontSize: 14.sp)),
                    ),
                    Text(
                      "${Utils.formatPrice(data.price ?? "0")} ${data.currency?.name ?? ""}",
                      style: AppTextStyles.semiBoldTextStyle.copyWith(
                          color: AppColors.primary, fontSize: 16.0.sp),
                    )
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Utils.getIconPath("ic_location_real"),
                      width: 24.0.w,
                      height: 24.0.h,
                    ),
                    SizedBox(width: 8.h),
                    Expanded(
                      child: Text(
                        data.address ?? "",
                        style: AppTextStyles.regularTextStyle.copyWith(
                            color: HexColor("747474"),
                            fontSize: 14.0.sp,
                            height: 1.5.h),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  children: [
                    // Expanded(
                    //     child: Row(
                    //   children: [
                    //     SvgPicture.asset(Utils.getIconPath("ic_bedroom"),
                    //         width: 14.w, height: 14.h),
                    //     SizedBox(width: 4.w),
                    //     Text(
                    //       "${data.numberOfRooms ?? "0"} غرف",
                    //       style: AppTextStyles.regularTextStyle.copyWith(
                    //           color: HexColor("A9A9A9"), fontSize: 12.0.sp),
                    //     )
                    //   ],
                    // )),
                    // SizedBox(width: 8.w),
                    // Expanded(
                    //     child: Row(
                    //   children: [
                    //     SvgPicture.asset(Utils.getIconPath("ic_bathroom"),
                    //         width: 14.w, height: 14.h),
                    //     SizedBox(width: 4.w),
                    //     Text(
                    //       "${data.numberOfBathrooms ?? "0"} حمام",
                    //       style: AppTextStyles.regularTextStyle.copyWith(
                    //           color: HexColor("A9A9A9"), fontSize: 12.0.sp),
                    //     )
                    //   ],
                    // )),
                    // SizedBox(width: 8.w),
                    Expanded(
                        child: Row(
                      children: [
                        SvgPicture.asset(Utils.getIconPath("ic_building"),
                            width: 14.w, height: 14.h),
                        SizedBox(width: 4.w),
                        Expanded(
                            child: Text(
                          data.type ?? "",
                          style: AppTextStyles.regularTextStyle.copyWith(
                              color: HexColor("A9A9A9"), fontSize: 12.0.sp),
                        ))
                      ],
                    )),
                    SizedBox(width: 8.w),
                    Expanded(
                        child: Row(
                      children: [
                        SvgPicture.asset(Utils.getIconPath("ic_building_2"),
                            width: 14.w, height: 14.h),
                        SizedBox(width: 4.w),
                        Expanded(
                            child: Text(
                          data.realEstateStatus ?? "",
                          style: AppTextStyles.regularTextStyle.copyWith(
                              color: HexColor("A9A9A9"), fontSize: 12.0.sp),
                        ))
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 15.h),
                Divider(
                  height: 0,
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 20.0.r,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: data.user?.image ?? "",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            )),
                        SizedBox(width: 8.w),
                        Text(
                          data.user?.name ?? "",
                          style: AppTextStyles.mediumTextStyle.copyWith(
                              color: HexColor("696969"), fontSize: 12.0.sp),
                        )
                      ],
                    ),
                    // Expanded(
                    //     child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     InkWell(
                    //         onTap: () {
                    //           if (Get.find<ViewRealEstateUserController>()
                    //               .storage
                    //               .isAuth()) {
                    //             Get.find<ViewRealEstateUserController>()
                    //                 .makePhoneCall(
                    //                     data.user?.mobile ?? "", data.id ?? 0);
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
                    //           if (Get.find<ViewRealEstateUserController>()
                    //               .storage
                    //               .isAuth()) {
                    //             Get.toNamed(AppRoutes.contactBroker,
                    //                 arguments: {"data": data});
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
                    //           if (Get.find<ViewRealEstateUserController>()
                    //               .storage
                    //               .isAuth()) {
                    //             Get.find<ViewRealEstateUserController>()
                    //                 .launchWhatsApp(
                    //                     data.user?.mobile ?? "", data.id ?? 0);
                    //           } else {
                    //             confirmBottomSheet();
                    //           }
                    //         },
                    //         child: SvgPicture.asset(
                    //             Utils.getIconPath("ic_whatsapp"),
                    //             width: 30.w,
                    //             height: 30.w)),
                    //   ],
                    // ))
                  ],
                ),
                SizedBox(height: 10.h),
                Divider(
                  height: 0,
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              if (Get.find<ViewRealEstateUserController>()
                                  .storage
                                  .isAuth()) {
                                Get.find<ViewRealEstateUserController>()
                                    .launchWhatsApp(
                                        data.user?.mobile ?? "", data.id ?? 0);
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
                                      width: 0.50.w, color: AppColors.grey9),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      Utils.getIconPath("ic_whatsapp2"),
                                      width: 18.w,
                                      height: 18.h),
                                  SizedBox(width: 10.w),
                                  Text(
                                    data.whatsappCount.toString() ?? "0",
                                    style: AppTextStyles.mediumTextStyle
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
                              if (Get.find<ViewRealEstateUserController>()
                                  .storage
                                  .isAuth()) {
                                Get.toNamed(AppRoutes.contactBroker,
                                    arguments: {"data": data});
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
                                      width: 0.50.w, color: AppColors.grey9),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      Utils.getIconPath("ic_email3"),
                                      width: 18.w,
                                      height: 18.h),
                                  SizedBox(width: 10.w),
                                  Text(
                                    data.emailCount.toString() ?? "0",
                                    style: AppTextStyles.mediumTextStyle
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
                              if (Get.find<ViewRealEstateUserController>()
                                  .storage
                                  .isAuth()) {
                                Get.find<ViewRealEstateUserController>()
                                    .makePhoneCall(
                                        data.user?.mobile ?? "", data.id ?? 0);
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
                                      width: 0.50.w, color: AppColors.grey9),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      Utils.getIconPath("ic_call2"),
                                      width: 18.w,
                                      height: 18.h),
                                  SizedBox(width: 10.w),
                                  Text(
                                    data.callsCount.toString() ?? "0",
                                    style: AppTextStyles.mediumTextStyle
                                        .copyWith(
                                            color: AppColors.grey9,
                                            fontSize: 14.0.sp),
                                  ),
                                ],
                              ),
                            )))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 22.h)
        ],
      ),
    );
  }
}
