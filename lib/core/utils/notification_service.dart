import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_callkit_incoming/entities/entities.dart';

// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:nial_deliveries/chat_room/newCallingScreen.dart';
import 'package:nial_deliveries/chat_room/zego_voice_call.dart';
import 'package:nial_deliveries/core/utils/auth_constants.dart';
import 'package:nial_deliveries/core/utils/navigator_service%20copy.dart';
import 'package:nial_deliveries/routes/app_routes.dart';
import 'package:uuid/uuid.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void initLocalNotifications() async {
    var androidInitialization =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iosInitialization = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitialization, iOS: iosInitialization);
    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(Random.secure().nextInt(10000).toString(),
            'High Importance Channel',
            importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            androidNotificationChannel.id, androidNotificationChannel.name,
            channelDescription: 'dummy description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    Future.delayed(Duration.zero, () {
      localNotificationsPlugin.show(1, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });
  }

  ///////////////////////////calling notif////////////////////////////////////////

  // Future<void> showCallkitIncoming(
  //     String uuid, String name, String callToken) async {
  //   final params = CallKitParams(
  //     id: uuid,
  //     nameCaller: name,
  //     appName: 'Nail Delieries',
  //     type: 0,
  //     duration: 30000,
  //     textAccept: 'Accept',
  //     textDecline: 'Decline',
  //     missedCallNotification: const NotificationParams(
  //       showNotification: true,
  //       isShowCallback: true,
  //       subtitle: 'Missed call',
  //       callbackText: 'Call back',
  //     ),
  //     extra: <String, dynamic>{'callToken': callToken},
  //     headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
  //     android: const AndroidParams(
  //       isCustomNotification: true,
  //       isShowLogo: false,
  //       ringtonePath: 'system_ringtone_default',
  //       backgroundColor: '#0955fa',
  //       backgroundUrl: 'assets/test.png',
  //       actionColor: '#4CAF50',
  //       textColor: '#ffffff',
  //     ),
  //   );
  //   await FlutterCallkitIncoming.showCallkitIncoming(params);
  // }

  ////////////////////////////////////////////////////////////////////////////////

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      AppSettings.openAppSettings();
      print('user denied permission');
    }
  }

  // void listenerEvent() {
  //   try {
  //     print('i a being called');
  //     FlutterCallkitIncoming.onEvent.listen((event) {
  //       print('HOME: $event');
  //       switch (event!.event) {
  //         case Event.actionCallIncoming:
  //           // TODO: received an incoming call
  //           break;
  //         case Event.actionCallStart:
  //           // TODO: started an outgoing call
  //           // TODO: show screen calling in Flutter
  //           break;
  //         case Event.actionCallAccept:
  //           // TODO: accepted an incoming call
  //           // TODO: show screen calling in Flutter
  //           // Get.offNamed(AppRoutes.voiceCallScreen,
  //           //     arguments: {"callToken": event.body["extra"]['callToken']});
  //           // NavigatorService.navigatorKey.currentState!.push(
  //           // MaterialPageRoute<void>(
  //           //   builder: (BuildContext context) => NewCallingScreen(
  //           //       callToken: event.body["extra"]['callToken']),
  //           // ),
  //           // MaterialPageRoute<void>(
  //           //   builder: (BuildContext context) => ZegoVoiceCall(),
  //           // ),
  //           // );
  //           break;
  //         case Event.actionCallDecline:
  //           // TODO: declined an incoming call

  //           break;
  //         case Event.actionCallEnded:
  //           // TODO: ended an incoming/outgoing call
  //           break;
  //         case Event.actionCallTimeout:
  //           // TODO: missed an incoming call
  //           break;
  //         case Event.actionCallCallback:
  //           // TODO: only Android - click action `Call back` from missed call notification
  //           break;
  //         case Event.actionCallToggleHold:
  //           // TODO: only iOS
  //           break;
  //         case Event.actionCallToggleMute:
  //           // TODO: only iOS
  //           break;
  //         case Event.actionCallToggleDmtf:
  //           // TODO: only iOS
  //           break;
  //         case Event.actionCallToggleGroup:
  //           // TODO: only iOS
  //           break;
  //         case Event.actionCallToggleAudioSession:
  //           // TODO: only iOS
  //           break;
  //         case Event.actionDidUpdateDevicePushTokenVoip:
  //           // TODO: only iOS
  //           break;
  //         case Event.actionCallCustom:
  //           break;
  //       }
  //     });
  //   } on Exception catch (e) {
  //     print("error is $e");
  //   }
  // }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((event) {
      // print(event.notification!.title.toString());

      initLocalNotifications();
      if (event.notification!.body.toString() == "calling_from_other_device") {
        // showCallkitIncoming(Uuid().v4(), event.notification!.title.toString(),
        //     event.data['callToken']);
      } else
        showNotification(event);
    });
  }
}
