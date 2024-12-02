import 'dart:convert';
import 'dart:io';

Future<void> run() async {
  final lines = utf8.decoder
      .bind(File("lib/day2/input.txt").openRead())
      .transform(const LineSplitter());

  print('  Day 3 - Part 1');

  print('  Day 3 - Part 2');
}
