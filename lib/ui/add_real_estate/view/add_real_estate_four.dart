import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_constants.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/real_estates_constants/real_estate_constants.dart';
import 'package:hodhod/ui/add_real_estate/controller/add_real_estate_controller.dart';

import 'widget/item_old_image.dart';
import 'widget/item_property_image.dart';

class AddRealEstateFour extends StatelessWidget {
  AddRealEstateFour({super.key});

  AddRealEstateController controller = Get.find<AddRealEstateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(
              controller.isEdit == true
                  ? LangKeys.editRealEstate.tr
                  : LangKeys.addRealEstate.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 24.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              LangKeys.attachPhotoMainProperty.tr,
              style: AppTextStyles.mediumTextStyle
                  .copyWith(color: Colors.black, fontSize: 16.0.sp),
            ),
            SizedBox(height: 8.0.h),
            GetBuilder<AddRealEstateController>(
              id: "selectImage",
              builder: (controller) {
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.selectImage();
                      },
                      child: Container(
                        padding:
                            EdgeInsetsDirectional.symmetric(vertical: 21.h),
                        width: ScreenUtil().screenWidth,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: AppColors.divider1, width: 0.3.w),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(children: [
                          SvgPicture.asset(Utils.getIconPath("ic_upload"),
                              width: 30.w, height: 24.h),
                          SizedBox(height: 11.0.h),
                          Text(
                            controller.image != null
                                ? controller.image!.path.split('/').last
                                : LangKeys.attachPhotoMainProperty.tr,
                            style: AppTextStyles.mediumTextStyle.copyWith(
                                color: HexColor("BDBDBD"), fontSize: 14.0.sp),
                          )
                        ]),
                      ),
                    ),
                    controller.image != null
                        ? PositionedDirectional(
                            top: -20.0.h,
                            end: -18.0.w,
                            child: IconButton(
                                onPressed: () {
                                  controller.image = null;
                                  controller.update(['selectImage']);
                                },
                                icon: Image.asset(
                                    Utils.getImagePath("ic_close"),
                                    width: 25.0.w,
                                    height: 25.0.h)),
                          )
                        : const SizedBox()
                  ],
                );
              },
            ),
            SizedBox(height: 16.0.h),
            Text(
              LangKeys.attachPhotosProperty.tr,
              style: AppTextStyles.mediumTextStyle
                  .copyWith(color: Colors.black, fontSize: 16.0.sp),
            ),
            SizedBox(height: 8.0.h),
            InkWell(
                onTap: () {
                  controller.selectImage(isMulti: true);
                },
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 21.h),
                  width: ScreenUtil().screenWidth,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.divider1, width: 0.3.w),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(children: [
                    SvgPicture.asset(Utils.getIconPath("ic_upload"),
                        width: 30.w, height: 24.h),
                    SizedBox(height: 11.0.h),
                    Text(
                      LangKeys.attachPhotosProperty.tr,
                      style: AppTextStyles.mediumTextStyle.copyWith(
                          color: HexColor("BDBDBD"), fontSize: 14.0.sp),
                    )
                  ]),
                )),
            GetBuilder<AddRealEstateController>(
              id: 'selectImages',
              builder: (controller) {
                return controller.images.isNotEmpty
                    ? SizedBox(
                        height: 120.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.images.length,
                          itemBuilder: (context, index) {
                            return ItemPropertyImage(
                                data: controller.images[index].path,
                                onTap: () {
                                  controller.images.removeAt(index);
                                  controller.update(['selectImages']);
                                });
                          },
                        ),
                      )
                    : const SizedBox();
              },
            ),
            GetBuilder<AddRealEstateController>(
              id: 'oldImages',
              builder: (controller) {
                return controller.estateDetails.value.images != null &&
                        controller.estateDetails.value.images!.isNotEmpty
                    ? SizedBox(
                        height: 120.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              controller.estateDetails.value.images!.length,
                          itemBuilder: (context, index) {
                            return ItemOldImage(
                                data: controller
                                    .estateDetails.value.images![index],
                                onTap: () {
                                  confirmDeleteBottomSheet(LangKeys.delete.tr,
                                      LangKeys.deleteImgMsg.tr, () {
                                    Get.back(closeOverlays: false);
                                    controller.deleteImage(controller
                                            .estateDetails
                                            .value
                                            .images![index]
                                            .id ??
                                        0);
                                  });
                                  // if (controller
                                  //         .estateDetails.value.images!.length >
                                  //     1) {
                                  //
                                  // } else {
                                  //   UiErrorUtils.customSnackbar(
                                  //       title: LangKeys.error.tr,
                                  //       msg: LangKeys.deleteImgMsg2.tr);
                                  // }
                                });
                          },
                        ),
                      )
                    : const SizedBox();
              },
            ),
            SizedBox(height: 11.h),
            Divider(
              height: 0,
              thickness: 0.5.h,
              color: AppColors.grey7,
            ),
            // SizedBox(height: 10.h),
            // Text(
            //   LangKeys.additionalInformation.tr,
            //   style: AppTextStyles.semiBoldTextStyle
            //       .copyWith(color: Colors.black, fontSize: 16.0.sp),
            // ),
            //

            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.descriptionProperty.tr,
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
                controller: controller.descriptionProperty,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterDescriptionProperty.tr)),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Text(
                  LangKeys.landDepartmentPermitNumber.tr,
                  style: AppTextStyles.mediumTextStyle
                      .copyWith(color: Colors.black, fontSize: 15.0.sp),
                ),
                Text(
                  "",
                  style: AppTextStyles.regularTextStyle
                      .copyWith(color: AppColors.redColor1, fontSize: 15.0.sp),
                ),
              ],
            ),
            SizedBox(height: 8.0.h),
            TextFormField(
                controller: controller.landDepartmentPermitNumber,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: CommonStyle.textFieldStyle(
                    hintTextStr: LangKeys.enterPermitNumber.tr)),
            SizedBox(height: 29.0.h),
            PrimaryButton(
              width: ScreenUtil().screenWidth,
              onPressed: () {
                // Get.toNamed(AppRoutes.addRealEstateThird);
                controller.validationFour();
              },
              height: 47.0.h,
              borderRadius: BorderRadius.circular(6.0.r),
              child: Text(
                  controller.isEdit == true
                      ? LangKeys.editRealEstate.tr
                      : LangKeys.addRealEstate.tr,
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
