import 'dart:math';

/// Given a double value it returns its rapresentation as a string with few
/// tweaks: [significantFigures] is the number of significant figures to keep,
/// [removeTrailingZeros] say if non important zeros should be removed.
/// E.g. 1.000000 --> 1
String mantissaCorrection(
    double value, int significantFigures, bool removeTrailingZeros) {
  //Round to a fixed number of significant figures
  var stringValue = value.toStringAsPrecision(significantFigures);
  var append = '';

  //if the user want to remove the trailing zeros
  if (removeTrailingZeros) {
    //remove exponential part and append to the end
    if (stringValue.contains('e')) {
      append = 'e' + stringValue.split('e')[1];
      stringValue = stringValue.split('e')[0];
    }

    //remove trailing zeros (just fractional part)
    if (stringValue.contains('.')) {
      var firstZeroIndex = stringValue.length;
      for (; firstZeroIndex > stringValue.indexOf('.'); firstZeroIndex--) {
        var charAtIndex =
            stringValue.substring(firstZeroIndex - 1, firstZeroIndex);
        if (charAtIndex != '0' && charAtIndex != '.') break;
      }
      stringValue = stringValue.substring(0, firstZeroIndex);
    }
  }
  return stringValue + append; //append exponential part
}

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
