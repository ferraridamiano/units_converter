import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:rational/rational.dart';

/// Convert [stringDec], the String representation of a decimal value (e.g.
/// "10"), to another base depending of the value of [base] (E.g. 16 for
/// hexadecimal, 2 for binary, etc.).
String decToBase(String stringDec, int base) {
  var regExp = getBaseRegExp(10);
  if (!regExp.hasMatch(stringDec)) return '';

  var myString = '';
  String restoString;
  int resto;
  var dec = int.parse(stringDec);
  while (dec > 0) {
    resto = (dec % base);
    restoString = resto.toString();
    if (resto >= 10) {
      restoString = String.fromCharCode(resto + 55);
    }
    myString = restoString + myString; //aggiungo in testa
    dec = dec ~/ base;
  }
  return myString;
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
    if (unitCode >= 65 && unitCode <= 70) {
      // from A to F
      conversion =
          conversion + (unitCode - 55) * pow(base, len - i - 1).toInt();
    } else if (unitCode >= 48 && unitCode <= 57) {
      // from 0 to 9
      conversion =
          conversion + (unitCode - 48) * pow(base, len - i - 1).toInt();
    }
  }
  return conversion.toString();
}

/// Returns a regular expression that could match a certain String expressed
/// with a certain [base].
RegExp getBaseRegExp(int base) {
  assert([2, 8, 10, 16].contains(base), 'Base not supported');

  switch (base) {
    case 2:
      return RegExp(r'^[0-1]+$');
    case 8:
      return RegExp(r'^[0-7]+$');
    case 16:
      return RegExp(r'^[0-9A-Fa-f]+$');
    case 10:
    default:
      return RegExp(r'^[0-9]+$');
  }
}

Rational fraction(int numerator, int denominator) =>
    Rational(BigInt.from(numerator), BigInt.from(denominator));

extension RationalExt on Rational {
  String toStringWith({
    int significantFigures = 10,
    bool removeTrailingZeros = true,
  }) {
    String stringValue = toDecimal(scaleOnInfinitePrecision: 100)
        .toStringAsPrecision(significantFigures);
    if (removeTrailingZeros) {
      while (stringValue.contains('.') &&
          (stringValue.endsWith('0') || stringValue.endsWith('.'))) {
        stringValue = stringValue.substring(0, stringValue.length - 1);
      }
    }
    return stringValue;
  }
}
