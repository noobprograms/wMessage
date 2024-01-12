// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:agora_uikit/models/agora_rtm_mute_request.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nial_deliveries/core/utils/agora_appID.dart';
// import 'package:nial_deliveries/core/utils/size_utils.dart';

// class NewCallingScreen extends StatefulWidget {
//   NewCallingScreen({required this.callToken, super.key});
//   final String callToken;
//   @override
//   State<NewCallingScreen> createState() => _NewCallingScreenState();
// }

// class _NewCallingScreenState extends State<NewCallingScreen> {
//   String chatRoomId = "";
//   late AgoraClient client;

//   @override
//   void initState() {
//     super.initState();
//     callInit();
//   }

//   Future<void> callInit() async {
//     client = AgoraClient(
//       agoraConnectionData: AgoraConnectionData(
//         appId: appID,
//         channelName: 'nail_call',
//         tempToken: widget.callToken,
//       ),
//     );

//     var status = await [Permission.microphone].request();
//     print('permission says $status');
//     await client.initialize();
//     await client.engine.disableVideo();
//     await client.engine.enableLocalAudio(true);

//     // await client.initialize().then((value) => client.sessionController
//     //     .updateUserVideo(
//     //         uid: client.agoraConnectionData.uid ?? 0, videoDisabled: true));
//     // client.sessionController.value.copyWith(
//     //     isLocalVideoDisabled:
//     //         !(client.sessionController.value.isLocalVideoDisabled));
//     // await client.sessionController.value.engine?.muteLocalVideoStream(
//     //     client.sessionController.value.isLocalVideoDisabled);
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//     // dispose the client when done with it
//     client.release();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         body: SafeArea(
//             child: Stack(
//           children: [
//             AgoraVideoButtons(
//               client: client,
//               enabledButtons: [
//                 BuiltInButtons.toggleMic,
//                 BuiltInButtons.callEnd
//               ],
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }
