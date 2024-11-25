import 'package:flutter/material.dart';

import 'package:mobile_app_polimi/models/venue.dart';
import 'package:mobile_app_polimi/screens/venue_details.dart';

class VenuesList extends StatelessWidget {
  const VenuesList({super.key, required this.venues});

  final List<Venue> venues;

  void _onVenueTap(BuildContext ctx, Venue venue) {
    // we push the VenueDetailsScreen to the navigator stack (essentialy navigating to it)
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => VenueDetailsScreen(venue: venue),
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    if (venues.isEmpty) {
      return Center(
        child: Text(
          'No venues have been added yet.',
          style: Theme.of(ctx)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(ctx).colorScheme.onSurface),
        ),
      );
    }

    return ListView.builder(
      itemCount: venues.length,
      itemBuilder: (ctx, index) {
        final venue = venues[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(venue.image),
          ),
          title: Text(
            venue.title,
            // the !.copyWith(...) is to overwrite the default style only here
            style: Theme.of(ctx)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(ctx).colorScheme.onSurface),
          ),
          subtitle: Text(
            venue.location.address,
            style: Theme.of(ctx)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(ctx).colorScheme.onSurface),
          ),
          onTap: () => _onVenueTap(ctx, venue),
        );
      },
    );
  }
}
