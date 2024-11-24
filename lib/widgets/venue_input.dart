import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:http/http.dart' as http;
import 'package:mobile_app_polimi/models/venue.dart';

const String apiKey = 'AIzaSyCxHeFOR5O5_LlcXfEERcwdqZNXeErH8vo';

class VenueInput extends StatefulWidget {
  VenueInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VenueInputState();
  }
}

class _VenueInputState extends State<VenueInput> {
  VenueLocation? _pickedLocation;

  var _isGettingLocation = false;

  // special type of getters dart has (it's like a computed property, read only)
  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }

    final lat = _pickedLocation!.lattitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
  }

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

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    // make a request to google maps api to get the address from the coordinates
    // everyone will need to set their google api key for this to work
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey');
    final response = await http.get(url);
    final data = json.decode(response.body);
    final address = data['results'][0]['formatted_address'];

    _pickedLocation =
        VenueLocation(lattitude: lat, longitude: lng, address: address);
    _isGettingLocation = false;
    setState(() {});

    print(
        '??++ Location: ${locationData.latitude}, ${locationData.longitude}, $address');
  }

  @override
  Widget build(BuildContext ctx) {
    // the preview content is either the snapshot of the location or a message for empty location
    Widget previewContent =
        const Text('No Location Chosen', textAlign: TextAlign.center);

    if (_pickedLocation != null) {
      previewContent = Image.network(locationImage,
          fit: BoxFit.cover, width: double.infinity, height: double.infinity);
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
