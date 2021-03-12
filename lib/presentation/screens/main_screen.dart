import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geojson_map/application/cubit/map/map_cubit.dart';
import 'package:flutter_geojson_map/presentation/widgets/data_panel.dart';
import 'package:flutter_geojson_map/presentation/widgets/map_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(),
      child: MapScreenChild(),
    );
  }
}

class MapScreenChild extends StatefulWidget {
  MapScreenChild({Key key}) : super(key: key);
  @override
  _MyMapScreenState createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MapScreenChild> {
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state is MapLoaded)
          return Scaffold(
            body: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 3, child: _buildMapAndControllers(state)),
                Expanded(flex: 1, child: DataPanel(content: state.content))
              ],
            ),
          );
        return Container(); //not nice
      },
    );
  }

  Widget _buildMapAndControllers(MapLoaded state) {
    return Stack(
      children: [
        MapWidget(
          onTap: onMapTap,
          pointMarkers: state.pointMarkers,
        ),
        ControllersWidgets(
          editingMode: state.editingMode,
        ),
      ],
    );
  }

  void onMapTap(double latitude, double longitude) {    
    context.read<MapCubit>().mapTap(latitude: latitude, longitude: longitude);
  }
}

class ControllersWidgets extends StatelessWidget {
  final EditingMode editingMode;
  const ControllersWidgets({Key key, this.editingMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          backgroundColor:
              editingMode == EditingMode.point ? Colors.red : Colors.blue,
          onPressed: () => context.read<MapCubit>().editMode(EditingMode.point),
          child: FaIcon(FontAwesomeIcons.mapMarker),
        ),
        FloatingActionButton(
          backgroundColor:
              editingMode == EditingMode.polygon ? Colors.red : Colors.blue,
          onPressed: () =>
              context.read<MapCubit>().editMode(EditingMode.polygon),
          child: FaIcon(FontAwesomeIcons.drawPolygon),
        ),
      ],
    );
  }
}
