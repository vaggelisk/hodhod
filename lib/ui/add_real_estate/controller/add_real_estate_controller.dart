import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/categories/categories.dart';
import 'package:hodhod/data/models/categories/categories_model.dart';
import 'package:hodhod/data/models/cities/cities.dart';
import 'package:hodhod/data/models/cities/cities_model.dart';
import 'package:hodhod/data/models/countries/countries.dart';
import 'package:hodhod/data/models/countries/countries_model.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/real_estates/real_estate_details_model.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/data/models/real_estates_constants/real_estate_constants.dart';
import 'package:hodhod/data/models/real_estates_constants/real_estate_constants_model.dart';
import 'package:hodhod/data/models/real_estates_features/real_estates_features.dart';
import 'package:hodhod/data/models/real_estates_features/real_estates_features_model.dart';
import 'package:hodhod/data/models/real_estates_types/real_estates_types.dart';
import 'package:hodhod/data/models/real_estates_types/real_estates_types_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as d;

import '../../../app/util/utils.dart';
import '../../../data/models/regions/regions.dart';
import '../../../data/models/regions/regions_model.dart';

class AddRealEstateController extends BaseController {
  bool? isEdit;
  int? estateId;
  var estateDetails = RealEstates().obs;

  /*----------------Start One-------------------------*/
  var isLoadingCategory = false.obs;
  var categoryList = <Categories>[].obs;

  // Rx<Categories> selectedCategory = Categories(name: "").obs;
  Rx<Categories> selectedCategory = Categories(name: "", id: 1).obs;

  var isLoadingSubCategory = false.obs;
  var subCategoryList = <Categories>[].obs;
  Rx<Categories> selectedSubCategory = Categories(name: "").obs;

  var isLoadingCountries = false.obs;
  var countriesList = <Countries>[].obs;
  Rx<Countries> selectedCountries = Countries(name: "").obs;

  var isLoadingCities = false.obs;
  var citiesList = <Cities>[].obs;
  Rx<Cities> selectedCities = Cities(name: "").obs;

  var isLoadingRegions = false.obs;
  var regionsList = <Regions>[].obs;
  Rx<Regions> selectedRegions = Regions(name: "").obs;

  var phoneCode = "971".obs;
  var countryCode = 'AE'.obs;
  final mobile = TextEditingController();
  final nameRealEstateArabic = TextEditingController();
  final nameRealEstateEnglish = TextEditingController();
  final price = TextEditingController();

  /*----------------End One-------------------------*/

  /*----------------Start Two-------------------------*/

  final propertyArea = TextEditingController();

  var isLoadingRealEstatesTypes = false.obs;
  var realEstatesTypesList = <RealEstatesTypes>[].obs;
  Rx<RealEstatesTypes> selectedRealEstatesTypes =
      RealEstatesTypes(name: "").obs;

  final addressDetails = TextEditingController();
  final locationName = TextEditingController();
  Rx<PickResult> locationResult = PickResult().obs;
  final descriptionProperty = TextEditingController();
  final landDepartmentPermitNumber = TextEditingController();

  /*----------------End Two-------------------------*/

  /*----------------Start Third-------------------------*/
  var isSelectedFeatures = false.obs;
  final numberRooms = TextEditingController();
  final numberBathrooms = TextEditingController();
  final numberFloors = TextEditingController();
  final propertyFeatures = TextEditingController();

  /*----------------End Third-------------------------*/

  /*----------------Start Four-------------------------*/
  late List<XFile> images;
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  var isLoadingRealEstatesConstants = false.obs;

  var realEstateCompleteStatusList = <RealEstateConstants>[].obs;
  Rx<RealEstateConstants> selectedRealEstateCompleteStatus =
      RealEstateConstants(name: "").obs;

  var realEstateActionTypeList = <RealEstateConstants>[].obs;
  Rx<RealEstateConstants> selectedRealEstateActionType =
      RealEstateConstants(name: "").obs;

  var realEstateTransactionTypeList = <RealEstateConstants>[].obs;
  Rx<RealEstateConstants> selectedRealEstateTransactionType =
      RealEstateConstants(name: "").obs;

  /*----------------End Four-------------------------*/

