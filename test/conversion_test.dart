import 'package:test/test.dart';
import 'package:units_converter/units_converter.dart';

/// This function defines if a value is accettable. e.g. if we expect to have 1 but we get 1.00000000012, is this a valid result or not?
/// The term sensbility is used improperly.
bool isAcceptable(double convertedValue, double expectedValue, {double sensibility = 1e10}) {
  final double accuracy = expectedValue / sensibility;
  final double upperConstraint = expectedValue + accuracy;
  final double lowerConstraint = expectedValue - accuracy;
  return convertedValue >= lowerConstraint && convertedValue <= upperConstraint;
}

void main() {
  group('Angle conversion', () {
    const Map<ANGLE, double> expectedResult = {
      ANGLE.degree: 1,
      ANGLE.minutes: 60,
      ANGLE.seconds: 3600,
      ANGLE.radians: 0.01745329252,
    };
    final List<ANGLE> listNames = expectedResult.keys.toList();
    Angle property = Angle();
    for (ANGLE unitName in listNames) {
      test('Test from ${unitName.toString()}', () {
        property.convert(unitName, expectedResult[unitName]);
        List<Unit> unitList = property.getAll();
        for (Unit unit in unitList) {
          ANGLE name = unit.name;
          double convertedValue = unitList.where((element) => element.name == name).single.value!;
          expect(isAcceptable(convertedValue, expectedResult[name]!), true, reason: 'Error with ${name.toString()}');
        }
      });
      property.convert(listNames[0], null); //clear all values
    }
  });

  group('Area conversion', () {
    const Map<AREA, double> expectedResult = {
      AREA.square_meters: 1,
      AREA.square_centimeters: 1e4,
      AREA.square_inches: 1550.0031,
      AREA.square_feet: 10.76391041671,
      AREA.square_miles: 3.8610215854245e-7,
      AREA.square_yard: 1.1959900463011,
      AREA.square_millimeters: 1e6,
      AREA.square_kilometers: 1e-6,
      AREA.hectares: 1e-4,
      AREA.acres: 0.00024710538146717,
      AREA.are: 0.01,
    };
    final List<AREA> listNames = expectedResult.keys.toList();
    Area property = Area();
    for (AREA unitName in listNames) {
      test('Test from ${unitName.toString()}', () {
        property.convert(unitName, expectedResult[unitName]);
        List<Unit> unitList = property.getAll();
        for (Unit unit in unitList) {
          AREA name = unit.name;
          double convertedValue = unitList.where((element) => element.name == name).single.value!;
          expect(isAcceptable(convertedValue, expectedResult[name]!), true, reason: 'Error with ${name.toString()}');
        }
      });
      property.convert(listNames[0], null); //clear all values
    }
  });

  group('Digital data conversion', () {
    const Map<DIGITAL_DATA, double> expectedResult = {
      DIGITAL_DATA.bit: 8,
      DIGITAL_DATA.kilobit: 8e-3,
      DIGITAL_DATA.megabit: 8e-6,
      DIGITAL_DATA.gigabit: 8e-9,
      DIGITAL_DATA.terabit: 8e-12,
      DIGITAL_DATA.petabit: 8e-15,
      DIGITAL_DATA.exabit: 8e-18,
      DIGITAL_DATA.kibibit: 7.8125e-3,
      DIGITAL_DATA.mebibit: 7.62939453125e-6,
      DIGITAL_DATA.gibibit: 7.4505805969238e-9,
      DIGITAL_DATA.tebibit: 7.2759576141834e-12,
      DIGITAL_DATA.pebibit: 7.105427357601e-15,
      DIGITAL_DATA.exbibit: 6.9388939039072e-18,
      DIGITAL_DATA.nibble: 2,
      DIGITAL_DATA.byte: 1,
      DIGITAL_DATA.kilobyte: 1e-3,
      DIGITAL_DATA.megabyte: 1e-6,
      DIGITAL_DATA.gigabyte: 1e-9,
      DIGITAL_DATA.terabyte: 1e-12,
      DIGITAL_DATA.petabyte: 1e-15,
      DIGITAL_DATA.exabyte: 1e-18,
      DIGITAL_DATA.kibibyte: 0.0009765625,
      DIGITAL_DATA.mebibyte: 9.5367431640625e-7,
      DIGITAL_DATA.gibibyte: 9.3132257461548e-10,
      DIGITAL_DATA.tebibyte: 9.0949470177293e-13,
      DIGITAL_DATA.pebibyte: 8.8817841970013e-16,
      DIGITAL_DATA.exbibyte: 8.673617379884e-19,
    };
    final List<DIGITAL_DATA> listNames = expectedResult.keys.toList();
    DigitalData property = DigitalData();
    for (DIGITAL_DATA unitName in listNames) {
      test('Test from ${unitName.toString()}', () {
        property.convert(unitName, expectedResult[unitName]);
        List<Unit> unitList = property.getAll();
        for (Unit unit in unitList) {
          DIGITAL_DATA name = unit.name;
          double convertedValue = unitList.where((element) => element.name == name).single.value!;
          expect(isAcceptable(convertedValue, expectedResult[name]!), true, reason: 'Error with ${name.toString()}');
        }
      });
      property.convert(listNames[0], null); //clear all values
    }
  });
}
