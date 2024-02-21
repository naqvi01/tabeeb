import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:zakatrebuild/consts.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(30.009343, 77.764589);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  // static const LatLng _paffuPark = LatLng(37.3346, -122.0090);

  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
              generatePolyLineFromPoints(coordinates),
            }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text("Open Location..."),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _pGooglePlex,
                zoom: 0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!,
                ),
                Marker(
                    markerId: MarkerId("_destinationlocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pGooglePlex),
                Marker(
                    markerId: MarkerId("_destionationLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pApplePark),
                // Marker(
                // markerId: MarkerId("_destionationLocation"),
                // icon: BitmapDescriptor.defaultMarker,
                // position: ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
      // PointLatLng(_paffuPark.latitude, _paffuPark.longitude),

      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';

// class Maps extends StatefulWidget {
//   const Maps({super.key});

//   @override
//   State<Maps> createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // backgroundColor: Theme.of(context).primaryColor,
//         // body: FlutterMap(
//         //   options: MapOptions(
//         //     initialCenter: LatLng(51.509364, -0.128928),
//         //     initialZoom: 9.2,
//         //   ),
//         //   children: [
//         //     TileLayer(
//         //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//         //       userAgentPackageName: 'com.example.app',
//         //     ),
//         //     RichAttributionWidget(
//         //       attributions: [
//         //         TextSourceAttribution(
//         //           'OpenStreetMap contributors',
//         //           onTap: () =>
//         //               launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
//         //         ),
//         //       ],
//         //     ),
//         //   ],
//         // ),
//         );
//     // body: GoogleMap(
//     //     initialCameraPosition: CameraPosition(target: LatLng(0, 0))),
//     // body: SafeArea(
//     //   child: Center(
//     //       child: Text(
//     //     "Here Nearby slum areas or NGO's are shown on Maps which helps to easily donate to poor families near you . We didn't implement this because we didn't get Google Maps API but our idea is to impelement map which show nearby slum areas or NGO's for donation of anything to poor families. ",
//     //     style: TextStyle(
//     //         fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
//     //   )),
//     // ));
//   }
// }
