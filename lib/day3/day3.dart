import 'dart:collection';

import '../shared.dart';

Future<void> run() async {
  final input = (await readDay(3)).fold('', (a, b) => '$a$b');

  print('  Day 3 - Part 1');

  var result = RegExp(r'mul\((\d{1,3}),(\d{1,3})\)')
      .allMatches(input)
      .map((m) =>
          m.groups([1, 2]).map((i) => int.parse(i!)).fold(1, (a, b) => a * b))
      .fold(0, (a, b) => a + b);

  print('  Result = $result');

  print('  Day 3 - Part 2');

  final doOrDontMap = SplayTreeMap()..[0] = true;
  RegExp(r'do\(\)')
      .allMatches(input)
      .forEach((m) => doOrDontMap[m.start] = true);
  RegExp(r"don't\(\)")
      .allMatches(input)
      .forEach((m) => doOrDontMap[m.start] = false);

  result = RegExp(r'mul\((\d{1,3}),(\d{1,3})\)')
      .allMatches(input)
      .where((m) => doOrDontMap[doOrDontMap.lastKeyBefore(m.start)!])
      .map((m) =>
          m.groups([1, 2]).map((i) => int.parse(i!)).fold(1, (a, b) => a * b))
      .fold(0, (a, b) => a + b);

  print('  Result = $result');
}
