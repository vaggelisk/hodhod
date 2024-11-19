import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/real_estates_features/real_estates_features_children.dart';
import 'package:hodhod/ui/add_real_estate/controller/add_real_estate_controller.dart';

import 'widget/item_add_parent_featured.dart';

class PropertyFeatures extends StatelessWidget {
  PropertyFeatures({super.key});

  AddRealEstateController controller = Get.find<AddRealEstateController>();

  @override
  Widget build(BuildContext context) {
    // controller.isSelectedFeatures(false);
    controller.propertyFeatures.text = "";
    controller.realEstatesFeaturesSelectedList.clear();
    controller.getRealEstatesFeatures();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(LangKeys.choosePropertySpecificationsAndFeatures.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 24.h),
        child: GetBuilder<AddRealEstateController>(
          id: 'selectedRealEstatesFeatures',
          builder: (controller) {
            return controller.isLoadingRealEstatesFeatures.isFalse
                ? Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: controller.realEstatesFeaturesList.length,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ItemAddParentFeatured(
                              data: controller.realEstatesFeaturesList[index]);
                        },
                      )),
                      SizedBox(height: 16.h),
                      PrimaryButton(
                        width: ScreenUtil().screenWidth,
                        onPressed: () {
                          RealEstatesFeaturesChildren? found;
                          String? featuresStr = "";
                          for (var element
                              in controller.realEstatesFeaturesList) {
                            found = element.children!
                                .where((element) => element.selected == true)
                                .firstOrNull;
                            if (found != null) {
                              break;
                            }
                          }
                          if (found != null) {
                            for (var element
                                in controller.realEstatesFeaturesList) {
                              element.children?.forEach((element) {
                                if (element.selected) {
                                  featuresStr =
                                      "$featuresStr${element.name ?? ""},";
                                  controller.realEstatesFeaturesSelectedList
                                      .add(element.id ?? 0);
                                }
                              });
                            }
                            print(
                                "Log controller.realEstatesFeaturesSelectedList ${controller.realEstatesFeaturesSelectedList.length}");
                            controller.propertyFeatures.text =
                                featuresStr ?? "";
                            controller.isSelectedFeatures(true);
                            Get.back();
                          } else {
                            UiErrorUtils.customSnackbar(
                                title: LangKeys.error.tr,
                                msg: LangKeys
                                    .choosePropertySpecificationsAndFeatures
                                    .tr);
                          }

                          // Get.toNamed(AppRoutes.addRealEstateTwo);
                          // controller.validation();
                        },
                        height: 47.0.h,
                        borderRadius: BorderRadius.circular(6.0.r),
                        child: Text(LangKeys.next.tr,
                            style: AppTextStyles.semiBoldTextStyle.copyWith(
                                color: Colors.white, fontSize: 16.sp)),
                      ),
                      SizedBox(height: 25.h),
                    ],
                  )
                : const LoadingView();
          },
        ),
      ),
    );
  }
}
