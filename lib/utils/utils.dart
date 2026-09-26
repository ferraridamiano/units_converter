import 'package:units_converter/models/property.dart';
import 'package:units_converter/properties/amount_of_substance.dart';
import 'package:units_converter/properties/illuminance.dart';
import 'package:units_converter/properties/length.dart';
import 'package:units_converter/properties/area.dart';
import 'package:units_converter/properties/molar_mass.dart';
import 'package:units_converter/properties/molar_volume.dart';
import 'package:units_converter/properties/reciprocal_of_molar_mass.dart';
import 'package:units_converter/properties/volume.dart';
import 'package:units_converter/properties/time.dart';
import 'package:units_converter/properties/temperature.dart';
import 'package:units_converter/properties/speed.dart';
import 'package:units_converter/properties/si_prefixes.dart';
import 'package:units_converter/properties/mass.dart';
import 'package:units_converter/properties/pressure.dart';
import 'package:units_converter/properties/energy.dart';
import 'package:units_converter/properties/angle.dart';
import 'package:units_converter/properties/power.dart';
import 'package:units_converter/properties/force.dart';
import 'package:units_converter/properties/torque.dart';
import 'package:units_converter/properties/fuel_consumption.dart';
import 'package:units_converter/properties/digital_data.dart';
import 'package:units_converter/properties/shoe_size.dart';
import 'package:units_converter/properties/density.dart';

Property? getPropertyFromEnum(dynamic propertyEnum) {
  return switch (propertyEnum.runtimeType) {
    const (AMOUNT_OF_SUBSTANCE) => AmountOfSubstance(),
    const (ANGLE) => Angle(),
    const (AREA) => Area(),
    const (DENSITY) => Density(),
    const (DIGITAL_DATA) => DigitalData(),
    const (ENERGY) => Energy(),
    const (FORCE) => Force(),
    const (FUEL_CONSUMPTION) => FuelConsumption(),
    const (ILLUMINANCE) => Illuminance(),
    const (LENGTH) => Length(),
    const (MASS) => Mass(),
    const (MOLAR_MASS) => MolarMass(),
    const (MOLAR_VOLUME) => MolarVolume(),
    const (POWER) => Power(),
    const (PRESSURE) => Pressure(),
    const (RECIPROCAL_OF_MOLAR_MASS) => ReciprocalOfMolarMass(),
    const (SHOE_SIZE) => ShoeSize(),
    const (SI_PREFIXES) => SIPrefixes(),
    const (SPEED) => Speed(),
    const (TEMPERATURE) => Temperature(),
    const (TIME) => Time(),
    const (TORQUE) => Torque(),
    const (VOLUME) => Volume(),
    _ => () {
        assert(false, "${propertyEnum.runtimeType} is not a valid enum type");
        return null;
      }()
  } as Property?;
}

