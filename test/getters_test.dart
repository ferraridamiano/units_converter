import 'package:test/test.dart';
import 'package:units_converter/units_converter.dart';

void main() {
  void runGetterTest(Unit unit1, Unit unit2) {
    double? val1 = unit1.value;
    double? val2 = unit2.value;
    test('${unit1.name.toString()} test', () {
      expect(val1, val2,
          reason:
              'Failed ${unit1.name.toString()}: $val1 is different from $val2');
    });
  }

  group('Amount of Substance', () {
    var property = AmountOfSubstance();
    property.convert(AMOUNT_OF_SUBSTANCE.moles, 1);
    runGetterTest(property.moles, property.getUnit(AMOUNT_OF_SUBSTANCE.moles));
    runGetterTest(
        property.millimoles, property.getUnit(AMOUNT_OF_SUBSTANCE.millimoles));
    runGetterTest(
        property.micromoles, property.getUnit(AMOUNT_OF_SUBSTANCE.micromoles));
    runGetterTest(
        property.nanomoles, property.getUnit(AMOUNT_OF_SUBSTANCE.nanomoles));
    runGetterTest(
        property.picomoles, property.getUnit(AMOUNT_OF_SUBSTANCE.picomoles));
    runGetterTest(
        property.femtomoles, property.getUnit(AMOUNT_OF_SUBSTANCE.femtomoles));
  });

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
    runGetterTest(
        property.squareCentimeters, property.getUnit(AREA.squareCentimeters));
    runGetterTest(property.squareInches, property.getUnit(AREA.squareInches));
    runGetterTest(property.squareFeet, property.getUnit(AREA.squareFeet));
    runGetterTest(property.squareFeetUs, property.getUnit(AREA.squareFeetUs));
    runGetterTest(property.squareMiles, property.getUnit(AREA.squareMiles));
    runGetterTest(property.squareYard, property.getUnit(AREA.squareYard));
    runGetterTest(
        property.squareMillimeters, property.getUnit(AREA.squareMillimeters));
    runGetterTest(
        property.squareKilometers, property.getUnit(AREA.squareKilometers));
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
    runGetterTest(property.pebibyte, property.getUnit(DIGITAL_DATA.pebibyte));
    runGetterTest(property.exbibyte, property.getUnit(DIGITAL_DATA.exbibyte));
  });

  group('Energy test', () {
    var property = Energy();
    property.convert(ENERGY.joules, 1);
    runGetterTest(property.joules, property.getUnit(ENERGY.joules));
    runGetterTest(property.calories, property.getUnit(ENERGY.calories));
    runGetterTest(property.kilocalories, property.getUnit(ENERGY.kilocalories));
    runGetterTest(
        property.kilowattHours, property.getUnit(ENERGY.kilowattHours));
    runGetterTest(
        property.electronvolts, property.getUnit(ENERGY.electronvolts));
    runGetterTest(
        property.energyFootPound, property.getUnit(ENERGY.energyFootPound));
  });

  group('Force test', () {
    var property = Force();
    property.convert(FORCE.newton, 1);
    runGetterTest(property.newton, property.getUnit(FORCE.newton));
    runGetterTest(property.dyne, property.getUnit(FORCE.dyne));
    runGetterTest(property.poundForce, property.getUnit(FORCE.poundForce));
    runGetterTest(
        property.kilogramForce, property.getUnit(FORCE.kilogramForce));
    runGetterTest(property.poundal, property.getUnit(FORCE.poundal));
  });

  group('Fuel consumption test', () {
    var property = FuelConsumption();
    property.convert(FUEL_CONSUMPTION.kilometersPerLiter, 1);
    runGetterTest(property.kilometersPerLiter,
        property.getUnit(FUEL_CONSUMPTION.kilometersPerLiter));
    runGetterTest(property.litersPer100km,
        property.getUnit(FUEL_CONSUMPTION.litersPer100km));
    runGetterTest(property.milesPerUsGallon,
        property.getUnit(FUEL_CONSUMPTION.milesPerUsGallon));
    runGetterTest(property.milesPerImperialGallon,
        property.getUnit(FUEL_CONSUMPTION.milesPerImperialGallon));
  });

  group('Length test', () {
    var property = Length();
    property.convert(LENGTH.meters, 1);
    runGetterTest(property.meters, property.getUnit(LENGTH.meters));
    runGetterTest(property.centimeters, property.getUnit(LENGTH.centimeters));
    runGetterTest(property.inches, property.getUnit(LENGTH.inches));
    runGetterTest(property.feet, property.getUnit(LENGTH.feet));
    runGetterTest(property.feetUs, property.getUnit(LENGTH.feetUs));
    runGetterTest(
        property.nauticalMiles, property.getUnit(LENGTH.nauticalMiles));
    runGetterTest(property.yards, property.getUnit(LENGTH.yards));
    runGetterTest(property.miles, property.getUnit(LENGTH.miles));
    runGetterTest(property.millimeters, property.getUnit(LENGTH.millimeters));
    runGetterTest(property.micrometers, property.getUnit(LENGTH.micrometers));
    runGetterTest(property.nanometers, property.getUnit(LENGTH.nanometers));
    runGetterTest(property.angstroms, property.getUnit(LENGTH.angstroms));
    runGetterTest(property.picometers, property.getUnit(LENGTH.picometers));
    runGetterTest(property.kilometers, property.getUnit(LENGTH.kilometers));
    runGetterTest(
        property.astronomicalUnits, property.getUnit(LENGTH.astronomicalUnits));
    runGetterTest(property.lightYears, property.getUnit(LENGTH.lightYears));
    runGetterTest(property.parsec, property.getUnit(LENGTH.parsec));
    runGetterTest(property.mils, property.getUnit(LENGTH.mils));
  });

  group('Mass test', () {
    var property = Mass();
    property.convert(MASS.grams, 1);
    runGetterTest(property.grams, property.getUnit(MASS.grams));
    runGetterTest(property.ettograms, property.getUnit(MASS.ettograms));
    runGetterTest(property.kilograms, property.getUnit(MASS.kilograms));
    runGetterTest(property.pounds, property.getUnit(MASS.pounds));
    runGetterTest(property.ounces, property.getUnit(MASS.ounces));
    runGetterTest(property.quintals, property.getUnit(MASS.quintals));
    runGetterTest(property.tons, property.getUnit(MASS.tons));
    runGetterTest(property.milligrams, property.getUnit(MASS.milligrams));
    runGetterTest(property.uma, property.getUnit(MASS.uma));
    runGetterTest(property.carats, property.getUnit(MASS.carats));
    runGetterTest(property.centigrams, property.getUnit(MASS.centigrams));
    runGetterTest(property.pennyweights, property.getUnit(MASS.pennyweights));
    runGetterTest(property.troyOunces, property.getUnit(MASS.troyOunces));
    runGetterTest(property.stones, property.getUnit(MASS.stones));
    runGetterTest(property.femtograms, property.getUnit(MASS.femtograms));
    runGetterTest(property.picograms, property.getUnit(MASS.picograms));
    runGetterTest(property.nanograms, property.getUnit(MASS.nanograms));
    runGetterTest(property.micrograms, property.getUnit(MASS.micrograms));
    runGetterTest(property.decigrams, property.getUnit(MASS.decigrams));
  });

  group('Numeral systems test', () {
    var property = NumeralSystems();
    property.convert(NUMERAL_SYSTEMS.decimal, '1');
    runGetterTest(property.decimal, property.getUnit(NUMERAL_SYSTEMS.decimal));
    runGetterTest(
        property.hexadecimal, property.getUnit(NUMERAL_SYSTEMS.hexadecimal));
    runGetterTest(property.octal, property.getUnit(NUMERAL_SYSTEMS.octal));
    runGetterTest(property.binary, property.getUnit(NUMERAL_SYSTEMS.binary));
  });

  group('Power test', () {
    var property = Power();
    property.convert(POWER.watt, 1);
    runGetterTest(property.watt, property.getUnit(POWER.watt));
    runGetterTest(property.milliwatt, property.getUnit(POWER.milliwatt));
    runGetterTest(property.kilowatt, property.getUnit(POWER.kilowatt));
    runGetterTest(property.megawatt, property.getUnit(POWER.megawatt));
    runGetterTest(property.gigawatt, property.getUnit(POWER.gigawatt));
    runGetterTest(property.europeanHorsePower,
        property.getUnit(POWER.europeanHorsePower));
    runGetterTest(property.imperialHorsePower,
        property.getUnit(POWER.imperialHorsePower));
  });

  group('Pressure test', () {
    var property = Pressure();
    property.convert(PRESSURE.pascal, 1);
    runGetterTest(property.pascal, property.getUnit(PRESSURE.pascal));
    runGetterTest(property.atmosphere, property.getUnit(PRESSURE.atmosphere));
    runGetterTest(property.bar, property.getUnit(PRESSURE.bar));
    runGetterTest(property.millibar, property.getUnit(PRESSURE.millibar));
    runGetterTest(property.psi, property.getUnit(PRESSURE.psi));
    runGetterTest(property.torr, property.getUnit(PRESSURE.torr));
    runGetterTest(property.hectoPascal, property.getUnit(PRESSURE.hectoPascal));
    runGetterTest(
        property.inchOfMercury, property.getUnit(PRESSURE.inchOfMercury));
  });

  group('Shoe size test', () {
    var property = ShoeSize();
    property.convert(SHOE_SIZE.centimeters, 1);
    runGetterTest(
        property.centimeters, property.getUnit(SHOE_SIZE.centimeters));
    runGetterTest(property.inches, property.getUnit(SHOE_SIZE.inches));
    runGetterTest(property.euChina, property.getUnit(SHOE_SIZE.euChina));
    runGetterTest(
        property.ukIndiaChild, property.getUnit(SHOE_SIZE.ukIndiaChild));
    runGetterTest(property.ukIndiaMan, property.getUnit(SHOE_SIZE.ukIndiaMan));
    runGetterTest(
        property.ukIndiaWoman, property.getUnit(SHOE_SIZE.ukIndiaWoman));
    runGetterTest(
        property.usaCanadaChild, property.getUnit(SHOE_SIZE.usaCanadaChild));
    runGetterTest(
        property.usaCanadaMan, property.getUnit(SHOE_SIZE.usaCanadaMan));
    runGetterTest(
        property.usaCanadaWoman, property.getUnit(SHOE_SIZE.usaCanadaWoman));
    runGetterTest(property.japan, property.getUnit(SHOE_SIZE.japan));
  });

  group('SI prefixes test', () {
    var property = SIPrefixes();
    property.convert(SI_PREFIXES.base, 1);
    runGetterTest(property.base, property.getUnit(SI_PREFIXES.base));
    runGetterTest(property.deca, property.getUnit(SI_PREFIXES.deca));
    runGetterTest(property.hecto, property.getUnit(SI_PREFIXES.hecto));
    runGetterTest(property.kilo, property.getUnit(SI_PREFIXES.kilo));
    runGetterTest(property.mega, property.getUnit(SI_PREFIXES.mega));
    runGetterTest(property.giga, property.getUnit(SI_PREFIXES.giga));
    runGetterTest(property.tera, property.getUnit(SI_PREFIXES.tera));
    runGetterTest(property.peta, property.getUnit(SI_PREFIXES.peta));
    runGetterTest(property.exa, property.getUnit(SI_PREFIXES.exa));
    runGetterTest(property.zetta, property.getUnit(SI_PREFIXES.zetta));
    runGetterTest(property.yotta, property.getUnit(SI_PREFIXES.yotta));
    runGetterTest(property.deci, property.getUnit(SI_PREFIXES.deci));
    runGetterTest(property.centi, property.getUnit(SI_PREFIXES.centi));
    runGetterTest(property.milli, property.getUnit(SI_PREFIXES.milli));
    runGetterTest(property.micro, property.getUnit(SI_PREFIXES.micro));
    runGetterTest(property.nano, property.getUnit(SI_PREFIXES.nano));
    runGetterTest(property.pico, property.getUnit(SI_PREFIXES.pico));
    runGetterTest(property.femto, property.getUnit(SI_PREFIXES.femto));
    runGetterTest(property.atto, property.getUnit(SI_PREFIXES.atto));
    runGetterTest(property.zepto, property.getUnit(SI_PREFIXES.zepto));
    runGetterTest(property.yocto, property.getUnit(SI_PREFIXES.yocto));
  });

  group('Speed test', () {
    var property = Speed();
    property.convert(SPEED.metersPerSecond, 1);
    runGetterTest(
        property.metersPerSecond, property.getUnit(SPEED.metersPerSecond));
    runGetterTest(
        property.kilometersPerHour, property.getUnit(SPEED.kilometersPerHour));
    runGetterTest(property.milesPerHour, property.getUnit(SPEED.milesPerHour));
    runGetterTest(property.knots, property.getUnit(SPEED.knots));
    runGetterTest(
        property.feetsPerSecond, property.getUnit(SPEED.feetsPerSecond));
    runGetterTest(property.minutesPerKilometer,
        property.getUnit(SPEED.minutesPerKilometer));
  });

  group('Temperature test', () {
    var property = Temperature();
    property.convert(TEMPERATURE.fahrenheit, 1);
    runGetterTest(
        property.fahrenheit, property.getUnit(TEMPERATURE.fahrenheit));
    runGetterTest(property.celsius, property.getUnit(TEMPERATURE.celsius));
    runGetterTest(property.kelvin, property.getUnit(TEMPERATURE.kelvin));
    runGetterTest(property.reamur, property.getUnit(TEMPERATURE.reamur));
    runGetterTest(property.romer, property.getUnit(TEMPERATURE.romer));
    runGetterTest(property.delisle, property.getUnit(TEMPERATURE.delisle));
    runGetterTest(property.rankine, property.getUnit(TEMPERATURE.rankine));
  });

  group('Time test', () {
    var property = Time();
    property.convert(TIME.seconds, 1);
    runGetterTest(property.seconds, property.getUnit(TIME.seconds));
    runGetterTest(property.deciseconds, property.getUnit(TIME.deciseconds));
    runGetterTest(property.centiseconds, property.getUnit(TIME.centiseconds));
    runGetterTest(property.milliseconds, property.getUnit(TIME.milliseconds));
    runGetterTest(property.microseconds, property.getUnit(TIME.microseconds));
    runGetterTest(property.nanoseconds, property.getUnit(TIME.nanoseconds));
    runGetterTest(property.minutes, property.getUnit(TIME.minutes));
    runGetterTest(property.hours, property.getUnit(TIME.hours));
    runGetterTest(property.days, property.getUnit(TIME.days));
    runGetterTest(property.weeks, property.getUnit(TIME.weeks));
    runGetterTest(property.years365, property.getUnit(TIME.years365));
    runGetterTest(property.lustrum, property.getUnit(TIME.lustrum));
    runGetterTest(property.decades, property.getUnit(TIME.decades));
    runGetterTest(property.centuries, property.getUnit(TIME.centuries));
    runGetterTest(property.millennium, property.getUnit(TIME.millennium));
  });

  group('Torque test', () {
    var property = Torque();
    property.convert(TORQUE.newtonMeter, 1);
    runGetterTest(property.newtonMeter, property.getUnit(TORQUE.newtonMeter));
    runGetterTest(property.dyneMeter, property.getUnit(TORQUE.dyneMeter));
    runGetterTest(
        property.poundForceFeet, property.getUnit(TORQUE.poundForceFeet));
    runGetterTest(property.kilogramForceMeter,
        property.getUnit(TORQUE.kilogramForceMeter));
    runGetterTest(property.poundalMeter, property.getUnit(TORQUE.poundalMeter));
  });

  group('Volume test', () {
    var property = Volume();
    property.convert(VOLUME.cubicMeters, 1);
    runGetterTest(property.cubicMeters, property.getUnit(VOLUME.cubicMeters));
    runGetterTest(property.liters, property.getUnit(VOLUME.liters));
    runGetterTest(
        property.imperialGallons, property.getUnit(VOLUME.imperialGallons));
    runGetterTest(property.usGallons, property.getUnit(VOLUME.usGallons));
    runGetterTest(
        property.imperialPints, property.getUnit(VOLUME.imperialPints));
    runGetterTest(property.usPints, property.getUnit(VOLUME.usPints));
    runGetterTest(property.milliliters, property.getUnit(VOLUME.milliliters));
    runGetterTest(
        property.tablespoonsUs, property.getUnit(VOLUME.tablespoonsUs));
    runGetterTest(property.australianTablespoons,
        property.getUnit(VOLUME.australianTablespoons));
    runGetterTest(property.cups, property.getUnit(VOLUME.cups));
    runGetterTest(
        property.cubicCentimeters, property.getUnit(VOLUME.cubicCentimeters));
    runGetterTest(property.cubicFeet, property.getUnit(VOLUME.cubicFeet));
    runGetterTest(property.cubicInches, property.getUnit(VOLUME.cubicInches));
    runGetterTest(
        property.cubicMillimeters, property.getUnit(VOLUME.cubicMillimeters));
    runGetterTest(property.imperialFluidOunces,
        property.getUnit(VOLUME.imperialFluidOunces));
    runGetterTest(
        property.usFluidOunces, property.getUnit(VOLUME.usFluidOunces));
    runGetterTest(property.imperialGill, property.getUnit(VOLUME.imperialGill));
    runGetterTest(property.usGill, property.getUnit(VOLUME.usGill));
    runGetterTest(property.usQuarts, property.getUnit(VOLUME.usQuarts));
    runGetterTest(property.femtoliter, property.getUnit(VOLUME.femtoliters));
    runGetterTest(property.picoliter, property.getUnit(VOLUME.picoliters));
    runGetterTest(property.nanoliter, property.getUnit(VOLUME.nanoliters));
    runGetterTest(property.microliter, property.getUnit(VOLUME.microliters));
    runGetterTest(property.deciliter, property.getUnit(VOLUME.deciliters));
    runGetterTest(property.centiliter, property.getUnit(VOLUME.centiliters));
  });
}
