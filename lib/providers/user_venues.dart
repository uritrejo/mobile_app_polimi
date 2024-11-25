import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_polimi/models/venue.dart';

class UserVenuesNotifier extends StateNotifier<List<Venue>> {
  UserVenuesNotifier() : super(const []);

  void addVenue(String title, File image, VenueLocation location) {
    final venue = Venue(title: title, image: image, location: location);
    // you can't directly add the state, you need to re-create the list
    state = [...state, venue];
  }
}

// Q: what's better?
final userVenuesProvider =
    StateNotifierProvider<UserVenuesNotifier, List<Venue>>(
  (ref) => UserVenuesNotifier(),
);
