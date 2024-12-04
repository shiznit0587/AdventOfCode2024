import 'dart:convert';
import 'dart:io';

late final List<String> input;
late final int rows;
late final int cols;

typedef Coords = ({int x, int y});

extension on Coords {
  Coords go(Direction dir) => (x: x + dir.dx, y: y + dir.dy);
}

extension on List<String> {
  String at(Coords c) => this[c.x][c.y];
}

Future<void> run() async {
  input = await utf8.decoder
      .bind(File("lib/day4/input.txt").openRead())
      .transform(const LineSplitter())
      .toList();

  rows = input.length;
  cols = input[0].length;

  print('  Day 4 - Part 1');

  int foundCount = 0;
  for (int r = 0; r < rows; ++r) {
    for (int c = 0; c < cols; ++c) {
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
  for (int row = 1; row < rows - 1; ++row) {
    for (int col = 1; col < cols - 1; ++col) {
      Coords c = (x: row, y: col);

      // No need for bounds checks, we made sure the loops only cover the inside square.
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
  if (c.x < 0 || rows <= c.x || c.y < 0 || cols <= c.y) {
    return false;
  }

  // Failure condition
  if (input.at(c) != 'XMAS'[idx]) {
    return false;
  }

  // Recursive condition (tail)
  return found(c.go(dir), dir, idx + 1);
}

// Because it's being used to index into a list of strings, x is row (line) and y is col
enum Direction {
  up(dx: -1, dy: 0),
  upLeft(dx: -1, dy: -1),
  left(dx: 0, dy: -1),
  downLeft(dx: 1, dy: -1),
  down(dx: 1, dy: 0),
  downRight(dx: 1, dy: 1),
  right(dx: 0, dy: 1),
  upRight(dx: -1, dy: 1);

  final int dx;
  final int dy;

  const Direction({required this.dx, required this.dy});
}
