import 'package:dio/dio.dart';
import 'package:get/get.dart'hide Response;
import 'package:google_map_playground/core/helper/logger.dart';
import 'package:google_map_playground/core/network/network_service.dart';
import 'package:google_map_playground/data/model/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerController extends GetxController{

  HttpService httpService = HttpService();




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpService.init();
    fetchMarkers();

  }


  Set<Marker> allMarker =<Marker>{}.obs;


 Future<void> fetchMarkers()async{
    try {

      final result = await httpService.request(
          url: "/users",
          method: Method.GET,

        );

      if (result != null) {
        if (result is Response) {
          var jsonResponse = result.data;
          logger.d(jsonResponse);

          var userModel = jsonResponse.map((json) => UserModel.fromJson(json)).toList();
          for( var i =0 ; i < userModel.length;i++){
            allMarker.add(Marker(
              markerId: MarkerId(userModel[i].id.toString()), //way points
              position: LatLng(double.parse(userModel[i].address.geo.lat), double.parse(userModel[i].address.geo.lng)),

            ));
          }

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
          method: Method.GET
         );

      if (result != null) {
        if (result is Response) {



        } else {

        }
      }
    } finally {

    }
  }
}