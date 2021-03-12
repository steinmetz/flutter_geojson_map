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

  MapState(this.content, this.editingMode);
}

class MapLoaded extends MapState {
  MapLoaded(String content, {EditingMode editingMode: EditingMode.none})
      : super(content, editingMode);

  @override
  List<Object> get props => [content, editingMode];
}
