import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nial_deliveries/core/utils/auth_constants.dart';
import 'package:nial_deliveries/routes/app_routes.dart';

import '../../googleauth/controller/auth_controller.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  void signUp() {
    Get.put(AuthController());
    if (passwordController.text == confirmpasswordController.text)
      authController.register(emailController.text, passwordController.text,
          nameController.text, numberController.text);
    else
      Get.snackbar(
          'Unmatched Passwords', 'The passwords you entered do not match',
          snackPosition: SnackPosition.BOTTOM);
  }

  void goToSignIn() {
    Get.offNamed(AppRoutes.loginScreen);
  }

  void googleSignIn() {
    Get.put(AuthController());
    authController.signInWithGoogle();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
  }
}
