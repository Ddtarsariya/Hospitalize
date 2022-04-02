import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({Key? key}) : super(key: key);

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late GoogleMapController mapController;
  bool resetMapToCurrent = false;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<LatLng> _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));
    return Future.value(LatLng(position.latitude, position.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
        future: _getUserLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              compassEnabled: true,
              myLocationEnabled: true,
              onCameraMove: (val) {
                resetMapToCurrent = false;
              },
              initialCameraPosition: CameraPosition(
                target: snapshot.data ?? _center,
                zoom: 13.0,
              ),
            );
          }
        });
  }
}
