import 'package:test/test.dart';
import 'package:units_converter/units_converter.dart';

/// This function defines if a value is accettable. e.g. if we expect to have 1 but we get 1.00000000012, is this a valid result or not?
/// The term sensbility is used improperly.
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

/*bool areComparable(String value1, String value2){
  assert(!value1.contains('e') && !value2.contains('e'));
  String integer1, integer2, decimal1, decimal2;
  if(value1.contains('.')){
    var splittedString = value1.split('.');
    integer1 = splittedString[0];
    decimal1 = splittedString[1];
  } else {
    integer1 = value1;
    decimal1 = '';
  }
  if(value2.contains('.')){
    var splittedString = value2.split('.');
    integer2 = splittedString[0];
    decimal2 = splittedString[1];
  } else {
    integer2 = value1;
    decimal2 = '';
  }
}*/

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

void runStringConversionTest(
  Map<dynamic, String> expectedResult,
  Property property, {
  double sensibility = 1e10,
}) {
  final List listNames = expectedResult.keys.toList();
  for (var unitName in listNames) {
    test('Test from ${unitName.toString()}', () {
      property.convertFromString(unitName, expectedResult[unitName]);
      List<Unit> unitList = property.getAll();
      for (Unit unit in unitList) {
        var name = unit.name;
        String? convertedValue = unitList
            .where((element) => element.name == name)
            .single
            .stringValue;
        expect(
          convertedValue != null,
          true,
          reason: 'Expected $convertedValue to be not null.',
        );
        expect(
          isAcceptable(double.parse(convertedValue!),
              double.parse(expectedResult[name]!), sensibility),
          true,
          reason:
              'Error with ${name.toString()}. Expected: ${expectedResult[name]}, result: $convertedValue',
        );
        /*if (convertedValue!.length > 8) {
          int lenghtToKeep =
              math.min(convertedValue.length, expectedResult[name]!.length) - 1;

          String unit1 = convertedValue.substring(0, lenghtToKeep);
          String unit2 = expectedResult[name]!.substring(0, lenghtToKeep);

          expect(
            unit1,
            unit2,
            reason:
                'Error with ${name.toString()}. Expected: $unit2, result: $unit1',
          );
        }*/
      }
    });
  }
  for (var unitName in listNames) {
    test('Test from ${unitName.toString()}', () {
      property.convertFromString(unitName, null);
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
    const Map<ANGLE, String> expectedResult = {
      ANGLE.degree: '1',
      ANGLE.minutes: '60',
      ANGLE.seconds: '3600',
      ANGLE.radians: '0.0174532925199684',
    };
    runStringConversionTest(expectedResult, Angle(significantFigures: 15));
  });

  group('Area conversion', () {
    const Map<AREA, String> expectedResult = {
      AREA.squareMeters: '1',
      AREA.squareCentimeters: '10000',
      AREA.squareInches: '1550.003100006',
      AREA.squareFeet: '10.76391041671',
      AREA.squareYard: '1.195990046301',
      AREA.squareMiles: '0.0000003861021585424',
      AREA.acres: '0.0002471053814672',
      AREA.squareFeetUs: '10.7638673612',
      AREA.squareMillimeters: '1000000',
      AREA.hectares: '0.0001',
      AREA.squareKilometers: '0.000001',
      AREA.are: '0.01',
    };

    runStringConversionTest(expectedResult, Area(significantFigures: 15));
  });

  group('Digital data conversion', () {
    const Map<DIGITAL_DATA, String> expectedResult = {
      DIGITAL_DATA.bit: '8000000',
      DIGITAL_DATA.nibble: '2000000',
      DIGITAL_DATA.kilobit: '8000',
      DIGITAL_DATA.megabit: '8',
      DIGITAL_DATA.gigabit: '0.008',
      DIGITAL_DATA.terabit: '0.000008',
      DIGITAL_DATA.petabit: '0.000000008',
      DIGITAL_DATA.exabit: '0.000000000008',
      DIGITAL_DATA.kibibit: '7812.5',
      DIGITAL_DATA.mebibit: '7.62939453125',
      DIGITAL_DATA.gibibit: '0.00745058059692383',
      DIGITAL_DATA.tebibit: '0.00000727595761418343',
      DIGITAL_DATA.pebibit: '0.000000007105427357601',
      DIGITAL_DATA.exbibit: '0.00000000000693889390390723',
      DIGITAL_DATA.byte: '1000000',
      DIGITAL_DATA.kilobyte: '1000',
      DIGITAL_DATA.megabyte: '1',
      DIGITAL_DATA.gigabyte: '0.001',
      DIGITAL_DATA.terabyte: '0.000001',
      DIGITAL_DATA.petabyte: '0.000000001',
      DIGITAL_DATA.exabyte: '0.000000000001',
      DIGITAL_DATA.kibibyte: '976.5625',
      DIGITAL_DATA.mebibyte: '0.95367431640625',
      DIGITAL_DATA.gibibyte: '0.000931322574615479',
      DIGITAL_DATA.tebibyte: '0.000000909494701772928',
      DIGITAL_DATA.pebibyte: '0.000000000888178419700125',
      DIGITAL_DATA.exbibyte: '0.000000000000867361737988404',
    };
    runStringConversionTest(
        expectedResult, DigitalData(significantFigures: 15));
  });

  group('Energy', () {
    const Map<ENERGY, String> expectedResult = {
      ENERGY.joules: '1',
      ENERGY.calories: '0.238845899998995',
      ENERGY.kilocalories: '0.000238845899998995',
      ENERGY.kilowattHours: '0.000000277777777777778',
      ENERGY.electronvolts: '6241509074460760000',
      ENERGY.energyFootPound: '0.737562149277265',
    };
    runStringConversionTest(expectedResult, Energy(significantFigures: 15));
  });

  group('Force', () {
    const Map<FORCE, String> expectedResult = {
      FORCE.newton: '1',
      FORCE.dyne: '100000',
      FORCE.poundForce: '0.22480894309971',
      FORCE.kilogramForce: '0.101971621297793',
      FORCE.poundal: '7.23301385120989',
    };
    runStringConversionTest(expectedResult, Force(significantFigures: 15));
  });

  group('Fuel consumption', () {
    const Map<FUEL_CONSUMPTION, String> expectedResult = {
      FUEL_CONSUMPTION.kilometersPerLiter: '1',
      FUEL_CONSUMPTION.litersPer100km: '100',
      FUEL_CONSUMPTION.milesPerUsGallon: '2.35214583350082',
      FUEL_CONSUMPTION.milesPerImperialGallon: '2.82480936359469',
    };
    runStringConversionTest(
        expectedResult, FuelConsumption(significantFigures: 15));
  });

  group('Lenght', () {
    const Map<LENGTH, String> expectedResult = {
      LENGTH.meters: '1',
      LENGTH.centimeters: '100',
      LENGTH.inches: '39.3700787401575',
      LENGTH.feet: '3.28083989501312',
      LENGTH.yards: '1.09361329833771',
      LENGTH.miles: '0.000621371192237334',
      LENGTH.feetUs: '3.28083333334646',
      LENGTH.mils: '39370.0787401575',
      LENGTH.nauticalMiles: '0.000539956803455724',
      LENGTH.millimeters: '1000',
      LENGTH.micrometers: '1000000',
      LENGTH.nanometers: '1000000000',
      LENGTH.angstroms: '10000000000',
      LENGTH.picometers: '1000000000000',
      LENGTH.kilometers: '0.001',
      LENGTH.astronomicalUnits: '0.00000000000668458712226845',
      LENGTH.lightYears: '0.0000000000000001057000451015',
      LENGTH.parsec: '0.0000000000000000324233267182514',
    };
    runStringConversionTest(expectedResult, Length(significantFigures: 15));
  });

  group('Mass', () {
    const Map<MASS, String> expectedResult = {
      MASS.grams: '1000',
      MASS.ettograms: '10',
      MASS.kilograms: '1',
      MASS.pounds: '2.20462262184878',
      MASS.ounces: '35.2739619495804',
      MASS.stones: '0.15747304441777',
      MASS.quintals: '0.01',
      MASS.tons: '0.001',
      MASS.centigrams: '100000',
      MASS.milligrams: '1000000',
      MASS.uma: '602214100361389000000000000',
      MASS.carats: '5000',
      MASS.pennyweights: '643.01493137256',
      MASS.troyOunces: '32.150746568628',
    };
    runStringConversionTest(expectedResult, Mass(significantFigures: 15));
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
    const Map<POWER, String> expectedResult = {
      POWER.watt: '1',
      POWER.milliwatt: '1000',
      POWER.kilowatt: '0.001',
      POWER.megawatt: '0.000001',
      POWER.gigawatt: '0.000000001',
      POWER.europeanHorsePower: '0.0013596216173039',
      POWER.imperialHorsePower: '0.00134102208959911',
    };
    runStringConversionTest(expectedResult, Power(significantFigures: 15));
  });

  group('Pressure', () {
    const Map<PRESSURE, String> expectedResult = {
      PRESSURE.pascal: '1',
      PRESSURE.bar: '0.00001',
      PRESSURE.millibar: '0.01',
      PRESSURE.atmosphere: '0.00000986923266716013',
      PRESSURE.psi: '0.000145037737730217',
      PRESSURE.torr: '0.00750061682704466',
      PRESSURE.inchOfMercury: '0.000295299875080498',
      PRESSURE.hectoPascal: '0.01',
    };
    runStringConversionTest(expectedResult, Pressure(significantFigures: 15));
  });

  group('Shoe size', () {
    const Map<SHOE_SIZE, String> expectedResult = {
      SHOE_SIZE.centimeters: '25.1666666666667',
      SHOE_SIZE.euChina: '40',
      SHOE_SIZE.inches: '9.90813648293963',
      SHOE_SIZE.ukIndiaChild: '19.7244094488189',
      SHOE_SIZE.ukIndiaMan: '6.7244094488189',
      SHOE_SIZE.ukIndiaWoman: '6.2244094488189',
      SHOE_SIZE.usaCanadaChild: '13.3910761154856',
      SHOE_SIZE.usaCanadaMan: '7.7244094488189',
      SHOE_SIZE.usaCanadaWoman: '8.7244094488189',
      SHOE_SIZE.japan: '26.6666666666667',
    };
    runStringConversionTest(expectedResult, ShoeSize(significantFigures: 15),
        sensibility: 1e1);
  });

  group('SI prefixes', () {
    const Map<SI_PREFIXES, String> expectedResult = {
      SI_PREFIXES.base: '1',
      SI_PREFIXES.deca: '0.1',
      SI_PREFIXES.hecto: '0.01',
      SI_PREFIXES.kilo: '0.001',
      SI_PREFIXES.mega: '0.000001',
      SI_PREFIXES.giga: '0.000000001',
      SI_PREFIXES.tera: '0.000000000001',
      SI_PREFIXES.peta: '0.000000000000001',
      SI_PREFIXES.exa: '0.000000000000000001',
      SI_PREFIXES.zetta: '0.000000000000000000001',
      SI_PREFIXES.yotta: '0.000000000000000000000001',
      SI_PREFIXES.deci: '10',
      SI_PREFIXES.centi: '100',
      SI_PREFIXES.milli: '1000',
      SI_PREFIXES.micro: '1000000',
      SI_PREFIXES.nano: '1000000000',
      SI_PREFIXES.pico: '1000000000000',
      SI_PREFIXES.femto: '1000000000000000',
      SI_PREFIXES.atto: '1000000000000000000',
      SI_PREFIXES.zepto: '1000000000000000000000',
      SI_PREFIXES.yocto: '1000000000000000000000000',
    };
    runStringConversionTest(expectedResult, SIPrefixes(significantFigures: 15));
  });

  group('Speed', () {
    const Map<SPEED, String> expectedResult = {
      SPEED.metersPerSecond: '1',
      SPEED.kilometersPerHour: '3.6',
      SPEED.milesPerHour: '2.2369362920544',
      SPEED.knots: '1.9438444924406',
      SPEED.minutesPerKilometer: '16.6666666666667',
      SPEED.feetsPerSecond: '3.28083989501312',
    };
    runStringConversionTest(expectedResult, Speed(significantFigures: 15));
  });

  group('Temperature', () {
    const Map<TEMPERATURE, String> expectedResult = {
      TEMPERATURE.fahrenheit: '68',
      TEMPERATURE.celsius: '20',
      TEMPERATURE.kelvin: '293.15',
      TEMPERATURE.reamur: '16',
      TEMPERATURE.romer: '18',
      TEMPERATURE.delisle: '120',
      TEMPERATURE.rankine: '527.67',
    };
    runStringConversionTest(
        expectedResult, Temperature(significantFigures: 15));
  });

  group('Time', () {
    const Map<TIME, String> expectedResult = {
      TIME.seconds: '1',
      TIME.deciseconds: '10',
      TIME.centiseconds: '100',
      TIME.milliseconds: '1000',
      TIME.microseconds: '1000000',
      TIME.nanoseconds: '1000000000',
      TIME.minutes: '0.0166666666666667',
      TIME.hours: '0.000277777777777778',
      TIME.days: '0.0000115740740740741',
      TIME.weeks: '0.00000165343915343915',
      TIME.years365: '0.0000000317097919837646',
      TIME.lustrum: '0.00000000634195839675292',
      TIME.decades: '0.00000000317097919837646',
      TIME.centuries: '0.000000000317097919837646',
      TIME.millennium: '0.0000000000317097919837646',
    };
    runStringConversionTest(expectedResult, Time(significantFigures: 15));
  });

  group('Torque', () {
    const Map<TORQUE, String> expectedResult = {
      TORQUE.newtonMeter: '1',
      TORQUE.dyneMeter: '100000',
      TORQUE.poundForceFeet: '0.7375621489',
      TORQUE.kilogramForceMeter: '0.101967982053635',
      TORQUE.poundalMeter: '7.23301385120989',
    };
    runStringConversionTest(expectedResult, Torque(significantFigures: 15));
  });

  group('Volume', () {
    const Map<VOLUME, String> expectedResult = {
      VOLUME.cubicMeters: '1',
      VOLUME.liters: '1000',
      VOLUME.imperialGallons: '219.969248299088',
      VOLUME.usGallons: '264.172052358148',
      VOLUME.imperialPints: '1759.7539863927',
      VOLUME.imperialFluidOunces: '35195.079727854',
      VOLUME.imperialGill: '7039.01594557081',
      VOLUME.usPints: '2113.37641886519',
      VOLUME.usFluidOunces: '33814.022701843',
      VOLUME.usGill: '8453.50567546075',
      VOLUME.milliliters: '1000000',
      VOLUME.tablespoonsUs: '67567.5675675676',
      VOLUME.australianTablespoons: '50000',
      VOLUME.cups: '4166.66666666667',
      VOLUME.cubicCentimeters: '1000000',
      VOLUME.cubicInches: '61023.7440947323',
      VOLUME.cubicFeet: '35.3146667214886',
      VOLUME.cubicMillimeters: '1000000000',
    };
    runStringConversionTest(expectedResult, Volume(significantFigures: 15),
        sensibility: 1e9);
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
