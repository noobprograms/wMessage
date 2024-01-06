import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nial_deliveries/chat_room/controller/media_preview_controller.dart';

class MediaPreview extends StatelessWidget {
  MediaPreview({super.key});
  MediaController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child:
                  // controller.isVideo
                  // ? VideoPlayer(controller.videoController!):
                  Image.file(controller.assetFile),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.sendFile(controller.assetFile);
                },
                child: Text('Send Message'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
