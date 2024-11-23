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
      body: Center(
        child: Text(
          'Imaginary details of ${location.title}',
          style: Theme.of(ctx)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(ctx).colorScheme.onSurface),
        ),
      ),
    );
  }
}
