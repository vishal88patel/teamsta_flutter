import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teamsta/widgets/widgets.dart';

import '../constants/images.dart';
import '../constants/global_strings.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> customMarker = [];
  late CameraPosition _location;

// set the marker in the list,
// for some reason the custom icon is not working
  getCustomImage() async {
    customMarker.add(
      Marker(
        markerId: MarkerId("FirstMarker"),
        position: LatLng(
          lat!,
          lng!,
        ),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(40, 40)), CustomImage().pinIcon),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    LocationService().textSearch("${widget.location}").then((_) {
      _goToLocation();
    }).whenComplete(() {
      setState(() {
        getCustomImage();
        getLocation();
      });
    });
    customMarker.clear();
  }

// gets the lat lng from the database
// added this to the init state to get the _location to update.
  getLocation() {
    _location = CameraPosition(
      target: LatLng(lat!, lng!),
      zoom: 15,
    );
  }

// original position london central
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(51.5167, -0.1769),
      tilt: 0,
      zoom: 12.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: false,
            tiltGesturesEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kLake,
            markers: Set.from(customMarker),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _goToLocation() async {
    final GoogleMapController googleController = await _controller.future;
    googleController.animateCamera(CameraUpdate.newCameraPosition(_location));
  }
}
