import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nial_deliveries/firebase_options.dart';
import 'package:nial_deliveries/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'waleed_s_application2',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale(
          'en',
          '',
        ),
      ],
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    );
  }
}
