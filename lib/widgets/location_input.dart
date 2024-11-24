import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  LocationInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Location? _pickedLocation;
  var _isGettingLocation = false;

  void _getCurrentLocation() async {
    print('??++ Getting current location...');

    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // for the loader spinner
    _isGettingLocation = true;
    setState(() {});

    locationData = await location.getLocation();

    _isGettingLocation = false;
    setState(() {});

    print('??++ Location: ${locationData.latitude}, ${locationData.longitude}');
  }

  @override
  Widget build(BuildContext ctx) {
    Widget previewContent =
        const Text('No Location Chosen', textAlign: TextAlign.center);

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: previewContent,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLocation),
          TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              onPressed: () {})
        ],
      )
    ]);
  }
}
