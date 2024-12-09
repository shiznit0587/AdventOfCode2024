import 'dart:math';

import '../shared.dart';

typedef Equation = (int, List<int>);

Future<void> run() async {
  final equations = (await readDay(7)).map((l) {
    final parts = l.split(' ');
    final testValue = int.parse(parts[0].substring(0, parts[0].length - 1));
    final numbers = parts.sublist(1).map(int.parse).toList();
    return (testValue, numbers);
  }).toList();

  print('  Day 7 - Part 1');

  var total = 0;

  final operators = <int, List<List<Operator>>>{};

  final failedSet = <int>{};
  for (int i = 0; i < equations.length; ++i) {
    final (testValue, numbers) = equations[i];

    final opCount = numbers.length - 1;
    if (!operators.containsKey(opCount)) {
      operators[opCount] = buildOperatorLists(opCount);
    }

    bool passed = operators[opCount]!
        .map((ops) => applyOperators(numbers, ops))
        .any((r) => r == testValue);

    if (passed) {
      total += testValue;
    } else {
      failedSet.add(i);
    }
  }

  print('  Total calibration result = $total');

  print('  Day 7 - Part 2');

  operators.clear();

  for (int i in failedSet) {
    final (testValue, numbers) = equations[i];

    final opCount = numbers.length - 1;
    if (!operators.containsKey(opCount)) {
      operators[opCount] = buildOperatorLists2(opCount);
    }

    bool passed = operators[opCount]!
        .map((ops) => applyOperators(numbers, ops))
        .any((r) => r == testValue);

    total += passed ? testValue : 0;
  }

  print('  Total calibration result = $total');
}

int applyOperators(List<int> numbers, List<Operator> operators) {
  var result = numbers[0];
  for (var i = 0; i < operators.length; ++i) {
    result = operators[i].apply(result, numbers[i + 1]);
  }
  return result;
}

List<List<Operator>> buildOperatorLists(int count, [bool part2 = false]) {
  if (count == 0) {
    return [[]];
  }
  final List<List<Operator>> result = [];
  for (final op in Operator.values) {
    if (part2 || op != Operator.concat) {
      for (final list in buildOperatorLists(count - 1, part2)) {
        result.add([op, ...list]);
      }
    }
  }
  return result;
}

List<List<Operator>> buildOperatorLists2(int count) {
  return buildOperatorLists(count, true)
      .where((ops) => ops.contains(Operator.concat))
      .toList();
}

enum Operator {
  plus,
  mult,
  concat;

  int apply(int a, int b) {
    return switch (this) {
      plus => a + b,
      mult => a * b,
      concat => a * (pow(10, b.toString().length) as int) + b
    };
  }
}
