import 'package:units_converter/units_converter.dart';
import 'package:units_converter/utils/utils.dart';

extension ConvertUnitNum on num {
  static final Map<Type, Property> _propertyCache = {};

  double? convertFromTo(dynamic from, dynamic to) {
    assert(from.runtimeType == to.runtimeType,
        'from and to must be of the same type, e.g. LENGTH');
    Property? property = _propertyCache[from.runtimeType];
    if (property == null) {
      property = getPropertyFromEnum(from);
      if (property == null) {
        return null;
      }
      _propertyCache[from.runtimeType] = property;
    }
    property.convert(from, toDouble());
    return property.getUnit(to).value;
  }
}

extension ConvertUnitString on String {
  static final NumeralSystems _numeralSystems = NumeralSystems();

  String? convertFromTo(NUMERAL_SYSTEMS from, NUMERAL_SYSTEMS to) {
    _numeralSystems.convert(from, this);
    return _numeralSystems.getUnit(to).stringValue;
  }
}
