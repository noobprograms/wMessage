import 'package:flutter/material.dart';
import 'package:nial_deliveries/core/utils/chat_service%20copy.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';
import 'package:intl/intl.dart';

class ChatInfoTile extends StatelessWidget {
  ChatInfoTile(this.instantUser, this.currentUser, {super.key});
  final instantUser;
  final currentUser;
  late String lastMessage;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatService.getLastUserMessage(currentUser, instantUser),
      builder: (context, snapshot) {
        final data = snapshot.data?.docs;
        if (snapshot.hasError) return Text('Error${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.waiting)
          return Text('Loading...');
        if (snapshot.hasData) {
          var message = data?.first.data() as Map<String, dynamic>;
          if (message.isNotEmpty) {
            if (message?['type'] == 'location')
              lastMessage = "Location";
            else if (message?['type'] == 'image')
              lastMessage = "Image";
            else
              lastMessage = message?['message'];
          }
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              padding: EdgeInsets.all(7.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 65, 74, 148),
                    Color.fromARGB(255, 108, 76, 249),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(instantUser.profileImageUrl),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(instantUser.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19)),
                        Text(
                          lastMessage,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateFormat.jm()
                            .format(message?['timestamp'].toDate())
                            .toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 193, 196, 225),
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else
          return Container();
      },
    );
  }
}
