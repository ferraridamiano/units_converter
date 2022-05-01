import 'package:test/test.dart';
import 'package:units_converter/utils/utils.dart';

void main() {
  group('Value to String test', () {
    test('10 -> "10"', () {
      String output = valueToString(10, 10, true);
      expect(output, '10');
    });
    test('10.2 -> "10.2"', () {
      String output = valueToString(10.2, 10, true);
      expect(output, '10.2');
    });
    test('1e12 -> "1e+12" (scientific notation)', () {
      String output = valueToString(1e12, 10, true, useScientificNotation: true);
      expect(output, '1e+12');
    });
    test('1e12 -> "1000000000000 (decimal notation)"', () {
      String output = valueToString(1e12, 10, true, useScientificNotation: false);
      expect(output, '1000000000000');
    });
    test('1.2e12 -> "1.2e+12" (scientific notation)', () {
      String output = valueToString(1.2e12, 10, true, useScientificNotation: true);
      expect(output, '1.2e+12');
    });
    test('1.2e12 -> "1200000000000" (decimal notation)', () {
      String output = valueToString(1.2e12, 10, true, useScientificNotation: false);
      expect(output, '1200000000000');
    });
    test('1.2e-9 -> "1.2e-9" (exponential notation)', () {
      String output = valueToString(1.2e-9, 10, true, useScientificNotation: true);
      expect(output, '1.2e-9');
    });
    test('1.2e-9 -> "0.0000000012 (decimal notation)"', () {
      String output = valueToString(1.2e-9, 10, true, useScientificNotation: false);
      expect(output, '0.0000000012');
    });

    test('1.2e21 -> "1.2e21" (scientific notation)', () {
      String output = valueToString(1.2e21, 10, true, useScientificNotation: true);
      expect(output, '1.2e+21');
    });

    test('1.2e21 -> "1200000000000000000000" (decimal notation)', () {
      String output = valueToString(1.2e21, 10, true, useScientificNotation: false);
      expect(output, '1200000000000000000000');
    });

    test('1e21 -> "1e21" (scientific notation)', () {
      String output = valueToString(1e21, 10, true, useScientificNotation: true);
      expect(output, '1e+21');
    });

    test('1e21 -> "1000000000000000000000" (decimal notation)', () {
      String output = valueToString(1e21, 10, true, useScientificNotation: false);
      expect(output, '1000000000000000000000');
    });
  });
}