import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nial_deliveries/chats_screen/controller/chats_screen_controller.dart';
import 'package:nial_deliveries/core/models/user_model.dart';
import 'package:nial_deliveries/core/utils/auth_constants.dart';
import 'package:nial_deliveries/core/utils/image_constant.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';
import 'package:nial_deliveries/googleauth/controller/auth_controller.dart';
import 'package:nial_deliveries/routes/app_routes.dart';
import 'package:nial_deliveries/widgets/chat_info_tile.dart';
import 'package:nial_deliveries/widgets/custom_image_view.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  ChatsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Image.asset(
            ImageConstant.cutLogo,
            width: mediaQueryData.size.width * 0.1,
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.put(AuthController());
                authController.signOut();
                ;
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: mediaQueryData.size.width * 0.015,
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7)),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 226, 224, 237),
                  Color.fromARGB(255, 92, 105, 205),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          padding: EdgeInsets.only(top: 30.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(
              //           'Chats',
              //           style: TextStyle(
              //             fontSize: mediaQueryData.size.height * 0.047,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Obx(() => controller.isLoaded.value
                  ? controller.noChats.value
                      ? Expanded(
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'No chats to display. Press the button below to start chatting',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: mediaQueryData.size.width * 0.05,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                        )
                      : Expanded(
                          child: ListView.separated(
                          itemCount: controller.allChatRooms.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (context, index) {
                            print(index);
                            var instantUser = User(
                              uid: controller.allChatRooms.value[index]['uid'],
                              name: controller.allChatRooms.value[index]
                                  ['name'],
                              email: controller.allChatRooms.value[index]
                                  ['email'],
                              profileImageUrl: controller
                                  .allChatRooms.value[index]['profileImageUrl'],
                              tokenValue: controller.allChatRooms.value[index]
                                  ['tokenValue'],
                              phoneNumber: controller.allChatRooms.value[index]
                                  ['phoneNumber'],
                            );
                            return GestureDetector(
                              onTap: () {
                                controller.goToChatRoom(instantUser);
                              },
                              child: ChatInfoTile(
                                  instantUser, controller.currentuser),
                            );
                          },
                        ))
                  : Expanded(
                      child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 65, 74, 148),
                  onPressed: () {
                    Get.bottomSheet(Container(
                      height: mediaQueryData.size.height - 20,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          TextField(
                            onChanged: (value) {
                              controller.messageTextChanged(value);
                              // print('I am${searchResults.length}');
                            },
                            controller: controller.searchUserInput,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter username to chat',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.h),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.h),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.h),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: Obx(() => ListView.separated(
                                  itemCount:
                                      controller.searchResults.value.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 10,
                                      ),
                                  itemBuilder: (context, index) {
                                    // print(
                                    //     'I am ${controller.searchResults.value[index]["name"]}');
                                    var instantUser = User(
                                      uid: controller.searchResults.value[index]
                                          ['uid'],
                                      name: controller
                                          .searchResults.value[index]['name'],
                                      email: controller
                                          .searchResults.value[index]['email'],
                                      profileImageUrl: controller.searchResults
                                          .value[index]['profileImageUrl'],
                                      phoneNumber: controller.searchResults
                                          .value[index]['phoneNumber'],
                                      tokenValue: controller.searchResults
                                          .value[index]['tokenValue'],
                                    );
                                    return GestureDetector(
                                      onTap: () {
                                        controller.goToChatRoom(instantUser);
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                controller.searchResults
                                                        .value[index]
                                                    ['profileImageUrl']),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Text(
                                                controller.searchResults
                                                    .value[index]['name'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19)),
                                          )
                                        ],
                                      ),
                                    );
                                  })))
                        ],
                      ),
                    ));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
