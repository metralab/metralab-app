import 'package:flutter/material.dart';

import '../data/deflection.dart';

class InputDataCard extends StatelessWidget {
  const InputDataCard(this.inclinometersData, {Key key}) : super(key: key);

  final List<InclinometerData> inclinometersData;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Input data',
                style: Theme.of(context).textTheme.headline5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Table(
                  border: TableBorder.symmetric(inside: const BorderSide()),
                  children: [
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('distance'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('inclination'),
                        ),
                      ],
                    ),
                    ...inclinometersData
                        .map(
                          (sensor) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${sensor.distanceMillimeters} mm'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${sensor.inclinationDegrees}°'),
                              ),
                            ],
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
