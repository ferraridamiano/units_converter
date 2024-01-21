import 'dart:collection';

/// Defines the type of the conversion between two nodes.
enum ConversionType {
  /// The conversion is expressed in a form like: y=ax+b. Where a is
  /// [coefficientProduct] and b is [coefficientSum].
  linearConversion,

  /// The conversion is expressed in a form like: y=(a/x)+b. Where a is
  /// [coefficientProduct] and b is [coefficientSum].
  reciprocalConversion,
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

  /// Convert this ConversionNode to all the other units
  void convert(double value) {
    this.value = value;

    Queue<ConversionNode> queue = Queue.from([this]);
    while (queue.isNotEmpty) {
      ConversionNode node = queue.removeFirst();

      final parent = node.parent;
      if (parent != null && parent.value == null) {
        _convertParentFromChild(node.parent!, this);
        queue.addLast(parent);
      }

      final children = node.children;
      if (children.isNotEmpty) {
        for (ConversionNode child in children) {
          if (child.value == null) {
            _convertParentToChild(node, child);
          }
          queue.addLast(child);
        }
      }
    }
  }

  /// This function performs the conversion from the parent node to a child
  /// node.
  void _convertParentToChild(ConversionNode parent, ConversionNode child) {
    child.value = switch (child.conversionType) {
      ConversionType.linearConversion =>
        (parent.value! - child.coefficientSum) / child.coefficientProduct,
      ConversionType.reciprocalConversion =>
        child.coefficientProduct / (parent.value! - child.coefficientSum)
    };
  }

  /// This function performs the conversion from a child node to the parent
  /// node.
  void _convertParentFromChild(ConversionNode parent, ConversionNode child) {
    parent.value = switch (child.conversionType) {
      ConversionType.linearConversion =>
        child.value! * child.coefficientProduct + child.coefficientSum,
      ConversionType.reciprocalConversion =>
        child.coefficientProduct / child.value! + child.coefficientSum
    };
  }
}
