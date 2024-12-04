import 'dart:convert';
import 'dart:io';

final keyword = "XMAS";

late final List<String> input;
late final int rows;
late final int cols;

typedef Coords = ({int x, int y});

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
  if (input[c.x][c.y] != keyword[idx]) {
    return false;
  }

  // Recursive condition (tail)
  return found((x: c.x + dir.dx, y: c.y + dir.dy), dir, idx + 1);
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
