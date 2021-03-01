import 'package:test/test.dart';
import 'package:units_converter/units_converter.dart';

/// This function defines if a value is accettable. e.g. if we expect to have 1 but we get 1.00000000012, is this a valid result or not?
/// The term sensbility is used improperly.
bool isAcceptable(double convertedValue, double expectedValue, sensibility) {
  final double accuracy = expectedValue / sensibility;
  final double upperConstraint = expectedValue + accuracy;
  final double lowerConstraint = expectedValue - accuracy;
  return convertedValue >= lowerConstraint && convertedValue <= upperConstraint;
}

void runConversionTest(Map<dynamic, double> expectedResult, Property property, {double sensibility = 1e10}) {
  final List listNames = expectedResult.keys.toList();
  for (var unitName in listNames) {
    test('Test from ${unitName.toString()}', () {
      property.convert(unitName, expectedResult[unitName]);
      List<Unit> unitList = property.getAll();
      for (Unit unit in unitList) {
        var name = unit.name;
        double convertedValue = unitList.where((element) => element.name == name).single.value!;
        expect(
          isAcceptable(convertedValue, expectedResult[name]!, sensibility),
          true,
          reason: 'Error with ${name.toString()}. Expected: ${expectedResult[name]}, result: ${convertedValue}',
        );
      }
    });
    property.convert(listNames[0], null); //clear all values
  }
}

void main() {
  group('Angle conversion', () {
    const Map<ANGLE, double> expectedResult = {
      ANGLE.degree: 1,
      ANGLE.minutes: 60,
      ANGLE.seconds: 3600,
      ANGLE.radians: 0.01745329252,
    };
    runConversionTest(expectedResult, Angle());
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
    runConversionTest(expectedResult, Area());
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
    runConversionTest(expectedResult, DigitalData());
  });

  group('Energy', () {
    const Map<ENERGY, double> expectedResult = {
      ENERGY.joules: 1,
      ENERGY.calories: 0.2388459,
      ENERGY.kilowatt_hours: 2.7777777778e-7,
      ENERGY.electronvolts: 6.2415097523028e18,
    };
    runConversionTest(expectedResult, Energy());
  });

  group('Force', () {
    const Map<FORCE, double> expectedResult = {
      FORCE.newton: 1,
      FORCE.dyne: 1e5,
      FORCE.pound_force: 0.22480894309971,
      FORCE.kilogram_force: 0.10197162129779,
      FORCE.poundal: 7.2330138512099,
    };
    runConversionTest(expectedResult, Force());
  });

  group('Fuel consumption', () {
    const Map<FUEL_CONSUMPTION, double> expectedResult = {
      FUEL_CONSUMPTION.kilometers_per_liter: 1,
      FUEL_CONSUMPTION.liters_per_100_km: 100,
      FUEL_CONSUMPTION.miles_per_US_gallon: 2.3521458335008,
      FUEL_CONSUMPTION.miles_per_imperial_gallon: 2.8248093635947,
    };
    runConversionTest(expectedResult, FuelConsumption());
  });

  group('Lenght', () {
    const Map<LENGTH, double> expectedResult = {
      LENGTH.meters: 1,
      LENGTH.centimeters: 100,
      LENGTH.inches: 39.370078740157,
      LENGTH.feet: 3.2808398950131,
      LENGTH.nautical_miles: 0.00053995680345572,
      LENGTH.yards: 1.0936132983377,
      LENGTH.miles: 0.00062137119223733,
      LENGTH.millimeters: 1e3,
      LENGTH.micrometers: 1e6,
      LENGTH.nanometers: 1e9,
      LENGTH.angstroms: 1e10,
      LENGTH.picometers: 1e12,
      LENGTH.kilometers: 1e-3,
      LENGTH.astronomical_units: 6.6845871222684e-12,
      LENGTH.light_years: 1.057000451015e-16,
      LENGTH.parsec: 3.2423326718251e-17,
    };
    runConversionTest(expectedResult, Length());
  });

  group('Mass', () {
    const Map<MASS, double> expectedResult = {
      MASS.grams: 1,
      MASS.ettograms: 1e-2,
      MASS.kilograms: 1e-3,
      MASS.pounds: 0.0022046226218488,
      MASS.ounces: 0.03527396194958,
      MASS.quintals: 0.00001,
      MASS.tons: 0.000001,
      MASS.milligrams: 1e3,
      MASS.uma: 6.0221410036139e23,
      MASS.carats: 5,
      MASS.centigrams: 1e2,
      MASS.pennyweights: 0.6430149314,
      MASS.troy_ounces: 0.03215074657,
      MASS.stones: 0.0001574730444,
    };
    runConversionTest(expectedResult, Mass(), sensibility: 1e9);
  });

  group('Power', () {
    const Map<POWER, double> expectedResult = {
      POWER.watt: 1,
      POWER.milliwatt: 1000,
      POWER.kilowatt: 1e-3,
      POWER.megawatt: 1e-6,
      POWER.gigawatt: 1e-9,
      POWER.european_horse_power: 0.0013596216173039,
      POWER.imperial_horse_power: 0.0013410220895991,
    };
    runConversionTest(expectedResult, Power());
  });

  group('Shoe size', () {
    const Map<SHOE_SIZE, double> expectedResult = {
      SHOE_SIZE.centimeters: 25.167,
      SHOE_SIZE.inches: 9.908,
      SHOE_SIZE.eu_china: 40,
      SHOE_SIZE.uk_india_child: 19.724,
      SHOE_SIZE.uk_india_man: 6.724,
      SHOE_SIZE.uk_india_woman: 6.224,
      SHOE_SIZE.usa_canada_child: 13.391,
      SHOE_SIZE.usa_canada_man: 7.724,
      SHOE_SIZE.usa_canada_woman: 8.724,
      SHOE_SIZE.japan: 26.667,
    };
    runConversionTest(expectedResult, ShoeSize(), sensibility: 1e1);
  });
}
