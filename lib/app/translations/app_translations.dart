import 'package:get/get.dart';
import 'package:hodhod/app/translations/el_gr.dart';

import 'ar_ps.dart';
import 'en_us.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'ar_PS':ar,
    'el_GR':el,
  };

}