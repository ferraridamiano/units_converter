import 'package:test/test.dart';
import 'package:units_converter/units_converter.dart';

void main() {
  test('Extension on num', () {
    expect(1.convertFromTo(ANGLE.degree, ANGLE.minutes), 60);
    expect(1.convertFromTo(AREA.squareMeters, AREA.hectares), 1e-4);
    expect(1.convertFromTo(DIGITAL_DATA.byte, DIGITAL_DATA.nibble), 2);
    expect(1.convertFromTo(ENERGY.kilocalories, ENERGY.calories), 1e3);
    expect(1.convertFromTo(FORCE.dyne, FORCE.newton), 1e-5);
    expect(
        1.convertFromTo(FUEL_CONSUMPTION.kilometersPerLiter,
            FUEL_CONSUMPTION.litersPer100km),
        100);
    expect(1.convertFromTo(LENGTH.feet, LENGTH.meters), 0.3048);
    expect(1.convertFromTo(MASS.kilograms, MASS.grams), 1e3);
    expect(1.convertFromTo(POWER.kilowatt, POWER.watt), 1e3);
    expect(1.convertFromTo(PRESSURE.bar, PRESSURE.pascal), 1e5);
    expect(1.convertFromTo(SHOE_SIZE.inches, SHOE_SIZE.centimeters), 2.54);
    expect(1.convertFromTo(SI_PREFIXES.kilo, SI_PREFIXES.base), 1e3);
    expect(1.convertFromTo(SPEED.kilometersPerHour, SPEED.minutesPerKilometer),
        60);
    expect(1.convertFromTo(TEMPERATURE.celsius, TEMPERATURE.fahrenheit), 33.8);
    expect(1.convertFromTo(TIME.hours, TIME.minutes), 60);
    expect(1.convertFromTo(TORQUE.dyneMeter, TORQUE.newtonMeter), 1e-5);
    expect(1.convertFromTo(VOLUME.cubicMeters, VOLUME.liters), 1e3);
    expect(() {
      1.convertFromTo('This unit does not exists', 'another unit');
    }, throwsA(isA<AssertionError>()));
    expect(
        500.convertUnitsAsRatioFromTo(MASS.milligrams, VOLUME.liters,
            MASS.milligrams, VOLUME.milliliters),
        0.5);
    expect(
        500.convertRatioFromTo(
          Ratio.milliGramsPerLiter,
          Ratio.milliGramsPerMilliliter,
        ),
        0.5);
  });

  test('Extension on String', () {
    expect(
        '10001011'
            .convertFromTo(NUMERAL_SYSTEMS.binary, NUMERAL_SYSTEMS.hexadecimal),
        '8B');
  });
}
