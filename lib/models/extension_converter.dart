import 'package:units_converter/units_converter.dart';
import 'package:units_converter/utils/utils.dart';

extension ConvertUnitNum on num {
  double? convertFromTo(dynamic from, dynamic to) {
    assert(from.runtimeType == to.runtimeType,
        'from and to must be of the same type, e.g. LENGTH');
    Property? property = getPropertyFromEnum(from);
    if (property == null) {
      return null;
    } else {
      property.convert(from, toDouble());
      return property.getUnit(to).value;
    }
  }
}

/*
extension ConvertUnitString on String {
  String? convertFromTo(NUMERAL_SYSTEMS from, NUMERAL_SYSTEMS to) {
    Property property = NumeralSystems()..convert(from, this);
    return property.getUnit(to).stringValue;
  }
}
*/