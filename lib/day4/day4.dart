import '../shared.dart';

late final List<String> input;

Future<void> run() async {
  input = await readDay(4);

  print('  Day 4 - Part 1');

  int foundCount = 0;
  for (int r = 0; r < input.rows; ++r) {
    for (int c = 0; c < input.cols; ++c) {
      for (final dir in Direction.values) {
        if (found((x: r, y: c), dir, 0)) {
          ++foundCount;
        }
      }
    }
  }

  print('  Found Times: $foundCount');

  print('  Day 4 - Part 2');

  foundCount = 0;
  for (int row = 1; row < input.rows - 1; ++row) {
    for (int col = 1; col < input.cols - 1; ++col) {
      Coords c = (x: row, y: col);

      // No need for bounds checks,
      // we made sure the loops only cover the inside square.
      foundCount += switch ((
        input.at(c),
        input.at(c.go(Direction.upLeft)),
        input.at(c.go(Direction.upRight)),
        input.at(c.go(Direction.downRight)),
        input.at(c.go(Direction.downLeft))
      )) {
        ('A', 'M', 'M', 'S', 'S') => 1,
        ('A', 'S', 'M', 'M', 'S') => 1,
        ('A', 'S', 'S', 'M', 'M') => 1,
        ('A', 'M', 'S', 'S', 'M') => 1,
        _ => 0
      };
    }
  }

  print('  Found Times: $foundCount');
}

bool found(Coords c, Direction dir, int idx) {
  // Success end condition
  if (idx == 4) {
    return true;
  }

  // Bounds check
  if (!input.inside(c)) {
    return false;
  }

  // Failure condition
  if (input.at(c) != 'XMAS'[idx]) {
    return false;
  }

  // Recursive condition (tail)
  return found(c.go(dir), dir, idx + 1);
}
