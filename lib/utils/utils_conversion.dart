import 'dart:math';

const linearConversion = 1; // y=ax+b
const reciprocalConversion = 2; // y=(a/x)+b
const baseConversion = 3; // conversione speciale (dec è father e tutti gli altri figlio)

class Node {
  Node({
    this.leafNodes = const [],
    this.coefficientProduct = 1.0,
    this.coefficientSum = 0.0,
    this.name,
    this.value,
    this.convertedNode = false,
    this.selectedNode = false,
    this.conversionType = linearConversion,
    this.stringValue,
    this.base,
  });

  List<Node> leafNodes;
  double coefficientProduct;
  double coefficientSum;
  double? value;
  // ignore: prefer_typing_uninitialized_variables
  var name;
  bool convertedNode;
  bool selectedNode;
  int conversionType;
  int? base;
  String? stringValue;

  void convert() {
    if (!convertedNode) {
      //if not already converted
      for (var node in leafNodes) {
        //for each leaf nodes check if it has a value
        switch (node.conversionType) {
          case linearConversion:
            {
              _linearConvert(node);
              break;
            }
          case reciprocalConversion:
            {
              _reciprocoConvert(node);
              break;
            }
          case baseConversion:
            {
              _baseConvert(node);
              break;
            }
        }
      }
    } else {
      //se ha valore
      for (var node in leafNodes) {
        if (node.convertedNode == false) _applyDown();
      }
    }
  }

  void _applyDown() {
    for (var node in leafNodes) {
      switch (node.conversionType) {
        case linearConversion:
          {
            _linearApplyDown(node);
            break;
          }
        case reciprocalConversion:
          {
            _reciprocoApplyDown(node);
            break;
          }
        case baseConversion:
          {
            _baseApplyDown(node);
            break;
          }
      }
    }
  }

  void _linearConvert(Node node) {
    //from low to high
    if (node.convertedNode) {
      //if a leaf node is already converted
      value = node.value == null //compute from father node respect to him
          ? null
          : (node.value! * node.coefficientProduct) + (node.coefficientSum); //put in this node the converted value
      convertedNode = true;
      _applyDown(); //convert lower nodes
    } else if (node.leafNodes.isNotEmpty) {
      //but has at leas a leaf node
      node.convert(); //repeat
      if (node.convertedNode) convert();
    }
  }

  void _linearApplyDown(Node node) {
    //from high to low
    node.value = value == null ? null : (value! - node.coefficientSum) * (1 / node.coefficientProduct); //warning here is the converse
    node.convertedNode = true;

    if (node.leafNodes.isNotEmpty) {
      //if it has at least a leaf node let's go away
      node._applyDown();
    }
  }

  void _reciprocoConvert(Node node) {
    //from low to high
    if (node.convertedNode) {
      //if a leaf node is already converted
      value = node.value == null //compute from father node respect to him
          ? null
          : (node.coefficientProduct / node.value!) + node.coefficientSum; //put in this node the converted value
      convertedNode = true;
      _applyDown(); //convert lower nodes
    } else if (node.leafNodes.isNotEmpty) {
      //but has at least a leaf node
      node.convert(); //repeat
      if (node.convertedNode) convert();
    }
  }

  void _reciprocoApplyDown(Node node) {
    //from high to low
    node.value = value == null ? null : node.coefficientProduct / (value! - node.coefficientSum); //warning here is the converse
    node.convertedNode = true;

    if (node.leafNodes.isNotEmpty) {
      //if it has at least a leaf node let's go away
      node._applyDown();
    }
  }

  //WARNING! This type of conversion has been built just for base conversion dec-(bin-oct-hex). A father with 3 children
  void _baseConvert(Node node) {
    //from low to high
    if (node.convertedNode) {
      //if a leaf node is already converted
      if (node.stringValue == null) {
        stringValue = null;
      } else {
        assert(node.base != null, 'Node.base must be non null');
        stringValue = baseToDec(node.stringValue!, node.base!);
      }
      convertedNode = true;
      _applyDown(); //convert lower nodes
    } else if (node.leafNodes.isNotEmpty) {
      //but has at leas a leaf node
      node.convert(); //repeat
      if (node.convertedNode) convert();
    }
  }

  void _baseApplyDown(Node node) {
    //from high to low
    if (stringValue == null) {
      node.stringValue = null;
    } else {
      assert(node.base != null, 'Node.base must be non null');
      node.stringValue = decToBase(stringValue!, node.base!);
    }

    node.convertedNode = true;

    if (node.leafNodes.isNotEmpty) {
      //if it has at least a leaf node let's go away
      node._applyDown();
    }
  }

