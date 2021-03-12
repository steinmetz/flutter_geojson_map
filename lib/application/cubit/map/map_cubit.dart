import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geojson_map/domain/entities/point_marker.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:meta/meta.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapLoaded(content: ''));

  void editMode(EditingMode editingMode) {
    final newEditingMode =
        state.editingMode == editingMode ? EditingMode.none : editingMode;

    emit(MapLoaded(content: state.content, editingMode: newEditingMode));
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
      final id = '$latitude$longitude';
      final point = GeoJSONPoint([longitude, latitude]);
      final pointFeature = GeoJSONFeature(point, id: id);
      featureCollection.features.add(pointFeature);
      final content = featureCollection.toJSON(indent: 4);

      final pointMarker = PointMarker(
        id: id,
        latitude: latitude,
        longitude: longitude,
        onTap: (id) => deletePoint(id),
      );

      final pointMarkers = {
        ...state.pointMarkers,
        pointMarker,
      };
      emit(MapLoaded(
        content: content,
        editingMode: state.editingMode,
        pointMarkers: pointMarkers,
      ));
    } else if (state.editingMode == EditingMode.polygon) {
      //TODO to be implemented
    }
  }

  void deletePoint(String id) {
    final point = state.pointMarkers.singleWhere((e) => e.id == id);
    final featureCollection = GeoJSONFeatureCollection.fromJSON(state.content);
    featureCollection.features.removeWhere((e) => e.id == id);
    final pointMarkers = state.pointMarkers..remove(point);

    emit(MapLoaded(
      content: featureCollection.toJSON(indent: 2),
      pointMarkers: pointMarkers,
      editingMode: state.editingMode,
    ));
  }
}
