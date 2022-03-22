import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
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

  // Set<Marker> allMarker =<Marker>{}.obs;
  var allMarker = <Marker>{}.obs;

  Future<void> fetchMarkers() async {
    try {
      final result = await httpService.request(url: "/users", method: Method.GET);

      if (result != null) {
        if (result is Response) {
          var jsonResponse = result.data;
          List<UserModel> userModelList = [];
          if (jsonResponse.length > 0) jsonResponse!.forEach((user) => userModelList.add(UserModel.fromJson(user)));
          // List<UserModel> userModel =
          // jsonResponse.map((json) => UserModel.fromJson(json)).toList();
          for (var i = 0; i < userModelList.length; i++) {
            allMarker.add(
              Marker(
                markerId: MarkerId(userModelList[i].id.toString()),
                //way points
                position: LatLng(double.parse(userModelList[i].address!.geo!.lat!), double.parse(userModelList[i].address!.geo!.lng!)),
                infoWindow: InfoWindow(
                  title: userModelList[i].name.toString(),
                  snippet: userModelList[i].company!.name.toString(),
                ),
                icon: await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 2.5), 'assets/marker.png'),
              ),
            );
          }
        } else {}
      }
    } finally {}
  }
}
