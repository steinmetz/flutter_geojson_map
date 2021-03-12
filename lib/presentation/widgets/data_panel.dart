import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataPanel extends StatelessWidget {
  final content;
  const DataPanel({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Demo of the GeoJson library geojson_vi',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SelectableText(
            content ?? '',
          ),
        )
      ],
    );
  }
}
