class PointMarker {
  final String id;
  final double latitude;
  final double longitude;
  final Function(String) onTap;

  PointMarker({this.id, this.latitude, this.longitude, this.onTap});
}
