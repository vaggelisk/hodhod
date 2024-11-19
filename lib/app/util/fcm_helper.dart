import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

import '../config/app_colors.dart';

class FcmHelper {
//   // FCM Messaging
  static late FirebaseMessaging messaging;
  static String? fcmToken;

  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications',
    description: 'This channel is used for important notifications.1',
    // description
    importance: Importance.high,
  );
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//   ///this function will initialize firebase and fcm instance
  static Future<void> initFcm() async {
    //initialize fcm and firebase core
    final notificationSettings = await FirebaseMessaging.instance
        .requestPermission(provisional: true, badge: true, sound: true);

    messaging = FirebaseMessaging.instance;

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_notification');
    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // handleFcmToken();
    //initialize notifications channel and libraries
    // initNotification("");

    // print("'Message from background ABEER");

    //generate token if it not already generated and store it on shared pref
    // await handleFcmToken();
    //subscribe To Topic
    await FirebaseMessaging.instance.subscribeToTopic('all');
    // await FirebaseMessaging.instance.subscribeToTopic('test');

    //notification settings handler
    await setupFcmNotificationSettings();

    //background and foreground handlers
    FirebaseMessaging.onMessage.listen(fcmForegroundHandler);
    // FirebaseMessaging.onMessage.listen(fcmBackgroundHandler);
    FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Eraser.resetBadgeCountAndRemoveNotificationsFromCenter();
    });
  }

//   ///handle fcm notification settings (sound,badge..etc)
  static Future<void> setupFcmNotificationSettings() async {
    //show notification with sound and badge
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );
    // // check code
    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         IOSFlutterLocalNotificationsPlugin>()
    //     ?.requestPermissions(
    //       alert: true,
    //       badge: true,
    //       sound: true,
    //     );

    //NotificationSettings settings
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
  }

  ///generate and save fcm token if its not already generated (generate only for 1 time)
  static Future<void> handleFcmToken() async {
    try {
      // check if the token was already generated and saved and stop function if it is..
      // String? savedToken = Get.find<StorageService>().getFcmToken();
      // if (savedToken != null) return;

      // let fcm generate token for us
      // String? token = await messaging.getToken(
      //   vapidKey: "AIzaSyBg3acn3YqRLJYYJl8wLdgbv0eLprgFoV4",
      // );

      messaging.getToken().then((token) {
        fcmToken = token;
        if (kDebugMode) {
          print(token);
          print("ABEER ddddddd ${token ?? ""}");
        }
      });
      // messaging.onTokenRefresh.listen((token) {
      //   // TODO: If necessary send token to application server.
      //   fcmToken = token;
      //   // Note: This callback is fired at each app startup and whenever a new
      //   // token is generated.
      // }).onError((err) {
      //   // Error getting token.
      // });

      //fail to generate token
      // if (token == null) {
      //   //close app safely
      //   //SystemNavigator.pop();
      //   return; //stop method
      // }

      //Logger().i('FCM Token => ${token}');
      //if token was generated successfully (save it to shared pref)
      // Get.find<StorageService>().setFcmToken(token);
    } catch (error) {
      Logger().e('Error => ${error}');
    }
  }

//   ///handle fcm notification when app is closed/terminated
  @pragma('vm:entry-point')
  static Future<void> fcmBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    // Map<String, dynamic> data = message.data;
    // Logger().e('Message from background USER=> ${message.data}');
    // Logger().e('Message from background title=> ${message.notification?.title}');

    // print("onBackgroundMessage: $message");
    // print("'Message from background USER=> ${message.data}");
    // print("'Message from background title=> ${message.notification?.title}");
    if (Platform.isAndroid) {
      if (message.data.isNotEmpty &&
          message.data['title'] != null &&
          message.data['title'] != "" &&
          message.data['body'] != null &&
          message.data['body'] != "") {
        await showNotification(
            message.data['title'], message.data['body'], message.data.hashCode);
      } else {
        if (message.notification != null) {
          await showNotification(message.notification?.title,
              message.notification?.body, message.notification.hashCode);
        }
      }
    } else {
      if (message.notification != null) {
        await showNotification(message.notification?.title,
            message.notification?.body, message.notification.hashCode);
      }
    }
    handleNotifications(message, false);
  }

