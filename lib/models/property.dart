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
  void convert(K name, V? value);

  ///Returns all the units converted with prefixes
  List<Unit> getAll();

  ///Returns the [Unit] with the corresponding name
  Unit getUnit(var name);
}
