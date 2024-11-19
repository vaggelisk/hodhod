import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/real_estates/real_estate_model.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:hodhod/ui/home_page/controller/home_page_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FavoriteController extends BaseController {
  final PagingController<int, RealEstates> pagingController =
      PagingController(firstPageKey: 1);
  static const _pageSize = 10;

  @override
  onInit() {
    super.onInit();
    if (storage.isAuth()) {
      pagingController.addPageRequestListener((pageKey) {
        getFavorites(pageKey);
      });
    }
  }

  Future<void> getFavorites(int pageKey) async {
    try {
      Map<String, dynamic> body = {
        'page': pageKey,
      };

      final result = await httpService
          .request(url: ApiConstant.favorites, method: Method.GET, params: body)
          .catchError((onError) {
        pagingController.error = onError;
      });
      if (result != null) {
        if (result is d.Response) {
          var resp = RealEstateModel.fromJson(result.data);
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

  Future<void> addOrRemoveFavorite(int adsId) async {
    try {
      EasyLoading.show();
      final result = await httpService.request(
          url: "${ApiConstant.favorites}/$adsId", method: Method.POST);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            int index = pagingController.itemList!
                .indexWhere((element) => element.id == adsId);
            pagingController.itemList!.removeAt(index);
            update(['updateList']);
            if (Get.isRegistered<HomePageController>()) {
              var homePageController = Get.find<HomePageController>();
              int index = homePageController.realEstatesMostRequestedList
                  .indexWhere((element) => element.id == adsId);
              if (index != -1) {
                homePageController
                    .realEstatesMostRequestedList[index].isFavorite = false;
              }
              int index1 = homePageController.realEstatesMostViewedList
                  .indexWhere((element) => element.id == adsId);
              if (index1 != -1) {
                homePageController
                    .realEstatesMostViewedList[index1].isFavorite = false;
              }
              int index3 = homePageController.realEstatesFinancierList
                  .indexWhere((element) => element.id == adsId);
              if (index3 != -1) {
                homePageController.realEstatesFinancierList[index3].isFavorite =
                    false;
              }
              homePageController.update(['updateHome']);
            }
            UiErrorUtils.customSnackbar(
                title: LangKeys.success.tr, msg: data.message ?? "");
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
