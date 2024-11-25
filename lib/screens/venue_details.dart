import 'package:flutter/material.dart';
import 'package:mobile_app_polimi/models/venue.dart';

// TODO: put this and the locationImage getter in a separate common file
const String apiKey = 'AIzaSyCxHeFOR5O5_LlcXfEERcwdqZNXeErH8vo';

class VenueDetailsScreen extends StatelessWidget {
  const VenueDetailsScreen({super.key, required this.venue});

  final Venue venue;

  String get locationImage {
    final lat = venue.location.lattitude;
    final lng = venue.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
  }

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
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 70, backgroundImage: NetworkImage(locationImage)),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.white54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(venue.location.address,
                          textAlign: TextAlign.center,
                          style: Theme.of(ctx).textTheme.titleLarge)),
                ],
              ))
        ],
      ),
    );
  }
}
