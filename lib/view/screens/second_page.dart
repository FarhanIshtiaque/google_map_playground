import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_playground/controller/marker_controller.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markerController = Get.put(MarkerController());

    return Container();
  }
}
