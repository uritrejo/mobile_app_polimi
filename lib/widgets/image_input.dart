import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    // here you can see the same type of thing as with js promises
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }

    _selectedImage = File(pickedImage.path);

    // reload the UI for the image to show up
    setState(() {});

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        icon: const Icon(Icons.camera),
        label: const Text('Take Picture'),
        onPressed: _takePicture);

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        // the ! at the end is cuz you know it'll never be null
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          // make it take over the whole container
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 1, color: Colors.grey),
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      height: 250,
      width: double.infinity, // as wide as the parent allows
      alignment: Alignment
          .center, // center the child in this container (horizontal & vertical)
      // the child will be either a button or the image preview
      child: content,
    );
  }
}
