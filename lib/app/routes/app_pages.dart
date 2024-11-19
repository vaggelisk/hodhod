import 'package:get/get.dart';
import 'package:hodhod/ui/account_verification/view/account_verification.dart';
import 'package:hodhod/ui/account_verification/view/account_verification_two.dart';
import 'package:hodhod/ui/account_verification/view/display_account_verification.dart';
import 'package:hodhod/ui/account_verification/view/languages.dart';
import 'package:hodhod/ui/add_real_estate/view/add_real_estate_four.dart';
import 'package:hodhod/ui/add_real_estate/view/add_real_estate_one.dart';
import 'package:hodhod/ui/add_real_estate/view/add_real_estate_third.dart';
import 'package:hodhod/ui/add_real_estate/view/add_real_estate_two.dart';
import 'package:hodhod/ui/add_real_estate/view/property_features.dart';
import 'package:hodhod/ui/budget/view/budget.dart';
import 'package:hodhod/ui/change_password/view/change_password.dart';
import 'package:hodhod/ui/contact_broker/view/contact_broker.dart';
import 'package:hodhod/ui/contact_us/view/contact_us.dart';
import 'package:hodhod/ui/forgot_password/view/forgot_password.dart';
import 'package:hodhod/ui/home/view/home.dart';
import 'package:hodhod/ui/new_password/view/new_password.dart';
import 'package:hodhod/ui/notifications/view/notifications.dart';
import 'package:hodhod/ui/on_boarding/view/on_boarding.dart';
import 'package:hodhod/ui/page/view/page_view.dart';
import 'package:hodhod/ui/payment/view/payment_page.dart';
import 'package:hodhod/ui/profile/view/profile.dart';
import 'package:hodhod/ui/real_estate_details/view/real_estate_details.dart';
import 'package:hodhod/ui/real_estate_financing/view/real_estate_financing.dart';
import 'package:hodhod/ui/search/view/search.dart';
import 'package:hodhod/ui/search_filter/view/property_features_search.dart';
import 'package:hodhod/ui/search_filter/view/search_filter.dart';
import 'package:hodhod/ui/select_country/view/select_country.dart';
import 'package:hodhod/ui/sign_in/view/sign_in.dart';
import 'package:hodhod/ui/sign_up/view/sign_up.dart';
import 'package:hodhod/ui/splash/view/splash.dart';
import 'package:hodhod/ui/technical_support/view/technical_support.dart';
import 'package:hodhod/ui/verification_code/view/verification_code.dart';
import 'package:hodhod/ui/view_real_estate_user/view/view_real_estate_user.dart';

import 'app_routes.dart';

final appPages = [
  GetPage(name: AppRoutes.splash, page: () => Splash()),
  GetPage(name: AppRoutes.onBoarding, page: () => OnBoarding()),
  GetPage(name: AppRoutes.signIn, page: () => SignIn()),
  GetPage(name: AppRoutes.signUp, page: () => SignUp()),
  GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPassword()),
  GetPage(name: AppRoutes.newPassword, page: () => NewPassword()),
  GetPage(name: AppRoutes.budget, page: () => Budget()),
  GetPage(name: AppRoutes.selectCountry, page: () => SelectCountry()),
  GetPage(name: AppRoutes.verificationCode, page: () => VerificationCode()),
  GetPage(name: AppRoutes.home, page: () => Home()),
  // GetPage(
  //   name: AppRoutes.settingsPage,
  //   page: () => SettingsPage(),
  // ),
  GetPage(name: AppRoutes.profile, page: () => Profile()),
  GetPage(name: AppRoutes.changePassword, page: () => ChangePassword()),
  // GetPage(name: AppRoutes.adsDetails, page: () => AdsDetails()),
  //
  GetPage(name: AppRoutes.contactUs, page: () => ContactUs()),
  GetPage(name: AppRoutes.technicalSupport, page: () => TechnicalSupport()),
  GetPage(
      name: AppRoutes.accountVerification, page: () => AccountVerification()),
  GetPage(
      name: AppRoutes.accountVerificationTwo,
      page: () => AccountVerificationTwo()),
  GetPage(name: AppRoutes.realStateDetails, page: () => RealStateDetails()),
  GetPage(name: AppRoutes.contactBroker, page: () => ContactBroker()),
  GetPage(name: AppRoutes.addRealEstateOne, page: () => AddRealEstateOne()),
  GetPage(name: AppRoutes.addRealEstateTwo, page: () => AddRealEstateTwo()),
  GetPage(name: AppRoutes.addRealEstateThird, page: () => AddRealEstateThird()),
  GetPage(name: AppRoutes.addRealEstateFour, page: () => AddRealEstateFour()),
  GetPage(name: AppRoutes.propertyFeatures, page: () => PropertyFeatures()),
  GetPage(name: AppRoutes.notifications, page: () => Notifications()),
  GetPage(
      name: AppRoutes.displayAccountVerification,
      page: () => DisplayAccountVerification()),
  GetPage(name: AppRoutes.search, page: () => Search()),
  GetPage(name: AppRoutes.searchFilter, page: () => SearchFilter()),
  GetPage(name: AppRoutes.viewRealEstateUser, page: () => ViewRealEstateUser()),
  GetPage(
      name: AppRoutes.propertyFeaturesSearch,
      page: () => PropertyFeaturesSearch()),
  GetPage(name: AppRoutes.pageView, page: () => PageView()),
  GetPage(name: AppRoutes.languages, page: () => Languages()),
  GetPage(
      name: AppRoutes.realEstateFinancing, page: () => RealEstateFinancing()),
  GetPage(name: AppRoutes.paymentPage, page: () => PaymentPage()),
  // GetPage(name: AppRoutes.comments, page: () => Comments()),
  // GetPage(name: AppRoutes.userAds, page: () => UserAds()),
];
