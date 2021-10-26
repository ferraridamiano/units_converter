import 'package:units_converter/models/node.dart';

import 'unit.dart';
//import '../utils/utils_conversion.dart';

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

class Property<K, V> {
  late Node unitConversion;
  List<Unit> unitList = [];
  late List<Node> nodeList;
  dynamic name;
  late final int size;

  Property({this.name});

  void convert(K name, V? value) {
    //Here we will suppose V is a double. In the case where V is a String (Numeral systems) I will override the entire function

    // if the value is null also the others units are null, this is convenient
    // in order to delete all the other units value, for example in a unit
    // converter app (such as Converter NOW)
    if (value == null) {
      for (Unit unit in unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }
    unitConversion.convert(name, value as double);
  }

  Node getNodeByName(var name) =>
      nodeList.singleWhere((node) => node.name == name);

  ///Returns all the units converted with prefixes
  List<Unit> getAll() => unitList;

  ///Returns the Unit with the corresponding name
  Unit getUnit(var name) =>
      unitList.where((element) => element.name == name).single;
}
