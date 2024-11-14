import 'package:google_maps/src/data/models/house.model.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String get _id => const Uuid().v4();

final defaultHouses = [
  House(
    id: _id,
    name: 'A',
    price: 10,
    position: const LatLng(41.900746, 12.483139),
  ),
  House(
    id: _id,
    name: 'B',
    price: 20,
    position: const LatLng(41.903197, 12.477798),
  ),
  House(
    id: _id,
    name: 'C',
    price: 30,
    position: const LatLng(41.914788, 12.474919),
  ),
];
