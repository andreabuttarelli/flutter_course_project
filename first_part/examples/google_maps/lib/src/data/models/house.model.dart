import 'package:google_maps_flutter/google_maps_flutter.dart';

class House {
  final String id;
  final String name;
  final double price;
  final LatLng position;

  const House({
    required this.id,
    required this.name,
    required this.price,
    required this.position,
  });
}
