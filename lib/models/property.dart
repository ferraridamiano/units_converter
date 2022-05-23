import 'conversion_node.dart';
import 'unit.dart';

enum PROPERTY {
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

  /// The tree hierarchy that describe the relation between the units in terms
  /// of products, sums, or even complex relations like in numeral systems
  late ConversionNode conversionTree;

  /// Map between units and its symbol
  late Map<K, String?> mapSymbols;

  /// The size of the [Property], i.e. the number of the [Unit]s that belong to
  /// that [Property].
  late int size;

  /// Convert the [value] of the units with name [name] to all the other units.
  void convert(K name, V? value);

  ///Returns all the units converted with prefixes
  List<Unit> getAll();

  ///Returns the [Unit] with the corresponding name
  Unit getUnit(var name);
}
