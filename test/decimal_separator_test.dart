import 'package:test/test.dart';
import 'package:units_converter/units_converter.dart';

void main() {
  group('Decimal separator test', () {
    test('Default decimal separator is "."', () {
      var length = Length();
      length.convert(LENGTH.inches, 1);
      expect(length.meters.stringValue, '0.0254');
    });

    test('Custom decimal separator (DoubleProperty)', () {
      var length = Length(decimalSeparator: ',');
      length.convert(LENGTH.inches, 1);
      expect(length.meters.stringValue, '0,0254');
    });

    test('Multi-character decimal separator', () {
      var length = Length(decimalSeparator: '__');
      length.convert(LENGTH.inches, 1);
      expect(length.meters.stringValue, '0__0254');
    });

    test('Custom decimal separator with scientific notation', () {
      var length = Length(decimalSeparator: ',', significantFigures: 2);
      length.convert(LENGTH.inches, 1);
      expect(length.meters.stringValue, '0,025');
    });

    test('Custom decimal separator with decimal notation of big numbers', () {
      var length = Length(decimalSeparator: ',', useScientificNotation: false);
      length.convert(LENGTH.astronomicalUnits, 1);
      expect(length.meters.stringValue, '149597870700');
    });

    test('Changing the decimal separator at runtime', () {
      var length = Length();
      length.convert(LENGTH.inches, 1);
      expect(length.meters.stringValue, '0.0254');
      length.decimalSeparator = ',';
      expect(length.meters.stringValue, '0,0254');
    });

    test('Custom decimal separator (RatioProperty)', () {
      var fuel = FuelConsumption(decimalSeparator: ',');
      fuel.convert(FUEL_CONSUMPTION.kilometersPerLiter, 1);
      expect(
        fuel.milesPerLiter.stringValue!.startsWith('0,62'),
        isTrue,
      );
    });

    test('Empty decimal separator is not allowed', () {
      expect(
        () => Length(decimalSeparator: ''),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
