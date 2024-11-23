import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  void _takePicture() {}

  @override
  Widget build(BuildContext context) {
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
      child: TextButton.icon(
          icon: const Icon(Icons.camera),
          label: const Text('Take Picture'),
          onPressed: _takePicture),
    );
  }
}
