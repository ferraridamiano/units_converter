import 'Unit.dart';
import 'UtilsConversion.dart';

class Property<K, V> {

  Node unit_conversion;
  List<Unit> unitList = [];

  void convert(K name, V value) {
    //Here we will suppose V is a double. In the case where V is a String (Numeral systems) I will override the entire function
    unit_conversion.clearAllValues();
    unit_conversion.clearSelectedNode();
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
