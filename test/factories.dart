import 'dart:math';

import 'package:metralab/data/deflection.dart';
import 'package:metralab/data/item.dart';

final _generator = Random();

double _randomSign() => _generator.nextBool() ? -1.0 : 1.0;

InclinometerData inclinometerDataFactory() => InclinometerData(
      distanceMillimeters: _generator.nextDouble() * 30000,
      inclinationDegrees: _generator.nextDouble() * _randomSign(),
    );

Item itemFactory([amount = 8]) => Item(
      inclinometersData: [
        for (var i = 0; i < amount; i++) inclinometerDataFactory()
      ],
    );

List<Item> itemCollectionFactory([amount = 5]) =>
    [for (var i = 0; i < amount; i++) itemFactory()];
