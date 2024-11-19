import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/categories/categories.dart';

class ItemHomeCategory extends StatelessWidget {
  final Categories data;
  int selectId;
  final VoidCallback onTap;

  ItemHomeCategory({
    super.key,
    required this.data,
    required this.selectId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 90.w,
            height: 80.h,
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsetsDirectional.only(
                start: 7.w, end: 7.w, top: 9.h, bottom: 9.h),
            margin: EdgeInsetsDirectional.only(end: 20.w),
            decoration: BoxDecoration(
              color: selectId == 0 ? Colors.white : Colors.white,
              border: Border.all(
                  width: selectId == 0 ? 0.8.w : 0.1.w,
                  color: AppColors.bgSplash),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3FB6A15E),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                displayImageFromNetwork(
                    data.image ?? "", BoxFit.none, 28.0.w, 28.0.h, 0),
                SizedBox(height: 10.h),
                Text(
                  data.name ?? "",
                  maxLines: 1,
                  style: AppTextStyles.mediumTextStyle.copyWith(
                      fontSize: 13.sp,
                      overflow: TextOverflow.ellipsis,
                      color: selectId == 0
                          ? AppColors.bgSplash
                          : AppColors.bgSplash),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
