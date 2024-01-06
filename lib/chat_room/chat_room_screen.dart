import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nial_deliveries/chat_room/controller/chat_room_controller.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';
import 'package:nial_deliveries/routes/app_routes.dart';
import 'package:nial_deliveries/widgets/custom_text_form_field.dart';
import 'package:nial_deliveries/widgets/message_bubble.dart';

class ChatRoom extends StatelessWidget {
  ChatRoom({super.key});
  ChatRoomController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Get.offAndToNamed(AppRoutes.chatsScreen,
                    arguments: {'currentUser': controller.currentUser}),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    // controller.seeAccount(context);
                  },
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(controller.thatUser.profileImageUrl),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                controller.thatUser.name,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 65, 74, 148),
        titleSpacing: 0,
        leadingWidth: 300.h,
        shadowColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.voiceCallScreen, arguments: {
                    'cUser': controller.currentUser,
                    'callToken': controller.callToken
                  });
                },
                icon: Icon(
                  Icons.call,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: Container(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        padding: EdgeInsets.only(top: 68.v),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: controller.chatService.getChatsForUser(
                    controller.currentUser.uid, controller.thatUser.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text('Error${snapshot.error}');
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Text('Loading...');
                  return ListView(
                    children: snapshot.data!.docs
                        .map((doc) => MessageBubble(
                              document: doc,
                              cUserId: controller.currentUser.uid,
                              otherUserName: controller.thatUser.name,
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: IconButton(
                    onPressed: controller.openAttachment,
                    icon: Icon(
                      Icons.attachment,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextFormField(
                    controller: controller.messageController,
                    hintText: 'Send Message',
                    textStyle: TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.sendMessage();
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.blue,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
