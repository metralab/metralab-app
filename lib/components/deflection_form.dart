import 'package:flutter/material.dart';

import '../data/item.dart';
import '../data/deflection.dart';
import 'deflection_results_card.dart';

class DeflectionForm extends StatefulWidget {
  const DeflectionForm({
    Key key,
    this.onSubmit,
    @required this.numSensors,
  }) : super(key: key);

  final int numSensors;
  final void Function(Item) onSubmit;

  @override
  _DeflectionFormState createState() => _DeflectionFormState();
}

class _DeflectionFormState extends State<DeflectionForm> {
  final _formKey = GlobalKey<FormState>();
  final _resultsKey = GlobalKey();

  List<double> distances;
  List<double> inclinations;
  List<double> deflection;

  @override
  Widget build(BuildContext context) {
    distances ??= List(widget.numSensors);
    inclinations ??= List(widget.numSensors);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_resultsKey.currentContext != null) {
        Scrollable.ensureVisible(_resultsKey.currentContext,
            duration: Duration(milliseconds: 500));
      }
    });

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int sensor = 0; sensor < widget.numSensors; sensor++)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sensor ${sensor + 1}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'distance [mm]',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        onChanged: (value) => setState(
                            () => distances[sensor] = double.parse(value)),
                        validator: (value) => value.trim().isEmpty
                            ? 'Please enter a distance.'
                            : null,
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'inclination [degrees]',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        onChanged: (value) => setState(
                            () => inclinations[sensor] = double.parse(value)),
                        validator: (value) => value.trim().isEmpty
                            ? 'Please enter an inclination.'
                            : null,
                        textInputAction: (sensor == widget.numSensors - 1)
                            ? TextInputAction.done
                            : TextInputAction.next,
                      ),
                    ],
                  ),
                ),
              ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: _submitInclinometersData,
            ),
            if (deflection != null)
              DeflectionResultsCard(deflection, key: _resultsKey),
          ],
        ),
      ),
    );
  }

  void _submitInclinometersData() {
    if (_formKey.currentState.validate()) {
      final inclinometersData = range(widget.numSensors)
          .map((sensor) => InclinometerData(
                distanceMillimeters: distances[sensor],
                inclinationDegrees: inclinations[sensor],
              ))
          .toList();
      setState(() => deflection =
          deflectionFromInclinometers(inclinometersData: inclinometersData));
      if (widget.onSubmit != null) {
        widget.onSubmit(Item(inclinometersData: inclinometersData));
      }
    }
  }
}
