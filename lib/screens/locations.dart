import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_polimi/providers/user_locations.dart';
import 'package:mobile_app_polimi/screens/add_location.dart';
import 'package:mobile_app_polimi/widgets/locations_list.dart';

// Consumer for riverpod
class LocationsScreen extends ConsumerWidget {
  const LocationsScreen({super.key});

  void _onAddPressed(BuildContext ctx) {
    // we push the AddLocationScreen to the navigator stack (essentialy navigating to it)
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => const AddLocationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    // will rebuild whenever the provider's state/value changes (i.e. the list of locations of that user)
    final userLocations = ref.watch(userLocationsProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sports Locations'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _onAddPressed(ctx),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: LocationsList(locations: userLocations),
        ));
  }
}
