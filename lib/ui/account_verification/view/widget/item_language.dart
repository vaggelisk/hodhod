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
import 'package:hodhod/data/models/languages/language.dart';
import 'package:hodhod/data/models/real_estates_features/real_estates_features.dart';
import 'package:hodhod/data/models/real_estates_features/real_estates_features_children.dart';
import 'package:hodhod/ui/account_verification/controller/account_verification_controller.dart';
import 'package:hodhod/ui/add_real_estate/controller/add_real_estate_controller.dart';

class ItemLanguage extends StatelessWidget {
  final Language data;

  // final VoidCallback onTap;

  const ItemLanguage({
    super.key,
    required this.data,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      margin: EdgeInsetsDirectional.only(bottom: 16.w, start: 13.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 22.0.h,
            width: 22.0.w,
            child: Checkbox(
              value: data.selected,
              activeColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) {
                data.selected = value!;
                Get.find<AccountVerificationController>().update(['selectedLanguages']);
              },
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            data.name ?? "",
            style: AppTextStyles.regularTextStyle.copyWith(
                color: Colors.black, fontSize: 14.0.sp, height: 1.2.h),
          ),
        ],
      ),
    );
  }
}
