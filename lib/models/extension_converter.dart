import 'package:units_converter/units_converter.dart';

extension ConvertUnitNum on num {
  Property? _type(dynamic checkType) {
    switch (checkType.runtimeType) {
      case ANGLE:
        return Angle();
      case AREA:
        return Area();
      case DIGITAL_DATA:
        return DigitalData();
      case ENERGY:
        return Energy();
      case FORCE:
        return Force();
      case FUEL_CONSUMPTION:
        return FuelConsumption();
      case LENGTH:
        return Length();
      case MASS:
        return Mass();
      case POWER:
        return Power();
      case PRESSURE:
        return Pressure();
      case SHOE_SIZE:
        return ShoeSize();
      case SI_PREFIXES:
        return SIPrefixes();
      case SPEED:
        return Speed();
      case TEMPERATURE:
        return Temperature();
      case TIME:
        return Time();
      case TORQUE:
        return Torque();
      case VOLUME:
        return Volume();
      default:
        {
          assert(false, "from and to don't have a valid type");
          return null;
        }
    }
  }

  double? convertFromTo(dynamic from, dynamic to) {
    assert(from.runtimeType == to.runtimeType,
        'from and to must be of the same type, e.g. LENGTH');
    Property? property = _type(from);
    if (property == null) {
      return null;
    } else {
      property.convert(from, toDouble());
      return property.getUnit(to).value;
    }
  }
}

extension ConvertUnitString on String {
  String? convertFromTo(NUMERAL_SYSTEMS from, NUMERAL_SYSTEMS to) {
    Property property = NumeralSystems()..convert(from, this);
    return property.getUnit(to).stringValue;
  }
}
