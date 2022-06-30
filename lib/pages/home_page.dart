import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_example/pages/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false).getPolyPoints();
    });

  }


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          // onTap: (LatLng latLng) {
          //   provider.getMarker(Marker(
          //     markerId: const MarkerId('point'),
          //     position: latLng,
          //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          //   ));
          // },
          markers: {
            provider.firstMarker,
            provider.secondMarker
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: provider.polylineCoordinates,
              color: Colors.indigo,
              width: 5
            )
          },
          // markers: Set<Marker>.of(provider.markers.iterator<Marker>),
          initialCameraPosition: provider.initialCameraPosition,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          padding: const EdgeInsets.only(top: 95),
          onMapCreated: (GoogleMapController controller) {
            provider.mapController = controller;
          },
        ),
      ),
    );
  }
}
