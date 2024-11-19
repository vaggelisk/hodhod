import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/notifications/notification_d.dart';
import 'package:hodhod/data/models/notifications/notifications_details_model.dart';
import 'package:hodhod/data/models/notifications/notifications_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:hodhod/ui/public_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationsController extends BaseController {
  final PagingController<int, NotificationD> pagingController =
      PagingController(firstPageKey: 1);
  static const _pageSize = 10;

  @override
  onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getNotifications(pageKey);
    });
  }

  Future<void> getNotifications(int pageKey) async {
    try {
      Map<String, dynamic> body = {
        'page': pageKey,
      };
      final result = await httpService
          .request(
              url: ApiConstant.notifications, method: Method.GET, params: body)
          .catchError((onError) {
        pagingController.error = onError;
      });
      if (result != null) {
        if (result is d.Response) {
          var resp = NotificationsModel.fromJson(result.data);
          Get.find<PublicController>().notCount.value =
              resp.data?.unreadNotificationsCount ?? 0;
          final list = resp.data!.items;
          final isLastPage = list!.length < _pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(list);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(list, nextPageKey);
          }
        } else {
          pagingController.error = LangKeys.anErrorFetchingData.tr;
        }
      } else {
        pagingController.error = LangKeys.anErrorFetchingData.tr;
      }
    } finally {
      // pagingController.error = LangKeys.anErrorFetchingData.tr;
    }
  }

  Future<void> getNotificationsDetails(String id) async {
    try {
      EasyLoading.show();
      final result = await httpService.request(
          url: "${ApiConstant.notifications}/$id", method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var data = NotificationsDetailsModel.fromJson(result.data);
          if (data.status == true) {
            int index = pagingController.itemList!
                .indexWhere((element) => element.id == id);
            if (index != -1) {
              pagingController.itemList![index] = data.data!;
              if (Get.find<PublicController>().notCount.value > 0) {
                Get.find<PublicController>().notCount.value =
                    Get.find<PublicController>().notCount.value - 1;
              }
              update(['updateList']);
            }
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: data.message ?? "");
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }
}
