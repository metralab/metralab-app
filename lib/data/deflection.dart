import 'dart:math';

import 'package:linalg/linalg.dart';
import 'package:meta/meta.dart';

List<double> deflectionFromInclinometers({
  @required final List<InclinometerData> inclinometersData,
  double beamLength,
  final double nSteps = 10,
}) {
  final nInclinometers = inclinometersData.length;
  final distances =
      inclinometersData.map((data) => data.distanceMillimeters).toList();
  final inclinations = inclinometersData
      .map((data) => data.inclinationDegrees)
      .map(_radiansFromDegrees)
      .toList();
  beamLength ??= distances.last;

  final firstRow = [
    for (int exponent = 0; exponent < nInclinometers + 1; exponent++)
      pow(beamLength, exponent) as double
  ];
  final otherRows = [
    for (final distance in distances)
      [
        for (final exponent in range(nInclinometers + 1))
          (exponent + 1.0) * pow(distance, exponent)
      ]
  ];
  final basis = Matrix([firstRow, ...otherRows]);
  final inv_basis = basis.inverse();

  final nodal_loads = inv_basis * Vector.column([0.0, ...inclinations]);

  final steps = _linSpace(length: 11, end: beamLength);
  final deflections = [
    for (final step in steps)
      (Vector.row([
            for (final node in range(nInclinometers + 1))
              pow(step, node + 1) as double
          ]) *
          nodal_loads)[0][0]
  ];

  return deflections;
}

class InclinometerData {
  const InclinometerData({
    @required this.distanceMillimeters,
    @required this.inclinationDegrees,
  });

  final double distanceMillimeters;
  final double inclinationDegrees;
}

List<int> range(final int end) => [for (int i = 0; i < end; i++) i];

double _radiansFromDegrees(degrees) => degrees * pi / 180.0;

List<double> _linSpace({
  final double start = 0.0,
  final double end = 1.0,
  @required final int length,
}) =>
    [
      for (int step = 0; step < length; step++)
        start + step * (end - start) / (length - 1)
    ];
