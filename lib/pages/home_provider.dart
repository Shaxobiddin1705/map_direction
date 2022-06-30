import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeProvider with ChangeNotifier{
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  final String apiKey = 'AIzaSyAd4rEAQqf58fCJGABqW99teDP9BcuyN08';
  // final String apiKey = 'AIzaSyA_YGIiAtLqXUt40gtJ9SwScmbKWx1gUjY';
  List<LatLng> polylineCoordinates = [];
  Marker firstMarker = const Marker(
    markerId: MarkerId('point1'),
    position: LatLng(41.3240, 69.2834),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker secondMarker = Marker(
    markerId: const MarkerId('point2'),
    position: const LatLng(41.326488, 69.228348),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );


  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(41.326488, 69.228348),
    zoom: 14.4746,
  );

  void getMarker(Marker marker) {
    markers.clear();
    markers.add(marker);
    notifyListeners();
  }

  void getPolyPoints() async{
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        const PointLatLng(41.3240, 69.2834),
        const PointLatLng(41.326488, 69.228348),
    );

    log('result points length is ${result.points.length}');

    if(result.points.isNotEmpty) {
      result.points.forEach((PointLatLng pointLatLng) {
        polylineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    notifyListeners();
  }
}