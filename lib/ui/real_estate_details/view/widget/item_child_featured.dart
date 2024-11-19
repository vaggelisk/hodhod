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
import 'package:hodhod/data/models/real_estates_features/real_estates_features_children.dart';

class ItemChildFeatured extends StatelessWidget {
  final RealEstatesFeaturesChildren data;

  // final VoidCallback onTap;

  const ItemChildFeatured({
    super.key,
    required this.data,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: ScreenUtil().screenWidth,
          margin: EdgeInsetsDirectional.only(bottom: 9.w, start: 11.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "- ${data.name ?? ""}",
                style: AppTextStyles.regularTextStyle
                    .copyWith(color: HexColor("535353"), fontSize: 14.0.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
