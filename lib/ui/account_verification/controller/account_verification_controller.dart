import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/company_profile/company_profile.dart';
import 'package:hodhod/data/models/company_profile/company_profile_model.dart';
import 'package:hodhod/data/models/gender_model.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:hodhod/data/models/languages/language.dart';
import 'package:hodhod/data/models/languages/languages_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as d;

class AccountVerificationController extends BaseController {
  final ImagePicker _picker = ImagePicker();
  var isLoading = false.obs;
  var languageList = <Language>[].obs;
  var languageSelectedList = <int>[];
  var companyProfile = CompanyProfile().obs;
  var companyProfileStatus = "".obs;
  var isLoadingProfile = false.obs;

  /*-------------start One--------------------*/
  XFile? image;
  var phoneCode = "971".obs;
  var countryCode = 'AE'.obs;
  var genderList = <GenderModel>[].obs;
  final email = TextEditingController();
  final fullName = TextEditingController();
  final personalPageLink = TextEditingController();
  final mobile = TextEditingController();
  final dob = TextEditingController();
  Rx<GenderModel> selectedGender = GenderModel(key: '', name: '').obs;

  /*-------------End One--------------------*/

  /*-------------End Two--------------------*/
  XFile? imageLicense;
  final experience = TextEditingController();
  final language = TextEditingController();
  final personalProfile = TextEditingController();
  final brokerNumberRealEstate = TextEditingController();
  final brokerNumberOrn = TextEditingController();
  final licenseNumber = TextEditingController();
  final licenseExpirationDate = TextEditingController();

