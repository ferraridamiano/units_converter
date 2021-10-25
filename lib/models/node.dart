import 'dart:collection';

/*
/// The conversion is expressed in a form like: y=ax+b. Where a is
/// [coefficientProduct] and b is [coefficientSum].
const linearConversion = 1;

/// The conversion is expressed in a form like: y=(a/x)+b. Where a is
/// [coefficientProduct] and b is [coefficientSum].
const reciprocalConversion = 2;

/// This is a special conversion. Use this just with base conversion.
const baseConversion = 3;
*/
enum CONVERSION_TYPE {
  linearConversion,
  reciprocalConversion,
  baseConversion,
}

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
    //this.areAdjNodeConverted = false,
  });

  List<Node> leafNodes;
  double coefficientProduct;
  double coefficientSum;
  double? value;
  dynamic name;
  CONVERSION_TYPE conversionType;
  int? base;
  String? stringValue;
  bool isConverted;
  //bool areAdjNodeConverted;

  /// This method will first use a DFS-like algorithm to find the converted node
  /// and convert everything up until the root node. An then a BFS-like
  /// algorithm to convert all the nodes.
  void convert() {
    List<Node> pathToConvertedNode = _getNodePathUntilConvertedNode();
    for (int i = pathToConvertedNode.length - 1; i > 0; i--) {}
  }




  void _convertTwoNodes({
    required Node parent,
    required Node child,

    /// If true the value is stored in the parent node and we want to propagate
    /// down to the child node. Otherwise if false.
    bool fromParentToChild = true,
  }) {
    switch (conversionType) {
      case CONVERSION_TYPE.linearConversion:
        if (fromParentToChild) {
          if (parent.value == null) {
            child.value = null;
          } else {
            child.value =
                parent.value! * child.coefficientProduct + child.coefficientSum;
          }
        } else {
          if (child.value == null) {
            parent.value = null;
          } else {
            parent.value = (child.value! - child.coefficientSum) /
                child.coefficientProduct;
          }
        }
        break;
      case CONVERSION_TYPE.reciprocalConversion:
        if (fromParentToChild) {
          if (parent.value == null) {
            child.value = null;
          } else {
            child.value =
                child.coefficientProduct / parent.value! + child.coefficientSum;
          }
        } else {
          if (child.value == null) {
            parent.value = null;
          } else {
            parent.value = child.coefficientProduct /
                (child.value! - child.coefficientSum);
          }
        }
        break;
      case CONVERSION_TYPE.baseConversion:
      //TODO
      break;
    }
  }

  /// This function returns the path from the root Node up until the converted
  /// Node in the form of a list.
  List<Node> _getNodePathUntilConvertedNode() {
    if (isConverted == false) {
      bool stopFlag = false;
      Queue<Node> stack = Queue.from([this]); // we will use a queue as a stack
      Queue<List<Node>> breadcrumbListQueue = Queue.from([
        [this]
      ]);
      while (!stopFlag && stack.isNotEmpty) {
        Node node = stack.removeLast();
        List<Node> breadcrumbList = breadcrumbListQueue.removeLast();
        if (node.leafNodes.isNotEmpty) {
          for (Node leafNode in node.leafNodes) {
            if (leafNode.isConverted == true) {
              return [...breadcrumbList, leafNode];
            }
            stack.addLast(leafNode);
            breadcrumbListQueue.addLast([...breadcrumbList, leafNode]);
          }
        }
      }
    }
    return [this];
  }
}
