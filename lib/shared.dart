import 'dart:convert';
import 'dart:io';

Future<List<String>> readDay(int day, {bool? sample}) async {
  return await utf8.decoder
      .bind(File('lib/day$day/${sample ?? false ? 'sample' : 'input'}.txt')
          .openRead())
      .transform(const LineSplitter())
      .toList();
}

extension InputExt on List<String> {
  String at(Coords c) => this[c.x][c.y];
  bool inside(Coords c) => 0 <= c.x && c.x < rows && 0 <= c.y && c.y < cols;

  int get rows => length;
  int get cols => this[0].length;
}

typedef Coords = ({int x, int y});

extension CoordsExt on Coords {
  Coords go(Direction dir) => (x: x + dir.dx, y: y + dir.dy);
}

/// Because it's being used to index into a list of strings,
/// x is row (line) and y is col
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

  /// Turn left 90°
  Direction turnLeft() => values[wrap(index + 2, 0, 8)];

  /// Turn right 90°
  Direction turnRight() => values[wrap(index - 2, 0, 8)];
}

/// Wrap an int within a range `[min, max)`
int wrap(int v, int min, int max) => (v + (max - min)) % (max - min);
