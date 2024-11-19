import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/company_profile/company_profile.dart';
import 'package:hodhod/data/models/user/profile_model.dart';
import 'package:hodhod/data/models/user/user.dart';
import 'package:hodhod/data/models/user/user_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:hodhod/ui/home_page/controller/home_page_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as d;

class ProfileController extends BaseController {
  final email = TextEditingController();
  final fullName = TextEditingController();
  final mobile = TextEditingController();

  User? user;
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  void validation() {
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
    // if (mobile.text.isEmpty) {
    //   UiErrorUtils.customSnackbar(
    //       title: LangKeys.error.tr, msg: "ادخل رقم الهاتف");
    //   return;
    // }

    updateProfile();
  }

  Future<void> getUserInfo() async {
    try {
      EasyLoading.show();
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
            fullName.text = user?.name ?? "";
            email.text = user?.email ?? "";
            mobile.text = user?.mobile ?? "";
            // if (Get.isRegistered<SettingsPageController>()) {
            //   Get.find<SettingsPageController>().updateUser();
            // }

            update(['selectImg']);
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  Future<void> updateProfile() async {
    try {
      FocusScopeNode currentFocus = FocusScope.of(Get.context!);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.focusedChild?.unfocus();
      }
      EasyLoading.show();
      d.FormData? formData;
      Map<String, dynamic>? body;
      if (image != null) {
        String fileName = image!.path.split('/').last;
        // var mimeType = lookupMimeType(image!.path);
        // mimeType ??= "image/png";
        // if (kDebugMode) {
        //   print("Log mimeType $mimeType");
        // }
        formData = d.FormData.fromMap({
          'name': fullName.text,
          'email': email.text,
          'mobile': user?.mobile ?? "",
          'country_code': user?.countryCode ?? "",
          'country_iso': user?.countryIso ?? "",
          'image':
              await d.MultipartFile.fromFile(image!.path, filename: fileName)
        });
      } else {
        body = {
          'name': fullName.text,
          'email': email.text,
          'mobile': user?.mobile ?? "",
          'country_code': user?.countryCode ?? "",
          'country_iso': user?.countryIso ?? "",
        };
      }

      final result = await httpService.request(
          url: ApiConstant.updateProfile,
          method: Method.POST,
          isUploadImg: image != null,
          formData: formData,
          params: body);

      if (result != null) {
        if (result is d.Response) {
          var resp = ProfileModel.fromJson(result.data);
          if (resp.status == true) {
            if (resp.data != null) {
              user = resp.data!;
              storage.setUser(resp.data!);
              storage.setCompanyProfile(
                  resp.data!.companyProfile ?? CompanyProfile());
              if (Get.isRegistered<HomePageController>()) {
                Get.find<HomePageController>().getInfoUser();
              }

              // if (Get.isRegistered<SettingsPageController>()) {
              //   Get.find<SettingsPageController>().updateUser();
              // }
            }
            Get.back();
            UiErrorUtils.customSnackbar(
                title: LangKeys.success.tr,
                msg: resp.message ?? "تم تعديل الملف الشخصي بنجاح");
          } else {
            UiErrorUtils.customSnackbar(
                title: LangKeys.error.tr, msg: resp.message!);
          }
        }
      }
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  Future<void> selectImage() async {
    if (Platform.isAndroid) {
      final androidVersion = await DeviceInfoPlugin().androidInfo;
      if ((androidVersion.version.sdkInt) >= 33) {
        if (await Permission.camera.request().isGranted &&
            await Permission.photos.request().isGranted) {
          showPicker();
        } else {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
            Permission.photos,
          ].request();
        }
      } else {
        if (await Permission.camera.request().isGranted &&
            await Permission.storage.request().isGranted) {
          showPicker();
        } else {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
            Permission.camera,
          ].request();
        }
      }
    }
    if (Platform.isIOS) {
      showPicker();
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
    image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50);
    update(['selectImg']);
    if (kDebugMode) {
      print(image?.path);
    }
  }

  _imgFromCamera() async {
    image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    update(['selectImg']);
    if (kDebugMode) {
      print(image?.path);
    }
  }
}
