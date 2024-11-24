import 'package:flutter/material.dart';
import 'package:mobile_app_polimi/models/venue.dart';

class VenueDetailsScreen extends StatelessWidget {
  const VenueDetailsScreen({super.key, required this.venue});

  final Venue venue;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(venue.title),
      ),
      body: Stack(
        children: [
          Image.file(
            venue.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
