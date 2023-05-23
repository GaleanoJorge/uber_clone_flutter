import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/utils/strings.dart';

class DriverMapController {
  BuildContext? context;
  late Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _mapController = Completer();

  CameraPosition initialPosition =
      CameraPosition(target: LatLng(4.5809721, -74.124009), zoom: 14.0);

  Future? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Strings.map_style_dark);
    _mapController.complete(controller);
  }
}
