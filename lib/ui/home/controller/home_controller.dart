import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hodhod/ui/base_controller.dart';
import 'package:hodhod/ui/favorite/view/favorite.dart';
import 'package:hodhod/ui/home_page/view/home_page.dart';
import 'package:hodhod/ui/my_real_estate/view/my_real_estate.dart';
import 'package:hodhod/ui/settings_page/view/settings_page.dart';

class HomeController extends BaseController {
  var currentIndex = 0.obs;
  var notCount = 0.obs;

  List<Widget> screens = [
    HomePage(),
    MyRealEstate(),
    Favorite(),
    SettingsPage(),
  ];
}
