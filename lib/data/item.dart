import 'package:meta/meta.dart';

import 'deflection.dart';

class Item {
  Item({
    @required this.inclinometersData,
    @required this.nSteps,
  }) : birth = DateTime.now();

  final List<InclinometerData> inclinometersData;
  final int nSteps;
  final DateTime birth;

  Iterable<double> get distances =>
      inclinometersData.map((sensor) => sensor.distanceMillimeters);

  Iterable<double> get inclinations =>
      inclinometersData.map((sensor) => sensor.inclinationDegrees);

  Iterable<double> get deflection => deflectionFromInclinometers(
        inclinometersData: inclinometersData,
        nSteps: nSteps,
      );

  int get numSensors => inclinometersData.length;
}
