import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geojson_map/domain/entities/point_marker.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:meta/meta.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapLoaded(''));

  void editMode(EditingMode editingMode) {
    final newEditingMode =
        state.editingMode == editingMode ? EditingMode.none : editingMode;

    emit(MapLoaded(state.content, editingMode: newEditingMode));
  }

  void mapTap({double latitude, double longitude}) {
    if (state.editingMode == EditingMode.none) return;

    GeoJSONFeatureCollection featureCollection;
    if (state.content.isEmpty) {
      featureCollection = GeoJSONFeatureCollection([]);
    } else {
      featureCollection = GeoJSONFeatureCollection.fromJSON(state.content);
    }

    if (state.editingMode == EditingMode.point) {
      final point = GeoJSONPoint([longitude, latitude]);
      final pointFeature = GeoJSONFeature(point);
      featureCollection.features.add(pointFeature);
      final content = featureCollection.toJSON(indent: 4);

      final pointMarker = PointMarker(
        id: '$latitude$longitude',
        latitude: latitude,
        longitude: longitude,
        onTap: (id) => print(id),
      );

      final pointMarkers = {
        ...state.pointMarkers,
        pointMarker,
      };
      emit(MapLoaded(
        content,
        editingMode: state.editingMode,
        pointMarkers: pointMarkers,
      ));
    } else if (state.editingMode == EditingMode.polygon) {
      //TODO to be implemented
    }
  }
}
