import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/empty_status_view.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/extensions/color.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/common_style.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/my_real_estate/view/widget/item_my_real_estate.dart';
import 'package:hodhod/ui/search/controller/search_page_controller.dart';
import 'package:hodhod/ui/shimmer_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'widget/item_real_estate.dart';

class Search extends StatelessWidget {
  Search({super.key});

  SearchPageController controller = Get.put(SearchPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: Text(LangKeys.realEstate.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 16.sp, height: 1.h))),
      body: GetBuilder<SearchPageController>(
        id: 'updateList',
        builder: (controller) {
          return Column(children: [
            Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 13.h),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                          controller: controller.search,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (value) {
                            controller.pagingController.refresh();
                          },
                          style: AppTextStyles.regularTextStyle
                              .copyWith(fontSize: 14.0.sp, color: Colors.black),
                          decoration: CommonStyle.textFieldSearch2Style(
                                  hintTextStr: LangKeys.searchHere.tr)
                              .copyWith(
                                  prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: SvgPicture.asset(
                                Utils.getIconPath("ic_search")),
                          )))),
                  InkWell(
                    onTap: () async {
                      try {
                        Map result =
                            await Get.toNamed(AppRoutes.searchFilter) as Map;
                        if (result["from_price"] != null) {
                          controller.fromPrice = result['from_price'];
                          controller.toPrice = result['to_price'];
                          controller.spaceFrom = result['space_from'];
                          controller.spaceTo = result['space_to'];
                          controller.sortBy = result['sort_by'];
                          controller.realEstateTypeId =
                              result['real_estate_type_id'];
                          controller.numberOfRooms = result['number_of_rooms'];
                          controller.numberOfFloors =
                              result['number_of_floors'];
                          controller.numberOfBathrooms =
                              result['number_of_bathrooms'];
                          controller.type = result['type'];

                          if (result['features_ids'] != null) {
                            controller.featuresIds =
                                result['features_ids']! as List<int>;
                          }
                          controller.pagingController.refresh();
                        }
                      } catch (e) {
                        e.printError();
                      }
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.only(start: 13.w),
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 13.w, vertical: 12.h),
                      decoration: BoxDecoration(
                          color: AppColors.bgSplash,
                          border: Border.all(
                              color: HexColor("D2D2D2"), width: 0.5.w),
                          borderRadius: BorderRadius.circular(4.r)),
                      child: SvgPicture.asset(
                        Utils.getIconPath("ic_filter"),
                        width: 24.w,
                        height: 24.h,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: RefreshIndicator(
                    onRefresh: () async {
                      controller.clearFilter();
                      controller.pagingController.refresh();
                    },
                    child: PagedListView<int, RealEstates>(
                      padding: EdgeInsetsDirectional.only(
                          start: 16.w, end: 16.w, top: 17.h),
                      pagingController: controller.pagingController,
                      shrinkWrap: false,
                      primary: true,
                      builderDelegate: PagedChildBuilderDelegate<RealEstates>(
                          itemBuilder: (context, item, index) => ItemRealEstate(
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
                          newPageErrorIndicatorBuilder: (_) => EmptyStatusView(
                              msg: controller.pagingController.error),
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
                    )))
          ]);
        },
      ),
    );
  }
}
