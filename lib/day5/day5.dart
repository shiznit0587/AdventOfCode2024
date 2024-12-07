import 'dart:collection';

import 'package:quiver/collection.dart';

import '../shared.dart';

typedef Rule = ({int left, int right});
typedef Update = List<int>;

final List<Rule> rules = [];
final List<Update> updates = [];

Future<void> run() async {
  final input = await readDay(5);

  print('  Day 5 - Part 1');

  for (final line in input) {
    if (line.contains("|")) {
      var parts = line.split("|");
      rules.add((left: int.parse(parts[0]), right: int.parse(parts[1])));
    } else if (line.contains(",")) {
      updates.add(line.split(",").map(int.parse).toList());
    }
  }

  var middleSum = 0;
  var wrongUpdates = [];
  for (final update in updates) {
    if (updatePassesRules(update)) {
      middleSum += update[update.length ~/ 2];
    } else {
      // Save for part 2
      wrongUpdates.add(update);
    }
  }

  print('  Middle Sum = $middleSum');

  print('  Day 5 - Part 2');

  middleSum = 0;
  for (final update in wrongUpdates) {
    final sorted = sortUpdate(update);
    middleSum += sorted[sorted.length ~/ 2];
  }

  print('  Middle Sum = $middleSum');
}

bool updatePassesRules(Update update) {
  // The way for none of the rules to be broken is for each existing page
  // to not come before any page a rule says it needs to come after.
  for (int i = 0; i < update.length; ++i) {
    final page = update[i];
    for (final rule in rules) {
      if (rule.right == page) {
        for (int j = i + 1; j < update.length; ++j) {
          if (update[j] == rule.left) {
            return false;
          }
        }
      }
    }
  }
  return true;
}

Update sortUpdate(Update update) {
  // This is Kahn's Algorithm, for topological sorting.

  final adjacencies = Multimap<int, int>.fromIterable(
      rules.where((r) => update.contains(r.left) && update.contains(r.right)),
      key: (r) => r.left,
      value: (r) => r.right);

  // Count of times a page is on the RHS of a rule (unsatisfied)
  final indegree = <int, int>{for (final p in update) p: 0};
  adjacencies.forEach((l, r) => indegree[r] = indegree[r]! + 1);

  final queue = Queue.from(update.where((p) => indegree[p] == 0));

  Update sorted = [];
  while (queue.isNotEmpty) {
    int page = queue.removeFirst();
    sorted.add(page);
    for (final adj in adjacencies[page]) {
      indegree[adj] = indegree[adj]! - 1;
      if (indegree[adj] == 0) {
        queue.addLast(adj);
      }
    }
  }

  return sorted;
}
