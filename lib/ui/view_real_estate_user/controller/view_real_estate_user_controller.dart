import 'package:flutter/cupertino.dart';
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
import 'package:hodhod/ui/favorite/controller/favorite_controller.dart';
import 'package:hodhod/ui/home_page/controller/home_page_controller.dart';
import 'package:hodhod/ui/real_estate_details/controller/real_estate_details_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewRealEstateUserController extends BaseController {
  final PagingController<int, RealEstates> pagingController =
      PagingController(firstPageKey: 1);
  static const _pageSize = 10;
  bool? isSort = false;
  bool? financing = false;
  dynamic userId = "0";
  String? sortKey = "";
  String? title = "";

  @override
  onInit() {
    super.onInit();
    isSort = Get.arguments['isSort'];
    financing = Get.arguments['financing'];
    userId = Get.arguments['userId'];
    sortKey = Get.arguments['sortKey'];
    title = Get.arguments['title'];
    pagingController.addPageRequestListener((pageKey) {
      getRealEstates(pageKey);
    });
  }

  Future<void> getRealEstates(int pageKey) async {
    try {
      Map<String, dynamic> body = {
        'page': pageKey,
        'country_id': storage.getCountry()?.id ?? "",
      };
      if (storage.getCity()?.id != 0) {
        body['city_id'] = storage.getCity()?.id ?? "";
      }
      if (isSort == true) {
        body['from_price'] = storage.getPrice()?.fromPrice ?? "";
        body['to_price'] = storage.getPrice()?.toPrice ?? "";

        if (financing == true) {
          body['financing'] = 1;
        } else {
          body['sort_by'] = sortKey;
        }
      } else {
        body['owner_id'] = userId;
      }
      final result = await httpService
          .request(url: ApiConstant.search, method: Method.GET, params: body)
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

  Future<void> addOrRemoveFavorite(int realId, bool isFav) async {
    try {
      EasyLoading.show();
      final result = await httpService.request(
          url: "${ApiConstant.favorites}/$realId", method: Method.POST);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            int index = pagingController.itemList!
                .indexWhere((element) => element.id == realId);
            pagingController.itemList![index].isFavorite =
                isFav == false ? true : false;
            update(['updateList']);
            if (Get.isRegistered<HomePageController>()) {
              var homePageController = Get.find<HomePageController>();
              int index = homePageController.realEstatesMostRequestedList
                  .indexWhere((element) => element.id == realId);
              if (index != -1) {
                homePageController.realEstatesMostRequestedList[index]
                    .isFavorite = isFav == false ? true : false;
              }
              int index1 = homePageController.realEstatesMostViewedList
                  .indexWhere((element) => element.id == realId);
              if (index1 != -1) {
                homePageController.realEstatesMostViewedList[index1]
                    .isFavorite = isFav == false ? true : false;
              }
              int index3 = homePageController.realEstatesFinancierList
                  .indexWhere((element) => element.id == realId);
              if (index3 != -1) {
                homePageController.realEstatesFinancierList[index3].isFavorite =
                    isFav == false ? true : false;
              }
              homePageController.update(['updateHome']);
            }
            if (Get.isRegistered<RealEstateDetailsController>()) {
              var realEstateDetailsController =
                  Get.find<RealEstateDetailsController>();
              if (realEstateDetailsController.data.value.id != null &&
                  realEstateDetailsController.data.value.id != 0) {
                if (realEstateDetailsController.data.value.id == realId) {
                  realEstateDetailsController.data.value.isFavorite =
                      isFav == false ? true : false;
                  realEstateDetailsController.update(['updateDetails']);
                }
              }
            }
            if (storage.isAuth()) {
              if (Get.isRegistered<FavoriteController>()) {
                Get.find<FavoriteController>().pagingController.refresh();
              }
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

  Future<void> makePhoneCall(String phoneNumber, int realEstateId) async {
    addRealEstateAction("call", realEstateId);
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void launchWhatsApp(String phoneNumber, int realEstateId) async {
    addRealEstateAction("whatsapp", realEstateId);
    String url = "https://wa.me/$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> addRealEstateAction(String type, int realEstateId) async {
    try {
      Map<String, dynamic> body = {
        'real_estate_id': realEstateId,
        'type': type,
      };
      // EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.addRealEstateAction,
          method: Method.POST,
          params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            // showSuccessBottomSheet(data.message ?? "", onClick: () {
            //   Get.back();
            //   Get.back();
            // });
          } else {
            // UiErrorUtils.customSnackbar(
            //     title: LangKeys.error.tr, msg: data.message!);
          }
        }
      }
    } finally {
      // EasyLoading.dismiss(animation: true);
    }
  }
}
