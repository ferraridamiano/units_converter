import 'package:units_converter/units_converter.dart';

extension ConvertUnitNum on num {
  double? convertFromTo(dynamic from, dynamic to) {
    assert(from.runtimeType == to.runtimeType,
        'from and to must be of the same type, e.g. LENGTH');
    Property property;
    switch (from.runtimeType) {
      case ANGLE:
        {
          property = Angle();
          break;
        }
      case AREA:
        {
          property = Area();
          break;
        }
      case DIGITAL_DATA:
        {
          property = DigitalData();
          break;
        }
      case ENERGY:
        {
          property = Energy();
          break;
        }
      case FORCE:
        {
          property = Force();
          break;
        }
      case FUEL_CONSUMPTION:
        {
          property = FuelConsumption();
          break;
        }
      case LENGTH:
        {
          property = Length();
          break;
        }
      case MASS:
        {
          property = Mass();
          break;
        }
      case POWER:
        {
          property = Power();
          break;
        }
      case PRESSURE:
        {
          property = Pressure();
          break;
        }
      case SHOE_SIZE:
        {
          property = ShoeSize();
          break;
        }
      case SI_PREFIXES:
        {
          property = SIPrefixes();
          break;
        }
      case SPEED:
        {
          property = Speed();
          break;
        }
      case TEMPERATURE:
        {
          property = Temperature();
          break;
        }
      case TIME:
        {
          property = Time();
          break;
        }
      case TORQUE:
        {
          property = Torque();
          break;
        }
      case VOLUME:
        {
          property = Volume();
          break;
        }

      default:
        {
          assert(false, "from and to don't have a valid type");
          return null;
        }
    }
    property.convert(from, toDouble());
    return property.getUnit(to).value;
  }
}

extension ConvertUnitString on String {
  String? convertFromTo(NUMERAL_SYSTEMS from, NUMERAL_SYSTEMS to) {
    Property property = NumeralSystems()..convert(from, this);
    return property.getUnit(to).stringValue;
  }
}
