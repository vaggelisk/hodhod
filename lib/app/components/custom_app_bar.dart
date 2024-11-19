
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/config/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget title;
  bool? isShowBack = true;
  bool? centerTitle = false;
  bool isGrayBg = false;
  // var storageService = Get.find<StorageService>();

  // final controller = Get.find<PublicController>();

  CustomAppBar(
      {required this.title, this.isShowBack, this.isGrayBg = false,this.centerTitle = false, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isGrayBg ? AppColors.lightGrey6 : Colors.white,
      centerTitle: centerTitle,
      surfaceTintColor: Colors.transparent,
      leading: isShowBack == true
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 24.0.r,
                color: Colors.black,
              ),
              onPressed: () async {
                // await Future.delayed(const Duration(milliseconds: 500));
                Get.back();
              },
            )
          : null,
      title: title,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
