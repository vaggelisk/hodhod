import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/notifications/notification_d.dart';

class ItemNotification extends StatelessWidget {
  final NotificationD data;
  final VoidCallback onTap;

  const ItemNotification({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsetsDirectional.only(
                start: 16.0.w, end: 16.w, bottom: 0.0.h, top: 0.0.h),
            width: ScreenUtil().screenWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Utils.getIconPath(data.readAt == null
                      ? "ic_notifcation_default"
                      : "ic_notifcation_read"),
                  width: 40.w,
                  height: 40.h,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title ?? "",
                        style: AppTextStyles.regularTextStyle.copyWith(
                            color: AppColors.text17, fontSize: 14.0.sp),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        data.details ?? "",
                        style: AppTextStyles.regularTextStyle.copyWith(
                            color: AppColors.text17, fontSize: 14.0.sp),
                      ),
                      Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            data.createdAtDiff ?? "",
                            style: AppTextStyles.regularTextStyle.copyWith(
                                color: AppColors.grey1, fontSize: 12.0.sp),
                          )),
                      SizedBox(height: 8.h),
                      Divider(
                        thickness: 1.h,
                        color: AppColors.grey26,
                        height: 0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h)
      ],
    );
  }
}
