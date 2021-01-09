import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:intl/intl.dart';

class DeflectionResultsCard extends StatelessWidget {
  const DeflectionResultsCard(this.deflection, {Key key}) : super(key: key);

  final List<double> deflection;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                  toBeginningOfSentenceCase(
                      AppLocalizations.of(context).results),
                  style: Theme.of(context).textTheme.headline5),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: deflection.map((y) => Text(y.toString())).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Sparkline(
                  data: deflection,
                  lineGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark,
                    ],
                  ),
                  fillMode: FillMode.below,
                  fillColor: Theme.of(context).primaryColorLight,
                ),
              ),
            ],
          ),
        ),
      );
}
