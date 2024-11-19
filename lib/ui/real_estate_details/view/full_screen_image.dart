import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hodhod/app/components/image.dart';
import 'package:hodhod/data/models/real_estates/real_estate_image.dart';

class FullScreenImage extends StatelessWidget {
  final List<RealEstateImage> listImages;
  final int indexSelected;

  const FullScreenImage(
      {super.key, required this.listImages, required this.indexSelected});

  // InkWell(
  //     onTap: () {
  //       Get.toNamed(AppRoutes.comments, arguments: {
  //         "id": controller.data.value.id ?? 0
  //       });
  //     },
  //     child: Icon(
  //       Icons.comment,
  //       color: AppColors.primary,
  //       size: 28.r,
  //     ))
  // Navigator.pop(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
          child: SizedBox(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Center(
              child: CarouselSlider.builder(
                itemCount: listImages.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return SizedBox(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().screenHeight / 2,
                      child: displayImageFromNetwork(
                          listImages[itemIndex].image ?? "",
                          BoxFit.fitWidth,
                          ScreenUtil().screenWidth,
                          ScreenUtil().screenHeight / 2,
                          0.r));
                },
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      // controller.sliderIndex(index);
                    },
                    autoPlay: false,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    initialPage: indexSelected,
                    viewportFraction: 1,
                    height: ScreenUtil().screenHeight / 2),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.all(12.r),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 30.r,
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
