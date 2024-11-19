import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAdsList extends StatelessWidget {
  const ShimmerAdsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: 140.h,
        child: ListView.builder(
          padding:
              EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 21.h),
          scrollDirection: Axis.horizontal,
          itemCount: 3, // Adjust// the count based on your needs
          itemBuilder: (context, index) {
            return Container(
              width: 292.w,
              margin: EdgeInsetsDirectional.only(end: 22.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmer Placeholder for Photo Image
                  SizedBox(
                    width: 292.w,
                    height: 138.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade200,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
