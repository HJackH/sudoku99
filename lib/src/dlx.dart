import 'node.dart';

/// Dancing Links data structure for solving sudoku(9 x 9)
class DLX {
  /// [maxn] is maximum internal nodes in data structure.
  static final int maxn = 100000 + 10;

  /// dancing link size = [n] x [m],
  /// [tot] is internal nodes for now,
  /// [ansd] is the number of ans when solving the sudoku.
  int n = 0, m = 0, tot = 0, ansd = 0;

  /// [nodes] store the all nodes informations,
  /// nodes0 is the entry point (root node),
  /// Notices reference in List.
  List<Node> nodes = List.generate(maxn, (index) => Node());

  /// [stk] is a temporary storage for solving the sudoku.
  List<int> stk = List.generate(maxn, (index) => 0);

  /// Initialize data structure with size [r] x [c],
  /// creating and linking column nodes.
  void init(int r, int c) {
    for (var i in nodes) {
      i.initSIZ();
    }
    n = r;
    m = c;
    ansd = 0;
    for (int i = 0; i <= c; i++) {
      Node t = nodes[i];
      t.L = i - 1;
      t.R = i + 1;
      t.U = t.D = i;
    }
    nodes[0].L = c;
    nodes[c].R = 0;
    tot = c;
  }

  /// Insert node at ([r], [c])
  void insert(int r, int c) {
    ++tot;
    Node t = nodes[tot];
    t.col = c;
    t.row = r;
    ++nodes[c].siz;
    t.D = nodes[c].D;
    nodes[nodes[c].D].U = tot;
    t.U = c;
    nodes[c].D = tot;
    if (nodes[r].first == 0) {
      nodes[r].first = t.L = t.R = tot;
    } else {
      t.R = nodes[nodes[r].first].R;
      nodes[nodes[nodes[r].first].R].L = tot;
      t.L = nodes[r].first;
      nodes[nodes[r].first].R = tot;
    }
  }

  /// Remove column [c] and
  /// update all columns in rows in column [c].
  void remove(int c) {
    nodes[nodes[c].R].L = nodes[c].L;
    nodes[nodes[c].L].R = nodes[c].R;
    for (int i = nodes[c].D; i != c; i = nodes[i].D) {
      for (int j = nodes[i].R; j != i; j = nodes[j].R) {
        nodes[nodes[j].D].U = nodes[j].U;
        nodes[nodes[j].U].D = nodes[j].D;
        --nodes[nodes[j].col].siz;
      }
    }
  }

  /// Recover informations removed by [remove(int c)].
  void recover(int c) {
    for (int i = nodes[c].U; i != c; i = nodes[i].U) {
      for (int j = nodes[i].L; j != i; j = nodes[j].L) {
        nodes[nodes[j].D].U = nodes[nodes[j].U].D = j;
        ++nodes[nodes[j].col].siz;
      }
    }
    nodes[nodes[c].R].L = nodes[nodes[c].L].R = c;
  }

  /// main function to solve the sudoku,
  /// [dep] = search steps,
  /// [board] = sudoku board(1-based, 10x10),
  /// init call = dance(0, board);
  /// return a integer for answer count.
  /// * 0 = no answer
  /// * 1 = only 1 answer
  /// * 2 = answers >= 2
  int dance(int dep, List<List<int>> board) {
    int c = nodes[0].R;

    /// no nodes remain in the data structure,
    /// search finished.
    if (c == 0) {
      for (int i = 1; i < dep; i++) {
        int x = (stk[i] - 1) ~/ 9 ~/ 9 + 1;
        int y = (stk[i] - 1) ~/ 9 % 9 + 1;
        int v = (stk[i] - 1) % 9 + 1;
        board[x][y] = v;
      }
      return (ansd += 1);
    }

    /// Pick the column [c] with least nodes.
    /// the most important column
    for (int i = nodes[0].R; i != 0; i = nodes[i].R) {
      if (nodes[i].siz < nodes[c].siz) {
        c = i;
      }
    }
    remove(c);
    for (int i = nodes[c].D; i != c; i = nodes[i].D) {
      stk[dep] = nodes[i].row;
      for (int j = nodes[i].R; j != i; j = nodes[j].R) {
        remove(nodes[j].col);
      }
      if (dance(dep + 1, board) >= 2) {
        return ansd;
      }
      for (int j = nodes[i].L; j != i; j = nodes[j].L) {
        recover(nodes[j].col);
      }
    }
    recover(c);
    return ansd;
  }
}
