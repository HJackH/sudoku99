/// node structure for dancing links
class Node {
  /// This node is at ([row], [col]).
  int col = 0, row = 0;

  /// Informations for column nodes and row nodes
  int first = 0, siz = 0;

  /// Left, Right, Up, Down node id
  int L = 0, R = 0, U = 0, D = 0;

  /// Reset [first] and [siz]
  void initSIZ() {
    first = siz = 0;
  }
}
