import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_polimi/models/location.dart';

class UserLocationsNotifier extends StateNotifier<List<Location>> {
  UserLocationsNotifier() : super(const []);

  void addLocation(String title, File image) {
    final location = Location(title: title, image: image);
    // you can't directly add the state, you need to re-create the list
    state = [...state, location];
  }
}

// Q: what's better?
final userLocationsProvider =
    StateNotifierProvider<UserLocationsNotifier, List<Location>>(
  (ref) => UserLocationsNotifier(),
);
