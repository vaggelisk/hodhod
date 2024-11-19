import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/data/models/home/ad.dart';

class ItemHomeAds extends StatelessWidget {
  final Ad data;
  final VoidCallback onTap;

  const ItemHomeAds({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 292.w,
          margin: EdgeInsetsDirectional.only(end: 22.w),
          child: Stack(
            children: [
              displayImageFromNetwork(
                  data.image ?? "", BoxFit.fitWidth, 292.w, 138.h, 12.r),
              Container(
                width: 292.w,
                height: 138.h,
                padding: EdgeInsetsDirectional.only(top: 12.h, start: 16.w),
                decoration: BoxDecoration(
                    // color: HexColor("/").withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.black.withOpacity(0.70),
                        Colors.black.withOpacity(0.60),
                        Colors.black.withOpacity(0.19),
                        Colors.black.withOpacity(0.0),
                      ],
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title ?? "",
                      style: AppTextStyles.semiBoldTextStyle
                          .copyWith(color: Colors.white, fontSize: 19.0.sp),
                    ),
                    SizedBox(height: 9.h),
                    Text(
                      data.description ?? "",
                      style: AppTextStyles.mediumTextStyle.copyWith(
                          color: HexColor("F9F9F9"), fontSize: 15.0.sp),
                    ),
                    SizedBox(height: 16.h),
                    Visibility(
                        visible: data.userId != null && data.userId != "",
                        child: PrimaryButton(
                          width: ScreenUtil().screenWidth / 2.8,
                          onPressed: onTap,
                          height: 29.0.h,
                          borderRadius: BorderRadius.circular(6.0.r),
                          child: Text(LangKeys.viewMore.tr,
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  height: 0.2.h)),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
