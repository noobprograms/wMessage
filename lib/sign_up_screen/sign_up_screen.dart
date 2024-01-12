import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:nial_deliveries/core/utils/image_constant.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';
import 'package:nial_deliveries/sign_up_screen/controller/sign_up_controller.dart';
import 'package:nial_deliveries/theme/theme_helper.dart';
import 'package:nial_deliveries/widgets/custom_image_view.dart';
import 'package:nial_deliveries/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key})
      : super(
          key: key,
        );

  SignUpController controller = Get.find();

  // TextEditingController nameController = TextEditingController();

  // TextEditingController emailController = TextEditingController();

  // TextEditingController passwordController = TextEditingController();

  // TextEditingController confirmpasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  final FocusNode numberFocus = FocusNode();

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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  bottom: 20.h,
                  right: 38.v,
                  left: 38.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.logo,
                      height: mediaQueryData.size.height * 0.2,
                      width: mediaQueryData.size.width * 0.4,
                    ),
                    SizedBox(
                      height: mediaQueryData.size.height * 0.007,
                    ),
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: mediaQueryData.size.height * 0.03),
                    ),
                    SizedBox(height: 28.v),
                    CustomTextFormField(
                      focusNode: nameFocus,
                      autofocus: false,
                      borderDecoration: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      controller: controller.nameController,
                      hintText: "Name",
                      textStyle: TextStyle(
                          fontSize: mediaQueryData.size.height * 0.03),
                    ),
                    SizedBox(height: 19.v),
                    CustomTextFormField(
                      focusNode: emailFocus,
                      autofocus: false,
                      borderDecoration: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      controller: controller.emailController,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                      textStyle: TextStyle(
                          fontSize: mediaQueryData.size.height * 0.03),
                    ),
                    SizedBox(height: 19.v),
                    CustomTextFormField(
                      focusNode: numberFocus,
                      autofocus: false,
                      borderDecoration: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      controller: controller.numberController,
                      hintText: "Number",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your mobile number';
                        }
                        return null;
                      },
                      textInputType: TextInputType.phone,
                      textStyle: TextStyle(
                          fontSize: mediaQueryData.size.height * 0.03),
                    ),
                    SizedBox(height: 19.v),
                    CustomTextFormField(
                      focusNode: passwordFocus,
                      autofocus: false,
                      borderDecoration: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      controller: controller.passwordController,
                      hintText: "Password",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Some password';
                        }
                        return null;
                      },
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      textStyle: TextStyle(
                          fontSize: mediaQueryData.size.height * 0.03),
                    ),
                    SizedBox(height: 19.v),
                    CustomTextFormField(
                      focusNode: confirmPasswordFocus,
                      autofocus: false,
                      borderDecoration: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      controller: controller.confirmpasswordController,
                      hintText: "Confirm Password",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      textStyle: TextStyle(
                          fontSize: mediaQueryData.size.height * 0.03),
                    ),
                    SizedBox(height: 19.v),
                    ElevatedButton(
                      onPressed: () {
                        controller.signUp();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 65, 74, 148),
                          fixedSize: Size(mediaQueryData.size.width * 0.83,
                              mediaQueryData.size.height * 0.0525),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: mediaQueryData.size.height * 0.026,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.h,
                        top: 10.v,
                        right: 20.h,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
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
                              width: 127.h,
                              child: Divider(
                                indent: 13.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.v),
                    ElevatedButton(
                      onPressed: () {
                        controller.googleSignIn();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 166, 198, 253),
                          fixedSize: Size(mediaQueryData.size.width * 0.83,
                              mediaQueryData.size.height * 0.0525),
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
                              // height: mediaQueryData.size.height * 0.0325,
                              width: mediaQueryData.size.width * 0.06,
                            ),
                          ),
                          Text(
                            'Login in with Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: mediaQueryData.size.height * 0.023,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 13.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: mediaQueryData.size.height * 0.023,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.goToSignIn();
                              },
                            text: 'Sign In',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: mediaQueryData.size.height * 0.023,
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
      ),
    );
  }
}
