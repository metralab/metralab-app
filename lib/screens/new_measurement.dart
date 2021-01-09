import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/deflection_form.dart';
import '../data/item.dart';

class NewMeasurementScreen extends StatefulWidget {
  const NewMeasurementScreen({Key key, this.onSubmit}) : super(key: key);

  final void Function(Item) onSubmit;

  @override
  _NewMeasurementScreenState createState() => _NewMeasurementScreenState();
}

class _NewMeasurementScreenState extends State<NewMeasurementScreen> {
  final _formKey = GlobalKey<FormState>();
  int numSensors;
  bool numSensorsSubmitted = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context).calculateDeflection)),
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
                        AppLocalizations.of(context).numInclinometers,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        onChanged: (value) =>
                            setState(() => numSensors = int.parse(value)),
                        validator: _validateNumberOfInclinometers,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      ElevatedButton(
                        child: Text(AppLocalizations.of(context).submit),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() => numSensorsSubmitted = true);
                          }
                        },
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

  String _validateNumberOfInclinometers(final String value) {
    if (value.trim().isEmpty) {
      return AppLocalizations.of(context).enterValue;
    }

    final computedValue = int.tryParse(value);
    if (computedValue == null) {
      return AppLocalizations.of(context).enterNumber;
    }

    if (computedValue <= 2) {
      return AppLocalizations.of(context).enterNumberGreaterThan(2);
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
