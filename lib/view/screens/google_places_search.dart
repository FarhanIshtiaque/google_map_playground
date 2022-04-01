import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_map_playground/controller/marker_controller.dart';
import 'package:google_map_playground/view/wigets/textfield/priamry_textfield.dart';

class GooglePlacesSearch extends StatefulWidget {
  const GooglePlacesSearch({Key? key}) : super(key: key);

  @override
  State<GooglePlacesSearch> createState() => _GooglePlacesSearchState();
}

class _GooglePlacesSearchState extends State<GooglePlacesSearch> {
  final _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final markerController = Get.put(MarkerController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const PrimaryTextField(),
              const SizedBox(
                height: 30,
              ),
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Where?",
                    prefixIcon: const Icon(Icons.pin_drop_rounded),
                    suffixIcon: const Icon(Icons.cancel_outlined),
                    contentPadding: const EdgeInsets.only(left: 16, top: 18.5, bottom: 19.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blueGrey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blueGrey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blueGrey, width: 1.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.deepOrange, width: 1.0),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return Future.delayed(
                    Duration(seconds: 1),
                    () => CitiesService.getSuggestions(pattern),
                  );
                },
                itemBuilder: (context, String suggestion) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      suggestion,
                    ),
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  setState(() {
                    _typeAheadController.text = suggestion;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 20,
                width: double.maxFinite,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CitiesService {
  static final List<String> cities = [
    'Beirut',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
