// import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/agora_uikit.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nial_deliveries/chat_room/controller/voice_call_controller.dart';

class VoiceCalling extends StatelessWidget {
  VoiceCalling({super.key});
  VoiceCallController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            AgoraVideoViewer(
              client: controller.client,
              layoutType: Layout.floating,
              showNumberOfUsers: true,
            ),
            AgoraVideoButtons(
              client: controller.client,
              enabledButtons: [
                BuiltInButtons.toggleMic,
                BuiltInButtons.callEnd
              ],
            )
          ],
        )),
      ),
    );
  }
}
