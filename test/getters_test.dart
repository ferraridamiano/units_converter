import 'package:test/test.dart';
import 'package:units_converter/units_converter.dart';

void main() {

  void runGetterTest(Unit unit1, Unit unit2) {
    double? val1 = unit1.value;
    double? val2 = unit2.value;
    test('${unit1.name.toString()} test', () {
      expect(val1, val2, reason: 'Failed ${unit1.name.toString()}: $val1 is different from $val2');
    });
  }

  group('Angle test', () {
    var property = Angle();
    property.convert(ANGLE.degree, 1);
    runGetterTest(property.degree, property.getUnit(ANGLE.degree));
    runGetterTest(property.minutes, property.getUnit(ANGLE.minutes));
    runGetterTest(property.seconds, property.getUnit(ANGLE.seconds));
    runGetterTest(property.radians, property.getUnit(ANGLE.radians));
  });

  group('Area test', () {
    var property = Area();
    property.convert(AREA.squareMeters, 1);
    runGetterTest(property.squareMeters, property.getUnit(AREA.squareMeters));
    runGetterTest(property.squareCentimeters, property.getUnit(AREA.squareCentimeters));
    runGetterTest(property.squareInches, property.getUnit(AREA.squareInches));
    runGetterTest(property.squareFeet, property.getUnit(AREA.squareFeet));
    runGetterTest(property.squareMiles, property.getUnit(AREA.squareMiles));
    runGetterTest(property.squareYard, property.getUnit(AREA.squareYard));
    runGetterTest(property.squareMillimeters, property.getUnit(AREA.squareMillimeters));
    runGetterTest(property.squareKilometers, property.getUnit(AREA.squareKilometers));
    runGetterTest(property.hectares, property.getUnit(AREA.hectares));
    runGetterTest(property.acres, property.getUnit(AREA.acres));
    runGetterTest(property.are, property.getUnit(AREA.are));
  });

  group('Digital data test', () {
    var property = DigitalData();
    property.convert(DIGITAL_DATA.byte, 1);
    runGetterTest(property.bit, property.getUnit(DIGITAL_DATA.bit));
    runGetterTest(property.nibble, property.getUnit(DIGITAL_DATA.nibble));
    runGetterTest(property.kilobit, property.getUnit(DIGITAL_DATA.kilobit));
    runGetterTest(property.megabit, property.getUnit(DIGITAL_DATA.megabit));
    runGetterTest(property.gigabit, property.getUnit(DIGITAL_DATA.gigabit));
    runGetterTest(property.terabit, property.getUnit(DIGITAL_DATA.terabit));
    runGetterTest(property.petabit, property.getUnit(DIGITAL_DATA.petabit));
    runGetterTest(property.exabit, property.getUnit(DIGITAL_DATA.exabit));
    runGetterTest(property.kibibit, property.getUnit(DIGITAL_DATA.kibibit));
    runGetterTest(property.mebibit, property.getUnit(DIGITAL_DATA.mebibit));
    runGetterTest(property.gibibit, property.getUnit(DIGITAL_DATA.gibibit));
    runGetterTest(property.tebibit, property.getUnit(DIGITAL_DATA.tebibit));
    runGetterTest(property.pebibit, property.getUnit(DIGITAL_DATA.pebibit));
    runGetterTest(property.exbibit, property.getUnit(DIGITAL_DATA.exbibit));
    runGetterTest(property.byte, property.getUnit(DIGITAL_DATA.byte));
    runGetterTest(property.kilobyte, property.getUnit(DIGITAL_DATA.kilobyte));
    runGetterTest(property.megabyte, property.getUnit(DIGITAL_DATA.megabyte));
    runGetterTest(property.gigabyte, property.getUnit(DIGITAL_DATA.gigabyte));
    runGetterTest(property.terabyte, property.getUnit(DIGITAL_DATA.terabyte));
    runGetterTest(property.petabyte, property.getUnit(DIGITAL_DATA.petabyte));
    runGetterTest(property.exabyte, property.getUnit(DIGITAL_DATA.exabyte));
    runGetterTest(property.kibibyte, property.getUnit(DIGITAL_DATA.kibibyte));
    runGetterTest(property.mebibyte, property.getUnit(DIGITAL_DATA.mebibyte));
    runGetterTest(property.gibibyte, property.getUnit(DIGITAL_DATA.gibibyte));
    runGetterTest(property.tebibyte, property.getUnit(DIGITAL_DATA.tebibyte));
    runGetterTest(property.exbibyte, property.getUnit(DIGITAL_DATA.exbibyte));
  });

  group('Energy test', () {
    var property = Energy();
    property.convert(ENERGY.joules, 1);
    runGetterTest(property.joules, property.getUnit(ENERGY.joules));
    runGetterTest(property.calories, property.getUnit(ENERGY.calories));
    runGetterTest(property.kilowattHours, property.getUnit(ENERGY.kilowattHours));
    runGetterTest(property.electronvolts, property.getUnit(ENERGY.electronvolts));
    runGetterTest(property.energyFootPound, property.getUnit(ENERGY.energyFootPound));
  });

  group('Force test', () {
    var property = Force();
    property.convert(FORCE.newton, 1);
    runGetterTest(property.newton, property.getUnit(FORCE.newton));
    runGetterTest(property.dyne, property.getUnit(FORCE.dyne));
    runGetterTest(property.poundForce, property.getUnit(FORCE.poundForce));
    runGetterTest(property.kilogramForce, property.getUnit(FORCE.kilogramForce));
    runGetterTest(property.poundal, property.getUnit(FORCE.poundal));
  });

  group('Fuel consumption test', () {
    var property = FuelConsumption();
    property.convert(FUEL_CONSUMPTION.kilometersPerLiter, 1);
    runGetterTest(property.kilometersPerLiter, property.getUnit(FUEL_CONSUMPTION.kilometersPerLiter));
    runGetterTest(property.litersPer100km, property.getUnit(FUEL_CONSUMPTION.litersPer100km));
    runGetterTest(property.milesPerUsGallon, property.getUnit(FUEL_CONSUMPTION.milesPerUsGallon));
    runGetterTest(property.milesPerImperialGallon, property.getUnit(FUEL_CONSUMPTION.milesPerImperialGallon));
  });

  group('Length test', () {
    var property = Length();
    property.convert(LENGTH.meters, 1);
    runGetterTest(property.meters, property.getUnit(LENGTH.meters));
    runGetterTest(property.centimeters, property.getUnit(LENGTH.centimeters));
    runGetterTest(property.inches, property.getUnit(LENGTH.inches));
    runGetterTest(property.feet, property.getUnit(LENGTH.feet));
    runGetterTest(property.nauticalMiles, property.getUnit(LENGTH.nauticalMiles));
    runGetterTest(property.yards, property.getUnit(LENGTH.yards));
    runGetterTest(property.miles, property.getUnit(LENGTH.miles));
    runGetterTest(property.millimeters, property.getUnit(LENGTH.millimeters));
    runGetterTest(property.micrometers, property.getUnit(LENGTH.micrometers));
    runGetterTest(property.nanometers, property.getUnit(LENGTH.nanometers));
    runGetterTest(property.angstroms, property.getUnit(LENGTH.angstroms));
    runGetterTest(property.picometers, property.getUnit(LENGTH.picometers));
    runGetterTest(property.kilometers, property.getUnit(LENGTH.kilometers));
    runGetterTest(property.astronomicalUnits, property.getUnit(LENGTH.astronomicalUnits));
    runGetterTest(property.lightYears, property.getUnit(LENGTH.lightYears));
    runGetterTest(property.parsec, property.getUnit(LENGTH.parsec));
    runGetterTest(property.mils, property.getUnit(LENGTH.mils));
  });
}
