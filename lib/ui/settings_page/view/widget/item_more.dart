import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/ui/settings_page/controller/more_model.dart';

class ItemMore extends StatelessWidget {
  final MoreModel data;
  final bool isLast;
  final String langCode;

  final VoidCallback onTap;

  const ItemMore({
    super.key,
    required this.data,
    required this.isLast,
    required this.onTap,
    required this.langCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: Row(
                    children: [
                      data.isWeb == true
                          ? Image.network(data.icon ?? "",
                              width: 24.w, height: 24.h)
                          : SvgPicture.asset(data.icon ?? "",
                              width: 24.w, height: 24.h),
                      SizedBox(width: 20.w),
                      Text(
                        data.name ?? "",
                        style: AppTextStyles.mediumTextStyle.copyWith(
                            color: isLast ? AppColors.redColor2 : Colors.black,
                            fontSize: 15.0.sp,
                            height: 1),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: !isLast,
                    child: Directionality(
                        textDirection: langCode == "ar"
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.primary,
                          size: 16.r,
                        )))
              ]),
              Visibility(
                visible: !isLast,
                child: SizedBox(
                  height: 16.h,
                ),
              ),
              Visibility(
                visible: !isLast,
                child: Divider(
                  height: 0,
                  color: AppColors.grey3,
                  thickness: 0.5.h,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10.w)
      ],
    );
  }
}
