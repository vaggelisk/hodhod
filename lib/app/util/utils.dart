import 'dart:io';

import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getIconPath(String name, {String format = 'svg'}) {
    return 'assets/icons/$name.$format';
  }

  static bool isAvDate(String data) {
    if (data.isNotEmpty) {
      DateTime dt1 = DateTime.parse(data);
      DateTime dt2 = DateTime.now();
      if (dt1.isAfter(dt2) || dt1.isAtSameMomentAs(dt2)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  static String formatPrice(dynamic price) {
    if (price != null && price != "") {
      // final oCcy = NumberFormat("#,##", "en_US");
      final formatCurrency = NumberFormat.simpleCurrency(
          decimalDigits: 0, locale: "en_US", name: "");
      // return oCcy.format(double.parse(price.toString()));
      return formatCurrency.format(price);
    } else {
      return "";
    }
  }

  static String formatInputPrice(dynamic price) {
    if (price != null && price != "") {
      // final oCcy = NumberFormat("#,##", "en_US");
      final formatCurrency = NumberFormat.simpleCurrency(
          decimalDigits: 0, locale: "en_US", name: "");
      // return oCcy.format(double.parse(price.toString()));
      return formatCurrency.format(price);
    } else {
      return "";
    }
  }
  static String removeLeadingZeros(String phoneNumber) {
    // Regular expression to match leading zeros
    RegExp regex = RegExp(r'^0+');

    // Replace leading zeros with an empty string
    String cleanedNumber = phoneNumber.replaceAll(regex, '');

    return cleanedNumber;
  }
  static void share(String uuid) {
    if(Platform.isIOS){
      Share.share(
          '${uuid ?? ""} \n https://apps.apple.com/app/hod-hod/id6618150618');
    }else{
      Share.share(
          '${uuid ?? ""} \n https://play.google.com/store/apps/details?id=com.ozone.hodhod');
    }

  }

  static String convertDateFormat(
      String dateTimeString, String oldFormat, String newFormat) {
    DateFormat newDateFormat = DateFormat(newFormat);
    DateTime dateTime = DateFormat(oldFormat).parse(dateTimeString);
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}
