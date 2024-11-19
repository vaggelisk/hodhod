import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/data/models/real_estates_features/real_estates_features.dart';
import 'package:hodhod/data/models/real_estates_types/real_estates_types.dart';
import 'package:hodhod/ui/add_real_estate/view/widget/item_add_child_featured.dart';

class ItemAddParentFeatured extends StatelessWidget {
  final RealEstatesFeatures data;

  // final VoidCallback onTap;

  const ItemAddParentFeatured({
    super.key,
    required this.data,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      margin: EdgeInsetsDirectional.only(bottom: 16.w, start: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name ?? "",
            style: AppTextStyles.boldTextStyle.copyWith(
              color: Colors.black,
              decoration: TextDecoration.underline,
              fontSize: 16.0.sp,
            ),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            itemCount: data.children!.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return ItemAddChildFeatured(
                data: data.children![index],
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 10),
            ),
          )
        ],
      ),
    );
  }
}
