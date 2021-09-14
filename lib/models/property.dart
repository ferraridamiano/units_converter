import 'unit.dart';
import '../utils/utils_conversion.dart';

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
  dynamic name;
  late final int size;

  Property({this.name});

  void convert(K name, V? value) {
    //Here we will suppose V is a double. In the case where V is a String (Numeral systems) I will override the entire function

    unitConversion.clearAllValues();
    //if the value is null also the others units are null, this is convenient to delete
    //all the other units value, for example in a unit converter app (such as Converter NOW)
    if (value == null) {
      unitConversion.clearAllValues();
      for (Unit unit in unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }
    unitConversion.clearSelectedNode();
    unitConversion.resetConvertedNode();
    var currentUnit = unitConversion.getByName(name);
    currentUnit?.value = value as double;
    currentUnit?.selectedNode = true;
    currentUnit?.convertedNode = true;
    unitConversion.convert();
  }

  ///Returns all the units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit getUnit(var name) {
    return unitList.where((element) => element.name == name).single;
  }
}
