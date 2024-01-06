import 'package:get/get.dart';
import 'package:nial_deliveries/chat_room/binding/chat_room_binding.dart';
import 'package:nial_deliveries/chat_room/binding/media_preview_binding.dart';
import 'package:nial_deliveries/chat_room/binding/voice_call_binding.dart';
import 'package:nial_deliveries/chat_room/chat_room_screen.dart';
import 'package:nial_deliveries/chat_room/media_preview_screen.dart';
import 'package:nial_deliveries/chat_room/voiceCallingScreen.dart';
import 'package:nial_deliveries/chats_screen/binding/chats_screen_binding.dart';
import 'package:nial_deliveries/chats_screen/chats_screen.dart';
import 'package:nial_deliveries/login_screen/binding/login_binding.dart';
import 'package:nial_deliveries/login_screen/login_screen.dart';
import 'package:nial_deliveries/sign_up_screen/binding/sign_up_binding.dart';
import 'package:nial_deliveries/sign_up_screen/sign_up_screen.dart';
import 'package:nial_deliveries/splash_screen/splash_screen.dart';

import '../splash_screen/binding/splash_binding.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String loginScreen = '/login_screen';

  static const String signUpScreen = '/sign_up_screen';
  static const String chatsScreen = '/chats_screen';
  static const String chatRoomScreen = '/chat_room_screen';
  static const String mediaPreview = '/media_preview';
  static const String voiceCallScreen = '/voice_calling_screen';
  static final routes = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: chatsScreen,
      page: () => ChatScreen(),
      binding: ChatsBinding(),
    ),
    GetPage(
      name: chatRoomScreen,
      page: () => ChatRoom(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: mediaPreview,
      page: () => MediaPreview(),
      binding: MediaPreviewBinding(),
    ),
    GetPage(
      name: voiceCallScreen,
      page: () => VoiceCalling(),
      binding: VoiceCallBinding(),
    ),
  ];
}
