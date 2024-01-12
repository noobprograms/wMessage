import 'package:get/get.dart';
import 'package:nial_deliveries/core/utils/notification_service.dart';
import 'package:nial_deliveries/routes/app_routes.dart';

import '../../googleauth/controller/auth_controller.dart';

/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
class SplashController extends GetxController {
  @override
  @override
  void onReady() async {
    await Future.delayed(Duration(milliseconds: 3000), () async {
      Get.put(AuthController());

      // Get.offNamed(AppRoutes.loginScreen);
    });
  }
}
