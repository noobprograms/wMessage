import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPreviewScreen extends StatefulWidget {
  MapPreviewScreen(
      {required this.message, required this.senderName, super.key});
  final String message;
  final String senderName;
  @override
  State<MapPreviewScreen> createState() => _MapPreviewScreenState();
}

class _MapPreviewScreenState extends State<MapPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            zoom: 15,
            target: LatLng(
                double.parse(
                    widget.message.substring(0, widget.message.indexOf(','))),
                double.parse(widget.message
                    .substring(widget.message.indexOf(',') + 1)))),
        markers: {
          Marker(
            markerId: MarkerId(widget.senderName),
            position: LatLng(
                double.parse(
                    widget.message.substring(0, widget.message.indexOf(','))),
                double.parse(
                    widget.message.substring(widget.message.indexOf(',') + 1))),
          )
        },
      ),
    );
  }
}
