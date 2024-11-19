import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/finance/finance.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/home_page/controller/home_page_controller.dart';
import 'package:hodhod/ui/real_estate_financing/controller/real_estate_financing_controller.dart';

class ItemFinancing extends StatelessWidget {
  final Finance? data;
  final VoidCallback onTap;
  bool isFree;
  int selectedIndex = -1;
  int index = 0;

  ItemFinancing({
    super.key,
    required this.data,
    required this.isFree,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: isFree != true ? 20.w : 0),
      padding: EdgeInsetsDirectional.only(
          start: 11.0.w, end: 7.w, bottom: 15.0.h, top: 16.0.h),
      height: 200.h,
      width: isFree == true
          ? ScreenUtil().screenWidth - 35.w
          : ScreenUtil().screenWidth / 2,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: HexColor("CACACA"), width: 0.7.w),
          borderRadius: BorderRadius.all(Radius.circular(6.0.r))),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 6.h),
            Text(
              data?.type.toString() ?? "0",
              style: AppTextStyles.boldTextStyle
                  .copyWith(color: Colors.black, fontSize: 16.0.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              "${data?.days.toString() ?? "0"} ${LangKeys.day.tr}",
              style: AppTextStyles.mediumTextStyle
                  .copyWith(color: Colors.black, fontSize: 14.0.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              "${data?.cost.toString() ?? "0"} ${data?.currency?.name ?? ""} ",
              style: AppTextStyles.mediumTextStyle
                  .copyWith(color: Colors.black, fontSize: 14.0.sp),
            ),
            SizedBox(height: 16.h),
            Image.asset(
                Utils.getImagePath(
                    selectedIndex == index ? "ic_radio_selected" : "ic_radio"),
                width: 24.w,
                height: 24.h)
          ],
        ),
      ),
    );
  }
}
