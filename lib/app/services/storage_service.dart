import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hodhod/data/models/cities/cities.dart';
import 'package:hodhod/data/models/company_profile/company_profile.dart';
import 'package:hodhod/data/models/countries/countries.dart';
import 'package:hodhod/data/models/search_filter/price.dart';
import 'package:hodhod/data/models/user/user.dart';

class StorageService extends GetxService {
  String? languageCode;
  String? countryCode;
  String? deviceId;
  String? version;
  String? timezone = "Asia/Amman";
  String? appVersion = "1.0";

  Future<StorageService> init() async {
    await GetStorage.init();
    languageCode = GetStorage().read('languageCode');
    countryCode = GetStorage().read('countryCode');
    // languageCode ??= Get.deviceLocale!.languageCode;
    print("Log languageCode $languageCode");
    print("Log countryCode $countryCode");
    if (languageCode == null || languageCode == "") {
      languageCode = Get.deviceLocale!.languageCode;
      countryCode = Get.deviceLocale!.countryCode;
    }
    return this;
  }

  User? getUser() {
    if (GetStorage().read("user_hodhod") != null) {
      return User.fromJson(GetStorage().read("user_hodhod"));
    }
    return null;
  }

  CompanyProfile? getCompanyProfile() {
    if (GetStorage().read("company_profile_hodhod") != null) {
      return CompanyProfile.fromJson(
          GetStorage().read("company_profile_hodhod"));
    }
    return null;
  }

  Countries? getCountry() {
    if (GetStorage().read("country_hodhod") != null) {
      return Countries.fromJson(GetStorage().read("country_hodhod"));
    }
    return null;
  }

  Cities? getCity() {
    if (GetStorage().read("city_hodhod") != null) {
      return Cities.fromJson(GetStorage().read("city_hodhod"));
    }
    return null;
  }

  Price? getPrice() {
    if (GetStorage().read("price_hodhod") != null) {
      return Price.fromJson(GetStorage().read("price_hodhod"));
    }
    return null;
  }

  String getLanguageCode() {
    if (GetStorage().read("languageCode") != null) {
      return GetStorage().read("languageCode");
    }
    // return "en";
    return Get.deviceLocale?.languageCode == "ar" ||
            Get.deviceLocale?.languageCode == "en" ||
            Get.deviceLocale?.languageCode == "el"
        ? Get.deviceLocale?.languageCode ?? "en"
        : "en";
  }

  //
  // String? getFcmToken() {
  //   if (GetStorage().read("token") != null) {
  //     return GetStorage().read("token");
  //   }
  //   return null;
  // }
  //
  // void setFcmToken(String value) {
  //   GetStorage().write("token", value);
  // }
  //
  String? getToken() {
    if (GetStorage().read("token_hodhod") != null) {
      return GetStorage().read("token_hodhod");
    }
    return null;
  }

  //
  void setUserToken(String value) {
    GetStorage().write("token_hodhod", value);
  }

  bool isAuth() {
    if (GetStorage().read("token_hodhod") != null &&
        GetStorage().read("user_hodhod") != null) {
      return true;
    }
    return false;
  }

  void clearApp() {
    GetStorage().remove("user_hodhod");
    GetStorage().remove("token_hodhod");
    GetStorage().remove("company_profile_hodhod");
    // Get.find<PublicController>().currentBalance.value = "0";
  }

  void clearFirstData() {
    GetStorage().remove("country_hodhod");
    GetStorage().remove("city_hodhod");
    GetStorage().remove("price_hodhod");
    // Get.find<PublicController>().currentBalance.value = "0";
  }

  void write(String key, dynamic value) {
    GetStorage().write(key, value);
  }

  bool isIntro() {
    if (GetStorage().read("is_intro_hodhod") != null) {
      return GetStorage().read("is_intro_hodhod");
    } else {
      return false;
    }
  }

  bool isLangFirst() {
    if (GetStorage().read("is_lang_first_hodhod") != null) {
      return GetStorage().read("is_lang_first_hodhod");
    } else {
      return false;
    }
  }

  void setIntro(bool isIntro) {
    GetStorage().write("is_intro_hodhod", isIntro);
  }

  void setLangFirst(bool isLang) {
    GetStorage().write("is_lang_first_hodhod", isLang);
  }

  //
  void setUser(User value) {
    GetStorage().write(
        "user_hodhod",
        User(
                name: value.name,
                id: value.id,
                countryCode: value.countryCode,
                countryIso: value.countryIso,
                createdAt: value.createdAt,
                email: value.email,
                emailVerifiedAt: value.emailVerifiedAt,
                image: value.image,
                isActive: value.isActive,
                mobile: value.mobile,
                language: value.language,
                mobileVerified: value.mobileVerified,
                mobileVerifiedAt: value.mobileVerifiedAt,
                notificationsCount: value.notificationsCount,
                readNotificationsCount: value.readNotificationsCount,
                uid: value.uid,
                unreadNotificationsCount: value.unreadNotificationsCount,
                updatedAt: value.updatedAt)
            .toJson());
  }

  void setCompanyProfile(CompanyProfile value) {
    GetStorage().write(
        "company_profile_hodhod",
        CompanyProfile(
                name: value.name,
                id: value.id,
                countryCode: value.countryCode,
                countryIso: value.countryIso,
                createdAt: value.createdAt,
                email: value.email,
                mobile: value.mobile,
                status: value.status,
                statusKey: value.statusKey,
                updatedAt: value.updatedAt)
            .toJson());
  }

  void setCountry(Countries value) {
    GetStorage().write(
        "country_hodhod",
        Countries(
                name: value.name,
                id: value.id,
                code: value.code,
                currency: value.currency,
                currencyId: value.currencyId,
                flag: value.flag,
                phoneCode: value.phoneCode)
            .toJson());
  }

  void setCity(Cities value) {
    GetStorage().write(
        "city_hodhod",
        Cities(name: value.name, id: value.id, countryId: value.countryId)
            .toJson());
  }

  void setPrice(Price value) {
    GetStorage().write("price_hodhod",
        Price(fromPrice: value.fromPrice, toPrice: value.toPrice).toJson());
  }
//
// Currency? getCurrency() {
//   if (GetStorage().read("user_currency") != null) {
//     return Currency.fromJson(GetStorage().read("user_currency"));
//   }
//   return Currency(key: "IQD", name: "IQD");
// }
//
// void setCurrency(Currency value) {
//   GetStorage().write(
//       "user_currency", Currency(key: value.key, name: value.name).toJson());
// }
}
