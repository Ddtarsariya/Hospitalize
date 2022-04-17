import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackAmbulance extends StatefulWidget {
  static const routeName = '/track-ambulance';

  const TrackAmbulance({Key? key}) : super(key: key);

  @override
  State<TrackAmbulance> createState() => _TrackAmbulanceState();
}

class _TrackAmbulanceState extends State<TrackAmbulance> {
  late GoogleMapController mapController;
  bool resetMapToCurrent = false;
  late Uint8List markerIcon;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Ambulance'),
      ),
      body: FutureBuilder<Uint8List>(
          future: getBytesFromAsset('assets/ambulance.png', 100),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              markerIcon = snapshot.data!;
              return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users/$email/ambulance')
                      .doc('tracking')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      GeoPoint loc =
                          (snapshot.data!.get('location') as GeoPoint);
                      LatLng location = LatLng(loc.latitude, loc.longitude);
                      Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
                      final marker = Marker(
                        markerId: const MarkerId('place_name'),
                        position: location,
                        icon: BitmapDescriptor.fromBytes(markerIcon),
                        infoWindow: const InfoWindow(
                          title: 'title',
                          snippet: 'address',
                        ),
                      );
                      markers[const MarkerId('place_name')] = marker;
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          compassEnabled: true,
                          myLocationEnabled: true,
                          onCameraMove: (val) {
                            resetMapToCurrent = false;
                          },
                          myLocationButtonEnabled: false,
                          markers: markers.values.toSet(),
                          initialCameraPosition: CameraPosition(
                            target: LatLng(loc.latitude, loc.longitude),
                            zoom: 15.0,
                          ),
                        ),
                      );
                    }
                  });
            }
          }),
    );
  }
}

/*

class TrackAmbulance extends StatelessWidget {
  static const routeName = '/track-ambulance';
  const TrackAmbulance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Ambulance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                label: const Text('Enter Tracking Number'),
                icon: const Icon(Icons.apartment_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.map_outlined,
                        size: 70,
                        color: Colors.orange,
                      ),
                      Text('Hospitals.'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
*/
