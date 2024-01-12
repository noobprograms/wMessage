import 'package:flutter/material.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';

class CallProcessScreen extends StatelessWidget {
  const CallProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Connecting...",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: mediaQueryData.size.height * 0.02),
              )
            ]),
      ),
    );
  }
}
