import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:uber_clone/src/models/client.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/providers/client_provider.dart';
// import 'package:uber_clone/src/providers/driver_provider.dart';
import 'package:uber_clone/src/providers/geofire_provider.dart';
// import 'package:uber_clone/src/utils/progress_dialog.dart';
import 'package:uber_clone/src/utils/strings.dart';
import 'package:location/location.dart' as location;
import 'package:uber_clone/src/utils/snackbar.dart' as utils;

class ClientMapController {
  BuildContext? context;
  late Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController>? _mapController = Completer();

  CameraPosition initialPosition =
      const CameraPosition(target: LatLng(4.5809721, -74.124009), zoom: 14.0);

  Position? _position;
  StreamSubscription<Position>? _positionStream;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  late BitmapDescriptor markerDriver;

  late GeofireProvider _geofireProvider;
  late AuthProvider _authProvider;
  late ClientProvider _clientProvider;
  // late DriverProvider _driverProvider;

  Client? client;

  bool isConnect = false;

  // late ProgressDialog _progressDialog;

  StreamSubscription<DocumentSnapshot<Object?>>? _statusSubscription;
  StreamSubscription<DocumentSnapshot<Object?>>? _clientInfoSubscription;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _geofireProvider = new GeofireProvider();
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    // _progressDialog =
    //     MyProgressDialog.createPrograssDialog(context, 'Conectandose...');
    markerDriver = await createMarkerImageFromAsset('assets/img/icon_taxi.png');
    checkGPS();
    getClientInfo();
  }

  void dispose() {
    _positionStream?.cancel();
    _statusSubscription?.cancel();
    _clientInfoSubscription?.cancel();
  }

  void signOut() async {
    await _authProvider.signOut();
    Navigator.pushNamedAndRemoveUntil(context!, 'home', (route) => false);
  }

  void getClientInfo() {
    Stream<DocumentSnapshot> clientStream =
        _clientProvider.getByIdStream(_authProvider.getUser()!.uid);

    _clientInfoSubscription = clientStream.listen((DocumentSnapshot document) {
      client = Client.fromJson(document.data() as Map<String, dynamic>);
      print('hollllll-----------: ${client!.toJson()}');
      refresh();
    });
  }

  void openDrawer() {
    key.currentState!.openDrawer();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Strings.map_style_dark);
    _mapController!.complete(controller);
  }

  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationEnabled) {
      print('gps activo');
      updateLocation();
    } else {
      print('gps inactivo');
      bool locationGPS = await location.Location().requestService();
      if (locationGPS) {
        updateLocation();
        print('el usuario activo el gps');
      }
    }
  }

  void updateLocation() async {
    try {
      await _determinePosition();
      _position = (await Geolocator.getLastKnownPosition())!;
      centerPosition();
      getNerbyDrivers();
    } catch (error) {
      print(error.toString());
    }
  }

  void getNerbyDrivers() {
    Stream<List<DocumentSnapshot>> stream = _geofireProvider.getNearbyDrivers(
        _position!.latitude, _position!.longitude, 10);
    print('get nerby');
    stream.listen((List<DocumentSnapshot> documentList) {
      print('get stream: ${documentList.toSet()}');
      print('get markers: ${markers.length}');
      for (MarkerId m in markers.keys) {
        bool remove = true;

        for (DocumentSnapshot d in documentList) {
          print('snapshot individual: $d');
          if (m.value == d.id) {
            remove = false;
          }
        }

        if (remove) {
          markers.remove(m);
          refresh();
        }
      }
      for (DocumentSnapshot d in documentList) {
        GeoPoint point = (d.data() as Map)['position']['geopoint'];
        print('get stream 2: ${point.toString()}');
        addMarker(d.id, point.latitude, point.longitude, 'Conductor disponible',
            '', markerDriver);
      }
      refresh();
    });
  }

  void centerPosition() {
    if (_position != null) {
      animateCameraToPosition(_position!.latitude, _position!.longitude);
    } else {
      utils.Snackbar.showSnackbarr(
          context!, 'Activa el GPS para obtener la posición.');
    }
  }

  Future? animateCameraToPosition(double latitude, double longitude) async {
    GoogleMapController? controller = await _mapController?.future;

    if (controller != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(latitude, longitude), bearing: 0, zoom: 13)));
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<BitmapDescriptor> createMarkerImageFromAsset(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(configuration, path);
    return bitmapDescriptor;
  }

  void addMarker(String markerId, double lat, double lng, String title,
      String content, BitmapDescriptor iconMarker) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
      markerId: id,
      icon: iconMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: content),
      draggable: false,
      // zIndex: 2,
      // flat: true,
      // anchor: Offset(0.5, 0.5),
      // rotation: _position!.heading,
    );
    print('add marker: $marker');
    markers[id] = marker;
  }
}
