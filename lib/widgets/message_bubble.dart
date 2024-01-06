import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nial_deliveries/chat_room/map_preview_widget.dart';
import 'package:nial_deliveries/core/utils/image_constant.dart';
import 'package:nial_deliveries/core/utils/image_full_screen.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {required this.document,
      required this.cUserId,
      required this.otherUserName,
      super.key});
  final DocumentSnapshot document;
  final String cUserId;
  final String otherUserName;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    bool thisUserMessage = data['senderId'] == cUserId;

    var alignment =
        thisUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start;
    var decoration = thisUserMessage
        ? BoxDecoration(
            color: Color.fromARGB(255, 81, 142, 248),
            borderRadius: BorderRadius.circular(15))
        : BoxDecoration(
            color: Color.fromARGB(255, 65, 74, 148),
            borderRadius: BorderRadius.circular(15));

    return !thisUserMessage
        ? Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: alignment,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.33,
                  decoration: decoration,
                  child: Row(
                    children: [
                      Expanded(
                          child: data['type'] == 'text'
                              ? Text(
                                  data['message'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : data['type'] == 'image'
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ImageFullScreen(
                                                    data['asset'])));
                                      },
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: data['asset'],
                                            placeholder: (_, url) =>
                                                Image.asset(
                                              ImageConstant.imageNotFound,
                                              color: Colors.white,
                                            ),
                                          )),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: MapPreviewWidget(
                                          message: data['message'],
                                          senderName: otherUserName),
                                    )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 7.h,
                  top: 16.v,
                  bottom: 22.v,
                ),
                child: Text(
                  DateFormat.jm().format(data['timestamp'].toDate()).toString(),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: alignment,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 7.h,
                  top: 16.v,
                  bottom: 22.v,
                ),
                child: Text(
                  DateFormat.jm().format(data['timestamp'].toDate()).toString(),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.33,
                  decoration: decoration,
                  child: Row(
                    children: [
                      Expanded(
                          child: data['type'] == 'text'
                              ? Text(
                                  data['message'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : data['type'] == 'image'
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ImageFullScreen(
                                                    data['asset'])));
                                      },
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: data['asset'],
                                            placeholder: (_, url) =>
                                                Image.asset(
                                              ImageConstant.imageNotFound,
                                              color: Colors.white,
                                            ),
                                          )),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: MapPreviewWidget(
                                          message: data['message'],
                                          senderName: 'You'),
                                    )),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
