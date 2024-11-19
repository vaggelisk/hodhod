import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'font_manager.dart';

var lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: FontConstants.fontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColors.primary,
    datePickerTheme:
        DatePickerThemeData(headerBackgroundColor: AppColors.primary),
    textTheme: TextTheme(
      titleSmall: AppTextStyles.lightTextStyle.copyWith(fontSize: 12.0.sp,color: Colors.black),
        titleLarge:  AppTextStyles.lightTextStyle.copyWith(fontSize: 14.0.sp,color: Colors.black),
        titleMedium: AppTextStyles.lightTextStyle.copyWith(fontSize: 13.0.sp,color: Colors.black)),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, // Only honored in Android M and above
          statusBarIconBrightness:
              Brightness.dark, // Only honored in Android M and above
          statusBarBrightness:
              Brightness.light, // Only honored in iOSS (dark icons)
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: false,
        titleSpacing: 0.0));
