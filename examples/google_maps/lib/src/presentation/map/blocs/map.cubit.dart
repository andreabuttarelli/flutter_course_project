import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/src/core/default_houses.dart';
import 'package:google_maps/src/data/models/house.model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit()
      : super(MapState(
          currentElementID: defaultHouses.first.id,
          houses: defaultHouses,
          markers: {},
        ));

  final Map<String, BitmapDescriptor> markerIcons = {};
  final Map<String, BitmapDescriptor> focusedMarkerIcons = {};

  void updateCurrentElementID(int index) {
    final currentState = state;
    final previousID = currentState.currentElementID;
    emit(state.copyWith(currentElementID: state.houses[index].id));
    loadMarker(
      previousID,
      state.houses[index].id,
    );
  }

  Future<void> loadMarkers() async {
    final currentState = state;
    final markers = <Marker>{};
    for (final house in currentState.houses) {
      markers.add(
        Marker(
          markerId: MarkerId(house.id),
          icon: await _markerIcon(
              house, currentState.currentElementID == house.id),
          position: house.position,
        ),
      );
    }
    emit(currentState.copyWith(markers: markers));
  }

  Future<void> loadMarker(String previousID, String nextID) async {
    final currentState = state;
    final markers = {...state.markers};

    final previousHouse =
        currentState.houses.firstWhere((e) => e.id == previousID);
    markers.removeWhere((e) => e.markerId.value == previousID);
    markers.add(
      Marker(
        markerId: MarkerId(previousHouse.id),
        icon: await _markerIcon(
          previousHouse,
          false,
        ),
        position: previousHouse.position,
      ),
    );

    final house = currentState.houses.firstWhere((e) => e.id == nextID);
    markers.removeWhere((e) => e.markerId.value == nextID);
    markers.add(
      Marker(
        markerId: MarkerId(house.id),
        icon: await _markerIcon(
          house,
          true,
        ),
        position: house.position,
      ),
    );
    emit(currentState.copyWith(markers: markers));
  }

  Widget _markerWidget(House house, bool isFocused) {
    return Container(
      width: 200,
      height: 150,
      color: isFocused ? Colors.blue : Colors.white,
      child: Center(
        child: Text(
          house.price.toStringAsFixed(2),
          style: TextStyle(
            color: isFocused ? Colors.white : Colors.black,
            fontSize: 64,
          ),
        ),
      ),
    );
  }

  Future<BitmapDescriptor> _markerIcon(House house, bool isFocused) async {
    final cached =
        isFocused ? focusedMarkerIcons[house.id] : markerIcons[house.id];
    if (cached != null) return cached;
    final res = await _markerWidget(house, isFocused).toBitmapDescriptor(
      logicalSize: const Size(200, 150),
      imageSize: const Size(200, 150),
    );
    if (isFocused) {
      focusedMarkerIcons[house.id] = res;
    } else {
      markerIcons[house.id] = res;
    }
    return res;
  }

  @override
  void onChange(Change<MapState> change) {
    print(change);
    super.onChange(change);
  }
}

class MapState {
  final String currentElementID;
  final List<House> houses;
  final Set<Marker> markers;

  const MapState({
    required this.currentElementID,
    required this.houses,
    required this.markers,
  });

  MapState copyWith({
    String? currentElementID,
    List<House>? houses,
    Set<Marker>? markers,
  }) {
    return MapState(
      currentElementID: currentElementID ?? this.currentElementID,
      houses: houses ?? this.houses,
      markers: markers ?? this.markers,
    );
  }
}
