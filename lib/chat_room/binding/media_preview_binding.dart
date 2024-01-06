import 'package:get/get.dart';
import 'package:nial_deliveries/chat_room/controller/media_preview_controller.dart';

class MediaPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MediaController());
  }
}
