import 'package:aoc/day1/day1.dart' as day1;
import 'package:aoc/day2/day2.dart' as day2;

void main(List<String> arguments) async {

  print("\n🎅🎅🎅🎅🎅 ADVENT OF CODE 2024 🎅🎅🎅🎅🎅\n");

  final stopwatch = Stopwatch()..start();

  await runDay(1, day1.run);
  await runDay(2, day2.run);

  print('Total Time = ${stopwatch.elapsed}\n');
}

Future<void> runDay(int day, Future<void> Function() run) async {
  print('Running Day $day...');
  final stopwatch = Stopwatch()..start();
  await run();
  print('Day $day Time = ${stopwatch.elapsed}\n');
}
