import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/real_estates_constants/real_estate_constants.dart';
import 'package:hodhod/data/models/real_estates_features/real_estates_features.dart';
import 'package:hodhod/data/models/real_estates_types/real_estates_types.dart';
import 'package:hodhod/data/models/search_filter/search_filter_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:dio/dio.dart' as d;
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SearchFilterController extends BaseController {
  var isLoadingRealEstatesConstants = false.obs;
  final propertyFeatures = TextEditingController();
  var realEstatesFeaturesSelectedList = <int>[];

  var realEstatesTypesList = <RealEstatesTypes>[].obs;
  Rx<RealEstatesTypes> selectedRealEstatesTypes =
      RealEstatesTypes(name: "").obs;

  var typeList = <RealEstateConstants>[].obs;
  Rx<RealEstateConstants> selectedType = RealEstateConstants(name: "").obs;

  var sortList = <RealEstateConstants>[].obs;
  Rx<RealEstateConstants> selectedSort = RealEstateConstants(name: "").obs;

  var roomsList = <int>[].obs;
  var selectRooms = 0.obs;
  var bathRoomsList = <int>[].obs;
  var selectBathRooms = 0.obs;

  final numberRooms = TextEditingController();
  final numberBathrooms = TextEditingController();
  final numberFloors = TextEditingController();

  var realEstatesFeaturesList = <RealEstatesFeatures>[].obs;
  SfRangeValues values = const SfRangeValues(1000.0, 1000000000);
  RxString startLabel = 1000.0.toString().obs;
  RxString endLabel = 1000000000.toString().obs;
  RxDouble startValue = 1000.0.obs;
  RxDouble endValue = 1000000000.0.obs;

  SfRangeValues valuesSpace = const SfRangeValues(0, 50000);
  RxString startSpaceLabel = 0.toString().obs;
  RxString endSpaceLabel = 50000.toString().obs;
  RxDouble startSpaceValue = 0.0.obs;
  RxDouble endSpaceValue = 50000.0.obs;

  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  final minSpacePriceController = TextEditingController();
  final maxSpacePriceController = TextEditingController();

  @override
  onInit() {
    super.onInit();
    minSpacePriceController.text = startSpaceValue.value.toString();
    maxSpacePriceController.text = endSpaceValue.value.toString();
    minPriceController.text = startValue.value.toString();
    maxPriceController.text = endValue.value.toString();
    getSearchFilter();
  }

  Future<void> getSearchFilter() async {
    try {
      isLoadingRealEstatesConstants(true);
      final result = await httpService.request(
          url: ApiConstant.searchFilter, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = SearchFilterModel.fromJson(result.data);
          realEstatesTypesList.clear();
          realEstatesFeaturesList.clear();
          typeList.clear();
          roomsList.clear();
          sortList.clear();
          if (resp.data != null) {
            if (resp.data!.realEstateTypes != null) {
              realEstatesTypesList.addAll(resp.data!.realEstateTypes!);
            }
            if (resp.data!.featuresIds != null) {
              realEstatesFeaturesList.addAll(resp.data!.featuresIds!);
            }
            if (resp.data!.sortBy != null) {
              sortList.addAll(resp.data!.sortBy!);
            }
            if (resp.data!.type != null) {
              typeList.addAll(resp.data!.type!);
            }
            if (resp.data!.numberOfRooms != null) {
              roomsList.addAll(resp.data!.numberOfRooms!);
            }
            if (resp.data!.numberOfBathrooms != null) {
              bathRoomsList.addAll(resp.data!.numberOfBathrooms!);
            }
          }
        }
      }
    } finally {
      isLoadingRealEstatesConstants(false);
      update(['updateUi']);
      update(['selectedType']);
      update(['selectedRealEstateType']);
      update(['selectedSortBy']);
      update(['selectedRooms']);
      update(['selectedBathrooms']);
    }
  }
}
