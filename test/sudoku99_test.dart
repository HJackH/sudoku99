import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import "package:path/path.dart" show join;
import 'package:sudoku99/sudoku99.dart';

void main() async {
  String path = join(
      Directory.current.path.endsWith('test')
          ? Directory.current.path
          : join(Directory.current.path, 'test'),
      'sudoku.csv');

  final input = File(path);
  final datas = await input
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .map((s) => s.split(','))
      .toList();

  test('Solver99 for solving sudoku', () {
    Solver99 solver = Solver99();
    for (int i = 1; i < datas.length; i++) {
      var b = Util.toBoard(datas[i][0]);
      int cnt = solver.run(b);
      String ans = Util.toStr(b);
      expect(cnt, 1);
      expect(ans, datas[i][1]);
    }
  });
}
