import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/components/custom_app_bar.dart';
import 'package:hodhod/app/components/empty_status_view.dart';
import 'package:hodhod/app/components/loading_view.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_text_styles.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/data/models/notifications/notification_d.dart';
import 'package:hodhod/ui/notifications/controller/notifications_controller.dart';
import 'package:hodhod/ui/notifications/view/widget/item_notifications.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});

  NotificationsController controller = Get.put(NotificationsController());

  // padding:
  // EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 10.h),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Text(LangKeys.notifications.tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: Colors.black, fontSize: 15.sp, height: 1.h))),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //     padding: EdgeInsetsDirectional.only(
          //         start: 16.w, end: 16.w, bottom: 10.h, top: 10.h),
          //     child: Text(
          //       "${LangKeys.latestNotifications.tr} (8)",
          //       maxLines: 1,
          //       style: AppTextStyles.semiBoldTextStyle.copyWith(
          //           overflow: TextOverflow.ellipsis,
          //           color: Colors.black,
          //           fontSize: 16.0.sp),
          //     )),
          // SizedBox(height: 29.h),
          Expanded(
              child: GetBuilder<NotificationsController>(
                  id: 'updateList',
                  builder: (controller) {
                    return RefreshIndicator(
                        onRefresh: () async {
                          controller.pagingController.refresh();
                        },
                        child: PagedListView<int, NotificationD>(
                          padding: EdgeInsetsDirectional.only(
                              start: 16.w, end: 16.w, top: 17.h),
                          pagingController: controller.pagingController,
                          shrinkWrap: false,
                          primary: true,
                          builderDelegate: PagedChildBuilderDelegate<
                                  NotificationD>(
                              itemBuilder: (context, item, index) =>
                                  ItemNotification(
                                    data: item,
                                    onTap: () {
                                      if (item.readAt == null) {
                                        controller.getNotificationsDetails(
                                            item.id ?? "");
                                      }
                                    },
                                  ),
                              firstPageErrorIndicatorBuilder: (_) {
                                return EmptyStatusView(
                                  img: "ic_no_not",
                                  msg: controller.pagingController.error,
                                );
                              },
                              noItemsFoundIndicatorBuilder: (_) =>
                                  EmptyStatusView(
                                    img: "ic_no_not",
                                    msg: LangKeys.noNotifications.tr,
                                  ),
                              newPageErrorIndicatorBuilder: (_) =>
                                  EmptyStatusView(
                                      img: "ic_no_not",
                                      msg: controller.pagingController.error),
                              firstPageProgressIndicatorBuilder: (_) => Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 50.0.w,
                                          height: 50.0.h,
                                          child: const LoadingView()),
                                    ],
                                  )),
                              newPageProgressIndicatorBuilder: (_) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 50.0.w,
                                          height: 50.0.h,
                                          child: const LoadingView()),
                                    ],
                                  )),
                        ));
                  }))
        ],
      ),
    );
  }
}

/**/
