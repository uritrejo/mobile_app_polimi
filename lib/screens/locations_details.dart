import 'package:flutter/material.dart';
import 'package:mobile_app_polimi/models/location.dart';

class LocationsDetailsScreen extends StatelessWidget {
  const LocationsDetailsScreen({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
      ),
      body: Stack(
        children: [
          Image.file(
            location.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
