import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_playground/controller/marker_controller.dart';

class GooglePlacesSearch extends StatelessWidget {
  const GooglePlacesSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markerController = Get.put(MarkerController());

    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
