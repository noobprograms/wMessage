import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:nial_deliveries/chat_room/middle_Screen.dart';
import 'package:nial_deliveries/chat_room/newCallingScreen.dart';
import 'package:nial_deliveries/chat_room/zego_voice_call.dart';
import 'package:nial_deliveries/core/utils/chat_service%20copy.dart';
import 'package:nial_deliveries/core/utils/zego_appId.dart';
import 'package:nial_deliveries/routes/app_routes.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../core/models/user_model.dart';
import '../../core/models/message_model.dart' as msg;

class ChatRoomController extends GetxController {
  User currentUser = Get.arguments['cUser'];
  User thatUser = Get.arguments['tUser'];
  String callToken = Get.arguments['callToken'];
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  Location location = Location();
  @override
  void onInit() async {
    super.onInit();
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          currentUser, thatUser, messageController.text, msg.Type.text, '');
      messageController.text = '';
    }
  }

  void callOther(BuildContext context) async {
    await chatService.ringOther(currentUser, thatUser, callToken);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => NewCallingScreen(callToken: callToken)));
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => NewCallingScreen(callToken: callToken)));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ZegoVoiceCall(
                name: currentUser.name, id: currentUser.uid.substring(0, 4))));
    // Get.offNamed(AppRoutes.voiceCallScreen,
    //     arguments: {"callToken": callToken});
  }

  // void seeAccount(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return OtherAccount(currentUser, thatUser);
  //   }));
  // }

  void openAttachment() {
    Get.bottomSheet(Container(
      height: 100,
      width: double.infinity,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              showFilePicker(FileType.image);
            },
            icon: Icon(
              Icons.photo,
            ),
            label: Text('Image'),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              sendCurrentLocation();
            },
            icon: Icon(Icons.location_on),
            label: Text('Location'),
          ),
        ],
      ),
    ));
  }

  Future<void> sendCurrentLocation() async {
    try {
      if (location == null) {
        location = Location();
      }
      var _serviceEnabled = await location!.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location!.requestService();
        if (!_serviceEnabled) {
          Get.snackbar(
              "Unable to access Location", 'Did you allow location access?');
        }
      }

      var _permissionGranted = await location!.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location!.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          Get.snackbar(
              "Unable to access Location", 'Did you allow location access?');
        }
      }
      final locationData = await location!.getLocation();
      chatService.sendMessage(
          currentUser,
          thatUser,
          '${locationData.latitude},${locationData.longitude}',
          msg.Type.location,
          '');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void showFilePicker(FileType fileType) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);

    msg.Type fileMsgType = msg.Type.values.byName(fileType.name);
    if (result == null) return;
    PlatformFile myFile = result!.files.first;
    File fileToUpload = File(myFile.path!);
    if (fileToUpload != null)
      Get.toNamed(AppRoutes.mediaPreview, arguments: {
        'cUser': currentUser,
        'tUser': thatUser,
        'theFile': fileToUpload,
        'fileType': fileMsgType,
      });
  }
}
