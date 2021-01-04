import 'dart:math';

class Unit {
  double value;
  String stringValue;
  var name;
  String symbol;
  Unit(this.name, {this.value, this.stringValue, this.symbol});
}

const LINEAR_CONVERSION = 1; // y=ax+b
const RECIPROCO_CONVERSION = 2; // y=(a/x)+b
const BASE_CONVERSION = 3; // conversione speciale (dec è father e tutti gli altri figlio)

class Node {
  Node({
    this.leafNodes,
    this.coefficientProduct = 1.0,
    this.coefficientSum = 0.0,
    this.name,
    this.value,
    this.convertedNode = false,
    this.selectedNode = false,
    this.conversionType = LINEAR_CONVERSION,
    this.valueString,
    this.base,
  });

  List<Node> leafNodes;
  double coefficientProduct;
  double coefficientSum;
  double value;
  var name;
  bool convertedNode;
  bool selectedNode;
  int conversionType;
  int base;
  String valueString;

  void convert() {
    if (!convertedNode) {
      //se non è già convertito
      for (var node in leafNodes) {
        //per ogni nodo foglia controlla se ha valore
        switch (node.conversionType) {
          case LINEAR_CONVERSION:
            {
              _linearConvert(node);
              break;
            }
          case RECIPROCO_CONVERSION:
            {
              _reciprocoConvert(node);
              break;
            }
          case BASE_CONVERSION:
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
        case LINEAR_CONVERSION:
          {
            _linearApplyDown(node);
            break;
          }
        case RECIPROCO_CONVERSION:
          {
            _reciprocoApplyDown(node);
            break;
          }
        case BASE_CONVERSION:
          {
            _baseApplyDown(node);
            break;
          }
      }
    }
  }

  void _linearConvert(Node node) {
    //da basso a alto
    if (node.convertedNode) {
      //se un nodo foglia è già stato convertito
      value = node.value == null //faccio in calcoli del nodo padre rispetto a lui
          ? null
          : (node.value * node.coefficientProduct) + (node.coefficientSum); //metto in questo nodo il valore convertito
      convertedNode = true;
      _applyDown(); //converto i nodi sottostanti
    } else if (node.leafNodes != null) {
      //Però ha almeno un nodo foglia
      node.convert(); //ripeti la procedura
      if (node.convertedNode) convert();
    }
  }

  void _linearApplyDown(Node node) {
    //da alto a a basso
    node.value = value == null ? null : (value - node.coefficientSum) * (1 / node.coefficientProduct); //attenzione qui funziona al contrario
    node.convertedNode = true;

    if (node.leafNodes != null) //se ha almeno un nodo foglia allora continuo
      node._applyDown();
  }

  void _reciprocoConvert(Node node) {
    //da basso a alto
    if (node.convertedNode) {
      //se un nodo foglia è già stato convertito
      value = node.value == null //faccio in calcoli del nodo padre rispetto a lui
          ? null
          : (node.coefficientProduct / node.value) + node.coefficientSum; //metto in questo nodo il valore convertito
      convertedNode = true;
      _applyDown(); //converto i nodi sottostanti
    } else if (node.leafNodes != null) {
      //Però ha almeno un nodo foglia
      node.convert(); //ripeti la procedura
      if (node.convertedNode) convert();
    }
  }

  void _reciprocoApplyDown(Node node) {
    //da alto a a basso
    node.value = value == null ? null : node.coefficientProduct / (value - node.coefficientSum); //attenzione qui funziona al contrario
    node.convertedNode = true;

    if (node.leafNodes != null) //se ha almeno un nodo foglia allora continuo
      node._applyDown();
  }

  //attenzione! Questo tipo di conversione è stata costruita esclusivamente sulla struttura dec-(bin-oct-hex). Un padre con 3 figli
  void _baseConvert(Node node) {
    //da basso a alto
    if (node.convertedNode) {
      //se un nodo foglia è già stato convertito
      if (node.valueString == null)
        valueString = null;
      else {
        valueString = baseToDec(node.valueString, node.base);
      }
      convertedNode = true;
      _applyDown(); //converto i nodi sottostanti
    } else if (node.leafNodes != null) {
      //Però ha almeno un nodo foglia
      node.convert(); //ripeti la procedura
      if (node.convertedNode) convert();
    }
  }

  void _baseApplyDown(Node node) {
    //da alto a a basso
    if (valueString == null) {
      node.valueString = null;
    } else {
      node.valueString = decToBase(valueString, node.base);
    }

    node.convertedNode = true;

    if (node.leafNodes != null) //se ha almeno un nodo foglia allora continuo
      node._applyDown();
  }

  //Resetta convertedNode su false per i nodi non selezionati dall'alto al basso (bisogna quindi chiamarlo dal nodo padre)
  void resetConvertedNode() {
    if (!selectedNode) //se non è il nodo selezionato
      convertedNode = false; //resetto il fatto che il nodo sia già stato convertito
    if (leafNodes != null) {
      for (Node node in leafNodes) {
        //per ogni nodo dell'albero
        node.resetConvertedNode();
      }
    }
  }

  // Resetta tutti i valori dei nodi (da chiamare sul nodo padre)
  void clearAllValues() {
    List<Node> listanodi = _getNodiFiglio();
    for (Node nodo in listanodi) {
      nodo.value = null;
      nodo.valueString = null;
    }
  }

  //Da chiamare sul nodo padre, resetta lo stato di selezionato per tutti i nodi (utile per cambio pagina)
  void clearSelectedNode() {
    List<Node> listanodi = _getNodiFiglio();
    for (Node nodo in listanodi) {
      nodo.selectedNode = false;
    }
  }

  List<Node> _getNodiFiglio() {
    List<Node> listaNodi = [this];
    if (leafNodes != null) {
      for (Node node in leafNodes) {
        listaNodi.addAll(node._getNodiFiglio());
      }
    }
    return listaNodi;
  }

  ///Returns the Node with name == unitName. If it is not found, returns null
  Node getByName(var unitName) {
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
  String stringValue = value.toStringAsPrecision(significantFigures);
  String append = "";

  //if the user want to remove the trailing zeros
  if (removeTrailingZeros) {
    //remove exponential part and append to the end
    if (stringValue.contains("e")) {
      append = "e" + stringValue.split("e")[1];
      stringValue = stringValue.split("e")[0];
    }

    //remove trailing zeros (just fractional part)
    if (stringValue.contains(".")) {
      int firstZeroIndex = stringValue.length;
      for (; firstZeroIndex > stringValue.indexOf("."); firstZeroIndex--) {
        String charAtIndex = stringValue.substring(firstZeroIndex - 1, firstZeroIndex);
        if (charAtIndex != "0" && charAtIndex != ".") break;
      }
      stringValue = stringValue.substring(0, firstZeroIndex);
    }
  }
  return stringValue + append; //append exponential part
}

String decToBase(String stringDec, int base) {
  RegExp regExp = getBaseRegExp(10);
  if (!regExp.hasMatch(stringDec)) return "";

  String myString = "";
  String restoString;
  int resto;
  int dec = int.parse(stringDec);
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

String baseToDec(String daConvertire, int base) {
  daConvertire = daConvertire.toUpperCase();

  RegExp regExp = getBaseRegExp(base);

  if (!regExp.hasMatch(daConvertire)) return "";

  int conversione = 0;
  int len = daConvertire.length;
  for (int i = 0; i < len; i++) {
    int unitCode = daConvertire.codeUnitAt(i);
    if (unitCode >= 65 && unitCode <= 70) {
      // da A a F
      conversione = conversione + (unitCode - 55) * pow(base, i);
    } else if (unitCode >= 48 && unitCode <= 57) {
      //da 0 a 9
      conversione = conversione + (unitCode - 48) * pow(base, len - i - 1);
    }
  }
  return conversione.toString();
}

RegExp getBaseRegExp(int base) {
  RegExp regExp;
  switch (base) {
    case 2:
      {
        regExp = new RegExp(r'^[0-1]+$');
        break;
      }
    case 8:
      {
        regExp = new RegExp(r'^[0-7]+$');
        break;
      }
    case 10:
      {
        regExp = new RegExp(r'^[0-9]+$');
        break;
      }
    case 16:
      {
        regExp = new RegExp(r'^[0-9A-Fa-f]+$');
        break;
      }
  }
  return regExp;
}
