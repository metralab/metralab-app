import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../components/deflection_form.dart';
import '../data/item.dart';

class NewMeasurementScreen extends StatefulWidget {
  const NewMeasurementScreen({Key key, this.onSubmit}) : super(key: key);

  final void Function(Item) onSubmit;

  @override
  _NewMeasurementScreenState createState() => _NewMeasurementScreenState();
}

class _NewMeasurementScreenState extends State<NewMeasurementScreen> {
  static const defaultNumSensors = 7;
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();

  int numSensors = defaultNumSensors;
  bool numSensorsSubmitted = false;

  @override
  void initState() {
    super.initState();
    _textFieldController.value =
        TextEditingValue(text: defaultNumSensors.toString());
    _textFieldController.addListener(() {
      numSensors = int.tryParse(_textFieldController.text);
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(tr('calculateDeflection'))),
        body: Navigator(
          pages: [
            MaterialPage(
              key: const ValueKey('NumSensorsForm'),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Text(
                        tr('numInclinometers'),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => _changeNumSensors(-1),
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: _textFieldController,
                                textAlign: TextAlign.center,
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                validator: _validateNumberOfInclinometers,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => _changeNumSensors(1),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() => numSensorsSubmitted = true);
                          }
                        },
                        child: Text(tr('submit')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (numSensorsSubmitted)
              MaterialPage(
                key: const ValueKey('DeflectionForm'),
                child: DeflectionForm(
                    onSubmit: widget.onSubmit, numSensors: numSensors),
              ),
          ],
          onPopPage: _onPopPage,
        ),
      );

  void _changeNumSensors(final int valueToAdd) {
    final currentValue = int.tryParse(_textFieldController.text) ?? 0;
    final text = max(0, currentValue + valueToAdd);
    _textFieldController.value =
        _textFieldController.value.copyWith(text: text.toString());
  }

  String _validateNumberOfInclinometers(final String value) {
    if (value.trim().isEmpty) {
      return tr('enterValue');
    }

    final computedValue = int.tryParse(value);
    if (computedValue == null) {
      return tr('enterNumber');
    }

    if (computedValue <= 2) {
      return tr('enterNumberGreaterThan', args: ['2']);
    }

    return null;
  }

  bool _onPopPage(final Route route, final dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }

    setState(() => numSensorsSubmitted = false);

    return true;
  }
}
