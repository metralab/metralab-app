import 'package:easy_localization/easy_localization.dart';
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
  int numSteps;

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
                        '${tr('sensor')} ${sensor + 1}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: tr('distance'),
                          suffixText: 'mm',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        onChanged: (value) => setState(
                            () => distances[sensor] = double.parse(value)),
                        validator: (value) =>
                            value.trim().isEmpty ? tr('enterDistance') : null,
                        textInputAction: TextInputAction.next,
                        autocorrect: false,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: tr('inclination'),
                          suffixText: tr('degrees'),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        onChanged: (value) => setState(
                            () => inclinations[sensor] = double.parse(value)),
                        validator: (value) => value.trim().isEmpty
                            ? tr('enterInclination')
                            : null,
                        textInputAction: TextInputAction.next,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
              ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      tr('numSteps'),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: tr('steps'),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                      onChanged: (value) =>
                          setState(() => numSteps = int.parse(value)),
                      validator: (value) =>
                          value.trim().isEmpty ? tr('enterNumSteps') : null,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              child: Text(tr('submit')),
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
      final newItem = Item(
        inclinometersData: inclinometersData,
        nSteps: numSteps,
      );
      setState(() {
        deflection = newItem.deflection;
        if (widget.onSubmit != null) {
          widget.onSubmit(newItem);
        }
      });
    }
  }
}
