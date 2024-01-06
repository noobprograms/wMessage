import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nial_deliveries/core/utils/auth_constants.dart';
import 'package:nial_deliveries/googleauth/controller/auth_controller.dart';
import 'package:nial_deliveries/routes/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void goToSignUp() {
    Get.toNamed(AppRoutes.signUpScreen);
  }

  void login() {
    Get.put(AuthController());
    authController.login(
        emailController.text.trim(), passwordController.text.trim());
  }

  void googleSignIn() {
    Get.put(AuthController());
    authController.signInWithGoogle();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
