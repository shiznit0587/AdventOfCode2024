import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';

final eq = ListEquality().equals;

Future<void> run() async {
  final lines = utf8.decoder
      .bind(File("lib/day2/input.txt").openRead())
      .transform(const LineSplitter());

  var safeReportsA = 0;
  var safeReportsB = 0;

  await for (final line in lines) {
    final report = line.split(" ").map(int.parse).toList();

    if (isReportSafe(report)) {
      ++safeReportsA;
      ++safeReportsB;
      continue;
    }

    // See if it's safe with the Problem Dampener.
    for (int i = 0; i < report.length; ++i) {
      final dampenedReport = List<int>.from(report);
      dampenedReport.removeAt(i);
      if (isReportSafe(dampenedReport)) {
        ++safeReportsB;
        break;
      }
    }
  }

  print('  Day 2 - Part 1');
  print('  Safe Reports = $safeReportsA');

  print('  Day 2 - Part 2');
  print('  Safe Reports = $safeReportsB');
}

bool isReportSafe(List<int> levels) {

  final ascending = List<int>.from(levels);
  ascending.sort();
  final descending = ascending.reversed.toList();

  // They need to be all increasing or all decreasing
  if (!eq(levels, ascending) && !eq(levels, descending)) {
    return false;
  }

  // adjacent levels differ by at least one and at most three
  for (int i = 0; i < levels.length - 1; ++i) {
    var diff = (levels[i] - levels[i+1]).abs();
    if (diff < 1 || 3 < diff) {
      return false;
    }
  }

  return true;
}
