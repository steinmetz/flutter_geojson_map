import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class MapScreen extends StatefulWidget {
  MapScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyMapScreenState createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          if (pointerSignal.scrollDelta.dy < 0) {
            mapController?.move(mapController.center, mapController.zoom + 0.1);
          } else { 
            mapController?.move(mapController.center, mapController.zoom - 0.1);
          }
        }
      },
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          allowPanning: true, 
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
        children: <Widget>[
          TileLayerWidget(
              options: TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'])),
          MarkerLayerWidget(
              options: MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
