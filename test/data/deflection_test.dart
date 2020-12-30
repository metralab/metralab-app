import 'package:metralab/data/deflection.dart';
import 'package:test/test.dart';

void main() {
  group('deflectionFromInclinometers', () {
    test('returns an empty list, if given an empty list', () {
      final inclinometersData = <InclinometerData>[];
      final result =
          deflectionFromInclinometers(inclinometersData: inclinometersData);
      expect(result, []);
    });

    test('returns something, if given a singleton list', () {
      final inclinometersData = [
        InclinometerData(distanceMillimeters: 1000.0, inclinationDegrees: 0.05)
      ];
      final result =
          deflectionFromInclinometers(inclinometersData: inclinometersData);
      expect(result, isList);
    });

    test('returns expected estimations, with given data', () {
      final inclinometersData = [
        InclinometerData(
            distanceMillimeters: 0.0, inclinationDegrees: -0.96679119),
        InclinometerData(
            distanceMillimeters: 5000.0, inclinationDegrees: -0.60097831),
        InclinometerData(
            distanceMillimeters: 15000.0, inclinationDegrees: 0.60097831),
        InclinometerData(
            distanceMillimeters: 20000.0, inclinationDegrees: 0.81001424),
      ];
      const expected = [
        0.000,
        -33.190,
        -61.958,
        -82.868,
        -94.233,
        -95.770,
        -88.244,
        -73.122,
        -52.221,
        -27.358,
        0.000,
      ];
      final result = deflectionFromInclinometers(
        inclinometersData: inclinometersData,
        nSteps: 10,
      );
      for (var i = 0; i < 11; i++) {
        expect(result[i] - expected[i], inInclusiveRange(-0.001, 0.001));
      }
    });

    test('returns a list of known length', () {
      final inclinometersData = [
        InclinometerData(
            distanceMillimeters: 0.0, inclinationDegrees: -0.96679119),
        InclinometerData(
            distanceMillimeters: 5000.0, inclinationDegrees: -0.60097831),
        InclinometerData(
            distanceMillimeters: 15000.0, inclinationDegrees: 0.60097831),
        InclinometerData(
            distanceMillimeters: 20000.0, inclinationDegrees: 0.81001424),
      ];
      const nSteps = 6;
      final result = deflectionFromInclinometers(
        inclinometersData: inclinometersData,
        nSteps: nSteps,
      );
      expect(result.length, nSteps + 1);
    });
  });
}
