import 'package:get/get.dart';
import 'package:hodhod/ui/language_controller.dart';
import 'package:hodhod/ui/public_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController(), permanent: true);
    Get.put(PublicController(), permanent: true);
  }
}
