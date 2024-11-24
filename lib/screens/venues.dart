import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_polimi/providers/user_venues.dart';
import 'package:mobile_app_polimi/screens/add_venue.dart';
import 'package:mobile_app_polimi/widgets/venues_list.dart';

// Consumer for riverpod
class VenuesScreen extends ConsumerWidget {
  const VenuesScreen({super.key});

  void _onAddPressed(BuildContext ctx) {
    // we push the AddVenueScreen to the navigator stack (essentialy navigating to it)
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => const AddVenueScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    // will rebuild whenever the provider's state/value changes (i.e. the list of venues of that user)
    final userVenues = ref.watch(userVenuesProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sports Venues'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _onAddPressed(ctx),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: VenuesList(venues: userVenues),
        ));
  }
}