  /// Reset convertedNode (false) for each non-selected node from high to low. Call it on the father node!
  void resetConvertedNode() {
    if (!selectedNode) {
      //if it is not the selected node
      convertedNode = false; //reset
    }
    if (leafNodes.isNotEmpty) {
      for (var node in leafNodes) {
        //for each node of the tree
        node.resetConvertedNode();
      }
    }
  }

  /// Reset all the values of the nodes. Call it on the father node!
  void clearAllValues() {
    var listanodi = _getNodiFiglio();
    for (var nodo in listanodi) {
      nodo.value = null;
      nodo.stringValue = null;
    }
  }

  /// Reset selectedNode (false). Call it on the father node!
  void clearSelectedNode() {
    var listanodi = _getNodiFiglio();
    for (var nodo in listanodi) {
      nodo.selectedNode = false;
    }
  }

  /// Returns every node of the tree as a List. Call it on the father node!
  List<Node> _getNodiFiglio() {
    var listaNodi = [this];
    if (leafNodes.isNotEmpty) {
      for (var node in leafNodes) {
        listaNodi.addAll(node._getNodiFiglio());
      }
    }
    return listaNodi;
  }

  ///Returns the Node with name == unitName. If it is not found, returns null
  Node? getByName(var unitName) {
    var nodeList = _getNodiFiglio();
    for (var node in nodeList) {
      if (unitName == node.name) {
        return node;
      }
    }
    return null;
  }
}

///Given a double value it returns its rapresentation as a string with few tweaks:
///significantFigures is the number of significant figures to keep,
///removeTrailingZeros say if non important zeros should be removed, e.g. 1.000000 --> 1
String mantissaCorrection(double value, int significantFigures, bool removeTrailingZeros) {
  //Round to a fixed number of significant figures
  var stringValue = value.toStringAsPrecision(significantFigures);
  var append = '';

  //if the user want to remove the trailing zeros
  if (removeTrailingZeros) {
    //remove exponential part and append to the end
    if (stringValue.contains('e')) {
      append = 'e' + stringValue.split('e')[1];
      stringValue = stringValue.split('e')[0];
    }

    //remove trailing zeros (just fractional part)
    if (stringValue.contains('.')) {
      var firstZeroIndex = stringValue.length;
      for (; firstZeroIndex > stringValue.indexOf('.'); firstZeroIndex--) {
        var charAtIndex = stringValue.substring(firstZeroIndex - 1, firstZeroIndex);
        if (charAtIndex != '0' && charAtIndex != '.') break;
      }
      stringValue = stringValue.substring(0, firstZeroIndex);
    }
  }
  return stringValue + append; //append exponential part
}

String decToBase(String stringDec, int base) {
  var regExp = getBaseRegExp(10);
  if (!regExp.hasMatch(stringDec)) return '';

  var myString = '';
  String restoString;
  int resto;
  var dec = int.parse(stringDec);
  while (dec > 0) {
    resto = (dec % base);
    restoString = resto.toString();
    if (resto >= 10) {
      restoString = String.fromCharCode(resto + 55);
    }
    myString = restoString + myString; //aggiungo in testa
    dec = dec ~/ base;
  }
  return myString;
}

String baseToDec(String toBeConverted, int base) {
  toBeConverted = toBeConverted.toUpperCase();

  var regExp = getBaseRegExp(base);

  if (!regExp.hasMatch(toBeConverted)) return '';

  int conversion = 0;
  int len = toBeConverted.length;
  for (int i = 0; i < len; i++) {
    int unitCode = toBeConverted.codeUnitAt(i);
    if (unitCode >= 65 && unitCode <= 70) {
      // da A a F
      conversion = conversion + (unitCode - 55) * pow(base, len - i - 1).toInt();
    } else if (unitCode >= 48 && unitCode <= 57) {
      //da 0 a 9
      conversion = conversion + (unitCode - 48) * pow(base, len - i - 1).toInt();
    }
  }
  return conversion.toString();
}

RegExp getBaseRegExp(int base) {
  assert([2, 8, 10, 16].contains(base), 'Base not supported');
  switch (base) {
    case 2:
      return RegExp(r'^[0-1]+$');
    case 8:
      return RegExp(r'^[0-7]+$');
    case 16:
      return RegExp(r'^[0-9A-Fa-f]+$');
    case 10:
    default:
      return RegExp(r'^[0-9]+$');
  }
}
