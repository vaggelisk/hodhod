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
import 'package:hodhod/ui/real_estate_details/view/widget/item_child_featured.dart';

class ItemParentFeatured extends StatelessWidget {
  // final Advertisement data;
  // final VoidCallback onTap;

  const ItemParentFeatured({
    super.key,
    // required this.data,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: ScreenUtil().screenWidth,
          margin: EdgeInsetsDirectional.only(bottom: 9.w, start: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "مميزات خارجية",
                style: AppTextStyles.mediumTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 14.0.sp,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(height: 9.h),
              // ListView.builder(
              //   itemCount: 4,
              //   shrinkWrap: true,
              //   primary: false,
              //   itemBuilder: (context, index) {
              //     return ItemChildFeatured(data: ,);
              //   },
              // )
            ],
          ),
        ),
      ],
    );
  }
}
