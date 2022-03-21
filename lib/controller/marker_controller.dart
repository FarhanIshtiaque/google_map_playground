import 'package:get/get.dart';
import 'package:google_map_playground/core/helper/logger.dart';
import 'package:google_map_playground/core/network/network_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerController extends GetxController{

  HttpService httpService = HttpService();




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMarkers();
  }


  List<Marker> allMarker =<Marker>[].obs;

  fetchMarkers()async{
    try {

      final result = await httpService.request(
          url: "/users",
          method: Method.GET,
        );

      if (result != null) {
        if (result is Response) {
          var jsonResponse = result.body;
          allMarker =;
          logger.d(jsonResponse);
        } else {

        }
      }
    } finally {

    }
  }


  fetchProject(int id) async {


    try {

      final result = await httpService.request(
          url: "/projects/$id",
          method: Method.GET,
          authToken: token.toString());

      if (result != null) {
        if (result is Response) {
          var jsonResponse = result.data;
          projectDetails = ProjectDetailsModel.fromJson(jsonResponse['data']);
          logger.d(jsonResponse);
        } else {

        }
      }
    } finally {

    }
  }
}