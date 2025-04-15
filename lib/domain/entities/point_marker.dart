class PointMarker {
  final String id; 
  final double latitude; 
  final double longitude; 
  final Function(String) onTap; 

  PointMarker({
    this.id = '',
    this.latitude = 0,
    this.longitude = 0,
    this.onTap = _defaultOnTap});
    
    static void _defaultOnTap(String id) { }
}
