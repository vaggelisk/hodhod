import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/util/utils.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget title;
  // var storageService = Get.find<StorageService>();

  // final controller = Get.find<PublicController>();

  CustomHomeAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            size: 24.r,
            color: Colors.black,
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.notifications);
            // do something
          },
        )
      ],
      leading: IconButton(
        icon: Icon(
          Icons.search,
          size: 24.0.r,
          color: Colors.black,
        ),
        onPressed: () async {
          // await Future.delayed(const Duration(milliseconds: 500));
          // Get.back();
          Get.toNamed(AppRoutes.search);
        },
      ),
      title: SvgPicture.asset(Utils.getIconPath("ic_logo_sp"),
          width: 80.w, height: 35.h),
    );
  }
  @override
  Size get preferredSize => AppBar().preferredSize;
}
