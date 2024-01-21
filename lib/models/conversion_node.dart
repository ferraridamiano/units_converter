import 'dart:collection';
import 'package:units_converter/utils/utils.dart';

/// Defines the type of the conversion between two nodes.
enum ConversionType {
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
/// parameter you can set other [ConversionNode]s that depends on this parent node. Thanks
/// to the [coefficientProduct], [coefficientSum], [conversionType] and [base]
/// parameters you can set the relationship between this node and the parent
/// node.
class ConversionNode<T> {
  ConversionNode({
    required this.name,
    this.children = const [],
    this.coefficientProduct = 1.0,
    this.coefficientSum = 0.0,
    this.value,
    this.stringValue,
    this.conversionType = ConversionType.linearConversion,
    this.base,
    this.isConverted = false,
  }) {
    for (var child in children) {
      child.parent = this;
    }
  }

  ConversionNode<T>? parent;

  /// This are the list of the [ConversionNode]s that depend by this node. These are the
  /// children of this parent node.
  List<ConversionNode<T>> children;

  /// This is the product coefficient of [ConversionType.linearConversion] and
  /// [ConversionType.reciprocalConversion]. It is the a coefficient.
  double coefficientProduct;

  /// This is the sum coefficient of [ConversionType.linearConversion] and
  /// [ConversionType.reciprocalConversion]. It is the b coefficient.
  double coefficientSum;

  /// This the value that has the unit of measurement of this node. This is
  /// valid for the most cases. But not for numeral systems conversion.
  double? value;

  /// This the value that has the unit of measurement of this node. This is
  /// just for numeral systems conversion. In all the other cases use [value].
  String? stringValue;

  /// This is the name of the unit. Can be a String or an enum.
  T name;

  /// This define the conversion type between this node and its parent. The
  /// default is [ConversionType.linearConversion]. This is useless for the
  /// root node (because it has no parent node).
  ConversionType conversionType;

  /// This is defined just for numeral system conversion. It defines the base of
  /// this number. E.g. 16 for hexadecimal, 10 for decimal, 10 for binary, etc.
  int? base; // TODO get rid of this

  /// If true this node is already converted, false otherwise. The node where
  /// the conversion start has [isConverted] = true.
  bool isConverted;

  /*void addChild(ConversionNode<T> child) {
    child.parent = this;
    children.add(child);
  }*/

  /// Convert this ConversionNode to all the other units
  void convert(dynamic value) {
    assert(value is String || value is double);

    this.value = value;
    isConverted = true;

    Queue<ConversionNode> queue = Queue.from([this]);
    while (queue.isNotEmpty) {
      ConversionNode node = queue.removeFirst();

      final parent = node.parent;
      if (parent != null && !parent.isConverted) {
        // TODO Maybe !node.parent!.isConverted is redundant, get rid of it
        _convertTwoNodes(
          parent: node.parent!,
          child: this,
          fromParentToChild: false,
        );
        parent.isConverted = true;
        queue.addLast(parent);
      }

      final children = node.children;
      if (children.isNotEmpty) {
        for (ConversionNode child in children) {
          if (!child.isConverted) {
            _convertTwoNodes(
              parent: node,
              child: child,
              fromParentToChild: true,
            );
            child.isConverted = true;
          }
          queue.addLast(child);
        }
      }
    }
  }

  /// This function performs the conversion from a [parent] node to the [child]
  /// node if [fromParentToChild]=true (the default). Otherwise the conversion
  /// is performed from child to parent.
  void _convertTwoNodes({
    required ConversionNode parent,
    required ConversionNode child,

    /// If true the value is stored in the parent node and we want to propagate
    /// down to the child node. Otherwise if false.
    bool fromParentToChild = true,
  }) {
    switch (child.conversionType) {
      case ConversionType.linearConversion:
        if (fromParentToChild) {
          child.value =
              (parent.value! - child.coefficientSum) / child.coefficientProduct;
        } else {
          parent.value =
              child.value! * child.coefficientProduct + child.coefficientSum;
        }
        break;
      case ConversionType.reciprocalConversion:
        if (fromParentToChild) {
          child.value =
              child.coefficientProduct / (parent.value! - child.coefficientSum);
        } else {
          parent.value =
              child.coefficientProduct / child.value! + child.coefficientSum;
        }
        break;
      case ConversionType.baseConversion:
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
}
