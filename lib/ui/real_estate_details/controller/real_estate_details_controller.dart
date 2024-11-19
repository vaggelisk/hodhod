import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/languages/language.dart';
import 'package:hodhod/data/models/real_estates/real_estate_details_model.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:hodhod/ui/favorite/controller/favorite_controller.dart';
import 'package:hodhod/ui/home_page/controller/home_page_controller.dart';
import 'package:hodhod/ui/search/controller/search_page_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class RealEstateDetailsController extends BaseController {
  var sliderIndex = 0.obs;
  var isLoading = false.obs;
  var isMoreComments = false.obs;
  var isLoadingComments = false.obs;
  var data = RealEstates().obs;

  // var commentsList = <Comment>[].obs;
  // final comment = TextEditingController();
  // final textFieldFocusNode = FocusNode();

  Completer<GoogleMapController> googleMapController = Completer();
  Set<Marker> markers = {};
  var lat = 0.0.obs;
  var lng = 0.0.obs;

  @override
  onInit() {
    super.onInit();
    getRealEstatesDetails();
    // getComments();
  }

  Future<void> getRealEstatesDetails() async {
    try {
      isLoading(true);
      final result = await httpService.request(
          url: "${ApiConstant.realEstates}/${Get.arguments['id']}",
          method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = RealEstateDetailsModel.fromJson(result.data);
          data.value = resp.data!;
          markers.clear();
          lat.value = double.parse(data.value.latitude.toString());
          lng.value = double.parse(data.value.longitude.toString());
          markers.add(Marker(
              markerId: const MarkerId('my_location'),
              position: LatLng(lat.value, lng.value),
              icon: BitmapDescriptor.defaultMarker,
              onTap: () {
                // print('Log ddddd');
                openMap(lat.value, lng.value);
              },
              infoWindow: const InfoWindow(title: "")));
          _goToNextLocation();
          // update(['refreshMap']);
        }
      }
    } finally {
      isLoading(false);
      update(['updateDetails']);
    }
  }

  Future<void> _goToNextLocation() async {
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(lat.value, lng.value),
            zoom: 16.151926040649414,
            // tilt: 59.440717697143555,
            bearing: 192.8334901395799),
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    addRealEstateAction("call");
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void launchWhatsApp(String phoneNumber) async {
    addRealEstateAction("whatsapp");
    String url = "https://wa.me/$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> addRealEstateAction(String type) async {
    try {
      Map<String, dynamic> body = {
        'real_estate_id': data.value.id ?? 0,
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

  Future<void> addOrRemoveFavorite() async {
    try {
      EasyLoading.show();
      final result = await httpService.request(
          url: "${ApiConstant.favorites}/${data.value.id ?? 0}",
          method: Method.POST);
      if (result != null) {
        if (result is d.Response) {
          var data2 = GlobalModel.fromJson(result.data);
          if (data2.status == true) {
            UiErrorUtils.customSnackbar(
                title: LangKeys.success.tr, msg: data2.message ?? "");
            data.value.isFavorite =
                data.value.isFavorite == false ? true : false;
            update(['updateDetails']);
            if (Get.isRegistered<HomePageController>()) {
              var homePageController = Get.find<HomePageController>();
              int index = homePageController.realEstatesMostRequestedList
                  .indexWhere((element) => element.id == data.value.id);
              if (index != -1) {
                homePageController.realEstatesMostRequestedList[index]
                    .isFavorite = data.value.isFavorite;
              }
              int index1 = homePageController.realEstatesMostViewedList
                  .indexWhere((element) => element.id == data.value.id);
              if (index1 != -1) {
                homePageController.realEstatesMostViewedList[index1]
                    .isFavorite = data.value.isFavorite;
              }
              int index3 = homePageController.realEstatesFinancierList
                  .indexWhere((element) => element.id == data.value.id);
              if (index3 != -1) {
                homePageController.realEstatesFinancierList[index3].isFavorite =
                    data.value.isFavorite;
              }
              homePageController.update(['updateHome']);
            }
            if (Get.isRegistered<SearchPageController>()) {
              var searchPageController = Get.find<SearchPageController>();
              searchPageController.pagingController.refresh();
            }
            if (Get.isRegistered<FavoriteController>()) {
              var favoritesController = Get.find<FavoriteController>();
              favoritesController.pagingController.refresh();
            }
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: data2.message ?? "");
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  String getLanguages(List<Language> langs) {
    var langStr = "";
    for (var i = 0; i < langs.length; i++) {
      if (i == langs.length - 1) {
        langStr = "$langStr${langs[i].name}";
      } else {
        langStr = "$langStr${langs[i].name},";
      }
    }
    return langStr;
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
