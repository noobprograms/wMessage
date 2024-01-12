import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nial_deliveries/core/utils/image_constant.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';
import 'package:nial_deliveries/splash_screen/controller/splash_controller.dart';
import 'package:nial_deliveries/localization/app_localization.dart';
import 'package:nial_deliveries/theme/theme_helper.dart';
import '../widgets/custom_image_view.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key})
      : super(
          key: key,
        );
  SplashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: mediaQueryData.size.height,
          width: mediaQueryData.size.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: mediaQueryData.size.height * 0.4,
              width: mediaQueryData.size.width * 0.6,
              child: Image.asset(
                ImageConstant.logo,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
