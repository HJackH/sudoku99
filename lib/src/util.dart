/// utilities to do some transformation
class Util {
  /// Transform [s] to a 10x10(1-based) List<List<int>> board.
  static List<List<int>> toBoard(String s) {
    if (s.length != 81) {
      throw ArgumentError.value(s.length, 'string length error != 81');
    }
    List<List<int>> b =
        List.generate(10, (index) => List.generate(10, (index) => 0));
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        int id = i * 9 + j;
        b[i + 1][j + 1] = int.parse(s[id]);
      }
    }
    return b;
  }

  /// Transform [b](10x10(1-based)) to a String with length=81.
  static String toStr(List<List<int>> b) {
    if (b.length != 10 || b[0].length != 10) {
      throw ArgumentError.value(b.length, 'board size error != 10');
    }
    String s = '';
    for (int i = 1; i <= 9; i++) {
      for (int j = 1; j <= 9; j++) {
        s += b[i][j].toString();
      }
    }
    return s;
  }

  /// Transform [b] from 9x9(0-based) to 10x10(1-based).
  static List<List<int>> toOneBase(List<List<int>> b) {
    if (b.length != 9 || b[0].length != 9) {
      throw ArgumentError.value(b.length, 'board size error != 9');
    }
    List<List<int>> ans =
        List.generate(10, (index) => List.generate(10, (index) => 0));
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        ans[i + 1][j + 1] = b[i][j];
      }
    }
    return ans;
  }

  /// Transform [b] from 10x10(1-based) to 9x9(0-based).
  static List<List<int>> toZeroBase(List<List<int>> b) {
    if (b.length != 10 || b[0].length != 10) {
      throw ArgumentError.value(b.length, 'board size error != 10');
    }
    List<List<int>> ans =
        List.generate(9, (index) => List.generate(9, (index) => 0));
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        ans[i][j] = b[i + 1][j + 1];
      }
    }
    return ans;
  }
}
