import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_polimi/models/venue.dart';
import 'package:mobile_app_polimi/providers/user_venues.dart';
import 'package:mobile_app_polimi/widgets/image_input.dart';
import 'package:mobile_app_polimi/widgets/venue_input.dart';

// ConsumerStatefulWidget allows us to consume from riverpod (notice ConsumerState as well)
class AddVenueScreen extends ConsumerStatefulWidget {
  const AddVenueScreen({super.key});

  @override
  ConsumerState<AddVenueScreen> createState() {
    return _AddVenueScreenState();
  }
}

class _AddVenueScreenState extends ConsumerState<AddVenueScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  VenueLocation? _selectedLocation;

  _saveVenue() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }

    // ref is available due to the ConsumerXXX
    // this is how we add the new venue to the provider
    ref
        .read(userVenuesProvider.notifier)
        .addVenue(enteredTitle, _selectedImage!, _selectedLocation!);

    // to go back to the previous screen
    // we have direct access to the context since we're inside a state
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Venue'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Venue Name'),
                controller: _titleController,
              ),

              const SizedBox(height: 10), // add some space before the button

              ImageInput(
                onPickImage: (pickedImage) {
                  _selectedImage = pickedImage;
                },
              ),

              const SizedBox(height: 10), // add some space before the button

              VenueInput(
                onSelectLocation: (location) {
                  _selectedLocation = location;
                },
              ),

              const SizedBox(height: 20), // add some space before the button

              ElevatedButton.icon(
                onPressed: _saveVenue,
                icon: const Icon(Icons.save),
                label: const Text('Save Venue'),
              )
            ],
          )),
    );
  }
}
