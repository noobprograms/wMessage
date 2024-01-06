import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nial_deliveries/chat_room/map_preview_screen.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';

class MapPreviewWidget extends StatelessWidget {
  MapPreviewWidget(
      {required this.message, required this.senderName, super.key});
  final String message;
  final String senderName;

  String get _constructUrl => Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        port: 443,
        path: '/maps/api/staticmap',
        queryParameters: {
          'center': '$message',
          'zoom': '18',
          'size': '700x500',
          'maptype': 'roadmap',
          'key': 'AIzaSyDIZp2gdUtRsySuwBUvbCnA4Z4fLByEYCE',
          'markers': 'color:red|$message'
        },
      ).toString();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapPreviewScreen(
                      message: message,
                      name: senderName,
                    )));
      },
      child: Image.network(
        _constructUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
