import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/cities/cities.dart';
import 'package:hodhod/data/models/cities/cities_model.dart';
import 'package:hodhod/data/models/countries/countries.dart';
import 'package:hodhod/data/models/countries/countries_model.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:dio/dio.dart' as d;

class CountryBudgetController extends BaseController {
  SfRangeValues values = const SfRangeValues(100000.0, 1000.0);
  RxString startLabel = 1000.0.toString().obs;
  RxString endLabel = 1000000000.toString().obs;
  RxDouble startValue = 1000.0.obs;
  RxDouble endValue = 1000000000.0.obs;
  var phoneCode = "971".obs;
  var countryCode = 'AE'.obs;

  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  var isLoadingCountry = false.obs;
  var countryList = <Countries>[].obs;
  Rx<Countries> selectedCountry = Countries(name: "").obs;

  var isLoadingCity = false.obs;
  var cityList = <Cities>[].obs;
  Rx<Cities> selectedCity = Cities(name: "").obs;

  @override
  onInit() {
    super.onInit();
    minPriceController.text = startValue.value.toString();
    maxPriceController.text = endValue.value.toString();
    getCountries();
  }
  Future<void> updateProfileSettings() async {
    try {
      Map<String, dynamic> body = {
        'min_budget': storage.getPrice()?.fromPrice ?? "",
        'max_budget': storage.getPrice()?.toPrice ?? "",
        'country_id': storage.getCountry()?.id ?? "",
        'city_id': storage.getCity()?.id != 0 ? storage.getCity()?.id : null,
      };
      // if (storage.getCity()?.id != 0) {
      //   body['city_id'] = storage.getCity()?.id ?? "";
      // }
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.updateProfileSettings,
          method: Method.POST,
          params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            Get.offAllNamed(AppRoutes.home);
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: data.message!);
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  Future<void> getCountries() async {
    try {
      isLoadingCountry(true);
      final result = await httpService.request(
          url: ApiConstant.countries, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = CountriesModel.fromJson(result.data);
          countryList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            countryList.addAll(resp.data!);
          }
        }
      }
    } finally {
      isLoadingCountry(false);
      update(['selectedCountry']);
    }
  }

  Future<void> getCity(int countryId) async {
    try {
      isLoadingCity(true);
      Map<String, int> body = {
        'country_id': countryId,
      };
      final result = await httpService.request(
          url: ApiConstant.cities, method: Method.GET, params: body);
      if (result != null) {
        if (result is d.Response) {
          var resp = CitiesModel.fromJson(result.data);
          cityList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            cityList.add(Cities(name: LangKeys.all.tr, id: 0));
            cityList.addAll(resp.data!);
          }
        }
      }
    } finally {
      isLoadingCity(false);
      update(['selectedCity']);
    }
  }
}
