import 'dart:collection';
import 'dart:convert';
import 'dart:io';

typedef Rule = ({int left, int right});
typedef Update = List<int>;

final List<Rule> rules = [];
final List<Update> updates = [];

Future<void> run() async {
  final input = await utf8.decoder
      .bind(File("lib/day5/input.txt").openRead())
      .transform(const LineSplitter())
      .toList();

  print('  Day 5 - Part 1');

  for (final line in input) {
    if (line.contains("|")) {
      var parts = line.split("|");
      rules.add((left: int.parse(parts[0]), right: int.parse(parts[1])));
    } else if (line.contains(",")) {
      updates.add(line.split(",").map(int.parse).toList());
    }
  }

  // The way for none of the rules to be broken is for each existing page to not come before any page a rule says it needs to come after.
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

  print('Middle Sum = $middleSum');

  print('  Day 5 - Part 2');

  middleSum = 0;
  for (final update in wrongUpdates) {
    final sorted = sortUpdate(update);
    middleSum += sorted[sorted.length ~/ 2];
  }

  print('Middle Sum = $middleSum');
}

bool updatePassesRules(Update update) {
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

  final filteredRules = rules
      .where((r) => update.contains(r.left) && update.contains(r.right))
      .toList();

  Map<int, List<int>> adjacencies = {};
  for (final rule in filteredRules) {
    if (!adjacencies.containsKey(rule.left)) {
      adjacencies[rule.left] = [];
    }
    adjacencies[rule.left]!.add(rule.right);
  }

  // Count of times a page is on the RHS of a rule.
  Map<int, int> indegree = {};
  for (final page in update) {
    indegree[page] = 0;
  }

  for (final entry in adjacencies.entries) {
    for (final adj in entry.value) {
      indegree[adj] = indegree[adj]! + 1;
    }
  }

  Queue<int> queue = Queue();
  for (final page in update) {
    if (indegree[page] == 0) {
      queue.addLast(page);
    }
  }

  Update sorted = [];
  while (queue.isNotEmpty) {
    int page = queue.removeFirst();
    sorted.add(page);
    for (final adj in adjacencies[page] ?? []) {
      indegree[adj] = indegree[adj]! - 1;
      if (indegree[adj] == 0) {
        queue.addLast(adj);
      }
    }
  }

  return sorted;
}
