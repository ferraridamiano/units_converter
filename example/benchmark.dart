import 'package:units_converter/units_converter.dart';

void main() {
  print('Starting Benchmark...');
  
  // 1. DoubleProperty Benchmark
  final length = Length();
  
  // Warmup
  for (int i = 0; i < 1000; i++) {
    length.convert(LENGTH.meters, 1.0);
  }

  final stopwatch = Stopwatch()..start();
  final iterations = 100000;
  
  for (int i = 0; i < iterations; i++) {
    length.convert(LENGTH.meters, 1.0);
  }
  stopwatch.stop();
  
  print('DoubleProperty (Length):');
  print('  Iterations: $iterations');
  print('  Time taken: ${stopwatch.elapsedMilliseconds} ms');
  print('  Operations per second: ${(iterations / stopwatch.elapsedMicroseconds * 1000000).toStringAsFixed(0)}');
  print('');

  // 2. RatioProperty Benchmark
  final speed = Speed();
  
  // Warmup
  for (int i = 0; i < 1000; i++) {
    speed.convert(SPEED.metersPerSecond, 1.0);
  }

  stopwatch.reset();
  stopwatch.start();
  
  for (int i = 0; i < iterations; i++) {
    speed.convert(SPEED.metersPerSecond, 1.0);
  }
  stopwatch.stop();

  print('RatioProperty (Speed):');
  print('  Iterations: $iterations');
  print('  Time taken: ${stopwatch.elapsedMilliseconds} ms');
  print('  Operations per second: ${(iterations / stopwatch.elapsedMicroseconds * 1000000).toStringAsFixed(0)}');
  print('');

  // 3. NumeralSystems Benchmark
  final numeralSystems = NumeralSystems();
  
  // Warmup
  for (int i = 0; i < 1000; i++) {
    numeralSystems.convert(NUMERAL_SYSTEMS.decimal, '100');
  }

  stopwatch.reset();
  stopwatch.start();
  
  for (int i = 0; i < iterations; i++) {
    numeralSystems.convert(NUMERAL_SYSTEMS.decimal, '100');
  }
  stopwatch.stop();

  print('NumeralSystems:');
  print('  Iterations: $iterations');
  print('  Time taken: ${stopwatch.elapsedMilliseconds} ms');
  print('  Operations per second: ${(iterations / stopwatch.elapsedMicroseconds * 1000000).toStringAsFixed(0)}');
}
