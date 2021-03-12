part of 'map_cubit.dart';

enum EditingMode {
  none,
  point,
  polygon,
}

@immutable
abstract class MapState extends Equatable {
  final String content;
  final EditingMode editingMode;
  final Set<PointMarker> pointMarkers;

  MapState({this.content, this.editingMode, this.pointMarkers});
}

class MapLoaded extends MapState {
  MapLoaded(
    String content, {
    EditingMode editingMode: EditingMode.none,
    Set<PointMarker> pointMarkers = const {},
  }) : super(
          content: content,
          editingMode: editingMode,
          pointMarkers: pointMarkers,
        );

  @override
  List<Object> get props => [content, editingMode];
}
