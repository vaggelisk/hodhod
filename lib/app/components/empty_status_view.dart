import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/util/utils.dart';

class EmptyStatusView extends StatelessWidget {
  String msg;
  String? textBtn;
  String? img;
  bool isShowBtn;

  EmptyStatusView(
      {super.key,
      required this.msg,
      this.isShowBtn = false,
      this.textBtn,
      this.img});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Utils.getIconPath(img ?? "ic_no_real_estate"),
            width: 129.0.w,
            height: 118.0.h,
            placeholderBuilder: (BuildContext context) =>
                const CircularProgressIndicator(),
          ),
          SizedBox(
            height: 20.0.h,
          ),
          Text(
            msg,
            style: AppTextStyles.semiBoldTextStyle
                .copyWith(fontSize: 16.0.sp, color: HexColor("404040")),
          ),
          SizedBox(
            height: 20.0.h,
          ),
          Visibility(
            visible: isShowBtn,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0.w),
              child: SizedBox(
                width: ScreenUtil().screenWidth,
                height: 43.0.h,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary),
                  onPressed: () {
                    // controller.currentIndex.value = 0;
                    // Get.toNamed(AppRoutes.home);
                  },
                  label: Text(
                    textBtn ?? "",
                    style: AppTextStyles.boldTextStyle.copyWith(
                        fontSize: 16.0.sp, color: Colors.white, height: 1.0.h),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
