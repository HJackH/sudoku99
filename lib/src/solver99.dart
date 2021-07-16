import 'dlx.dart';

/// Main Class for solving sudoku
class Solver99 {
  /// sudoku size = 9x9
  /// board size = 10x10 (1-based)
  static final int SZ = 10;
  DLX dlx = DLX();

  /// Get the row in the dlx.
  /// the constraint in [row][col] with [num]
  int GetId(int row, int col, int num) {
    return (row - 1) * 9 * 9 + (col - 1) * 9 + num;
  }

  /// Insert the constraint [row][col] with [num].
  void Insert(int row, int col, int num) {
    int dx = (row - 1) ~/ 3 + 1;
    int dy = (col - 1) ~/ 3 + 1;
    int room = (dx - 1) * 3 + dy;
    int id = GetId(row, col, num);
    int f1 = (row - 1) * 9 + num;
    int f2 = 81 + (col - 1) * 9 + num;
    int f3 = 81 * 2 + (room - 1) * 9 + num;
    int f4 = 81 * 3 + (row - 1) * 9 + col;
    dlx.insert(id, f1);
    dlx.insert(id, f2);
    dlx.insert(id, f3);
    dlx.insert(id, f4);
  }

  /// Main function to solve the sudoku,
  /// [board] = 10x10(1-based)
  int run(List<List<int>> board) {
    if (board.length != SZ || board[0].length != SZ) {
      return 0;
    }

    dlx.init(9 * 9 * 9, 9 * 9 * 4);

    for (int i = 1; i <= 9; i++) {
      for (int j = 1; j <= 9; j++) {
        RangeError.checkValueInInterval(board[i][j], 0, 10);

        if (board[i][j] != 0) {
          Insert(i, j, board[i][j]);
        } else {
          for (int v = 1; v <= 9; v++) {
            Insert(i, j, v);
          }
        }
      }
    }

    // 0, 1, 2
    return dlx.dance(1, board);
  }
}
