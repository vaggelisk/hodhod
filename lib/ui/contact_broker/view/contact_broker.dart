import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/app/components/primary_button.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/ui/contact_broker/controller/contact_broker_controller.dart';

class ContactBroker extends StatelessWidget {
  ContactBroker({super.key});

  ContactBrokerController controller = Get.put(ContactBrokerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(LangKeys.contactBroker.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 19.h),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    topRight: Radius.circular(4.r)),
                child: displayImageFromNetwork(controller.data?.image ?? "",
                    BoxFit.fitWidth, ScreenUtil().screenWidth, 193.h, 0.r),
              ),
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 10.w, end: 10.w, top: 10.h, bottom: 8.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: HexColor("D2D2D2"), width: 0.5.w),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(4.r),
                        bottomLeft: Radius.circular(4.r))),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(controller.data?.title ?? "",
                              style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: AppColors.text18, fontSize: 14.sp)),
                        ),
                        Text(
                          "${Utils.formatPrice(controller.data?.price)} ${controller.data?.currency?.name ?? ""}",
                          style: AppTextStyles.semiBoldTextStyle.copyWith(
                              color: AppColors.primary, fontSize: 16.0.sp),
                        )
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Utils.getIconPath("ic_location_real"),
                          width: 24.0.w,
                          height: 24.0.h,
                        ),
                        SizedBox(width: 8.h),
                        Expanded(
                          child: Text(
                            controller.data?.address ?? "",
                            style: AppTextStyles.regularTextStyle.copyWith(
                                color: HexColor("747474"),
                                fontSize: 14.0.sp,
                                height: 1.5.h),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        // Expanded(
                        //     child: Row(
                        //   children: [
                        //     SvgPicture.asset(Utils.getIconPath("ic_bedroom"),
                        //         width: 14.w, height: 14.h),
                        //     SizedBox(width: 4.w),
                        //     Text(
                        //       "${controller.data?.numberOfRooms ?? "0"} غرف",
                        //       style: AppTextStyles.regularTextStyle.copyWith(
                        //           color: HexColor("A9A9A9"), fontSize: 12.0.sp),
                        //     )
                        //   ],
                        // )),
                        // SizedBox(width: 8.w),
                        // Expanded(
                        //     child: Row(
                        //   children: [
                        //     SvgPicture.asset(Utils.getIconPath("ic_bathroom"),
                        //         width: 14.w, height: 14.h),
                        //     SizedBox(width: 4.w),
                        //     Text(
                        //       "${controller.data?.numberOfBathrooms ?? "0"} حمام",
                        //       style: AppTextStyles.regularTextStyle.copyWith(
                        //           color: HexColor("A9A9A9"), fontSize: 12.0.sp),
                        //     )
                        //   ],
                        // )),
                        // SizedBox(width: 8.w),
                        Expanded(
                            child: Row(
                          children: [
                            SvgPicture.asset(Utils.getIconPath("ic_building"),
                                width: 14.w, height: 14.h),
                            SizedBox(width: 4.w),
                            Expanded(
                                child: Text(
                              controller.data?.type ?? "",
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: HexColor("A9A9A9"), fontSize: 12.0.sp),
                            ))
                          ],
                        )),
                        SizedBox(width: 8.w),
                        Expanded(
                            child: Row(
                          children: [
                            SvgPicture.asset(Utils.getIconPath("ic_building_2"),
                                width: 14.w, height: 14.h),
                            SizedBox(width: 4.w),
                            Expanded(
                                child: Text(
                              controller.data?.realEstateStatus ?? "",
                              style: AppTextStyles.regularTextStyle.copyWith(
                                  color: HexColor("A9A9A9"), fontSize: 12.0.sp),
                            ))
                          ],
                        )),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Divider(
                      height: 0,
                      thickness: 0.5.h,
                      color: AppColors.grey7,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.5.w,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 20.0.r,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: controller.data?.user?.image ?? "",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            )),
                        SizedBox(width: 8.w),
                        Text(
                          controller.data?.user?.name ?? "",
                          style: AppTextStyles.mediumTextStyle.copyWith(
                              color: HexColor("696969"), fontSize: 12.0.sp),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Divider(
                height: 0,
                thickness: 0.5.h,
                color: AppColors.grey7,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Text(
                    LangKeys.fullName.tr,
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
                  controller: controller.fullName,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: CommonStyle.textFieldStyle(
                      hintTextStr: LangKeys.enterFullName.tr)),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Text(
                    LangKeys.phoneNumber.tr,
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.3.w, color: AppColors.divider1),
                      borderRadius: BorderRadius.circular(8.0.r)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: controller.mobile,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: "",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0.w),
                              border: InputBorder.none),
                        ),
                      ),
                      // SizedBox(width: 5.0.w),
                      VerticalDivider(
                        color: AppColors.divider1,
                        thickness: 0.3.w,
                        width: 0,
                      ),
                      // SizedBox(width: 5.0.w),
                      InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            favorite: <String>['AE', 'SA'],
                            // countryFilter: <String>['SA', 'YE'],
                            showPhoneCode: true,
                            searchAutofocus: false,
                            onSelect: (Country country) {
                              controller.phoneCode(country.phoneCode);
                              controller.countryCode(country.countryCode);
                              print("Log countryCode ${country.countryCode}");
                            },
                            countryListTheme: CountryListThemeData(
                              flagSize: 24.0.r,
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 12.0.sp),
                              bottomSheetHeight: ScreenUtil().screenHeight / 2,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0.r),
                                topRight: Radius.circular(10.0.r),
                              ),
                              inputDecoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0.r),
                                labelText: "بحث",
                                labelStyle: TextStyle(fontSize: 14.0.sp),
                                hintText: "ابدأ الكتابة للبحث'",
                                prefixIcon: Icon(Icons.search, size: 24.0.r),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.keyboard_arrow_down_rounded,
                                size: 24.0.r),
                            Obx(() => Text("+${controller.phoneCode.value}",
                                textDirection: TextDirection.ltr,
                                style: AppTextStyles.mediumTextStyle.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 14.0.sp))),
                          ],
                        ),
                      ),
                      SizedBox(width: 5.0.w)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Text(
                    LangKeys.email.tr,
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
                  controller: controller.email,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: CommonStyle.textFieldStyle(
                      hintTextStr: LangKeys.enterEmail.tr)),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Text(
                    LangKeys.message.tr,
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
                  minLines: 3,
                  decoration: CommonStyle.textFieldStyle(
                      hintTextStr: LangKeys.writeMessage.tr)),
              SizedBox(height: 16.0.h),
              PrimaryButton(
                width: ScreenUtil().screenWidth,
                onPressed: () {
                  // Get.toNamed(AppRoutes.accountVerificationTwo);
                  controller.validation();
                },
                height: 47.0.h,
                borderRadius: BorderRadius.circular(6.0.r),
                child: Text(LangKeys.send.tr,
                    style: AppTextStyles.semiBoldTextStyle
                        .copyWith(color: Colors.white, fontSize: 16.sp)),
              ),
              SizedBox(height: 16.0.h),
            ],
          ),
        ),
      ),
    );
  }
}
