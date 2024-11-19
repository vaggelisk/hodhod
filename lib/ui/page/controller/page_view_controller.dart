import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:hodhod/data/api/api_constant.dart';
import 'package:hodhod/data/api/http_service.dart';
import 'package:hodhod/data/models/pages/page_model.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageViewController extends BaseController {
  var isLoading = false.obs;
  var data = "".obs;
  var title = "";
  var key = "";
  late WebViewController webViewController;

  // ..loadHtmlString('''
  //   <!DOCTYPE html>
  //   <html>
  //   <body>
  //   ${data.value}
  //   </body>
  //   </html>
  // ''')
  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController();
    title = Get.arguments['title'];
    key = Get.arguments['key'];
    getPage();
  }

  Future<void> getPage() async {
    try {
      isLoading(true);
      final result = await httpService.request(
          url: "${ApiConstant.page}/$key", method: Method.GET);
      if (result != null) {
        if (result is d.Response) {
          var resp = PageModel.fromJson(result.data);
          data.value = resp.data?.content ?? "";
          if (data.value != "") {
            webViewController = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..loadHtmlString(data.value)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                ),
              );
          }
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
