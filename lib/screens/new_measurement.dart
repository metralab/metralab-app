import 'package:flutter/material.dart';

import '../data/item.dart';
import '../components/deflection_form.dart';

class NewMeasurementScreen extends StatelessWidget {
  const NewMeasurementScreen({Key key, this.onSubmit}) : super(key: key);

  final void Function(Item) onSubmit;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Calculate deflection')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DeflectionForm(
            numSensors: 4,
            onSubmit: onSubmit,
          ),
        ),
      );
}