//   //handle fcm notification when app is open
  static Future<void> fcmForegroundHandler(RemoteMessage message) async {
    // print("fcmForegroundHandler");

    // Logger().e('Message from foreground data=> ${message.data}');
    // print("onForegroundMessage: ${message.toMap()}");
    // Logger().e('Message from foreground notification=> ${message.notification?.toMap()}');
    // Map<String, dynamic> data = message.data;
    if (Platform.isAndroid) {
      if (message.data.isNotEmpty &&
          message.data['title'] != null &&
          message.data['title'] != "" &&
          message.data['body'] != null &&
          message.data['body'] != "") {
        await showNotification(
            message.data['title'], message.data['body'], message.data.hashCode);
      } else {
        if (message.notification != null) {
          await showNotification(message.notification?.title,
              message.notification?.body, message.notification.hashCode);
        }
      }
    }

    // else {
    //   if (message.notification != null && message.notification?.title != null) {
    //     await showNotification(message.notification?.title,
    //         message.notification?.body, message.notification.hashCode);
    //   }
    // }
    // handleNotifications(message, true);
  }

//   //display notification for user with sound
  static Future<void> showNotification(
      String? title, String? body, int id) async {
    // AndroidNotification? android = message.notification?.android;

    flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          // groupKey: channel.groupId,
          channelDescription: channel.description,
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          // ticker: 'ticker',
          color: AppColors.primary,
        )));
  }

  //account_type_id = 1 -> customer  / 2 -> sp
  static void handleNotifications(RemoteMessage message, bool isForeground) {
    if (isForeground) {
      // var user = Get.find<StorageService>().getUser();
      if (message.data.isNotEmpty) {
        // String type = message.data['type'];
        //todo update
        /*
        switch (type) {
          case "new_order":
            if (user?.accountTypeId == 1) {
              bool isRegisteredOffers = Get.isRegistered<OffersController>();
              if (isRegisteredOffers) {
                Get.find<OffersController>().pagingController.refresh();
              }
              bool isRegisteredMyOrders =
                  Get.isRegistered<MyOrdersController>();
              if (isRegisteredMyOrders) {
                Get.find<MyOrdersController>().pagingController.refresh();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOffers =
                  Get.isRegistered<SpOffersController>();
              if (isRegisteredSpOffers) {
                Get.find<SpOffersController>().getMyOffers();
              }
              bool isRegisteredSpHome =
                  Get.isRegistered<SpHomePageController>();
              if (isRegisteredSpHome) {
                Get.find<SpHomePageController>().pagingController.refresh();
              }
            }
            break;
          case "offer_received":
            if (user?.accountTypeId == 1) {
              bool isRegisteredOffers = Get.isRegistered<OffersController>();
              if (isRegisteredOffers) {
                Get.find<OffersController>().pagingController.refresh();
              }
              bool isRegisteredOrderOffers =
                  Get.isRegistered<OrderOffersController>();
              if (isRegisteredOrderOffers) {
                Get.find<OrderOffersController>().myOrderOffers();
              }
              bool isRegisteredMyOrders =
                  Get.isRegistered<MyOrdersController>();
              if (isRegisteredMyOrders) {
                Get.find<MyOrdersController>().pagingController.refresh();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOffers =
                  Get.isRegistered<SpOffersController>();
              if (isRegisteredSpOffers) {
                Get.find<SpOffersController>().getMyOffers();
              }
              bool isRegisteredSpHome =
                  Get.isRegistered<SpHomePageController>();
              if (isRegisteredSpHome) {
                Get.find<SpHomePageController>().pagingController.refresh();
              }
            }
            break;
          case "offer_canceld":
            if (user?.accountTypeId == 1) {
              bool isRegisteredOffers = Get.isRegistered<OffersController>();
              if (isRegisteredOffers) {
                Get.find<OffersController>().pagingController.refresh();
              }
              bool isRegisteredOrderOffers =
                  Get.isRegistered<OrderOffersController>();
              if (isRegisteredOrderOffers) {
                Get.find<OrderOffersController>().myOrderOffers();
              }
              bool isRegisteredMyOrders =
                  Get.isRegistered<MyOrdersController>();
              if (isRegisteredMyOrders) {
                Get.find<MyOrdersController>().pagingController.refresh();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOffers =
                  Get.isRegistered<SpOffersController>();
              if (isRegisteredSpOffers) {
                Get.find<SpOffersController>().getMyOffers();
              }
              bool isRegisteredSpHome =
                  Get.isRegistered<SpHomePageController>();
              if (isRegisteredSpHome) {
                Get.find<SpHomePageController>().pagingController.refresh();
              }
            }
            break;
          case "offer_accepted":
            if (user?.accountTypeId == 1) {
              bool isRegisteredHome = Get.isRegistered<HomeController>();
              if (isRegisteredHome) {
                Get.find<HomeController>().currentIndex.value = 1;
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOffers =
                  Get.isRegistered<SpOffersController>();
              if (isRegisteredSpOffers) {
                Get.find<SpOffersController>().getMyOffers();
              }
              bool isRegisteredSpHome =
                  Get.isRegistered<SpHomePageController>();
              if (isRegisteredSpHome) {
                Get.find<SpHomePageController>().pagingController.refresh();
              }
            }
            break;

          case "cost_holded":
            bool isRegisteredPublic = Get.isRegistered<PublicController>();
            if (isRegisteredPublic) {
              Get.find<PublicController>().getCurrentBalance();
            }
            if (user?.accountTypeId == 1) {
              bool isRegisteredWallet = Get.isRegistered<WalletController>();
              if (isRegisteredWallet) {
                Get.find<WalletController>().getWallet();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpWallet =
                  Get.isRegistered<SpWalletController>();
              if (isRegisteredSpWallet) {
                Get.find<SpWalletController>().getWallet();
              }
            }
            break;

          case "order_handoverd":
            if (user?.accountTypeId == 1) {
              bool isRegisteredOrderDetails =
                  Get.isRegistered<OrderDetailsController>();
              if (isRegisteredOrderDetails) {
                var controller = Get.find<OrderDetailsController>();
                if (controller.order.orderTypeId == 7) {
                  controller.getOrderDetailsPhoto();
                } else {
                  controller.getOrderDetails();
                }
                if (controller.order.categoryId == 3) {
                  controller.getPhotographyDeliveryData();
                } else {
                  controller.getDeliveryData();
                }
                controller.getUpdates();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOrderDetails =
                  Get.isRegistered<SpOrderDetailsController>();
              if (isRegisteredSpOrderDetails) {
                var controller = Get.find<SpOrderDetailsController>();
                if (controller.order.orderTypeId == 7) {
                  controller.getOrderDetailsPhoto();
                } else {
                  controller.getOrderDetails();
                }
                if (controller.order.categoryId == 3) {
                  controller.getPhotographyDeliveryData();
                } else {
                  controller.getDeliveryData();
                }
                controller.getUpdates();
              }
            }
            break;
          case "recieve_update":
            if (user?.accountTypeId == 1) {
              bool isRegisteredOrderDetails =
                  Get.isRegistered<OrderDetailsController>();
              if (isRegisteredOrderDetails) {
                var controller = Get.find<OrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                // if (controller.order.categoryId == 3) {
                //   controller.getPhotographyDeliveryData();
                // } else {
                //   controller.getDeliveryData();
                // }
                controller.getUpdates();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOrderDetails =
                  Get.isRegistered<SpOrderDetailsController>();
              if (isRegisteredSpOrderDetails) {
                var controller = Get.find<SpOrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                // if (controller.order.categoryId == 3) {
                //   controller.getPhotographyDeliveryData();
                // } else {
                //   controller.getDeliveryData();
                // }
                controller.getUpdates();
              }
            }
            break;

          case "accept_update":
            if (user?.accountTypeId == 1) {
              bool isRegisteredOrderDetails =
                  Get.isRegistered<OrderDetailsController>();
              if (isRegisteredOrderDetails) {
                var controller = Get.find<OrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                // if (controller.order.categoryId == 3) {
                //   controller.getPhotographyDeliveryData();
                // } else {
                //   controller.getDeliveryData();
                // }
                controller.getUpdates();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOrderDetails =
                  Get.isRegistered<SpOrderDetailsController>();
              if (isRegisteredSpOrderDetails) {
                var controller = Get.find<SpOrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                // if (controller.order.categoryId == 3) {
                //   controller.getPhotographyDeliveryData();
                // } else {
                //   controller.getDeliveryData();
                // }
                controller.getUpdates();
              }
            }
            break;

          case "decline_update":
            if (user?.accountTypeId == 1) {
              bool isRegisteredOrderDetails =
                  Get.isRegistered<OrderDetailsController>();
              if (isRegisteredOrderDetails) {
                var controller = Get.find<OrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                // if (controller.order.categoryId == 3) {
                //   controller.getPhotographyDeliveryData();
                // } else {
                //   controller.getDeliveryData();
                // }
                controller.getUpdates();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOrderDetails =
                  Get.isRegistered<SpOrderDetailsController>();
              if (isRegisteredSpOrderDetails) {
                var controller = Get.find<SpOrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                // if (controller.order.categoryId == 3) {
                //   controller.getPhotographyDeliveryData();
                // } else {
                //   controller.getDeliveryData();
                // }
                controller.getUpdates();
              }
            }
            break;
          case "sp_recieved":
            if (user?.accountTypeId == 1) {
              bool isRegisteredOrderDetails =
                  Get.isRegistered<OrderDetailsController>();
              if (isRegisteredOrderDetails) {
                var controller = Get.find<OrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                if (controller.order.categoryId == 3) {
                  controller.getPhotographyDeliveryData();
                } else {
                  controller.getDeliveryData();
                }
                // controller.getUpdates();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOrderDetails =
                  Get.isRegistered<SpOrderDetailsController>();
              if (isRegisteredSpOrderDetails) {
                var controller = Get.find<SpOrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                if (controller.order.categoryId == 3) {
                  controller.getPhotographyDeliveryData();
                } else {
                  controller.getDeliveryData();
                }
                // controller.getUpdates();
              }
            }
            break;
          case "sp_in_way":
            if (user?.accountTypeId == 1) {
              bool isRegisteredOrderDetails =
                  Get.isRegistered<OrderDetailsController>();
              if (isRegisteredOrderDetails) {
                var controller = Get.find<OrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                if (controller.order.categoryId == 3) {
                  controller.getPhotographyDeliveryData();
                } else {
                  controller.getDeliveryData();
                }
                // controller.getUpdates();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpOrderDetails =
                  Get.isRegistered<SpOrderDetailsController>();
              if (isRegisteredSpOrderDetails) {
                var controller = Get.find<SpOrderDetailsController>();
                // if (controller.order.orderTypeId == 7) {
                //   controller.getOrderDetailsPhoto();
                // } else {
                //   controller.getOrderDetails();
                // }
                if (controller.order.categoryId == 3) {
                  controller.getPhotographyDeliveryData();
                } else {
                  controller.getDeliveryData();
                }
                // controller.getUpdates();
              }
            }
            break;

          case "balance_charge":
            bool isRegisteredPublic = Get.isRegistered<PublicController>();
            if (isRegisteredPublic) {
              Get.find<PublicController>().getCurrentBalance();
            }
            if (user?.accountTypeId == 1) {
              bool isRegisteredWallet = Get.isRegistered<WalletController>();
              if (isRegisteredWallet) {
                Get.find<WalletController>().getWallet();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpWallet =
                  Get.isRegistered<SpWalletController>();
              if (isRegisteredSpWallet) {
                Get.find<SpWalletController>().getWallet();
              }
            }
            break;
          case "balance_withdrawl":
            bool isRegisteredPublic = Get.isRegistered<PublicController>();
            if (isRegisteredPublic) {
              Get.find<PublicController>().getCurrentBalance();
            }
            if (user?.accountTypeId == 1) {
              bool isRegisteredWallet = Get.isRegistered<WalletController>();
              if (isRegisteredWallet) {
                Get.find<WalletController>().getWallet();
              }
            } else if (user?.accountTypeId == 2) {
              bool isRegisteredSpWallet =
                  Get.isRegistered<SpWalletController>();
              if (isRegisteredSpWallet) {
                Get.find<SpWalletController>().getWallet();
              }
            }
            break;

          case "academeic_permession_approved":
          case "academeic_permession_declined":
          case "academeic_permession_sent":
            if (user?.accountTypeId == 2) {
              if (user?.categoryId == 1) {
                bool isRegisteredSpHome = Get.isRegistered<SpHomeController>();
                if (isRegisteredSpHome) {
                  Get.find<SpHomeController>().spGetMyProfile();
                }
              }
            }
            break;
        }
        */
      }
    }
  }
}
