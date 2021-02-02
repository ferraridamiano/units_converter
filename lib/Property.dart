import 'Unit.dart';
import 'UtilsConversion.dart';

enum PROPERTY {
  ANGLE,
  AREA,
  DIGITAL_DATA,
  ENERGY,
  FORCE,
  FUEL_CONSUMPTION,
  LENGTH,
  MASS,
  NUMERAL_SYSTEMS,
  POWER,
  PRESSURE,
  SHOE_SIZE,
  SI_PREFIXES,
  SPEED,
  TEMPERATURE,
  TIME,
  TORQUE,
  VOLUME,
}

class Property<K, V> {
  Node unit_conversion;
  List<Unit> unitList = [];
  var name;

  Property({this.name});

  void convert(K name, V value) {
    //Here we will suppose V is a double. In the case where V is a String (Numeral systems) I will override the entire function

    unit_conversion.clearAllValues();
    //if the value is null also the others units are null, this is convenient to delete
    //all the other units value, for example in a unit converter app (such as Converter NOW)
    if (value == null) {
      unit_conversion.clearAllValues();
      for (Unit unit in unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }
    unit_conversion.clearSelectedNode();
    unit_conversion.resetConvertedNode();
    var currentUnit = unit_conversion.getByName(name);
    currentUnit.value = value as double;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    unit_conversion.convert();
  }

  ///Returns all the units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }
}
