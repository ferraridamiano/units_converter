import 'dart:collection';
import 'package:units_converter/utils/utils.dart';

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

  List<Node> leafNodes;
  double coefficientProduct;
  double coefficientSum;
  double? value;
  dynamic name;
  CONVERSION_TYPE conversionType;
  int? base;
  String? stringValue;
  bool isConverted;

  /// This method will first use a DFS-like algorithm to find the converted node
  /// and convert everything up until the root node. An then a BFS-like
  /// algorithm to convert all the nodes.
  void convert(dynamic name, dynamic value) {
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
          if (parent.value == null) {
            //TODO remove all the null checks
            child.value = null;
          } else {
            child.value = (parent.value! - child.coefficientSum) /
                child.coefficientProduct;
          }
        } else {
          if (child.value == null) {
            parent.value = null;
          } else {
            parent.value =
                child.value! * child.coefficientProduct + child.coefficientSum;
          }
        }
        break;
      case CONVERSION_TYPE.reciprocalConversion:
        if (fromParentToChild) {
          if (parent.value == null) {
            child.value = null;
          } else {
            child.value = child.coefficientProduct /
                (parent.value! - child.coefficientSum);
          }
        } else {
          if (child.value == null) {
            parent.value = null;
          } else {
            parent.value =
                child.coefficientProduct / child.value! + child.coefficientSum;
          }
        }
        break;
      case CONVERSION_TYPE.baseConversion:
        // Note: in this case the parent is always the decimal
        assert(parent.base != null && child.base != null);
        if (fromParentToChild) {
          if (parent.stringValue == null) {
            child.stringValue = null;
          } else {
            child.stringValue=decToBase(parent.stringValue!, child.base!);
          }
        } else {
          if (child.stringValue == null) {
            parent.stringValue = null;
          } else {
            parent.stringValue = baseToDec(child.stringValue!, child.base!);
          }
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
  /// Node in the form of a list.
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
        if(value is double){
          node.value = value;
        } else if(value is String){
          node.stringValue = value;
        } else{
          throw Exception('Value not assigned. Must be double or string');
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
