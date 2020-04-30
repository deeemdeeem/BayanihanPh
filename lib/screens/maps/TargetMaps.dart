import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:helpinghand/providers/Location.dart';
import 'package:provider/provider.dart';
import 'package:latlong/latlong.dart';

class TargetMaps extends StatefulWidget {
  @override
  _TargetMapsState createState() => _TargetMapsState();
}

class _TargetMapsState extends State<TargetMaps> with TickerProviderStateMixin {
  LatLng initialLoc = LatLng(14.590499, 120.980817);
  MapController mapController;
  double zoom = 11;

  @override
  void initState() {
    super.initState();
    mapController = new MapController();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    var controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Target'),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _animatedMapMove(
                  Provider.of<Location>(context).targetMarker.point, zoom);
            },
            mini: true,
            heroTag: 'fab1',
            child: Icon(Icons.my_location),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
            heroTag: 'fab2',
            onPressed: () => Navigator.pop(context),
            label: Text('Confirm'),
            icon: Icon(
              Icons.check_circle,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            zoom: 11,
            minZoom: 11,
            maxZoom: 15,
            center: Provider.of<Location>(context).targetMarker.point,
            nePanBoundary: LatLng(19.072501, 126.374430),
            swPanBoundary: LatLng(5.101887, 114.723184),
            onPositionChanged: (mapPos, b) {
              zoom = mapPos.zoom;
            },
            onTap: (latLng) {
              Marker newMarker = Marker(
                builder: (context) => Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 30,
                ),
                point: latLng,
              );
              Provider.of<Location>(context).setTargetLat(latLng.latitude);
              Provider.of<Location>(context).setTargetLon(latLng.longitude);
              Provider.of<Location>(context).setTargetMarker(newMarker);
            },
          ),
          layers: [
            TileLayerOptions(
              maxZoom: 19,
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: [
              Provider.of<Location>(context).targetMarker,
              Provider.of<Location>(context).hostMarker
            ]),
          ],
        ),
      ),
    );
  }
}
