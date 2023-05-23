import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/pages/driver/driver_map/driver_map_controller.dart';

class DriverMapPage extends StatefulWidget {
  const DriverMapPage({super.key});

  @override
  State<DriverMapPage> createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {
  DriverMapController _con = new DriverMapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _googleMapsWidget(),
      ),
    );
  }

  Widget _googleMapsWidget() {
    return GoogleMap(
      initialCameraPosition: _con.initialPosition,
      mapType: MapType.normal,
      onMapCreated: _con.onMapCreated,
    );
  }

  void refresh() => setState(() {});
}
