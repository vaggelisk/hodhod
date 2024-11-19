import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/ui/payment/controller/payment_page_controller.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  PaymentPageController controller = Get.put(PaymentPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(LangKeys.payment.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: Padding(
        padding: EdgeInsetsDirectional.all(16.r),
        child: Column(
          children: [

            PrimaryButton(
              width: ScreenUtil().screenWidth,
              onPressed: () {
              },
              height: 47.0.h,
              borderRadius: BorderRadius.circular(6.0.r),
              child: Text(LangKeys.pay.tr,
                  style: AppTextStyles.semiBoldTextStyle
                      .copyWith(color: Colors.white, fontSize: 16.sp)),
            ),
          ],
        ),
      ),
    );
  }


}
