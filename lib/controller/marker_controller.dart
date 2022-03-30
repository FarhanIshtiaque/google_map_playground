import 'package:custom_info_window/custom_info_window.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_map_playground/core/helper/triangle_painter.dart';
import 'package:google_map_playground/core/network/network_service.dart';
import 'package:google_map_playground/data/model/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerController extends GetxController {
  HttpService httpService = HttpService();

  @override
  void onInit() {
    // TODO: implement onInit
    httpService.init();
    fetchMarkers();
    super.onInit();
  }

  final CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();

  // Set<Marker> allMarker =<Marker>{}.obs;
  var allMarker = <Marker>{}.obs;

  Future<void> fetchMarkers() async {
    try {
      final result = await httpService.request(url: "/users", method: Method.GET);

      if (result != null) {
        if (result is Response) {
          var jsonResponse = result.data;
          List<UserModel> userModelList = [];
          if (jsonResponse.length > 0) {
            jsonResponse!.forEach((user) => userModelList.add(UserModel.fromJson(user)));
          }
          // List<UserModel> userModel =
          // jsonResponse.map((json) => UserModel.fromJson(json)).toList();
          for (var i = 0; i < userModelList.length; i++) {
            allMarker.add(
              Marker(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    customInfoWindowController.addInfoWindow!(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: userModelList[i].id! >= 5
                                    ? const Color(0xff64CEBA)
                                    : Colors.greenAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    userModelList[i].company!.name.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          CustomPaint(
                            painter: TrianglePainter(
                              strokeColor: userModelList[i].id! >= 5
                                  ? const Color(0xff64CEBA)
                                  : Colors.greenAccent,
                              strokeWidth: 1,
                              paintingStyle: PaintingStyle.fill,
                            ),
                            child: const SizedBox(
                              height: 10,
                              width: 20,
                            ),
                          ),
                          // Triangle.isosceles(
                          //   edge: Edge.BOTTOM,
                          //   child: Container(
                          //     color: Colors.blue,
                          //     width: 20.0,
                          //     height: 10.0,
                          //   ),
                          // ),
                        ],
                      ),
                      LatLng(double.parse(userModelList[i].address!.geo!.lat!),
                          double.parse(userModelList[i].address!.geo!.lng!)),
                    );
                  });
                },
                markerId: MarkerId(userModelList[i].id.toString()),
                //way points
                position: LatLng(double.parse(userModelList[i].address!.geo!.lat!),
                    double.parse(userModelList[i].address!.geo!.lng!)),
                // infoWindow: InfoWindow(
                //   title: userModelList[i].name.toString(),
                //   snippet: userModelList[i].company!.name.toString(),
                // ),
                icon: await BitmapDescriptor.fromAssetImage(
                    const ImageConfiguration(devicePixelRatio: 2.5), 'assets/marker.png'),
              ),
            );
          }
        } else {}
      }
    } finally {}
  }
}