  /*-------------End Two--------------------*/

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
    // getUserInfo();
    genderList.add(GenderModel(name: LangKeys.male.tr, key: "male"));
    genderList.add(GenderModel(name: LangKeys.female.tr, key: "female"));
    getCompanyProfile();
  }

  Future<void> validationOne() async {
    if (image == null) {
      UiErrorUtils.customSnackbar(title: LangKeys.error.tr, msg: LangKeys.chooseLogo.tr);
      return;
    }
    if (fullName.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterFullName.tr);
      return;
    }
    if (email.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterEmail.tr);
      return;
    }
    if (!GetUtils.isEmail(email.text.trim())) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.emailNotValid.tr);
      return;
    }
    if (mobile.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterMobileNumber.tr);
      return;
    }
    bool? isValid = await isMobileValid();
    if (!isValid!) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.mobileNumberInvalid.tr);
      return;
    }

    if (personalPageLink.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterPersonalPageLink.tr);
      return;
    }

    if (personalPageLink.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterPersonalPageLink.tr);
      return;
    }
    if (selectedGender.value.name == "") {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.chooseGender.tr);
      return;
    }
    if (dob.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.dob.tr);
      return;
    }
    Get.toNamed(AppRoutes.accountVerificationTwo);
    // updateProfile();
  }

  Future<void> validationTwo() async {
    if (experience.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterExperience.tr);
      return;
    }
    if (language.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.chooseLanguages.tr);
      return;
    }

    // if (personalProfile.text.isEmpty) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.enterPersonalProfile.tr);
    //   return;
    // }
    //
    // if (brokerNumberRealEstate.text.isEmpty) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.enterBrokerNumber.tr);
    //   return;
    // }
    //
    // if (brokerNumberOrn.text.isEmpty) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: LangKeys.enterBrokerNumberOrn.tr);
    //   return;
    // }

    if (licenseNumber.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.enterLicenseNumber.tr);
      return;
    }

    if (licenseExpirationDate.text.isEmpty) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.licenseExpirationDate.tr);
      return;
    }
    if (imageLicense == null) {
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: LangKeys.attachTheLicenseHere.tr);
      return;
    }
    createCompanyProfile();
  }

  Future<void> createCompanyProfile() async {
    try {
      FocusScopeNode currentFocus = FocusScope.of(Get.context!);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.focusedChild?.unfocus();
      }
      EasyLoading.show();
      Map<String, dynamic>? body;
      body = {
        'name': fullName.text,
        'email': email.text,
        'mobile': fullMobile ?? "",
        "country_code": "+${phoneCode.value}",
        "country_iso": countryCode.value,
        "personal_page_url": personalPageLink.text,
        'gender': selectedGender.value.key ?? "",
        'date_of_birth': dob.text,
        'experience_years': experience.text,
        'about': personalProfile.text,
        'broker_number_regulatory_authority': brokerNumberRealEstate.text,
        'broker_orn_number': brokerNumberOrn.text,
        'broker_license_number': licenseNumber.text,
        'license_expiry_date': licenseExpirationDate.text,
        'logo': await d.MultipartFile.fromFile(image!.path),
        'license': await d.MultipartFile.fromFile(imageLicense!.path)
      };
      if (languageSelectedList.isNotEmpty) {
        for (int i = 0; i < languageSelectedList.length; i++) {
          body['languages[$i]'] = languageSelectedList[i];
        }
      }
      final formData = d.FormData.fromMap(body);

      final result = await httpService.request(
          url: ApiConstant.companyProfile,
          method: Method.POST,
          isUploadImg: true,
          formData: formData);
      if (result != null) {
        if (result is d.Response) {
          var resp = GlobalModel.fromJson(result.data);
          if (resp.status == true) {
            showSuccessBottomSheet(resp.message ?? "", onClick: () {
              Get.back();
              // Get.back();
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

  Future<void> getLanguages() async {
    try {
      isLoading(true);
      final result = await httpService.request(
          url: ApiConstant.languages, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = LanguagesModel.fromJson(result.data);
          languageList.clear();
          if (resp.data != null && resp.data!.isNotEmpty) {
            languageList.addAll(resp.data!);
          }
        }
      }
    } finally {
      isLoading(false);
      update(['selectedLanguages']);
    }
  }

  Future<void> getCompanyProfile() async {
    try {
      isLoadingProfile(true);
      final result = await httpService.request(
          url: ApiConstant.companyProfile, method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = CompanyProfileModel.fromJson(result.data);
          companyProfile.value = resp.data ?? CompanyProfile();
          companyProfileStatus.value = resp.data?.statusKey ?? "";
        }
      }
    } finally {
      isLoadingProfile(false);
      update(['updateUi']);
    }
  }

  Future<void> selectImage(bool isLogo) async {
    if (Platform.isAndroid) {
      final androidVersion = await DeviceInfoPlugin().androidInfo;
      if ((androidVersion.version.sdkInt) >= 33) {
        if (await Permission.camera.request().isGranted &&
            await Permission.photos.request().isGranted) {
          showPicker(isLogo);
        } else {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
            Permission.photos,
          ].request();
        }
      } else {
        if (await Permission.camera.request().isGranted &&
            await Permission.storage.request().isGranted) {
          showPicker(isLogo);
        } else {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
            Permission.camera,
          ].request();
        }
      }
    }
    if (Platform.isIOS) {
      showPicker(isLogo);
    }
  }

  void showPicker(bool isLogo) async {
    Get.bottomSheet(SafeArea(
      child: Container(
        color: Colors.white,
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text("الاستديو"),
                onTap: () {
                  _imgFromGallery(isLogo);
                  Get.back();
                }),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text("الكاميرا"),
              onTap: () {
                _imgFromCamera(isLogo);
                Get.back();
              },
            ),
          ],
        ),
      ),
    ));
  }

  _imgFromGallery(bool isLogo) async {
    if (isLogo) {
      image = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
      update(['selectLogoImg']);
      if (kDebugMode) {
        print(image?.path);
      }
    } else {
      imageLicense = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
      update(['selectLicenseImg']);
      if (kDebugMode) {
        print(imageLicense?.path);
      }
    }
  }

  _imgFromCamera(bool isLogo) async {
    if (isLogo) {
      image =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
      update(['selectLogoImg']);
      if (kDebugMode) {
        print(image?.path);
      }
    } else {
      imageLicense =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
      update(['selectLicenseImg']);
      if (kDebugMode) {
        print(imageLicense?.path);
      }
    }
  }
}
