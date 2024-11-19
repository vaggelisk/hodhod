import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:hodhod/app/services/storage_service.dart';
import 'package:hodhod/app/translations/lang_keys.dart';
import 'package:hodhod/app/util/bottom_sheet.dart';
import 'package:hodhod/app/util/ui_error_utils.dart';
import 'package:hodhod/data/models/global_model.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// ignore: constant_identifier_names
enum Method { POST, GET, PUT, DELETE, PATCH }

// ignore: constant_identifier_names
const BASE_URL = "https://hodhod.ae/api/";

class HttpService extends GetxService {
  Dio? _dio;

  Future<HttpService> init() async {
    // _dio = Dio(BaseOptions(
    //     baseUrl: BASE_URL,
    //     connectTimeout: const Duration(seconds: 30),
    //     receiveTimeout: const Duration(seconds: 30)));
    // initInterceptors();
    // followRedirects: false,
    // validateStatus: (status) {
    // return status! < 500;
    // }
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      // contentType: "application/json",
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
    ))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: kDebugMode ? true : false,
        requestBody: kDebugMode ? true : false,
        request: kDebugMode ? true : false,
        responseBody: kDebugMode ? true : false,
        responseHeader: kDebugMode ? true : false,
        compact: false,
      ));
    // initInterceptors();
    return this;
  }

  var logger = Logger(
    printer: PrettyPrinter(colors: true, printEmojis: true, printTime: true),
  );

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          logger.i(
              "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
              "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          logger
              .i("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          logger.i("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request(
      {required String url,
      required Method method,
      Map<String, dynamic>? params,
      bool isUploadImg = false,
      FormData? formData}) async {
    print("Log url $url");
    Response response;
    try {
      _dio!.options.headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Accept-Language": Get.find<StorageService>().getLanguageCode(),
        // "X-localization": Get.find<StorageService>().getLanguageCode(),
        // "Authorization":
        //     "Bearer ${Get.find<StorageService>().getToken() ?? ""}",
        "device-type": Platform.isAndroid ? "android" : "ios",
        // "device-id": storage.deviceId ?? "",
      };
      if (Get.find<StorageService>().getToken() != null &&
          Get.find<StorageService>().getToken()!.isNotEmpty) {
        _dio!.options.headers['Authorization'] =
            "Bearer ${Get.find<StorageService>().getToken() ?? ""}";
      }
      if (method == Method.POST) {
        response = await _dio!.post(
          url,
          data: isUploadImg == true ? formData : params,
        );
      } else if (method == Method.PUT) {
        response =
            await _dio!.put(url, data: isUploadImg == true ? formData : params);
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url, data: isUploadImg == true ? formData : params);
      } else {
        response = await _dio!.get(url, queryParameters: params);
      }
      return response;
    } on SocketException catch (e) {
      logger.e(e);
      showErrorBottomSheet(LangKeys.notInternetConnection.tr);

      // UiErrorUtils.customSnackbar(title:LangKeys.error.tr,msg: LangKeys.notInternetConnection.tr);
    } on FormatException catch (e) {
      logger.e(e);
      showErrorBottomSheet("Bad response format");
      // UiErrorUtils.customSnackbar(title:LangKeys.error.tr,msg:"Bad response format");
      // showErrorBottomSheet("Bad response format");
    } on DioError catch (e) {
      // logger.e(e);
      String? message;
      switch (e.type) {
        case DioErrorType.cancel:
          message = "Request to API server was cancelled";
          break;
        case DioErrorType.connectionTimeout:
          message = "Connection timeout with API server";
          break;
        case DioErrorType.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioErrorType.badResponse:
          if (e.response!.statusCode! == 401) {
            // EasyLoading.showToast("Unauthorized",
            //     duration: const Duration(seconds: 3),
            //     toastPosition: EasyLoadingToastPosition.bottom);
            // Get.snackbar(LangKeys.error.tr, e.response?.data['message']);

            showLogoutBottomSheet(e.response?.data['message']);
            // GlobalModel model = GlobalModel.fromJson(e.response?.data);
            // if (model.StatusCode == -15) {
            //   storage.clearApp();
            //   Get.offAllNamed("/splash");
            // } else {
            //   storage.logoutUser();
            //   Get.offAllNamed("/login");
            // }
          } else {
            message = _handleError(e.response!.statusCode!, e.response?.data);
          }
          break;
        case DioErrorType.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        case DioErrorType.unknown:
          message = LangKeys.notInternetConnection.tr;
          break;
        default:
          message = LangKeys.notInternetConnection.tr;
          break;
      }
      if (message != null && message != "") {
        // showErrorBottomSheet(LangKeys.notInternetConnection.tr);
        // UiErrorUtils.customSnackbar(title:LangKeys.error.tr,msg: message );
        UiErrorUtils.customSnackbar(title: LangKeys.error.tr, msg: message);
        // showErrorBottomSheet(message);
      } else {
        UiErrorUtils.customSnackbar(
            title: LangKeys.error.tr, msg: LangKeys.notInternetConnection.tr);
        // showErrorBottomSheet(LangKeys.notInternetConnection.tr);
      }
      // throw Exception(e);
    } catch (e) {
      logger.e(e);
      UiErrorUtils.customSnackbar(
          title: LangKeys.error.tr, msg: "Something wen't wrong");
      // showErrorBottomSheet("Something wen't wrong");
      // UiErrorUtils.customSnackbar(title:LangKeys.error.tr,msg: "Something wen't wrong" );
      // showErrorBottomSheet("Something wen't wrong");
    }
  }
}
//

String _handleError(int statusCode, dynamic error) {
  switch (statusCode) {
    case 400:
      return GlobalModel.fromJson(error).toString();
    case 404:
      return error["message"];
    case 405:
      return error["message"];
    case 403:
      return error["message"];
    case 422:
      return GlobalModel.fromJson(error).message ?? "";
    case 500:
      return 'Internal Server Error';
    default:
      return 'Oops Something Went Wrong';
  }
}

// String showError(Errors errors) {
//   String errorStr = "";
//   if (errors.email != null && errors.email!.isNotEmpty) {
//     errorStr = errors.email![0];
//   } else if (errors.phoneNumber != null && errors.phoneNumber!.isNotEmpty) {
//     errorStr = errors.phoneNumber![0];
//   } else if (errors.customFields != null && errors.customFields!.isNotEmpty) {
//     errorStr = errors.customFields![0];
//   }
//   return errorStr;
// }
