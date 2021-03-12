import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_geojson_map/domain/entities/point_marker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';

class MapWidget extends StatefulWidget {
  final Set<PointMarker> pointMarkers;
  final Function(double, double) onTap;
  MapWidget({Key key, this.onTap, this.pointMarkers = const {}})
      : super(key: key);

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
            mapController?.move(mapController.center, mapController.zoom + 0.1);
          } else {
            mapController?.move(mapController.center, mapController.zoom - 0.1);
          }
        }
      },
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onTap: (latLng) {
            if (widget.onTap != null) {
              widget.onTap(latLng.latitude, latLng.longitude);
            }
          },
          allowPanning: true,
          center: LatLng(50.03, 8.73),
          zoom: 13.0,
        ),
        layers: [
          MarkerLayerOptions(
            markers: [
              for (final marker in widget.pointMarkers)
                Marker(
                  anchorPos: AnchorPos.align(AnchorAlign.top),
                  point: LatLng(marker.latitude, marker.longitude),
                  builder: (ctx) => GestureDetector(
                    onTap: () => marker.onTap(marker.id),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.mapMarker,
                        color: Colors.blue,
                      ),
                    ),
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
        ],
      ),
    );
  }
}
