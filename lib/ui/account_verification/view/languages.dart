import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/models/languages/language.dart';
import 'package:hodhod/ui/account_verification/controller/account_verification_controller.dart';
import 'package:hodhod/ui/account_verification/view/widget/item_language.dart';

class Languages extends StatelessWidget {
  Languages({super.key});

  AccountVerificationController controller =
      Get.find<AccountVerificationController>();

  @override
  Widget build(BuildContext context) {
    // controller.isSelectedFeatures(false);
    controller.language.text = "";
    controller.languageSelectedList.clear();
    controller.getLanguages();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(LangKeys.languages.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 24.h),
        child: GetBuilder<AccountVerificationController>(
          id: 'selectedLanguages',
          builder: (controller) {
            return controller.isLoading.isFalse
                ? Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: controller.languageList.length,
                        itemBuilder: (context, index) {
                          return ItemLanguage(
                              data: controller.languageList[index]);
                        },
                      )),
                      SizedBox(height: 16.h),
                      PrimaryButton(
                        width: ScreenUtil().screenWidth,
                        onPressed: () {
                          Language? found;
                          String? languageStr = "";
                          found = controller.languageList
                              .where((p0) => p0.selected == true)
                              .firstOrNull;
                          if (found != null) {
                            for (var element in controller.languageList) {
                              if (element.selected) {
                                languageStr =
                                    "$languageStr${element.name ?? ""},";
                                controller.languageSelectedList
                                    .add(element.id ?? 0);
                              }
                            }
                            print(
                                "Log controller.languageSelectedList ${controller.languageSelectedList.length}");
                            controller.language.text = languageStr ?? "";
                            Get.back();
                          } else {
                            UiErrorUtils.customSnackbar(
                                title: LangKeys.error.tr, msg: LangKeys.chooseLanguages.tr);
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
