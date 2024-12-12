import 'package:quiver/collection.dart';

import '../shared.dart';

late final List<String> map;
final antinodes1 = <Coords>{};
final antinodes2 = <Coords>{};

Future<void> run() async {
  map = await readDay(8);

  final antennas = Multimap<String, Coords>();
  for (int x = 0; x < map.rows; ++x) {
    for (int y = 0; y < map.cols; ++y) {
      if (map[x][y] != '.') {
        antennas.add(map[x][y], (x: x, y: y));
      }
    }
  }

  for (String antenna in antennas.keys) {
    final coords = antennas[antenna].toList();
    if (coords.length > 1) {
      antinodes2.addAll(coords);
    }

    for (int i = 0; i < coords.length; ++i) {
      for (int j = 0; j < coords.length; ++j) {
        if (i != j) {
          findAntinodes(coords[i], coords[i] - coords[j]);
          findAntinodes(coords[j], coords[j] - coords[i]);
        }
      }
    }
  }

  print('  Day 8 - Part 1');
  print('  Unique antinode locations = ${antinodes1.length}');
  print('  Day 8 - Part 2');
  print('  Unique antinode locations = ${antinodes2.length}');
}

void findAntinodes(Coords a, Coords delta) {
  var added1 = false;
  var anti = a + delta;

  while (map.inside(anti)) {
    if (!added1) {
      added1 = true;
      antinodes1.add(anti);
    }
    antinodes2.add(anti);
    anti += delta;
  }
}
