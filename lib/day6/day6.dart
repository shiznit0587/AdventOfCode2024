import '../shared.dart';

class Knight {
  Coords pos;
  Direction dir;

  Knight({required this.pos, required this.dir});

  factory Knight.from(Knight other) => Knight(pos: other.pos, dir: other.dir);

  @override
  operator ==(other) => other is Knight && other.pos == pos && other.dir == dir;

  @override
  int get hashCode => Object.hash(pos, dir);
}

Future<void> run() async {
  final map = await readDay(6);

  print('  Day 6 - Part 1');

  Knight knight = Knight(pos: (x: 0, y: 0), dir: Direction.up);
  Coords start = (x: 0, y: 0);

  for (int x = 0; x < map.length; ++x) {
    var y = map[x].indexOf('^');
    if (y > -1) {
      start = knight.pos = (x: x, y: y);
      break;
    }
  }

  Set<Coords> visited = {};
  while (true) {
    visited.add(knight.pos);

    var next = knight.pos.go(knight.dir);
    if (!map.inside(next)) {
      break;
    }

    if (map.at(next) == '#') {
      knight.dir = knight.dir.turnRight();
    } else {
      knight.pos = next;
    }
  }

  print('  Visited = ${visited.length}');

  print('  Day 6 - Part 2');

  int loopsFound = 0;

  // Only need to check spots that the guard passed through in part 1.
  for (final obstruction in visited) {
    knight = Knight(pos: start, dir: Direction.up);
    Set<Knight> visitedB = {};

    while (true) {
      visitedB.add(Knight.from(knight));

      var next = knight.pos.go(knight.dir);
      if (!map.inside(next)) {
        break;
      }
      if (visitedB.contains(Knight(pos: next, dir: knight.dir))) {
        loopsFound++;
        break;
      }

      if (map.at(next) == '#' || next == obstruction) {
        knight.dir = knight.dir.turnRight();
      } else {
        knight.pos = next;
      }
    }
  }

  print('  Loops Found = $loopsFound');
}
