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

  double? convertUnitsAsRatioFromTo(
    dynamic fromNumerator,
    dynamic fromDenominator,
    dynamic toNumerator,
    dynamic toDenominator,
  ) {
    assert(fromNumerator.runtimeType == toNumerator.runtimeType,
        'fromNumberator and toNumerator must be of the same type, e.g. LENGTH');
    assert(fromDenominator.runtimeType == toDenominator.runtimeType,
        'fromNumberator and toNumerator must be of the same type, e.g. LENGTH');

    /// Get the type of unit for the input ratio numerator
    final numeratorProperty = _type(fromNumerator);

    /// Get the type of unit for the input ratio denominator
    final denominatorProperty = _type(fromDenominator);

    /// Get the conversion ready for the Numerator. The passed numerical value
    /// is included in this just as it is for the above function
    ///
    /// 500 mg/L - starts with converting 500 mg
    numeratorProperty?.convert(fromNumerator, toDouble());

    /// for the Denominator, we include the unit, but assume the value is 1
    ///
    /// 500 mg/L = 500 mg / 1 L
    denominatorProperty?.convert(fromDenominator, 1.0);

    /// if any value is null OR the denominator is 0 (undefined by reality) we
    /// just return 0
    if (numeratorProperty?.getUnit(toNumerator).value == null ||
        denominatorProperty?.getUnit(toDenominator).value == null ||
        denominatorProperty?.getUnit(toDenominator).value == 0) {
      return 0;
    } else {
      /// Otherwise we convert the top value and divde by the bottom value
      ///
      /// 500 mg / L => mg / mL
      /// 500 mg = 500 mg
      /// 1 L = 1000 mL
      /// 500 / 1000 = 0.5
      return numeratorProperty!.getUnit(toNumerator).value! /
          denominatorProperty!.getUnit(toDenominator).value!;
    }
  }

  double? convertRatioFromTo(Ratio from, Ratio to) => convertUnitsAsRatioFromTo(
        from.numeratorUnit(),
        from.denominatorUnit(),
        to.numeratorUnit(),
        to.denominatorUnit(),
      );
}

extension ConvertUnitString on String {
  String? convertFromTo(NUMERAL_SYSTEMS from, NUMERAL_SYSTEMS to) {
    Property property = NumeralSystems()..convert(from, this);
    return property.getUnit(to).stringValue;
  }
}
