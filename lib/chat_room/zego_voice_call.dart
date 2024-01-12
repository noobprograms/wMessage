import 'package:flutter/material.dart';
import 'package:nial_deliveries/core/utils/zego_appId.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZegoVoiceCall extends StatelessWidget {
  const ZegoVoiceCall({this.name, this.id, super.key});
  final name; // user's name
  final id; // user's ID

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: zegoAppID,
      appSign: zegoAppSignIn,
      callID: 'customerId',
      userID: id,
      userName: name,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
