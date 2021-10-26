import 'dart:collection';
import 'package:units_converter/utils/utils.dart';

/// Defines the type of the conversion between two nodes.
enum CONVERSION_TYPE {
  /// The conversion is expressed in a form like: y=ax+b. Where a is
  /// [coefficientProduct] and b is [coefficientSum].
  linearConversion,

  /// The conversion is expressed in a form like: y=(a/x)+b. Where a is
  /// [coefficientProduct] and b is [coefficientSum].
  reciprocalConversion,

  /// This is a special conversion. Use this just with base conversion.
  baseConversion,
}

/// This is the building block of the conversion tree. Thanks to the [leafNodes]
/// parameter you can set other [Node]s that depends on this parent node. Thanks
/// to the [coefficientProduct], [coefficientSum], [conversionType] and [base]
/// parameters you can set the relationship between this node and the parent
/// node.
class Node {
  Node({
    this.leafNodes = const [],
    this.coefficientProduct = 1.0,
    this.coefficientSum = 0.0,
    this.name,
    this.value,
    this.stringValue,
    this.conversionType = CONVERSION_TYPE.linearConversion,
    this.base,
    this.isConverted = false,
  });

  /// This are the list of the [Node]s that depend by this node. These are the
  /// children of this parent node.
  List<Node> leafNodes;

  /// This is the product coefficient of [CONVERSION_TYPE.linearConversion] and
  /// [CONVERSION_TYPE.reciprocalConversion]. It is the a coefficient.
  double coefficientProduct;

  /// This is the sum coefficient of [CONVERSION_TYPE.linearConversion] and
  /// [CONVERSION_TYPE.reciprocalConversion]. It is the b coefficient.
  double coefficientSum;

  /// This the value that has the unit of measurement of this node. This is
  /// valid for the most cases. But not for numeral systems conversion.
  double? value;

  /// This the value that has the unit of measurement of this node. This is
  /// just for numeral systems conversion. In all the other cases use [value].
  String? stringValue;

  /// This is the name of the unit. Can be a String or an enum.
  dynamic name;

  /// This define the conversion type between this node and its parent. The
  /// default is [CONVERSION_TYPE.linearConversion]. This is useless for the
  /// root node (because it has no parent node).
  CONVERSION_TYPE conversionType;

  /// This is defined just for numeral system conversion. It defines the base of
  /// this number. E.g. 16 for hexadecimal, 10 for decimal, 10 for binary, etc.
  int? base;

  /// If true this node is already converted, false otherwise. The node where
  /// the conversion start has [isConverted] = true.
  bool isConverted;

  /// **This method must be used on the root [Node] of the conversion**. It
  /// converts all the [Node] of the tree from the [Node] which name is equal to
  /// [name] ([value] is assigned to this [Node]) to all the other [Node]s of
  /// the tree.
  void convert(dynamic name, dynamic value) {
    assert(value is String || value is double);

    List<Node> pathToConvertedNode = _getNodesPathAndSelectNode(name, value);
    for (int i = pathToConvertedNode.length - 2; i >= 0; i--) {
      _convertTwoNodes(
          parent: pathToConvertedNode[i],
          child: pathToConvertedNode[i + 1],
          fromParentToChild: false);
    }

    //Now we use a BFS-like algorithm to convert everything from the root node
    //to every other node.
    Queue<Node> queue = Queue.from([this]);
    while (queue.isNotEmpty) {
      Node node = queue.removeFirst();
      if (node.leafNodes.isNotEmpty) {
        for (Node leafNode in node.leafNodes) {
          if (leafNode.isConverted == false) {
            _convertTwoNodes(parent: node, child: leafNode);
          }
          queue.addLast(leafNode);
        }
      }
    }
  }

  /// This function performs the conversion from a [parent] node to the [child]
  /// node if [fromParentToChild]=true (the default). Otherwise the conversion
  /// is performed from child to parent.
  void _convertTwoNodes({
    required Node parent,
    required Node child,

    /// If true the value is stored in the parent node and we want to propagate
    /// down to the child node. Otherwise if false.
    bool fromParentToChild = true,
  }) {
    switch (child.conversionType) {
      case CONVERSION_TYPE.linearConversion:
        if (fromParentToChild) {
          child.value =
              (parent.value! - child.coefficientSum) / child.coefficientProduct;
        } else {
          parent.value =
              child.value! * child.coefficientProduct + child.coefficientSum;
        }
        break;
      case CONVERSION_TYPE.reciprocalConversion:
        if (fromParentToChild) {
          child.value =
              child.coefficientProduct / (parent.value! - child.coefficientSum);
        } else {
          parent.value =
              child.coefficientProduct / child.value! + child.coefficientSum;
        }
        break;
      case CONVERSION_TYPE.baseConversion:
        // Note: in this case the parent is always the decimal
        assert(parent.base != null && child.base != null);
        if (fromParentToChild) {
          child.stringValue = decToBase(parent.stringValue!, child.base!);
        } else {
          parent.stringValue = baseToDec(child.stringValue!, child.base!);
        }
        break;
    }
    // At this point the child (or the father) is converted
    if (fromParentToChild) {
      child.isConverted = true;
    } else {
      parent.isConverted = true;
    }
  }

  /// This function returns the path from the root Node up until the converted
  /// Node in the form of a list. Moreover, it sets the node which name is equal
  /// to name as converted [isConverted]=true. All the other nodes are marked as
  /// not converted.
  List<Node> _getNodesPathAndSelectNode(dynamic name, dynamic value) {
    Queue<Node> stack = Queue.from([this]); // we will use a queue as a stack
    Queue<List<Node>> breadcrumbListQueue = Queue.from([
      [this]
    ]);
    List<Node> result = [];
    while (stack.isNotEmpty) {
      Node node = stack.removeLast();
      List<Node> breadcrumbList = breadcrumbListQueue.removeLast();
      // if the node is the starting point of the conversion we assign it
      // its value and we mark it as converted. All the others are marked as
      // not converted
      if (node.name == name) {
        if (value is double) {
          node.value = value;
        } else {
          // value is String
          node.stringValue = value;
        }
        node.isConverted = true;
        result = [...breadcrumbList];
      } else {
        node.isConverted = false;
      }
      if (node.leafNodes.isNotEmpty) {
        for (Node leafNode in node.leafNodes) {
          stack.addLast(leafNode);
          breadcrumbListQueue.addLast([...breadcrumbList, leafNode]);
        }
      }
    }
    return result;
  }

  /// Recursive function to get a list of the nodes of the tree
  List<Node> getTreeAsList() {
    List<Node> result = [this];
    for (Node node in leafNodes) {
      result = [...result, ...node.getTreeAsList()];
    }
    return result;
  }
}
