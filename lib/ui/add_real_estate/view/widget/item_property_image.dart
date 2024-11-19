import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hodhod/app/util/utils.dart';

class ItemPropertyImage extends StatelessWidget {
  final String data;
  final VoidCallback onTap;

  const ItemPropertyImage({
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
            ClipRRect(
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10.0.r),
                    topStart: Radius.circular(10.0.r),
                    bottomEnd: Radius.circular(10.0.r),
                    bottomStart: Radius.circular(10.0.r)),
                child: Image.file(File(data),
                    fit: BoxFit.cover, width: 88.w, height: 88.h)),
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
