import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Location {
  Location({required this.title}) : id = uuid.v4();

  final String title;
  final String id;
}
