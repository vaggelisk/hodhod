import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_constants.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/ui/add_real_estate/controller/add_real_estate_controller.dart';

class AddRealEstateThird extends StatelessWidget {
  AddRealEstateThird({super.key});

  AddRealEstateController controller = Get.find<AddRealEstateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(controller.isEdit == true
              ? LangKeys.editRealEstate.tr
              : LangKeys.addRealEstate.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 24.h),
          child: Column(children: [
            Row(
              children: [
                Text(
                  LangKeys.numberRooms.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.numberRooms,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterNumberRooms.tr)),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.numberBathrooms.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "*",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.numberBathrooms,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterNumberBathrooms.tr)),
            SizedBox(height: 50.0.h),
            PrimaryButton(
              width: ScreenUtil().screenWidth,
              onPressed: () {

                controller.validationThird();
              },
              height: 47.0.h,
              borderRadius: BorderRadius.circular(6.0.r),
              child: Text(LangKeys.next.tr,
                  style: AppTextStyles.semiBoldTextStyle
                      .copyWith(color: Colors.white, fontSize: 16.sp)),
            ),
            SizedBox(height: 25.h),
          ]),
        ),
      ),
    );
  }
}
