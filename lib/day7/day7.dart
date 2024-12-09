import '../shared.dart';

Future<void> run() async {
  final lines = await readDay(7);

  print('  Day 7 - Part 1');

  var total = 0;

  final operators = <int, List<List<Operator>>>{};

  for (final line in lines) {
    final parts = line.split(' ');
    final testValue = int.parse(parts[0].substring(0, parts[0].length - 1));
    final numbers = parts.sublist(1).map(int.parse).toList();

    final opCount = numbers.length - 1;
    if (!operators.containsKey(opCount)) {
      operators[opCount] = buildOperatorLists(opCount).toList();
    }

    bool passed = operators[opCount]!
        .map((ops) => applyOperators(numbers, ops))
        .any((r) => r == testValue);

    total += passed ? testValue : 0;
  }

  print('  Total calibration result = $total');

  print('  Day 7 - Part 2');
}

int applyOperators(List<int> numbers, List<Operator> operators) {
  var result = numbers[0];
  for (var i = 0; i < operators.length; ++i) {
    result = operators[i].apply(result, numbers[i + 1]);
  }
  return result;
}

List<List<Operator>> buildOperatorLists(int count) {
  if (count == 0) {
    return [[]];
  }
  final List<List<Operator>> result = [];
  for (final op in Operator.values) {
    for (final list in buildOperatorLists(count - 1)) {
      result.add([op, ...list]);
    }
  }
  return result;
}

enum Operator {
  plus,
  mult;

  int apply(int a, int b) => switch (this) { plus => a + b, mult => a * b };
}
