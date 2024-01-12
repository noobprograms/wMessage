import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nial_deliveries/core/utils/navigator_service%20copy.dart';
import 'package:nial_deliveries/core/utils/notification_service.dart';
import 'package:nial_deliveries/core/utils/zego_appId.dart';
import 'package:nial_deliveries/firebase_options.dart';
import 'package:nial_deliveries/routes/app_routes.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

final navigatorKey = NavigatorService.navigatorKey;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  NotificationService notificationService = NotificationService();
  notificationService.requestNotificationPermission();
  // notificationService.listenerEvent();
  notificationService.firebaseInit();
  runApp(MyApp(navigatorKey: navigatorKey));
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService notifser = NotificationService();
  notifser.initLocalNotifications();
  if (message.notification!.body == 'calling_from_other_device') {
    // notifser.showCallkitIncoming(Uuid().v4(),
    //     message.notification!.title.toString(), message.data['callToken']);
  } else
    notifser.showNotification(message);
}

class MyApp extends StatelessWidget {
  // ZegoUIKitPrebuiltCallInvitationService().uninit()
  MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);
  final navigatorKey;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'waleed_s_application2',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      supportedLocales: [
        Locale(
          'en',
          '',
        ),
      ],
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    );
  }
}
