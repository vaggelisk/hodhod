import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/ui/page/controller/page_view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageView extends StatelessWidget {
  PageView({super.key});
  PageViewController controller = Get.put(PageViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(controller.title ?? "",
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  fontSize: 16.0.sp, color: Colors.black, height: 1.h))),
      body: SafeArea(
        child: Obx(() => controller.isLoading.isFalse
            ? Padding(
                padding: EdgeInsets.all(5.0.r),
                child: WebViewWidget(controller: controller.webViewController),
              )
            : LoadingView()),
      ),
    );
  }
}
