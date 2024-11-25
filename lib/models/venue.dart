import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class VenueLocation {
  VenueLocation(
      {required this.lattitude,
      required this.longitude,
      required this.address});

  final double lattitude;
  final double longitude;
  final String address;
}

class Venue {
  Venue({required this.title, required this.image, required this.location})
      : id = uuid.v4();

  final String title;
  final String id;
  final File image;
  final VenueLocation location;
}
