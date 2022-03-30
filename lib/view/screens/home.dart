import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_playground/view/screens/google_places_search.dart';
import 'package:google_map_playground/view/screens/multiple_marker.dart';
import 'package:google_map_playground/view/wigets/buttons/button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              onPressed: () {
                Get.to(MapSample());
              },
              buttonNameWidget: const Text('Multiple Marker'),
            ),
            const SizedBox(
              height: 20,
            ),
            Button(
                onPressed: () {
                  Get.to(GooglePlacesSearch());
                },
                buttonNameWidget: const Text('Google Places Search'))
          ],
        ),
      ),
    );
  }
}
