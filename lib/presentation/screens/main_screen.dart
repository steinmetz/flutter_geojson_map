import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geojson_map/application/cubit/map/map_cubit.dart';
import 'package:flutter_geojson_map/presentation/widgets/data_panel.dart';
import 'package:flutter_geojson_map/presentation/widgets/map_widget.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);
  @override
  _MyMapScreenState createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MapScreen> {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(),
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state is MapLoaded)
            return Scaffold(
              body: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(flex: 3, child: _buildMapAndControllers()),
                  Expanded(flex: 1, child: DataPanel(content: state.content))
                ],
              ),
            );
          return Container(); //not nice
        },
      ),
    );
  }

  Widget _buildMapAndControllers() {
    return Stack(
      children: [
        MapWidget(),
        ControllersWidgets(),
      ],
    );
  }
}

class ControllersWidgets extends StatelessWidget {
  const ControllersWidgets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
