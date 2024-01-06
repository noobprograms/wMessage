import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart';
import 'package:nial_deliveries/core/models/user_model.dart';
import 'package:nial_deliveries/core/utils/agora_appID.dart';
import 'package:nial_deliveries/core/utils/auth_constants.dart';
import 'package:nial_deliveries/routes/app_routes.dart';

class ChatsController extends GetxController {
  User currentuser = Get.arguments['currentUser'];
  RxList allChatRooms = [].obs;
  TextEditingController searchUserInput = TextEditingController();
  RxList allUsers = [].obs;
  RxList searchResults = [].obs;
  RxBool isLoaded = false.obs;
  void onInit() {
    super.onInit();
    getAllUsers();
    searchResults.value = allUsers;
  }

  void onClose() {
    super.dispose();
  }

  void goToChatRoom(User thatUser) async {
    List<String> ids = [currentuser.uid, thatUser.uid];
    ids.sort();
    String chatRoomId = ids.join('-');
    var result =
        await get(Uri.parse('$baseUrl/nail_call/publisher/userAccount/0/'));
    var extractedToken = jsonDecode(result.body)['rtcToken'];

    Get.toNamed(AppRoutes.chatRoomScreen, arguments: {
      'cUser': currentuser,
      'tUser': thatUser,
      'callToken': extractedToken
    });
  }

  void messageTextChanged(String value) {
    // List<Map<String, dynamic>> results = [];
    // if (value.isEmpty) results = allUsers;

    if (value.isNotEmpty) {
      searchResults.value = allUsers
          .where((element) =>
              element['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      // Filter and add users that match the search query
      searchResults.value = allUsers;
    }

    update();
  }

  void getAllUsers() async {
    var data = await firebaseFirestore
        .collection('users')
        .where('uid', isNotEqualTo: currentuser.uid)
        .get();

    data.docs.forEach(
      (element) {
        allUsers.add(element.data());

        isLoaded(true);
      },
    );
    allUsers.forEach((element) async {
      //generating the chatroom id
      List<String> ids = [currentuser.uid, element['uid']];

      ids.sort();
      String chatRoomId = ids.join('-');
      final docRef = await firebaseFirestore
          .collection("rooms")
          .doc(chatRoomId)
          .collection("messages")
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          allChatRooms.add(element);
        }
      });

      // if (docRef.docs.length > 1) {
      //   print("Hello");
      //   allChatRooms.add(element);
      // }
    });
  }
}
