import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_polimi/providers/user_locations.dart';
import 'package:mobile_app_polimi/widgets/image_input.dart';

// ConsumerStatefulWidget allows us to consume from riverpod (notice ConsumerState as well)
class AddLocationScreen extends ConsumerStatefulWidget {
  const AddLocationScreen({super.key});

  @override
  ConsumerState<AddLocationScreen> createState() {
    return _AddLocationScreenState();
  }
}

class _AddLocationScreenState extends ConsumerState<AddLocationScreen> {
  final _titleController = TextEditingController();

  File? _selectedImage;

  // ??++ I think I need to pass in the location?
  _saveLocation() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }

    // ??++ could add validation here (there's a lot missing anyways)

    // ref is available due to the ConsumerXXX
    // this is how we add the new location to the provider
    ref
        .read(userLocationsProvider.notifier)
        .addLocation(enteredTitle, _selectedImage!);

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
        title: const Text('Add New Location'),
      ),
      // TODO: here we could use a form to get all the values
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Location Name'),
                controller: _titleController,
              ),

              const SizedBox(height: 10), // add some space before the button

              // ??++ Image Input incoming
              ImageInput(
                onPickImage: (pickedImage) {
                  _selectedImage = pickedImage;
                },
              ),

              const SizedBox(height: 20), // add some space before the button
              ElevatedButton.icon(
                onPressed: _saveLocation,
                icon: const Icon(Icons.add),
                label: const Text('Add Location'),
              )
            ],
          )),
    );
  }
}
