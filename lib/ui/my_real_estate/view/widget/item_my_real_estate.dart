import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/components/my_outlined_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/my_real_estate/controller/my_real_estate_controller.dart';

class ItemMyRealEstate extends StatelessWidget {
  final RealEstates data;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ItemMyRealEstate({
    super.key,
    required this.data,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsetsDirectional.only(
                start: 11.0.w, end: 7.w, bottom: 15.0.h, top: 13.0.h),
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.grey2, width: 0.5.w),
                borderRadius: BorderRadius.all(Radius.circular(4.0.r))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 96.w,
                  height: 125.h,
                  child: displayImageFromNetwork(
                      data.image ?? "", BoxFit.cover, 96.w, 125.h, 6.r),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.title ?? "",
                              maxLines: 1,
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontSize: 15.0.sp),
                            ),
                          ),
                          InkWell(
                              onTap: onEdit,
                              child: SvgPicture.asset(
                                  Utils.getIconPath("ic_edit_property"),
                                  width: 28.0.w,
                                  height: 28.0.h)),
                          SizedBox(width: 8.w),
                          InkWell(
                              onTap: onDelete,
                              child: SvgPicture.asset(
                                  Utils.getIconPath("ic_delete_property"),
                                  width: 28.0.w,
                                  height: 28.0.h)),
                        ],
                      ),
                      SizedBox(height: 7.h),
                      Row(
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
                              style: AppTextStyles.mediumTextStyle.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontSize: 13.0.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        children: [
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
                          )),
                          Visibility(
                              visible: data.finance == false,
                              child: InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.realEstateFinancing,
                                        arguments: {"data": data});
                                  },

                                  child: Container(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 12.w,
                                          end: 12.w,
                                          top: 2.h,
                                          bottom: 2.h),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: AppColors.primary,
                                              width: 0.3.w),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.0.r))),
                                      height: 26.h,
                                      child: Text(
                                          LangKeys.sponsoredAdvertisement.tr,
                                          style: AppTextStyles.mediumTextStyle
                                              .copyWith(
                                                  fontSize: 10.0.sp,
                                                  color: AppColors.primary,
                                                  height: 0.h))))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(data.typeStatus ?? "",
                                  maxLines: 1,
                                  style: AppTextStyles.mediumTextStyle.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                      fontSize: 14.0.sp))),
                          Transform.scale(
                            scale: 0.7,
                            child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Switch(
                                  value: data.typeStatusKey == "available"
                                      ? true
                                      : false,
                                  activeColor: Colors.white,
                                  activeTrackColor: HexColor("1DC9A0"),
                                  inactiveTrackColor: HexColor("D1D1D6"),
                                  inactiveThumbColor: Colors.white,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (bool value1) {
                                    Get.find<MyRealEstateController>()
                                        .changeStatus(data.id ?? 0,
                                            data.typeStatusKey ?? "");
                                  },
                                )),
                          ),
                          // Switch(
                          //     value: false,
                          //     activeColor: Colors.white,
                          //     activeTrackColor: HexColor("1DC9A0"),
                          //     inactiveTrackColor: HexColor("D1D1D6"),
                          //     inactiveThumbColor: Colors.white,
                          //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //     onChanged: (value) {})
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h)
      ],
    );
  }
}
