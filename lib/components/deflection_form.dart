import 'package:flutter/material.dart';

import '../data/item.dart';
import '../data/deflection.dart';

class DeflectionForm extends StatefulWidget {
  const DeflectionForm({Key key, @required this.numSensors, this.onSubmit})
      : super(key: key);

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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int sensor = 0; sensor < widget.numSensors; sensor += 1)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Sensor #${sensor + 1}', textAlign: TextAlign.start),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'distance',
                          helperText: 'Distance [mm]',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        onChanged: (value) =>
                            distances[sensor] = double.parse(value),
                        validator: (value) =>
                            value.isEmpty ? 'Please enter a distance.' : null,
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'inclination',
                          helperText: 'Inclination [degrees]',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        onChanged: (value) =>
                            inclinations[sensor] = double.parse(value),
                        validator: (value) => value.isEmpty
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
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  final inclinometersData = range(widget.numSensors)
                      .map((sensor) => InclinometerData(
                            distanceMillimeters: distances[sensor],
                            inclinationDegrees: inclinations[sensor],
                          ))
                      .toList();
                  setState(() => deflection = deflectionFromInclinometers(
                      inclinometersData: inclinometersData));
                  widget.onSubmit(Item(inclinometersData: inclinometersData));
                  Scrollable.ensureVisible(_resultsKey.currentContext,
                      duration: Duration(milliseconds: 500));
                }
              },
            ),
            if (deflection != null)
              Card(
                key: _resultsKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Results',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...deflection.map((y) => Text(y.toString())).toList()
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
