import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataPanel extends StatelessWidget {
  final content;
  const DataPanel({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Demo of the GeoJson library geojson_vi',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(
            child:Text(content ?? '',
            textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
