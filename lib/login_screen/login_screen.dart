import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nial_deliveries/core/utils/image_constant.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';
import 'package:nial_deliveries/login_screen/controller/login_controller.dart';
import 'package:nial_deliveries/theme/theme_helper.dart';
import 'package:nial_deliveries/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  LoginController controller = Get.find();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 14.h,
                vertical: 45.v,
              ),
              child: Column(
                children: [
                  Image.asset(
                    ImageConstant.logo,
                    height: mediaQueryData.size.height * 0.2,
                    width: mediaQueryData.size.width * 0.5,
                  ),
                  SizedBox(
                    height: mediaQueryData.size.height * 0.023,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: mediaQueryData.size.height * 0.05),
                  ),
                  CustomTextFormField(
                    focusNode: emailFocus,
                    controller: controller.emailController,
                    width: mediaQueryData.size.width * 0.83,
                    autofocus: false,
                    borderDecoration: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    textStyle: theme.textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: mediaQueryData.size.height * 0.023,
                  ),
                  CustomTextFormField(
                    focusNode: passwordFocus,
                    controller: controller.passwordController,
                    width: mediaQueryData.size.width * 0.83,
                    autofocus: false,
                    borderDecoration: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'password',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    textStyle: theme.textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: mediaQueryData.size.height * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.login();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 65, 74, 148),
                        fixedSize: Size(mediaQueryData.size.width * 0.83,
                            mediaQueryData.size.height * 0.0625),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: mediaQueryData.size.height * 0.036,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 26.h,
                      top: 21.v,
                      right: 26.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13.v),
                          child: SizedBox(
                            width: 127.h,
                            child: Divider(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 13.h),
                          child: Text('or'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 12.v,
                            bottom: 13.v,
                          ),
                          child: SizedBox(
                            width: 147.h,
                            child: Divider(
                              indent: 13.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.v),
                  ElevatedButton(
                    onPressed: () {
                      controller.googleSignIn();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 166, 198, 253),
                        fixedSize: Size(mediaQueryData.size.width * 0.83,
                            mediaQueryData.size.height * 0.0625),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 18.h),
                          child: Image.asset(
                            ImageConstant.googleLogo,
                            height: mediaQueryData.size.height * 0.0425,
                            width: mediaQueryData.size.width * 0.09,
                          ),
                        ),
                        Text(
                          'Login in with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: mediaQueryData.size.height * 0.026,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 37.v),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: mediaQueryData.size.height * 0.026,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.goToSignUp();
                            },
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: mediaQueryData.size.height * 0.026,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
