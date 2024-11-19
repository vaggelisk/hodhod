import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/types/enum.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/app/util/utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:hodhod/ui/language_controller.dart';
import 'package:hodhod/ui/settings_page/controller/more_model.dart';

import '../../../data/api/http_service.dart';
import 'package:dio/dio.dart' as d;

class SettingsPageController extends BaseController {
  var moreList = <MoreModel>[].obs;

  // User? user;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // user = storage.getUser();
    addMoreList();
    // getPages();
  }

  void updateUser() {
    // user = storage.getUser();
    update(['updateUser']);
  }

  /*
  Future<void> getPages() async {
    try {
      isLoading(true);
      final result =
          await httpService.request(url: ApiConstant.pages, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = PagesModel.fromJson(result.data);
          pagesList.clear();
          if (resp.pages != null && resp.pages!.isNotEmpty) {
            pagesList.addAll(resp.pages!);
          }
          for (var element in pagesList) {
            moreList.add(MoreModel(
                icon: element.iconUrl,
                isWeb: true,
                name: element.name,
                keyPage: element.slug,
                key: MoreType.aboutAs));
          }
          moreList.add(MoreModel(
              icon: Utils.getIconPath("ic_delete_account"),
              name: LangKeys.deleteAccount.tr,
              key: MoreType.deleteAccount));

          moreList.add(MoreModel(
              icon: Utils.getIconPath("ic_log_out"),
              name: LangKeys.logOut.tr,
              key: MoreType.signOut));
        }
      }
    } finally {
      update(['updateMoreMenuList']);
      isLoading(false);
    }
  }

   */
  void addMoreList() {
    if (storage.isAuth()) {
      moreList.add(MoreModel(
          icon: Utils.getIconPath("ic_user_profile"),
          name: LangKeys.profile.tr,
          key: MoreType.profile));
      moreList.add(MoreModel(
          icon: Utils.getIconPath("ic_account_verification"),
          name: LangKeys.accountVerification.tr,
          key: MoreType.accountVerification));
      moreList.add(MoreModel(
          icon: Utils.getIconPath("ic_add_real_estate"),
          name: LangKeys.addRealEstate.tr,
          key: MoreType.addRealEstate));
      // moreList.add(MoreModel(
      //     icon: Utils.getIconPath("ic_my_ads"),
      //     name: LangKeys.myAds.tr,
      //     key: MoreType.myAds));

      moreList.add(MoreModel(
          icon: Utils.getIconPath("ic_change_password"),
          name: LangKeys.changePassword.tr,
          key: MoreType.changePassword));
    }

    moreList.add(MoreModel(
        icon: Utils.getIconPath("ic_change_country_city"),
        name: LangKeys.changeCountryAndCity.tr,
        key: MoreType.changeCountryCity));

    moreList.add(MoreModel(
        icon: Utils.getIconPath("ic_change_language"),
        name: LangKeys.changeLanguage.tr,
        key: MoreType.changeLanguage));


    moreList.add(MoreModel(
        icon: Utils.getIconPath("ic_contact_us"),
        name: LangKeys.contactUs.tr,
        key: MoreType.contactUs));


    moreList.add(MoreModel(
        icon: Utils.getIconPath("ic_privacy_policy"),
        name: LangKeys.privacyPolicy.tr,
        key: MoreType.privacyPolicy));

    moreList.add(MoreModel(
        icon: Utils.getIconPath("ic_about_us"),
        name: LangKeys.aboutUs.tr,
        key: MoreType.aboutAs));

    if (storage.isAuth()) {
      moreList.add(MoreModel(
          icon: Utils.getIconPath("ic_technical_support"),
          name: LangKeys.technicalSupport.tr,
          key: MoreType.technicalSupport));
    }

    moreList.add(MoreModel(
        icon: Utils.getIconPath("ic_share_app"),
        name: LangKeys.shareApp.tr,
        key: MoreType.shareApp));

    if (storage.isAuth()) {
      moreList.add(MoreModel(
          icon: Utils.getIconPath("ic_delete_account"),
          name: LangKeys.deleteAccount.tr,
          key: MoreType.deleteAccount));

      moreList.add(MoreModel(
          icon: Utils.getIconPath("ic_logout"),
          name: LangKeys.logOut.tr,
          key: MoreType.signOut));
    }
  }

  Future<void> logout(bool isDeleteAccount) async {
    try {
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.logout, method: Method.POST);
      if (result != null) {
        if (result is d.Response) {
          var resp = GlobalModel.fromJson(result.data);
          if (resp.status == true) {
            if (isDeleteAccount == false) {
              UiErrorUtils.customSnackbar(
                  title: LangKeys.success.tr, msg: resp.message ?? "");
            }
            await FirebaseMessaging.instance
                .unsubscribeFromTopic('user_${storage.getUser()?.id}');
            storage.clearApp();
            Get.offAllNamed(AppRoutes.signIn);
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: resp.message ?? "");
          }
        } else {}
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  Future<void> updateLanguage(String lang) async {
    try {
      Map<String, dynamic> body = {
        'language': lang,
      };
      EasyLoading.show();
      final result = await httpService.request(
          url: ApiConstant.updateLanguage, method: Method.POST, params: body);
      if (result != null) {
        if (result is d.Response) {
          var data = GlobalModel.fromJson(result.data);
          if (data.status == true) {
            Get.find<LanguageController>().updateLocale(lang);
            // Get.offAllNamed(AppRoutes.home);
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
}