/// Given a double value it returns its representation as a string with few
/// tweaks: [significantFigures] is the number of significant figures to keep,
/// [removeTrailingZeros] say if non important zeros should be removed.
/// [decimalSeparator] is the string used to separate the integer part from the
/// decimal one (default is ".").
/// E.g. 1.000000 --> 1
String valueToString(
  double value,
  int significantFigures,
  bool removeTrailingZeros,
  bool useScientificNotation,
  String decimalSeparator,
) {
  //Round to a fixed number of significant figures
  String stringValue;
  if (useScientificNotation) {
    stringValue = value.toStringAsPrecision(significantFigures);
  } else {
    stringValue = value.toStringAsFixed(significantFigures);
  }

  /**
   * [stringValue] can be in multiple form:
   *  - x     (an integer)
   *  - x.y   (a decimal)
   *  - xez   (integer with an exponential part)
   *  - x.yez (decimal with an exponential part)
   */

  List<String> splittedNumbers = stringValue.split('.');
  String integerPart = splittedNumbers[0];
  String? decimalPart, exponentialPart;

  // x.y and x.yez
  if (splittedNumbers.length == 2) {
    splittedNumbers = splittedNumbers[1].split('e');
    decimalPart = splittedNumbers[0];

    // x.yez
    if (splittedNumbers.length == 2) {
      exponentialPart = splittedNumbers[1];
    }
  }
  // x and xez
  else {
    splittedNumbers = splittedNumbers[0].split('e');

    // xez
    if (splittedNumbers.length == 2) {
      integerPart = splittedNumbers[0];
      exponentialPart = splittedNumbers[1];
    }
  }

  //if the user want to remove the trailing zeros
  if (removeTrailingZeros && decimalPart != null) {
    //remove trailing zeros (just fractional part)
    int firstZeroIndex = decimalPart.length;
    for (; firstZeroIndex > 0; firstZeroIndex--) {
      String charAtIndex =
          decimalPart.substring(firstZeroIndex - 1, firstZeroIndex);
      if (charAtIndex != '0') break;
    }
    decimalPart = decimalPart.substring(0, firstZeroIndex);
    if (decimalPart == "") {
      decimalPart = null;
    }
  }

  if (!useScientificNotation && exponentialPart != null) {
    // It means that the absolute value of [value] is greater or equal than 1e21
    // (see the documentation of .toStringAsFixed() method)

    /**
     *  There are 2 cases:
     *  - x.ye+z
     *  - xe+z
     */
    int exponentialNumber = int.parse(exponentialPart);
    // x.ye+z
    if (decimalPart != null) {
      if (decimalPart.length < exponentialNumber) {
        decimalPart = decimalPart +
            ''.padRight(exponentialNumber - decimalPart.length, '0');
      }
      integerPart = integerPart + decimalPart.substring(0, exponentialNumber);
      decimalPart = decimalPart.substring(exponentialNumber);
      if (decimalPart == '') decimalPart = null;
    }
    // xe+z
    else {
      integerPart = integerPart + ''.padRight(exponentialNumber, '0');
    }
    exponentialPart = null;
  }

  // Recompose the string
  String finalString = integerPart;
  if (decimalPart != null) {
    finalString = '$finalString$decimalSeparator$decimalPart';
  }
  if (exponentialPart != null) {
    finalString = '${finalString}e$exponentialPart';
  }
  return finalString;
}

/// Convert [stringDec], the String representation of a decimal value (e.g.
/// "10"), to another base depending of the value of [base] (E.g. 16 for
/// hexadecimal, 2 for binary, etc.).
String decToBase(String stringDec, int base) {
  var regExp = getBaseRegExp(10);
  if (!regExp.hasMatch(stringDec)) return '';

  var dec = int.parse(stringDec);
  var digits = <int>[];
  while (dec > 0) {
    final remainder = dec % base;
    // '0'-'9' have code unit 48-57, 'A'-'F' have code unit 65-70
    digits.add(remainder >= 10 ? remainder + 55 : remainder + 48);
    dec = dec ~/ base;
  }
  if (digits.isEmpty) return '';
  return String.fromCharCodes(digits.reversed);
}

/// Convert [toBeConverted], the String representation of a value with a certain
/// [base] (E.g. 16 for hexadecimal, 2 for binary, etc.), to another String
/// expressed with the decimal base.
String baseToDec(String toBeConverted, int base) {
  toBeConverted = toBeConverted.toUpperCase();

  var regExp = getBaseRegExp(base);

  if (!regExp.hasMatch(toBeConverted)) return '';

  int conversion = 0;
  int len = toBeConverted.length;
  for (int i = 0; i < len; i++) {
    int unitCode = toBeConverted.codeUnitAt(i);
    int digit;
    if (unitCode >= 65 && unitCode <= 70) {
      // from A to F
      digit = unitCode - 55;
    } else if (unitCode >= 48 && unitCode <= 57) {
      // from 0 to 9
      digit = unitCode - 48;
    } else {
      return '';
    }
    conversion = conversion * base + digit;
  }
  return conversion.toString();
}

final RegExp _binaryRegExp = RegExp(r'^[0-1]+$');
final RegExp _octalRegExp = RegExp(r'^[0-7]+$');
final RegExp _hexadecimalRegExp = RegExp(r'^[0-9A-Fa-f]+$');
final RegExp _decimalRegExp = RegExp(r'^[0-9]+$');

/// Returns a regular expression that could match a certain String expressed
/// with a certain [base].
RegExp getBaseRegExp(int base) {
  assert([2, 8, 10, 16].contains(base), 'Base not supported');
  switch (base) {
    case 2:
      return _binaryRegExp;
    case 8:
      return _octalRegExp;
    case 16:
      return _hexadecimalRegExp;
    case 10:
    default:
      return _decimalRegExp;
  }
}
