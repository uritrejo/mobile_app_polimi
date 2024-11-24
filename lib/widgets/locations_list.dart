import 'package:flutter/material.dart';

import 'package:mobile_app_polimi/models/location.dart';
import 'package:mobile_app_polimi/screens/locations_details.dart';

class LocationsList extends StatelessWidget {
  const LocationsList({super.key, required this.locations});

  final List<Location> locations;

  void _onLocationTap(BuildContext ctx, Location location) {
    // we push the LocationsDetailsScreen to the navigator stack (essentialy navigating to it)
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => LocationsDetailsScreen(location: location),
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    if (locations.isEmpty) {
      return Center(
        child: Text(
          'No locations have been added yet.',
          style: Theme.of(ctx)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(ctx).colorScheme.onSurface),
        ),
      );
    }

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (ctx, index) {
        final location = locations[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(location.image),
          ),
          title: Text(
            location.title,
            // the !.copyWith(...) is to overwrite the default style only here
            style: Theme.of(ctx)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(ctx).colorScheme.onSurface),
          ),
          onTap: () => _onLocationTap(ctx, location),
        );
      },
    );
  }
}
