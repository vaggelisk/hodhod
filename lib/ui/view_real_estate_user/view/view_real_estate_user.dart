import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/empty_status_view.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/shimmer_list.dart';
import 'package:hodhod/ui/view_real_estate_user/controller/view_real_estate_user_controller.dart';
import 'package:hodhod/ui/view_real_estate_user/view/widget/item_real_estate_user.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ViewRealEstateUser extends StatelessWidget {
  ViewRealEstateUser({super.key});

  ViewRealEstateUserController controller =
      Get.put(ViewRealEstateUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(
              controller.isSort == true
                  ? controller.title ?? ""
                  : LangKeys.realEstate.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: GetBuilder<ViewRealEstateUserController>(
        id: 'updateList',
        builder: (controller) {
          return RefreshIndicator(
              onRefresh: () async {
                controller.pagingController.refresh();
              },
              child: PagedListView<int, RealEstates>(
                padding: EdgeInsetsDirectional.only(
                    start: 16.w, end: 16.w, top: 17.h),
                pagingController: controller.pagingController,
                shrinkWrap: false,
                primary: true,
                builderDelegate: PagedChildBuilderDelegate<RealEstates>(
                    itemBuilder: (context, item, index) => ItemRealEstateUser(
                          data: item,
                          onTap: () {
                            Get.toNamed(AppRoutes.realStateDetails,
                                arguments: {"id": item.id});
                          },
                        ),
                    firstPageErrorIndicatorBuilder: (_) {
                      return EmptyStatusView(
                        msg: controller.pagingController.error,
                      );
                    },
                    noItemsFoundIndicatorBuilder: (_) => EmptyStatusView(
                          img: "ic_no_real_estate",
                          msg: LangKeys.noRealEstateAvailableMsg.tr,
                        ),
                    newPageErrorIndicatorBuilder: (_) =>
                        EmptyStatusView(msg: controller.pagingController.error),
                    firstPageProgressIndicatorBuilder: (_) => SizedBox(
                        width: ScreenUtil().screenWidth,
                        height: ScreenUtil().screenHeight,
                        child: ShimmerList()),
                    newPageProgressIndicatorBuilder: (_) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 50.0.w,
                                height: 50.0.h,
                                child: const LoadingView()),
                          ],
                        )),
              ));
        },
      ),
    );
  }
}
