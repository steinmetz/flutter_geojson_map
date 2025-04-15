import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geojson_map/domain/entities/point_marker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';


class MapWidget extends StatefulWidget {
  final Set<PointMarker> pointMarkers;
  final void Function(double, double) onTap;
  MapWidget({Key? key, required this.onTap, this.pointMarkers = const {}}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
            if (pointerSignal.scrollDelta.dy < 0) {
              mapController.move(mapController.camera.center, mapController.camera.zoom + 0.2 );
            } else {
              mapController.move(mapController.camera.center, mapController.camera.zoom - 0.2);
            }
          }
      },
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onTap: (_, latLng) {
            widget.onTap(latLng.latitude, latLng.longitude);
          },
          initialCenter: LatLng(50.03, 8.73),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
              urlTemplate:
                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayer(
            markers: widget.pointMarkers
                .map((marker) => Marker(
                      alignment: Alignment.topCenter,
                      point: LatLng(marker.latitude, marker.longitude),
                      child: GestureDetector(
                        onTap: () => marker.onTap(marker.id),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.locationPin,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

