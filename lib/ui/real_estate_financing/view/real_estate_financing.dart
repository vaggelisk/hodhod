import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/empty_status_view.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/real_estate_financing/controller/real_estate_financing_controller.dart';
import 'package:hodhod/ui/real_estate_financing/view/widget/item_financing.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

class RealEstateFinancing extends StatefulWidget {
  RealEstateFinancing({super.key});

  @override
  State<RealEstateFinancing> createState() => _State();
}

class _State extends State<RealEstateFinancing> {
  late RealEstateFinancingController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(RealEstateFinancingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(LangKeys.realEstateFinancing.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: GetBuilder<RealEstateFinancingController>(
          id: "updateUi",
          builder: (controller) {
            return controller.isLoading.isTrue
                ? const LoadingView()
                : controller.financeList.isNotEmpty
                    ? SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 16.w, end: 16.w, top: 16.h),
                            child: Column(
                              children: [
                                controller.finance != null
                                    ? SizedBox(
                                        height: 220.h,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                controller.financeList.length,
                                            padding: EdgeInsets.zero,
                                            physics: controller
                                                        .finance?.typeKey !=
                                                    "free"
                                                ? ClampingScrollPhysics()
                                                : NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ItemFinancing(
                                                  index: index,
                                                  selectedIndex: controller
                                                      .financeSelected,
                                                  data: controller
                                                      .financeList[index],
                                                  isFree: controller
                                                          .finance?.typeKey ==
                                                      "free",
                                                  onTap: () {
                                                    if (controller
                                                            .financeSelected ==
                                                        index) {
                                                      controller
                                                          .financeSelected = -1;
                                                    } else {
                                                      controller
                                                              .financeSelected =
                                                          index;
                                                    }

                                                    controller
                                                        .update(['updateUi']);
                                                  });
                                            }),
                                      )
                                    : SizedBox(),
                                SizedBox(height: 50.h),
                                PrimaryButton(
                                  width: ScreenUtil().screenWidth,
                                  onPressed: () async {
                                    controller.validation(context);


                                  },
                                  height: 47.0.h,
                                  borderRadius: BorderRadius.circular(6.0.r),
                                  child: Text(LangKeys.subscription.tr,
                                      style: AppTextStyles.semiBoldTextStyle
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 16.sp)),
                                ),
                                SizedBox(height: 25.h),
                              ],
                            )),
                      )
                    : EmptyStatusView(
                        img: "ic_no_real_estate",
                        msg: LangKeys.noFinancingPlans.tr);
          }),
    );
  }
}
