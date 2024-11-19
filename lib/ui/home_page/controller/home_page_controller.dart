import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/categories/categories.dart';
import 'package:hodhod/data/models/company_profile/company_profile.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/home/ad.dart';
import 'package:hodhod/data/models/home/home_model.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/data/models/user/profile_model.dart';
import 'package:hodhod/data/models/user/user.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:hodhod/ui/favorite/controller/favorite_controller.dart';
import 'package:hodhod/ui/home/controller/home_controller.dart';
import 'package:hodhod/ui/public_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePageController extends BaseController {
  var isLoadingHome = false.obs;
  var isLoadingSubCategories = false.obs;

  var catId = 0.obs;
  var subCatId = 0.obs;
  var adsList = <Ad>[].obs;
  var categoriesList = <Categories>[].obs;
  var realEstatesMostRequestedList = <RealEstates>[].obs;
  var realEstatesFinancierList = <RealEstates>[].obs;
  var realEstatesMostViewedList = <RealEstates>[].obs;
  User? user;
  CompanyProfile? companyProfile;

  @override
  onInit() {
    super.onInit();
    getInfoUser();
    if (storage.isAuth()) {
      getUserInfo();
    }
    getHome();
  }

  void getInfoUser() {
    // update(['updateInfo']);
    user = storage.getUser();
    companyProfile = storage.getCompanyProfile();
    update(['updateInfo']);
  }

  Future<void> getHome() async {
    try {
      update(['updateHome']);
      isLoadingHome(true);
      Map<String, dynamic> body = {
        'from_price': storage.getPrice()?.fromPrice ?? "",
        'to_price': storage.getPrice()?.toPrice ?? "",
        'country_id': storage.getCountry()?.id ?? "",
        // 'city_id': storage.getCity()?.id ?? "",
      };
      if (storage.getCity()?.id != 0) {
        body['city_id'] = storage.getCity()?.id ?? "";
      }
      final result = await httpService.request(
          url: ApiConstant.home, method: Method.GET, params: body);
      if (result != null) {
        if (result is d.Response) {
          var resp = HomeModel.fromJson(result.data);
          if (resp.data != null) {
            Get.find<PublicController>().notCount.value =
                resp.data?.unreadNotificationsCount ?? 0;
            adsList.clear();
            categoriesList.clear();
            realEstatesMostRequestedList.clear();
            realEstatesMostViewedList.clear();
            realEstatesFinancierList.clear();
            if (resp.data!.ads != null && resp.data!.ads!.isNotEmpty) {
              adsList.addAll(resp.data!.ads!);
            }
            if (resp.data!.categories != null &&
                resp.data!.categories!.isNotEmpty) {
              categoriesList.addAll(resp.data!.categories!);
            }
            if (resp.data!.realEstatesMostRequested != null &&
                resp.data!.realEstatesMostRequested!.isNotEmpty) {
              realEstatesMostRequestedList
                  .addAll(resp.data!.realEstatesMostRequested!);
            }
            if (resp.data!.realEstatesFinancing != null &&
                resp.data!.realEstatesFinancing!.isNotEmpty) {
              realEstatesFinancierList.addAll(resp.data!.realEstatesFinancing!);
            }
            if (resp.data!.realEstatesMostViewed != null &&
                resp.data!.realEstatesMostViewed!.isNotEmpty) {
              realEstatesMostViewedList
                  .addAll(resp.data!.realEstatesMostViewed!);
            }
          }
        }
      }
    } finally {
      isLoadingHome(false);
      update(['updateHome']);
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
            int index = realEstatesMostRequestedList
                .indexWhere((element) => element.id == realId);
            if (index != -1) {
              realEstatesMostRequestedList[index].isFavorite =
                  isFav == false ? true : false;
            }

            int index2 = realEstatesMostViewedList
                .indexWhere((element) => element.id == realId);
            if (index2 != -1) {
              realEstatesMostViewedList[index2].isFavorite =
                  isFav == false ? true : false;
            }

            int index3 = realEstatesFinancierList
                .indexWhere((element) => element.id == realId);
            if (index3 != -1) {
              realEstatesFinancierList[index3].isFavorite =
                  isFav == false ? true : false;
            }
            update(['updateHome']);
            if (Get.isRegistered<FavoriteController>()) {
              Get.find<FavoriteController>().pagingController.refresh();
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

  Future<void> getUserInfo() async {
    try {
      // EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.getProfile, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = ProfileModel.fromJson(result.data);
          if (resp.data != null) {
            storage.setUser(resp.data!);
            storage.setCompanyProfile(
                resp.data!.companyProfile ?? CompanyProfile());
            if (Get.isRegistered<HomePageController>()) {
              Get.find<HomePageController>().getInfoUser();
            }
            user = resp.data!;
          }
        }
      }
    } finally {
      // EasyLoading.dismiss(animation: true);
    }
  }
}
