import 'package:get/get.dart';
import 'package:nial_deliveries/chat_room/controller/chat_room_controller.dart';

class ChatRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRoomController());
  }
}
