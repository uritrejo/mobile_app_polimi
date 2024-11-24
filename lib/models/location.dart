import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Location {
  Location({required this.title, required this.image}) : id = uuid.v4();

  final String title;
  final String id;
  final File image;
}
