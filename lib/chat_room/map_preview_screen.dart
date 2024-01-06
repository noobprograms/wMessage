import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nial_deliveries/core/utils/size_utils.dart';

class MapPreviewScreen extends StatelessWidget {
  const MapPreviewScreen(
      {required this.message, required this.name, super.key});
  final String message;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
          zoom: 15,
          target: LatLng(
              double.parse(message.substring(0, message.indexOf(','))),
              double.parse(message.substring(message.indexOf(',') + 1)))),
      markers: {
        Marker(
            markerId: MarkerId(name),
            position: LatLng(
                double.parse(message.substring(0, message.indexOf(','))),
                double.parse(message.substring(message.indexOf(',') + 1))),
            infoWindow: InfoWindow(title: name))
      },
    ));
  }
}
