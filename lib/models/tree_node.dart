class TreeNode<T> {
  T data;
  TreeNode<T>? parent;
  List<TreeNode<T>> children;

  TreeNode(this.data) : children = [];

  void addChild(TreeNode<T> child) {
    child.parent = this;
    children.add(child);
  }
}
