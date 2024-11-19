import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/real_estates/real_estate_image.dart';

class ItemOldImage extends StatelessWidget {
  final RealEstateImage data;
  final VoidCallback onTap;

  const ItemOldImage({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.topEnd,
          children: [
            displayImageFromNetwork(
                data.image ?? "", BoxFit.cover, 88.w, 88.h, 10.0.r),
            PositionedDirectional(
              top: -20.0.h,
              end: -18.0.w,
              child: IconButton(
                  onPressed: onTap,
                  icon: Image.asset(Utils.getImagePath("ic_close"),
                      width: 25.0.w, height: 25.0.h)),
            )
          ],
        ),
        SizedBox(width: 16.w)
      ],
    );
  }
}
