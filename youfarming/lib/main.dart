
import 'package:flutter/material.dart';
import 'package:youfarming/data/homedata.dart';
import 'package:youfarming/pages/login.dart';
import 'package:youfarming/pages/register.dart';
import 'package:youfarming/pages/homedash.dart';
import 'package:youfarming/pages/informing.dart';
import 'package:youfarming/pages/stage_info.dart';
import 'package:youfarming/pages/checklist.dart';
import 'package:youfarming/pages/business_dash.dart';
import 'package:youfarming/pages/generate_portfolio_docs.dart';
import 'package:youfarming/pages/portfolio_desc.dart';
import 'package:youfarming/pages/gen_form.dart';
import 'package:youfarming/pages/quizes.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() => runApp(MaterialApp(
    initialRoute: '/dash',
    routes: {
      '/reg': (context) => register(), // register page
      '/login': (context) => Login2(),
      '/dash': (context) => HomeDashboard(),
      '/_information': (context) => FarmingHomePage(), // to do YourWidget informing.dart
      '/MyApp': (context) => ParentPage(), //checklist.dart
      '/business_dashboard2': (context) => BusinessDashboard2(), //business_dash.dart
      '/_portfolio_description': (context) => PortfolioDescription(),
      '/_form_gen': (context) => GenerateForm(),
      '/_Portfolio_Gen': (context) => Portfolio_Gen(),
          '/QuizPage': (context) => LessonPage(), // to do quizes.dart

    }
));
//
// //Global Initialization
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title// description
//     importance: Importance.high,
//     playSound: true);
//
// // flutter local notification
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// // firebase background message handler
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A Background message just showed up :  ${message.messageId}');
// }
//
//
// Future<void> main() async {
//   // firebase App initialize
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
// // // Firebase local notification plugin
// //   await flutterLocalNotificationsPlugin
// //       .resolvePlatformSpecificImplementation<
// //       AndroidFlutterLocalNotificationsPlugin>()
// //       ?.createNotificationChannel(channel);
// //
// // //Firebase messaging
// //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
// //     alert: true,
// //     badge: true,
// //     sound: true,
// //   );
//
//
//   WidgetsFlutterBinding.ensureInitialized();
//   //await Firebase.initializeApp();
//
//   runApp(MaterialApp(
//       initialRoute: '/login',
//       routes: {
//         '/home': (context) => Home(), // register page
//         '/login': (context) => login2(),
//
//       }
//   ));
// }

