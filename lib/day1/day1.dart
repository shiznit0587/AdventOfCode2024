import 'dart:convert';
import 'dart:io';
import 'dart:core';

Future<void> run() async {
  final lines = utf8.decoder
      .bind(File("lib/day1/input.txt").openRead())
      .transform(const LineSplitter());

  print('  Day 1 - Part 1');

  var numbers = RegExp(r'(\d+)\s+(\d+)');

  List<int> list1 = [];
  List<int> list2 = [];

  await for (final line in lines) {
    final match = numbers.firstMatch(line)!;
    list1.add(int.parse(match.group(1)!));
    list2.add(int.parse(match.group(2)!));
  }

  list1.sort();
  list2.sort();

  var difference = 0;
  for (var i = 0; i < list1.length; ++i) {
    difference += (list1[i] - list2[i]).abs();
  }

  print('  difference = $difference');

  print('  Day 1 - Part 2');

  var similarity = 0;
  for (var i = 0; i < list1.length; ++i) {
    int count = 0;
    for (var j = 0; j < list2.length; ++j) {
      if (list1[i] == list2[j]) {
        ++count;
      }
    }
    similarity += list1[i] * count;
  }

  print('  similarity = $similarity');
}
