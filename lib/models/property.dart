import 'package:units_converter/models/conversion_node.dart';

import 'unit.dart';

enum PROPERTY {
  amountOfSubstance,
  angle,
  area,
  digitalData,
  energy,
  force,
  fuelConsumption,
  length,
  mass,
  numeralSystems,
  power,
  pressure,
  shoeSize,
  siPrefixes,
  speed,
  temperature,
  time,
  torque,
  volume,
}

abstract class Property<K, V> {
  /// The name of the [Property]. If it is not a custom [Property] is one of the
  /// values of [PROPERTY].
  late dynamic name;

  /// The size of the [Property], i.e. the number of the [Unit]s that belong to
  /// that [Property].
  late int size;

  /// Defines the relation between the units of measurement of this property.
  /// E.g. in the following example we defined: `KiloDash = 1000 * Dash`,
  /// `DashPlus1 = Dash + 1` and `OneOver(DashPlus1) = 1 / (DashPlus1)`:
  /// ```dart
  /// ConversionNode conversionTree = ConversionNode(
  ///   name: 'Dash',
  ///   leafNodes: [
  ///     ConversionNode(
  ///       name: 'KiloDash',
  ///       coefficientProduct: 1000,
  ///     ),
  ///     ConversionNode(
  ///       name: 'DashPlus1',
  ///       coefficientSum: -1,
  ///       leafNodes: [
  ///         ConversionNode(
  ///           name: 'OneOver(DashPlus1)',
  ///           conversionType: ConversionType.reciprocalConversion,
  ///         ),
  ///       ],
  ///     ),
  ///   ],
  /// );
  /// ```
  late ConversionNode<K> conversionTree;

  /// Convert the [value] of the units with name [name] to all the other units.
  void convert(K name, V? value);

  /// Returns all the units converted with prefixes
  List<Unit> getAll();

  /// Returns the [Unit] with the corresponding name
  Unit getUnit(K name);
}
