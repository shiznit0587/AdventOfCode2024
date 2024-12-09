import 'package:aoc/day1/day1.dart' as day1;
import 'package:aoc/day2/day2.dart' as day2;
import 'package:aoc/day3/day3.dart' as day3;
import 'package:aoc/day4/day4.dart' as day4;
import 'package:aoc/day5/day5.dart' as day5;
import 'package:aoc/day6/day6.dart' as day6;
import 'package:aoc/day7/day7.dart' as day7;

void main(List<String> arguments) async {
  print("\n🎅🎅🎅🎅🎅 ADVENT OF CODE 2024 🎅🎅🎅🎅🎅\n");

  final stopwatch = Stopwatch()..start();

  await runDay(1, day1.run);
  await runDay(2, day2.run);
  await runDay(3, day3.run);
  await runDay(4, day4.run);
  await runDay(5, day5.run);
  await runDay(6, day6.run);
  await runDay(7, day7.run);

  print('Total Time = ${stopwatch.elapsed}\n');
}

Future<void> runDay(int day, Future<void> Function() run) async {
  print('Running Day $day...');
  final stopwatch = Stopwatch()..start();
  await run();
  print('Day $day Time = ${stopwatch.elapsed}\n');
}