  var realEstatesFeaturesList = <RealEstatesFeatures>[].obs;
  var realEstatesFeaturesSelectedList = <int>[];
  var isLoadingRealEstatesFeatures = false.obs;
  final experience = TextEditingController();
  final language = TextEditingController();
  final personalProfile = TextEditingController();
  final brokerNumberRealEstate = TextEditingController();
  final brokerNumberOrn = TextEditingController();
  final licenseNumber = TextEditingController();
  final licenseExpirationDate = TextEditingController();

  // User? user;

  String? fullMobile;

  Future<bool?> isMobileValid() async {
    bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    fullMobile = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: mobile.text, isoCode: countryCode.value);
    // print("Log fullMobile $fullMobile");
    return isValid;
  }

  @override
  void onInit() {
    super.onInit();
    isEdit = Get.arguments['isEdit'] ?? false;
    estateId = Get.arguments['estateId'];
    images = <XFile>[];
    // getUserInfo();
    if (isEdit != true) {
      selectedCountries.value = storage.getCountry()!;
      // getCategories();
      getSubCategories(1);
      getCities(storage.getCountry()?.id ?? 0);
      getRealEstatesTypes();
      getRealEstatesConstants();
    } else {
      getRealEstatesDetails();
    }
  }

  Future<void> getRealEstatesDetails() async {
    try {
      EasyLoading.show();
      final result = await httpService.request(
          url: "${ApiConstant.realEstates}/$estateId", method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = RealEstateDetailsModel.fromJson(result.data);
          estateDetails.value = resp.data!;
          /* ------------------start one ----------------------*/
          getSubCategories(1);
          // getCategories();
          phoneCode.value =
              estateDetails.value.countryCode!.replaceAll("+", "");
          countryCode.value = estateDetails.value.countryIso ?? "";
          mobile.text = estateDetails.value.mobile!
              .replaceAll(estateDetails.value.countryCode ?? "", "");
          nameRealEstateArabic.text = estateDetails.value.titleLocal?.ar ?? "";
          nameRealEstateEnglish.text = estateDetails.value.titleLocal?.en ?? "";
          price.text = estateDetails.value.price != null &&
                  estateDetails.value.price != ""
              ? Utils.formatInputPrice(estateDetails.value.price ?? 0)
              : estateDetails.value.price.toString();
          // price.text = estateDetails.value.price.toString() ?? "";
          getCountries();
          /* ------------------end one ----------------------*/

          /* ------------------start two ----------------------*/
          getRealEstatesTypes();
          propertyArea.text = estateDetails.value.space.toString();
          addressDetails.text = estateDetails.value.address ?? "";
          descriptionProperty.text = estateDetails.value.description ?? "";
          landDepartmentPermitNumber.text =
              estateDetails.value.permitNumber ?? "";
          // final locationName;
          /* ------------------end two ----------------------*/

          /* ------------------start third ----------------------*/
          numberRooms.text = estateDetails.value.numberOfRooms != null &&
                  estateDetails.value.numberOfRooms.toString() != "0"
              ? estateDetails.value.numberOfRooms.toString()
              : "";
          numberBathrooms.text =
              estateDetails.value.numberOfBathrooms != null &&
                      estateDetails.value.numberOfBathrooms.toString() != "0"
                  ? estateDetails.value.numberOfBathrooms.toString()
                  : "";
          numberFloors.text = estateDetails.value.numberOfFloors != null &&
                  estateDetails.value.numberOfFloors.toString() != "0"
              ? estateDetails.value.numberOfFloors.toString()
              : "";

          String? featuresStr = "";
          for (var element in estateDetails.value.features!) {
            featuresStr = "$featuresStr${element.name ?? ""},";
            realEstatesFeaturesSelectedList.add(element.id ?? 0);
          }
          propertyFeatures.text = featuresStr ?? "";
          /* ------------------end third ----------------------*/
          /* ------------------start four ----------------------*/
          update(['oldImages']);
          getRealEstatesConstants();
          /* ------------------end four ----------------------*/
        }
      }
    } finally {
      EasyLoading.dismiss();
      update(['updateDetails']);
    }
  }

  Future<void> validationOne() async {
    // if (selectedCategory.value.name == "") {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.chooseCategory.tr);
    //   return;
    // }
    if (selectedSubCategory.value.name == "") {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.choosePropertyCategory.tr);
      return;
    }
    if (selectedRealEstatesTypes.value.name == "") {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.choosePropertyType.tr);
      return;
    }
    if (propertyFeatures.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr,
          msg: LangKeys.choosePropertySpecificationsAndFeatures.tr);
      return;
    }
    if (selectedRealEstateActionType.value.name == "") {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.thisPropertyIs.tr);
      return;
    }
    if (selectedRealEstateActionType.value.key == "sale") {
      if (selectedRealEstateCompleteStatus.value.name == "") {
        UiErrorUtils.customSnackbar(
            title: LangKeys.error.tr, msg: LangKeys.choosePropertyStatus.tr);
        return;
      }
    }
    if (propertyArea.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterPropertyArea.tr);
      return;
    }
    if (price.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterPropertyPrice.tr);
      return;
    }
    if (nameRealEstateArabic.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterPropertyName.tr);
      return;
    }
    if (selectedRealEstateTransactionType.value.name == "") {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.realEstateTransactions.tr);
      return;
    }
    // if (nameRealEstateEnglish.text.isEmpty) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr,
    //       msg: LangKeys.enterNameRealEstateEnglish.tr);
    //   return;
    // }
    if (mobile.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterMobileNumber.tr);
      return;
    }
    bool? isValid = await isMobileValid();
    if (!isValid!) {
      Get.snackbar(LangKeys.error.tr, LangKeys.enterMobileNumberCorrectly.tr);
      return;
    }

    Get.toNamed(AppRoutes.addRealEstateTwo);
  }

  Future<void> validationTwo() async {
    if (isEdit == true) {
      if (selectedCountries.value.name == "") {
        UiErrorUtils.customSnackbar(
            title: LangKeys.error.tr, msg: LangKeys.selectedCountry.tr);
        return;
      }
    }
    if (selectedCities.value.name == "") {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.selectedCity.tr);
      return;
    }

    // if (selectedRegions.value.name == "") {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.chooseRegion.tr);
    //   return;
    // }

    // if (addressDetails.text.isEmpty) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.enterAddressDetails.tr);
    //   return;
    // }
    if (isEdit != true) {
      if (locationResult.value.formattedAddress == null) {
        UiErrorUtils.customSnackbar(
            title: LangKeys.error.tr, msg: LangKeys.locatePropertyOnMap.tr);
        return;
      }
    }

    Get.toNamed(AppRoutes.addRealEstateFour);
  }

  Future<void> validationThird() async {
    // if (numberRooms.text.isEmpty) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.enterNumberRooms.tr);
    //   return;
    // }
    // if (numberBathrooms.text.isEmpty) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.enterNumberBathrooms.tr);
    //   return;
    // }

    Get.toNamed(AppRoutes.addRealEstateFour);
  }

  Future<void> validationFour() async {
    if (isEdit == false) {
      if (image == null) {
        UiErrorUtils.customSnackbar(
            title: LangKeys.error.tr, msg: LangKeys.attachPhotoMainProperty.tr);
        return;
      }
      if (images.isEmpty) {
        UiErrorUtils.customSnackbar(
            title: LangKeys.error.tr, msg: LangKeys.attachPhotosProperty.tr);
        return;
      }

      // if (landDepartmentPermitNumber.text.isEmpty) {
      //   UiErrorUtils.customSnackbar(
      //       title: LangKeys.error.tr,
      //       msg: LangKeys.landDepartmentPermitNumber.tr);
      //   return;
      // }
      if (descriptionProperty.text.isEmpty) {
        UiErrorUtils.customSnackbar(
            title: LangKeys.error.tr,
            msg: LangKeys.enterDescriptionProperty.tr);
        return;
      }
    }

    if (isEdit == true) {
      editRealEstates();
    } else {
      addRealEstates();
    }

    // Get.toNamed(AppRoutes.addRealEstateFour);
  }

  Future<void> editRealEstates() async {
    try {
      EasyLoading.show();
      Map<String, dynamic>? body;
      body = {
        '_method': "PUT",
        'category_id': selectedCategory.value.id ?? 0,
        'sub_category_id': selectedSubCategory.value.id ?? 0,
        'real_estate_type_id': selectedRealEstatesTypes.value.id ?? 0,
        'title[ar]': nameRealEstateArabic.text,
        'title[en]': nameRealEstateArabic.text,
        'title[el]': nameRealEstateArabic.text,
        'description[ar]': descriptionProperty.text,
        'description[en]': descriptionProperty.text,
        'description[el]': descriptionProperty.text,
        'mobile': fullMobile ?? "",
        "country_code": "+${phoneCode.value}",
        "country_iso": countryCode.value,
        "price": price.text.replaceAll(",", ""),
        'country_id': selectedCountries.value.id ?? 0,
        'currency_id': selectedCountries.value.currency?.id ?? 0,
        'city_id': selectedCities.value.id ?? 0,
        'region_id':
            selectedRegions.value.name != "" ? selectedRegions.value.id : null,
        'address': addressDetails.text,
        'latitude': locationResult.value.geometry?.location != null
            ? locationResult.value.geometry?.location.lat
            : estateDetails.value.latitude,
        'longitude': locationResult.value.geometry?.location != null
            ? locationResult.value.geometry?.location.lng
            : estateDetails.value.longitude,
        'permit_number': landDepartmentPermitNumber.text,
        'number_of_floors':
            numberFloors.text.isNotEmpty ? numberFloors.text : "0",
        'number_of_rooms': numberRooms.text.isNotEmpty ? numberRooms.text : "0",
        'number_of_bathrooms':
            numberBathrooms.text.isNotEmpty ? numberBathrooms.text : "0",
        'real_estate_status': selectedRealEstateActionType.value.key == "sale"
            ? selectedRealEstateCompleteStatus.value.key
            : "completed",
        'type': selectedRealEstateActionType.value.key,
        'transaction_type': selectedRealEstateTransactionType.value.key,
        'type_status': estateDetails.value.typeStatusKey ?? "",
        'space': propertyArea.text,
        // 'real_estate_feature_id[]': realEstatesFeaturesSelectedList,
      };
      if (realEstatesFeaturesSelectedList.isNotEmpty) {
        for (int i = 0; i < realEstatesFeaturesSelectedList.length; i++) {
          body['real_estate_feature_id[$i]'] =
              realEstatesFeaturesSelectedList[i];
        }
      }
      if (image != null) {
        body['image'] = await d.MultipartFile.fromFile(image!.path);
      }
      if (images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          body['images[$i]'] = await d.MultipartFile.fromFile(images[i].path);
        }
      }
      final formData = d.FormData.fromMap(body);

      final result = await httpService.request(
          url: "${ApiConstant.realEstates}/$estateId",
          method: Method.POST,
          isUploadImg: true,
          formData: formData);
      if (result != null) {
        if (result is d.Response) {
          var resp = GlobalModel.fromJson(result.data);
          if (resp.status == true) {
            showSuccessBottomSheet(resp.message ?? "", onClick: () {
              Get.back();
              // if (Get.isRegistered<MyRealEstateController>()) {
              //   Get.find<MyRealEstateController>().pagingController.refresh();
              // }
              Get.offAllNamed(AppRoutes.home);
            });
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: resp.message ?? "");
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  Future<void> addRealEstates() async {
    try {
      EasyLoading.show();
      Map<String, dynamic>? body;
      body = {
        'category_id': selectedCategory.value.id ?? 0,
        'sub_category_id': selectedSubCategory.value.id ?? 0,
        'real_estate_type_id': selectedRealEstatesTypes.value.id ?? 0,
        'title[ar]': nameRealEstateArabic.text,
        'title[en]': nameRealEstateArabic.text,
        'title[el]': nameRealEstateArabic.text,
        'description[ar]': descriptionProperty.text,
        'description[en]': descriptionProperty.text,
        'description[el]': descriptionProperty.text,
        'mobile': fullMobile ?? "",
        "country_code": "+${phoneCode.value}",
        "country_iso": countryCode.value,
        "price": price.text.replaceAll(",", ""),
        'country_id': storage.getCountry()?.id ?? 0,
        'currency_id': selectedCountries.value.currency?.id ?? 0,
        'city_id': selectedCities.value.id ?? 0,
        'region_id':
            selectedRegions.value.name != "" ? selectedRegions.value.id : null,
        'address': addressDetails.text,
        'latitude': locationResult.value.geometry?.location.lat,
        'longitude': locationResult.value.geometry?.location.lng,
        'permit_number': landDepartmentPermitNumber.text,
        'number_of_floors':
            numberFloors.text.isNotEmpty ? numberFloors.text : "0",
        'number_of_rooms': numberRooms.text.isNotEmpty ? numberRooms.text : "0",
        'number_of_bathrooms':
            numberBathrooms.text.isNotEmpty ? numberBathrooms.text : "0",
        'real_estate_status': selectedRealEstateActionType.value.key == "sale"
            ? selectedRealEstateCompleteStatus.value.key
            : "completed",
        'type': selectedRealEstateActionType.value.key,
        'transaction_type': selectedRealEstateTransactionType.value.key,
        'type_status': "available",
        'space': propertyArea.text,
        // 'real_estate_feature_id[]': realEstatesFeaturesSelectedList,
        'image': await d.MultipartFile.fromFile(image!.path)
      };
      if (realEstatesFeaturesSelectedList.isNotEmpty) {
        // var json = jsonEncode(customFieldList.map((e) => e.toJson()).toList());
        // body['custom_fields'] = json.toString();
        for (int i = 0; i < realEstatesFeaturesSelectedList.length; i++) {
          body['real_estate_feature_id[$i]'] =
              realEstatesFeaturesSelectedList[i];
        }
      }
      for (int i = 0; i < images.length; i++) {
        body['images[$i]'] = await d.MultipartFile.fromFile(images[i].path);
      }
      final formData = d.FormData.fromMap(body);

      final result = await httpService.request(
          url: ApiConstant.realEstates,
          method: Method.POST,
          isUploadImg: true,
          formData: formData);
      if (result != null) {
        if (result is d.Response) {
          var resp = GlobalModel.fromJson(result.data);
          if (resp.status == true) {
            showSuccessBottomSheet(resp.message ?? "", onClick: () {
              Get.back();
              Get.offAllNamed(AppRoutes.home);
            });
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: resp.message ?? "");
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  Future<void> getRealEstatesConstants() async {
    try {
      isLoadingRealEstatesConstants(true);
      final result = await httpService.request(
          url: ApiConstant.realEstatesConstants, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = RealEstateConstantsModel.fromJson(result.data);
          realEstateCompleteStatusList.clear();
          realEstateActionTypeList.clear();
          realEstateTransactionTypeList.clear();

          if (resp.data != null) {
            if (resp.data!.realEstateCompleteStatus != null) {
              realEstateCompleteStatusList
                  .addAll(resp.data!.realEstateCompleteStatus!);
            }
            if (resp.data!.realEstateActionType != null) {
              realEstateActionTypeList.addAll(resp.data!.realEstateActionType!);
            }
            if (resp.data!.realEstateTransactionType != null) {
              realEstateTransactionTypeList
                  .addAll(resp.data!.realEstateTransactionType!);
            }
            if (isEdit == true) {
              var realEstateCompleteStatus = realEstateCompleteStatusList
                  .where(
                      (p0) => p0.key == estateDetails.value.realEstateStatusKey)
                  .firstOrNull;
              if (realEstateCompleteStatus != null) {
                selectedRealEstateCompleteStatus.value =
                    realEstateCompleteStatus;
              }

              var realEstateActionType = realEstateActionTypeList
                  .where((p0) => p0.key == estateDetails.value.typeKey)
                  .firstOrNull;
              if (realEstateActionType != null) {
                selectedRealEstateActionType.value = realEstateActionType;
              }

              var realEstateTransactionType = realEstateTransactionTypeList
                  .where(
                      (p0) => p0.key == estateDetails.value.transactionTypeKey)
                  .firstOrNull;
              if (realEstateTransactionType != null) {
                selectedRealEstateTransactionType.value =
                    realEstateTransactionType;
              }
            }
          }
        }
      }
    } finally {
      isLoadingRealEstatesConstants(false);
      update(['selectedRealEstateCompleteStatus']);
      update(['selectedRealEstateActionType']);
      update(['selectedRealEstateTransactionType']);
    }
  }

  Future<void> getRealEstatesFeatures() async {
    try {
      isLoadingRealEstatesFeatures(true);
      final result = await httpService.request(
          url: ApiConstant.realEstatesFeatures, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = RealEstatesFeaturesModel.fromJson(result.data);
          realEstatesFeaturesList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            realEstatesFeaturesList.addAll(resp.data!);
          }
        }
      }
    } finally {
      isLoadingRealEstatesFeatures(false);
      update(['selectedRealEstatesFeatures']);
    }
  }

  Future<void> getCategories() async {
    try {
      isLoadingCategory(true);
      final result = await httpService.request(
          url: ApiConstant.categories, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = CategoriesModel.fromJson(result.data);
          categoryList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            categoryList.addAll(resp.data!);
          }
          if (isEdit == true) {
            var cat = categoryList
                .where((p0) =>
                    p0.id ==
                    int.parse(estateDetails.value.categoryId.toString() ?? "0"))
                .firstOrNull;
            if (cat != null) {
              selectedCategory.value = cat;
              getSubCategories(selectedCategory.value.id ?? 0);
            }
          }
        }
      }
    } finally {
      isLoadingCategory(false);
      update(['selectedCategory']);
    }
  }

  Future<void> getSubCategories(int categoryId) async {
    try {
      isLoadingSubCategory(true);
      Map<String, int> body = {
        'category_id': categoryId,
      };
      final result = await httpService.request(
          url: ApiConstant.subCategories, method: Method.GET, params: body);
      if (result != null) {
        if (result is d.Response) {
          var resp = CategoriesModel.fromJson(result.data);
          subCategoryList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            subCategoryList.addAll(resp.data!);
          }
          if (isEdit == true) {
            if (estateDetails.value.subCategoryId != null &&
                estateDetails.value.subCategoryId != "0") {
              var subCat = subCategoryList
                  .where((p0) =>
                      p0.id ==
                      int.parse(
                          estateDetails.value.subCategoryId.toString() ?? "0"))
                  .firstOrNull;
              if (subCat != null) {
                selectedSubCategory.value = subCat;
              }
            }
          }
        }
      }
    } finally {
      isLoadingSubCategory(false);
      update(['selectedSubCategory']);
    }
  }

  Future<void> getCountries() async {
    try {
      isLoadingCountries(true);
      final result = await httpService.request(
          url: ApiConstant.countries, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = CountriesModel.fromJson(result.data);
          countriesList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            countriesList.addAll(resp.data!);
          }
          if (isEdit == true) {
            var country = countriesList
                .where((p0) =>
                    p0.id ==
                    int.parse(estateDetails.value.countryId.toString() ?? "0"))
                .firstOrNull;
            if (country != null) {
              selectedCountries.value = country;
              getCities(selectedCountries.value.id ?? 0);
            }
          }
        }
      }
    } finally {
      isLoadingCountries(false);
      update(['selectedCountries']);
    }
  }

  Future<void> getCities(int countryId) async {
    try {
      isLoadingCities(true);
      Map<String, int> body = {
        'country_id': countryId,
      };
      final result = await httpService.request(
          url: ApiConstant.cities, method: Method.GET, params: body);
      if (result != null) {
        if (result is d.Response) {
          var resp = CitiesModel.fromJson(result.data);
          citiesList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            citiesList.addAll(resp.data!);
          }
          if (isEdit == true) {
            if (estateDetails.value.cityId != null &&
                estateDetails.value.cityId != "0") {
              var city = citiesList
                  .where((p0) =>
                      p0.id ==
                      int.parse(estateDetails.value.cityId.toString() ?? "0"))
                  .firstOrNull;
              if (city != null) {
                selectedCities.value = city;
                getRegions(selectedCities.value.id ?? 0);
              }
            }
          }
        }
      }
    } finally {
      isLoadingCities(false);
      update(['selectedCities']);
    }
  }

  Future<void> getRegions(int cityId) async {
    try {
      isLoadingRegions(true);
      Map<String, int> body = {
        'city_id': cityId,
      };
      final result = await httpService.request(
          url: ApiConstant.regions, method: Method.GET, params: body);
      if (result != null) {
        if (result is d.Response) {
          var resp = RegionsModel.fromJson(result.data);
          regionsList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            regionsList.addAll(resp.data!);
          }
          if (isEdit == true) {
            if (estateDetails.value.regionId != null &&
                estateDetails.value.regionId != "0") {
              var region = regionsList
                  .where((p0) =>
                      p0.id ==
                      int.parse(estateDetails.value.regionId.toString() ?? "0"))
                  .firstOrNull;
              if (region != null) {
                selectedRegions.value = region;
              }
            }
          }
        }
      }
    } finally {
      isLoadingRegions(false);
      update(['selectedRegions']);
    }
  }

  Future<void> getRealEstatesTypes() async {
    try {
      isLoadingRealEstatesTypes(true);
      final result = await httpService.request(
          url: ApiConstant.realEstatesTypes, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = RealEstatesTypesModel.fromJson(result.data);
          realEstatesTypesList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            realEstatesTypesList.addAll(resp.data!);
          }
          if (isEdit == true) {
            var realEstateType = realEstatesTypesList
                .where((p0) =>
                    p0.id ==
                    int.parse(
                        estateDetails.value.realEstateTypeId.toString() ?? "0"))
                .firstOrNull;
            if (realEstateType != null) {
              selectedRealEstatesTypes.value = realEstateType;
            }
          }
        }
      }
    } finally {
      isLoadingRealEstatesTypes(false);
      update(['selectedRealEstatesTypes']);
    }
  }

  void showPlacePicker() async {
    // try {
    //   locationResult.value = await Get.to(PlacePicker(
    //       "AIzaSyDCKrRODi8noc3OQfrBfIWEw1snU0tBkss",
    //       localizationItem: LocalizationItem(
    //           languageCode: storage.languageCode != null
    //               ? "${storage.languageCode!}_us"
    //               : 'ar_ps',
    //           nearBy: "الاماكن القريبة",
    //           tapToSelectLocation: "اختر الموقع",
    //           findingPlace: "العثور علي المواقع",
    //           noResultsFound: LangKeys.noResultsFound.tr,
    //           unnamedLocation: "قبول")));
    //   print(locationResult.value.latLng);
    // } catch (e) {
    //   e.printError();
    // }

    // Handle the result in your way
  }

  Future<void> deleteImage(int imageId) async {
    try {
      EasyLoading.show();
      final result = await httpService.request(
          url: "${ApiConstant.realEstates}/$estateId/images/$imageId",
          method: Method.DELETE);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            if (estateDetails.value.images != null &&
                estateDetails.value.images!.isNotEmpty) {
              int index = estateDetails.value.images!
                  .indexWhere((element) => element.id == imageId);
              estateDetails.value.images!.removeAt(index);
              update(['oldImages']);
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

  Future<void> selectImage({bool isMulti = false}) async {
    if (Platform.isAndroid) {
      final androidVersion = await DeviceInfoPlugin().androidInfo;
      if ((androidVersion.version.sdkInt) >= 33) {
        if (await Permission.camera.request().isGranted &&
            await Permission.photos.request().isGranted) {
          if (isMulti) {
            images = await _picker.pickMultiImage(imageQuality: 80);
            if (images.isNotEmpty) {
              print(images[0].path);
              update(['selectImages']);
            }
          } else {
            showPicker();
          }
        } else {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.photos,
            Permission.camera,
          ].request();
        }
      } else {
        if (await Permission.camera.request().isGranted &&
            await Permission.storage.request().isGranted) {
          if (isMulti) {
            images = await _picker.pickMultiImage(imageQuality: 80);
            if (images.isNotEmpty) {
              print(images[0].path);

              update(['selectImages']);
            }
          } else {
            showPicker();
          }
        } else {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
            Permission.camera,
          ].request();
        }
      }
    }
    if (Platform.isIOS) {
      if (isMulti) {
        images = await _picker.pickMultiImage(imageQuality: 80);
        if (images.isNotEmpty) {
          print(images[0].path);
          update(['selectImages']);
        }
      } else {
        showPicker();
      }
    }
  }

  void showPicker() async {
    Get.bottomSheet(SafeArea(
      child: Container(
        color: Colors.white,
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text("الاستديو"),
                onTap: () {
                  _imgFromGallery();
                  Get.back();
                }),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text("الكاميرا"),
              onTap: () {
                _imgFromCamera();
                Get.back();
              },
            ),
          ],
        ),
      ),
    ));
  }

  _imgFromGallery() async {
    image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      // if (kDebugMode) {
      print(image?.path);
      // }path
      update(['selectImage']);
    }
  }

  _imgFromCamera() async {
    image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (image != null) {
      // if (kDebugMode) {
      print(image?.path);
      // }
      update(['selectImage']);
    }
  }
}
