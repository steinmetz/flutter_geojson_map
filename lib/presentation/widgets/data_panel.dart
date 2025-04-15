import 'package:flutter/material.dart';

class DataPanel extends StatelessWidget {
  final content;
  const DataPanel({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'DataPanel',
          style: Theme.of(context).textTheme.bodyMedium,
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
