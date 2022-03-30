import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_playground/controller/marker_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.7128, -74.0060),
    zoom: 1,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final markerController = Get.put(MarkerController());
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: true,
              markers: markerController.allMarker.value,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onTap: (position) {
                markerController.customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                markerController.customInfoWindowController.onCameraMove!();
              },
              onMapCreated: (GoogleMapController controller) async {
                markerController.customInfoWindowController.googleMapController = controller;
              },
            ),
            CustomInfoWindow(
              controller: markerController.customInfoWindowController,
              offset: 30,
              width: 150,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
