import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/App_Routes/app_routes.dart';

import 'package:application_1/provider/paymentProvider.dart';

import 'App_Routes/app_pages.dart';
import 'firebase_options.dart';
import 'handle_notificatioin/forground_notification.dart';
import 'model/notification/notification_response.dart';
import 'resources/repositories/service_repository.dart';

import 'utils/api_utils.dart';
import 'binding/initial_binding.dart';

late AndroidNotificationChannel channel;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
late FirebaseMessaging messaging;
late NotificationDetails platformChannelSpecifics;
late InitializationSettings initializationSettings;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("_firebaseMessagingBackgroundHandler $message");
  await notificationInIt();
  if (Platform.isAndroid) {
    _showNotification(message);
  }
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await notificationInIt();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => Paymentprovider())],
        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var introValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging = FirebaseMessaging.instance;
    _isAndroidPermissionGranted();
    _requestPermissions();
    registerNotification();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      // setState(() {
      //   _notificationsEnabled = granted;
      // });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      // setState(() {
      //   _notificationsEnabled = granted ?? false;
      // });
    }
  }

  dynamic _initEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..radius = 10.0
      ..successWidget = const Icon(
        MaterialCommunityIcons.check_circle_outline,
        color: Colors.green,
        size: 50,
      )
      ..errorWidget = const Icon(
        MaterialCommunityIcons.close_circle_outline,
        color: Colors.red,
        size: 50,
      )
      ..infoWidget = const Icon(
        MaterialCommunityIcons.information_outline,
        color: Colors.lightBlueAccent,
        size: 50,
      )
      ..maskType = EasyLoadingMaskType.custom
      ..progressColor = Colors.blue
      ..maskType = EasyLoadingMaskType.custom
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.blue
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..textColor = Colors.black
      ..fontSize = 14
      ..maskColor = Colors.black.withOpacity(0.4)
      ..userInteractions = false
      ..dismissOnTap = false;

    return EasyLoading.init();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: _initEasyLoading(),
      debugShowCheckedModeBanner: false,
      initialBinding: InitialAppBinding(),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.routes,
    );
  }

  Future<String> checkToken() async {
    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    String userData = await SharedRefrence().getString(key: ApiUtills.userData);
    if (userData.isNotEmpty) {
      var data = json.decode(userData);
      var resp = await ServiceReposiotry()
          .userAvailable(data['data']['user']['id'].toString());
      introValue = resp ? true : false;
      print(authToken);
    }
    return introValue ? AppRoutes.WRAPPER : AppRoutes.INTRO;
    // return authToken.isNotEmpty ? BottomNavigation.id : SignupOrLoginScreen.id;
  }

  void registerNotification() async {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      criticalAlert: true,
      carPlay: true,
      announcement: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
        RemoteNotification? notification =
            RemoteNotification.fromMap(event.data);
        NotificationResponseData model =
            NotificationResponseData.fromJson(event.data);
        debugPrint("onMessage $event");

        switch (model.type) {
          case "Status":
            ForgroundNotification.accountStatusChangeNotification(model);
            break;
          case "SERVICE_REQUEST":
            ForgroundNotification.updateAvailableJobs(model);
        }

        if (Platform.isAndroid) {
          _showNotification(event);
        }
      });

      RemoteMessage? message =
          await FirebaseMessaging.instance.getInitialMessage();

      if (message != null) {
        print("initialMessage $message");
        if (Platform.isAndroid) {
          _showNotification(message);
        }
      }

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
        if (Platform.isAndroid) {
          _showNotification(event);
        }
      });
      //
    } else {
      print('message declined or has not accepted permission');
    }
  }
}

_showNotification(RemoteMessage event) async {
  String id = event.data["id"];

  NotificationResponseData model =
      NotificationResponseData.fromJson(event.data);

  await flutterLocalNotificationsPlugin.show(
      id.toInt(),
      model.title,
      model.body,
      payload: jsonEncode(model),
      platformChannelSpecifics);
}

notificationInIt() async {
  if (kDebugMode) {
    await SharedRefrence().getString(key: ApiUtills.authToken).then((value) {
      debugPrint(value);
    });
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {},
  );
  initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails("0", "Farenow",
          importance: Importance.high,
          priority: Priority.high,
          icon: 'ic_launcher',
          channelDescription: "this is desscription",
          actions: [
        // AndroidNotificationAction(
        //   "0",
        //   "Open",
        //   showsUserInterface: true,
        //   cancelNotification: false,
        //   inputs: <AndroidNotificationActionInput>[
        //     AndroidNotificationActionInput(
        //       label: 'Enter a message',
        //     ),
        //   ],
        // ),
        AndroidNotificationAction("1", "Dismiss")
      ]);
  platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: checkBack,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      ForgroundNotification.handleOnClickNotification(notificationResponse);
    },
  );
}

checkBack(NotificationResponse val) async {
  if (val.actionId!.contains("1")) {
    await flutterLocalNotificationsPlugin.cancel(val.actionId.toInt());
  }
}


//{"body":"New message from Shahmeer","receiver_id":"5","show":"","title":"New message received","provider_id":"","type":"MESSAGE"…"
