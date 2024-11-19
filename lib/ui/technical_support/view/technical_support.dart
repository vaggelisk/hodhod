import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/data/models/support_reasons/support_reasons.dart';
import 'package:hodhod/ui/technical_support/controller/technical_support_controller.dart';

class TechnicalSupport extends StatelessWidget {
  TechnicalSupport({super.key});

  TechnicalSupportController controller = Get.put(TechnicalSupportController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
              title: Text(LangKeys.technicalSupport.tr,
                  style: AppTextStyles.semiBoldTextStyle.copyWith(
                      color: Colors.black, fontSize: 16.sp, height: 1.h))),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0.h),
                  Row(
                    children: [
                      Text(
                        LangKeys.chooseReason.tr,
                        style: AppTextStyles.mediumTextStyle
                            .copyWith(color: Colors.black, fontSize: 16.0.sp),
                      ),
                      Text(
                        "*",
                        style: AppTextStyles.regularTextStyle.copyWith(
                            color: AppColors.redColor1, fontSize: 16.0.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0.h),
                  GetBuilder<TechnicalSupportController>(
                    id: 'selectedSupportReasons',
                    builder: (controller) {
                      return controller.isLoading.isFalse
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0.w, vertical: 10.0.h),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.3.w, color: AppColors.divider1),
                                  borderRadius: BorderRadius.circular(6.0.r)),
                              child: DropdownButton<SupportReasons>(
                                value: controller.selectedSupportReasons.value
                                        .content!.isNotEmpty
                                    ? controller.selectedSupportReasons.value
                                    : null,
                                icon: Icon(Icons.expand_more_outlined,
                                    color: AppColors.grey9),
                                iconSize: 24.0.r,
                                elevation: 0,
                                hint: Text(LangKeys.chooseReason.tr,
                                    style: AppTextStyles.regularTextStyle
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.30),
                                            fontSize: 14.0.sp)),
                                isExpanded: true,
                                dropdownColor: AppColors.grey15,
                                style: AppTextStyles.regularTextStyle.copyWith(
                                    color: AppColors.hintTextInput,
                                    fontSize: 14.0.sp),
                                autofocus: true,
                                isDense: true,
                                underline: const SizedBox(),
                                onChanged: (data) {
                                  controller.selectedSupportReasons.value =
                                      data!;
                                  controller.update(['selectedSupportReasons']);
                                },
                                items: controller.supportReasonsList
                                    .map<DropdownMenuItem<SupportReasons>>(
                                        (SupportReasons value) {
                                  return DropdownMenuItem<SupportReasons>(
                                    value: value,
                                    child: Text(value.content ?? ""),
                                  );
                                }).toList(),
                              ),
                            )
                          : const LoadingView();
                    },
                  ),
                  SizedBox(height: 16.0.h),
                  Row(
                    children: [
                      Text(
                        LangKeys.messageContent.tr,
                        style: AppTextStyles.mediumTextStyle
                            .copyWith(color: Colors.black, fontSize: 15.0.sp),
                      ),
                      Text(
                        "*",
                        style: AppTextStyles.regularTextStyle.copyWith(
                            color: AppColors.redColor1, fontSize: 15.0.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0.h),
                  TextFormField(
                      controller: controller.message,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 6,
                      decoration: CommonStyle.textFieldStyle(
                          hintTextStr: LangKeys.messageContent.tr)),
                  SizedBox(height: 50.0.h),
                  PrimaryButton(
                    width: ScreenUtil().screenWidth,
                    onPressed: () {
                      controller.validation();
                    },
                    height: 47.0.h,
                    borderRadius: BorderRadius.circular(6.0.r),
                    child: Text(LangKeys.send.tr,
                        style: AppTextStyles.semiBoldTextStyle
                            .copyWith(color: Colors.white, fontSize: 15.sp)),
                  ),
                  SizedBox(height: 25.h)
                ],
              ),
            ),
          )),
    );
  }
}
