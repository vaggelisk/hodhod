import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/home_page/controller/home_page_controller.dart';
import 'package:intl/intl.dart';

class ItemHomeRealEstate extends StatelessWidget {
  final RealEstates data;
  final VoidCallback onTap;

  const ItemHomeRealEstate({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsetsDirectional.only(
                start: 11.0.w, end: 7.w, bottom: 15.0.h, top: 16.0.h),
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: AppColors.grey2, width: 0.5.w),
                borderRadius: BorderRadius.all(Radius.circular(4.0.r))),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 96.w,
                      height: 96.h,
                      child: displayImageFromNetwork(
                          data.image ?? "", BoxFit.cover, 96.w, 96.h, 6.r),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data.title ?? "",
                                  maxLines: 1,
                                  style: AppTextStyles.semiBoldTextStyle
                                      .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: 15.0.sp),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    if (Get.find<HomePageController>()
                                        .storage
                                        .isAuth()) {
                                      Get.find<HomePageController>()
                                          .addOrRemoveFavorite(data.id ?? 0,
                                              data.isFavorite ?? false);
                                    } else {
                                      confirmBottomSheet();
                                    }
                                  },
                                  child: SvgPicture.asset(
                                      Utils.getIconPath(data.isFavorite == true
                                          ? "ic_fav"
                                          : "ic_un_fav"),
                                      width: 24.0.w,
                                      height: 24.0.h)),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        Utils.getIconPath("ic_user_real"),
                                        width: 16.0.w,
                                        height: 16.0.h),
                                    SizedBox(width: 8.h),
                                    Expanded(
                                      child: Text(
                                        data.user?.name ?? "",
                                        maxLines: 1,
                                        style: AppTextStyles.mediumTextStyle
                                            .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 13.0.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        Utils.getIconPath("ic_location_real"),
                                        width: 16.0.w,
                                        height: 16.0.h),
                                    SizedBox(width: 8.h),
                                    Expanded(
                                      child: Text(
                                        data.country?.name ?? "",
                                        maxLines: 1,
                                        style: AppTextStyles.mediumTextStyle
                                            .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 13.0.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 13.h),
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  SvgPicture.asset(
                                      Utils.getIconPath("ic_calender_real"),
                                      width: 16.0.w,
                                      height: 16.0.h),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                        Utils.convertDateFormat(
                                            data.createdAt ?? "",
                                            "yyyy-mm-dd",
                                            "dd/mm/yyyy"),
                                        maxLines: 1,
                                        style: AppTextStyles.mediumTextStyle
                                            .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 13.0.sp)),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                children: [
                                  SvgPicture.asset(
                                      Utils.getIconPath("ic_price_real"),
                                      width: 16.0.w,
                                      height: 16.0.h),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                        "${Utils.formatPrice(data.price ?? "0")} ${data.currency?.name ?? ""}",
                                        maxLines: 1,
                                        style: AppTextStyles.mediumTextStyle
                                            .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 13.0.sp)),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 13.h),
                Divider(
                  height: 0,
                  thickness: 0.5.h,
                  color: AppColors.grey7,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 11.w, top: 5.h, bottom: 5.h, end: 11.w),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50.w, color: AppColors.grey9),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Utils.getIconPath("ic_whatsapp2"),
                              width: 18.w, height: 18.h),
                          SizedBox(width: 10.w),
                          Text(
                            data.whatsappCount.toString() ?? "0",
                            style: AppTextStyles.mediumTextStyle.copyWith(
                                color: AppColors.grey9, fontSize: 14.0.sp),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(width: 22.w),
                    Expanded(
                        child: Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 11.w, top: 5.h, bottom: 5.h, end: 11.w),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50.w, color: AppColors.grey9),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Utils.getIconPath("ic_email3"),
                              width: 18.w, height: 18.h),
                          SizedBox(width: 10.w),
                          Text(
                            data.emailCount.toString() ?? "0",
                            style: AppTextStyles.mediumTextStyle.copyWith(
                                color: AppColors.grey9, fontSize: 14.0.sp),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(width: 22.w),
                    Expanded(
                        child: Container(
                      alignment: AlignmentDirectional.center,
                      padding: EdgeInsetsDirectional.only(
                          start: 11.w, top: 5.h, bottom: 5.h, end: 11.w),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50.w, color: AppColors.grey9),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Utils.getIconPath("ic_call2"),
                              width: 18.w, height: 18.h),
                          SizedBox(width: 10.w),
                          Text(
                            data.callsCount.toString() ?? "0",
                            style: AppTextStyles.mediumTextStyle.copyWith(
                                color: AppColors.grey9, fontSize: 14.0.sp),
                          ),
                        ],
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h)
      ],
    );
  }
}
