import 'package:test/test.dart';
import 'package:units_converter/units_converter.dart';

/// This function defines if a value is accettable. e.g. if we expect to have 1 but we get 1.00000000012, is this a valid result or not?
/// The term sensibility is used improperly.
bool isAcceptable(double? convertedValue, double? expectedValue, sensibility) {
  if ((convertedValue == null && expectedValue != null) ||
      (convertedValue != null && expectedValue == null)) {
    return false;
  }
  final double accuracy = expectedValue! / sensibility;
  final double upperConstraint = expectedValue + accuracy;
  final double lowerConstraint = expectedValue - accuracy;
  return convertedValue! >= lowerConstraint &&
      convertedValue <= upperConstraint;
}

void runConversionTest(Map<dynamic, double> expectedResult, Property property,
    {double sensibility = 1e10}) {
  final List listNames = expectedResult.keys.toList();
  for (var unitName in listNames) {
    test('Test from ${unitName.toString()}', () {
      property.convert(unitName, expectedResult[unitName]);
      List<Unit> unitList = property.getAll();
      for (Unit unit in unitList) {
        var name = unit.name;
        double? convertedValue =
            unitList.where((element) => element.name == name).single.value;
        expect(
          isAcceptable(convertedValue, expectedResult[name]!, sensibility),
          true,
          reason:
              'Error with ${name.toString()}. Expected: ${expectedResult[name]}, result: $convertedValue',
        );
      }
    });
  }
  for (var unitName in listNames) {
    test('Test from ${unitName.toString()}', () {
      property.convert(unitName, null);
      List<Unit> unitList = property.getAll();
      for (Unit unit in unitList) {
        var name = unit.name;
        double? convertedValue =
            unitList.where((element) => element.name == name).single.value;
        expect(
          convertedValue,
          null,
          reason:
              'Error with ${name.toString()}. Expected: null, result: $convertedValue',
        );
      }
    });
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
      AREA.squareMeters: 1,
      AREA.squareCentimeters: 1e4,
      AREA.squareInches: 1550.0031,
      AREA.squareFeet: 10.76391041671,
      AREA.squareFeetUs: 10.763867361197223,
      AREA.squareMiles: 3.8610215854245e-7,
      AREA.squareYard: 1.1959900463011,
      AREA.squareMillimeters: 1e6,
      AREA.squareKilometers: 1e-6,
      AREA.hectares: 1e-4,
      AREA.acres: 0.00024710538146717,
      AREA.are: 0.01,
    };
    runConversionTest(expectedResult, Area());
  });

  group('Density conversion', () {
    const Map<DENSITY, double> expectedResult = {
      DENSITY.gramsPerLiter: 1,
      DENSITY.gramsPerCubicCentimeter: 0.001,
      DENSITY.gramsPerMilliliter: 0.001,
      DENSITY.gramsPerDeciliter: 0.1,
      DENSITY.kilogramsPerLiter: 0.001,
      DENSITY.kilogramsPerCubicMeter: 1,
      DENSITY.milligramsPerLiter: 1000,
      DENSITY.milligramsPerDeciliter: 100,
      DENSITY.milligramsPerMilliliter: 1,
      DENSITY.milligramsPerCubicMeter: 1e6,
      DENSITY.milligramsPerCubicCentimeter: 1,
      DENSITY.microgramsPerLiter: 1e6,
      DENSITY.microgramsPerDeciliter: 1e5,
      DENSITY.microgramsPerMilliliter: 1e3,
      DENSITY.nanogramsPerLiter: 1e9,
      DENSITY.nanogramsPerMilliliter: 1e6,
      DENSITY.picogramsPerLiter: 1e12,
      DENSITY.picogramsPerMilliliter: 1e9,
    };
    runConversionTest(expectedResult, Density());
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
      ENERGY.kilocalories: 0.0002388459,
      ENERGY.kilowattHours: 2.7777777778e-7,
      ENERGY.electronvolts: 6.2415097523028e18,
      ENERGY.energyFootPound: 0.7375621493,
    };
    runConversionTest(expectedResult, Energy());
  });

  group('Force', () {
    const Map<FORCE, double> expectedResult = {
      FORCE.newton: 1,
      FORCE.dyne: 1e5,
      FORCE.poundForce: 0.22480894309971,
      FORCE.kilogramForce: 0.10197162129779,
      FORCE.poundal: 7.2330138512099,
    };
    runConversionTest(expectedResult, Force());
  });

  group('Fuel consumption', () {
    const Map<FUEL_CONSUMPTION, double> expectedResult = {
      FUEL_CONSUMPTION.kilometersPerLiter: 1,
      FUEL_CONSUMPTION.litersPer100km: 100,
      FUEL_CONSUMPTION.milesPerUsGallon: 2.3521458335008,
      FUEL_CONSUMPTION.milesPerImperialGallon: 2.8248093635947,
    };
    runConversionTest(expectedResult, FuelConsumption());
  });

  group('Length', () {
    const Map<LENGTH, double> expectedResult = {
      LENGTH.meters: 1,
      LENGTH.centimeters: 100,
      LENGTH.inches: 39.370078740157,
      LENGTH.feet: 3.2808398950131,
      LENGTH.feetUs: 3.280833333346457,
      LENGTH.nauticalMiles: 0.00053995680345572,
      LENGTH.yards: 1.0936132983377,
      LENGTH.miles: 0.00062137119223733,
      LENGTH.millimeters: 1e3,
      LENGTH.micrometers: 1e6,
      LENGTH.nanometers: 1e9,
      LENGTH.angstroms: 1e10,
      LENGTH.picometers: 1e12,
      LENGTH.kilometers: 1e-3,
      LENGTH.astronomicalUnits: 6.6845871222684e-12,
      LENGTH.lightYears: 1.057000451015e-16,
      LENGTH.parsec: 3.2423326718251e-17,
      LENGTH.mils: 39370.0787401574803,
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
      MASS.troyOunces: 0.03215074657,
      MASS.stones: 0.0001574730444,
      MASS.femtograms: 1e15,
      MASS.picograms: 1e12,
      MASS.nanograms: 1e9,
      MASS.micrograms: 1e6,
      MASS.decigrams: 10,
    };
    runConversionTest(expectedResult, Mass(), sensibility: 1e9);
  });

  group('Molar Mass conversion', () {
    const Map<MOLAR_MASS, double> expectedResult = {
      MOLAR_MASS.gramsPerMole: 1,
      MOLAR_MASS.gramsPerMillimole: 1e-3,
      MOLAR_MASS.gramsPerMicromole: 1e-6,
      MOLAR_MASS.gramsPerNanomole: 1e-9,
      MOLAR_MASS.gramsPerPicomole: 1e-12,
      MOLAR_MASS.gramsPerFemtomole: 1e-15,
      MOLAR_MASS.milligramsPerMole: 1e3,
      MOLAR_MASS.milligramsPerMillimole: 1,
      MOLAR_MASS.milligramsPerMicromole: 1e-3,
      MOLAR_MASS.milligramsPerNanomole: 1e-6,
      MOLAR_MASS.milligramsPerPicomole: 1e-9,
      MOLAR_MASS.milligramsPerFemtomole: 1e-12,
      MOLAR_MASS.kilogramsPerMole: 1e-3,
      MOLAR_MASS.kilogramsPerMillimole: 1e-6,
    };
    runConversionTest(expectedResult, MolarMass());
  });

  group('Molar Volume conversion', () {
    const Map<MOLAR_VOLUME, double> expectedResult = {
      MOLAR_VOLUME.molesPerLiter: 1,
      MOLAR_VOLUME.molesPerMilliliter: 1e-3,
      MOLAR_VOLUME.molesPerCubicMeter: 1000,
      MOLAR_VOLUME.millimolesPerLiter: 1000,
      MOLAR_VOLUME.millimolesPerDeciliter: 100,
      MOLAR_VOLUME.micromolesPerLiter: 1e6,
      MOLAR_VOLUME.micromolesPerDeciliter: 1e5,
      MOLAR_VOLUME.micromolesPerMilliliter: 1e3,
      MOLAR_VOLUME.nanomolesPerLiter: 1e9,
      MOLAR_VOLUME.nanomolesPerDeciliter: 1e8,
      MOLAR_VOLUME.nanomolesPerMilliliter: 1e6,
      MOLAR_VOLUME.picomolesPerLiter: 1e12,
      MOLAR_VOLUME.picomolesPerDeciliter: 1e11,
      MOLAR_VOLUME.picomolesPerMilliliter: 1e9,
      MOLAR_VOLUME.femtomolesPerMilliliter: 1e12
    };
    runConversionTest(expectedResult, MolarVolume());
  });

  group('Numeral systems', () {
    const Map<NUMERAL_SYSTEMS, String> expectedResult = {
      NUMERAL_SYSTEMS.decimal: '178897',
      NUMERAL_SYSTEMS.hexadecimal: '2BAD1',
      NUMERAL_SYSTEMS.octal: '535321',
      NUMERAL_SYSTEMS.binary: '101011101011010001',
    };
    NumeralSystems property = NumeralSystems();
    final List listNames = expectedResult.keys.toList();
    for (var unitName in listNames) {
      test('Test from ${unitName.toString()}', () {
        property.convert(unitName, expectedResult[unitName]);
        List<Unit> unitList = property.getAll();
        for (Unit unit in unitList) {
          var name = unit.name;
          String? convertedValue = unitList
              .where((element) => element.name == name)
              .single
              .stringValue!;
          expect(
            convertedValue,
            expectedResult[name],
            reason:
                'Error with ${name.toString()}. Expected: ${expectedResult[name]}, result: $convertedValue',
          );
        }
      });
      property.convert(listNames[0], null); //clear all values
    }
    for (var unitName in listNames) {
      test('Test from ${unitName.toString()}', () {
        property.convert(unitName, null);
        List<Unit> unitList = property.getAll();
        for (Unit unit in unitList) {
          var name = unit.name;
          String? convertedValue = unitList
              .where((element) => element.name == name)
              .single
              .stringValue;
          expect(
            convertedValue,
            null,
            reason:
                'Error with ${name.toString()}. Expected: null, result: $convertedValue',
          );
        }
      });
    }
  });

  group('Power', () {
    const Map<POWER, double> expectedResult = {
      POWER.watt: 1,
      POWER.milliwatt: 1000,
      POWER.kilowatt: 1e-3,
      POWER.megawatt: 1e-6,
      POWER.gigawatt: 1e-9,
      POWER.europeanHorsePower: 0.0013596216173039,
      POWER.imperialHorsePower: 0.0013410220895991,
    };
    runConversionTest(expectedResult, Power());
  });

  group('Pressure', () {
    const Map<PRESSURE, double> expectedResult = {
      PRESSURE.pascal: 1,
      PRESSURE.atmosphere: 1 / 101325,
      PRESSURE.bar: 1e-5,
      PRESSURE.millibar: 1e-2,
      PRESSURE.psi: 0.00014503773773,
      PRESSURE.torr: 0.00750061682704,
      PRESSURE.hectoPascal: 1e-2,
      PRESSURE.inchOfMercury: 0.00029529987508,
    };
    runConversionTest(expectedResult, Pressure());
  });

  group('Reciprocal OF Molar Mass conversion', () {
    const Map<RECIPROCAL_OF_MOLAR_MASS, double> expectedResult = {
      RECIPROCAL_OF_MOLAR_MASS.molesPerGram: 1,
      RECIPROCAL_OF_MOLAR_MASS.millimolesPerGram: 1e3,
      RECIPROCAL_OF_MOLAR_MASS.micromolesPerGram: 1e6,
      RECIPROCAL_OF_MOLAR_MASS.nanomolesPerGram: 1e9,
      RECIPROCAL_OF_MOLAR_MASS.picomolesPerGram: 1e12,
      RECIPROCAL_OF_MOLAR_MASS.femtomolesPerGram: 1e15,
      RECIPROCAL_OF_MOLAR_MASS.molesPerMilligram: 1e-3,
      RECIPROCAL_OF_MOLAR_MASS.millimolesPerMilligram: 1,
      RECIPROCAL_OF_MOLAR_MASS.micromolesPerMilligram: 1e3,
      RECIPROCAL_OF_MOLAR_MASS.nanomolesPerMilligram: 1e6,
      RECIPROCAL_OF_MOLAR_MASS.picomolesPerMilligram: 1e9,
      RECIPROCAL_OF_MOLAR_MASS.femtomolesPerMilligram: 1e12,
      RECIPROCAL_OF_MOLAR_MASS.molesPerKilogram: 1e3,
      RECIPROCAL_OF_MOLAR_MASS.millimolesPerKilogram: 1e6,
    };
    runConversionTest(expectedResult, ReciprocalOfMolarMass());
  });

  group('Shoe size', () {
    const Map<SHOE_SIZE, double> expectedResult = {
      SHOE_SIZE.centimeters: 25.167,
      SHOE_SIZE.inches: 9.908,
      SHOE_SIZE.euChina: 40,
      SHOE_SIZE.ukIndiaChild: 19.724,
      SHOE_SIZE.ukIndiaMan: 6.724,
      SHOE_SIZE.ukIndiaWoman: 6.224,
      SHOE_SIZE.usaCanadaChild: 13.391,
      SHOE_SIZE.usaCanadaMan: 7.724,
      SHOE_SIZE.usaCanadaWoman: 8.724,
      SHOE_SIZE.japan: 26.667,
    };
    runConversionTest(expectedResult, ShoeSize(), sensibility: 1e1);
  });

  group('SI prefixes', () {
    const Map<SI_PREFIXES, double> expectedResult = {
      SI_PREFIXES.base: 1,
      SI_PREFIXES.deca: 1e-1,
      SI_PREFIXES.hecto: 1e-2,
      SI_PREFIXES.kilo: 1e-3,
      SI_PREFIXES.mega: 1e-6,
      SI_PREFIXES.giga: 1e-9,
      SI_PREFIXES.tera: 1e-12,
      SI_PREFIXES.peta: 1e-15,
      SI_PREFIXES.exa: 1e-18,
      SI_PREFIXES.zetta: 1e-21,
      SI_PREFIXES.yotta: 1e-24,
      SI_PREFIXES.deci: 1e1,
      SI_PREFIXES.centi: 1e2,
      SI_PREFIXES.milli: 1e3,
      SI_PREFIXES.micro: 1e6,
      SI_PREFIXES.nano: 1e9,
      SI_PREFIXES.pico: 1e12,
      SI_PREFIXES.femto: 1e15,
      SI_PREFIXES.atto: 1e18,
      SI_PREFIXES.zepto: 1e21,
      SI_PREFIXES.yocto: 1e24,
    };
    runConversionTest(expectedResult, SIPrefixes());
  });

  group('Speed', () {
    const Map<SPEED, double> expectedResult = {
      SPEED.metersPerSecond: 1,
      SPEED.kilometersPerHour: 3.6,
      SPEED.milesPerHour: 2.2369362920544,
      SPEED.knots: 1.9438444924406,
      SPEED.feetsPerSecond: 3.2808398950131,
      SPEED.minutesPerKilometer: 60 / 3.6,
    };
    runConversionTest(expectedResult, Speed());
  });

  group('Temperature', () {
    const Map<TEMPERATURE, double> expectedResult = {
      TEMPERATURE.fahrenheit: 33.8,
      TEMPERATURE.celsius: 1,
      TEMPERATURE.kelvin: 274.15,
      TEMPERATURE.reamur: 0.8,
      TEMPERATURE.romer: 8.025,
      TEMPERATURE.delisle: 148.5,
      TEMPERATURE.rankine: 493.47,
    };
    runConversionTest(expectedResult, Temperature());
  });

  group('Time', () {
    const Map<TIME, double> expectedResult = {
      TIME.seconds: 1,
      TIME.deciseconds: 10,
      TIME.centiseconds: 100,
      TIME.milliseconds: 1e3,
      TIME.microseconds: 1e6,
      TIME.nanoseconds: 1e9,
      TIME.minutes: 1 / 60,
      TIME.hours: 1 / (60 * 60),
      TIME.days: 1 / (60 * 60 * 24),
      TIME.weeks: 1 / (60 * 60 * 24 * 7),
      TIME.years365: 1 / (60 * 60 * 24 * 365),
      TIME.lustrum: 1 / (60 * 60 * 24 * 365 * 5),
      TIME.decades: 1 / (60 * 60 * 24 * 365 * 10),
      TIME.centuries: 1 / (60 * 60 * 24 * 365 * 100),
      TIME.millennium: 1 / (60 * 60 * 24 * 365 * 1000),
    };
    runConversionTest(expectedResult, Time());
  });

  group('Torque', () {
    const Map<TORQUE, double> expectedResult = {
      TORQUE.newtonMeter: 1,
      TORQUE.dyneMeter: 1e5,
      TORQUE.poundForceFeet: 0.7375621489,
      TORQUE.kilogramForceMeter: 0.10196798205364,
      TORQUE.poundalMeter: 7.2330138512099,
    };
    runConversionTest(expectedResult, Torque());
  });

  group('Volume', () {
    const Map<VOLUME, double> expectedResult = {
      VOLUME.cubicMeters: 1,
      VOLUME.liters: 1e3,
      VOLUME.imperialGallons: 219.96924829909,
      VOLUME.usGallons: 264.17205235815,
      VOLUME.imperialPints: 1759.7539863927,
      VOLUME.usPints: 2113.3764188652,
      VOLUME.milliliters: 1e6,
      VOLUME.tablespoonsUs: 67567.567567568,
      VOLUME.australianTablespoons: 50000,
      VOLUME.cups: 4166.6666666667,
      VOLUME.cubicCentimeters: 1e6,
      VOLUME.cubicFeet: 35.314666721489,
      VOLUME.cubicInches: 61023.744094732,
      VOLUME.cubicMillimeters: 1e9,
      VOLUME.imperialFluidOunces: 35195.07973,
      VOLUME.usFluidOunces: 33814.0227,
      VOLUME.imperialGill: 7039.015946,
      VOLUME.usGill: 8453.505675,
      VOLUME.usQuarts: 1056.6882094325938,
      VOLUME.femtoliters: 1e18,
      VOLUME.picoliters: 1e15,
      VOLUME.nanoliters: 1e12,
      VOLUME.microliters: 1e9,
      VOLUME.deciliters: 1e4,
      VOLUME.centiliters: 1e5,
    };
    runConversionTest(expectedResult, Volume(), sensibility: 1e9);
  });

  group('Amount of Substance', () {
    const Map<AMOUNT_OF_SUBSTANCE, double> expectedResult = {
      AMOUNT_OF_SUBSTANCE.moles: 1,
      AMOUNT_OF_SUBSTANCE.millimoles: 1e3,
      AMOUNT_OF_SUBSTANCE.micromoles: 1e6,
      AMOUNT_OF_SUBSTANCE.nanomoles: 1e9,
      AMOUNT_OF_SUBSTANCE.picomoles: 1e12,
      AMOUNT_OF_SUBSTANCE.femtomoles: 1e15,
    };
    runConversionTest(expectedResult, AmountOfSubstance());
  });

  group('Simple custom conversion', () {
    const Map<String, double> expectedResult = {
      'EUR': 1,
      'CAD': 1.5213,
      'HKD': 9.3363,
      'RUB': 88.6563,
      'USD': 1.2034,
      'GBP': 0.8627,
    };
    const Map<String, String> mapSymbol = {
      'EUR': '€',
      'CAD': '\$',
      'HKD': 'HK\$',
      'RUB': '₽',
      'USD': '\$',
      'GBP': '£',
    };
    runConversionTest(expectedResult,
        SimpleCustomProperty(expectedResult, mapSymbols: mapSymbol));
    // We use it with null symbols
    var conversion = SimpleCustomProperty(expectedResult)..convert('EUR', 1);
    // test single units
    expectedResult.forEach((key, value) {
      test(
        'Test single unit: $key',
        () {
          expect(isAcceptable(conversion.getUnit(key).value, value, 1e10), true,
              reason: 'Failed single unit test:($key)');
        },
      );
    });
  });
}
