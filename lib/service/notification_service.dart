// import 'dart:convert';


// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../AllPages/ExplorePages/provider_profile_screen/provider_profile/export_file.dart';

// class NotificationService {
//   BuildContext? context;
//   var onClick;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal();

//   Future<void> init({message, path, flag, var onClick}) async {
//     this.onClick = onClick;
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ic_launcher_playstore');
//     final DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//     );
//     // final IOSInitializationSettings initializationSettingsIOS =
//     //     IOSInitializationSettings(
//     //   requestSoundPermission: true,
//     //   requestBadgePermission: true,
//     //   requestAlertPermission: true,
//     //   // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     // );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS);

//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails("123", "Farenow",
//             importance: Importance.high,
//             priority: Priority.high,
//             icon: 'ic_launcher');
//     NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     // await flutterLocalNotificationsPlugin.show(
//     //     1, path.title, message, platformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         123, path.title, message, platformChannelSpecifics,
//         payload: json.encode(path.toJson()));

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: selectNotificationPdf,

//       // onSelectNotification: selectNotificationPdf
//     );
//   }

//   Future selectNotificationPdf(payload) async {
//     onClick("$payload");
//     // Navigator.pushNamed(context, 'fileViewer', arguments: payload);
//   }

//   Future selectNotificationCSV(String payload) async {
//     // Navigator.pushNamed(context, 'csvViewer', arguments: payload);
//     // final AndroidIntent intent = AndroidIntent(
//     //   action: 'action_view',
//     //   data: Uri.encodeFull('https://flutter.io'),
//     //   flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK]
//     // );
//     // intent.launch();
//   }
// }
