class Unit {
  /// The value of the unit of measurement.
  double? _value;
  double? get value => _value;
  set value(double? val) {
    _value = val;
    _stringValue = null;
  }

  /// The String representation of [value]. It could be changed according to
  /// other parameters of the property (e.g. `significantFigures`,
  /// `removeTrailingZeros` and `useScientificNotation`).
  String? _stringValue;
  String? get stringValue {
    if (_stringValue != null) return _stringValue;
    if (_value == null) return null;
    if (stringValueCallback != null) {
      _stringValue = stringValueCallback!(_value!);
      return _stringValue;
    }
    return _value.toString();
  }

  set stringValue(String? val) {
    _stringValue = val;
  }

  String Function(double)? stringValueCallback;

  /// The name of the unit (e.g. LENGTH.meters, VOLUME.liters).
  dynamic name;

  /// The symbols that represent the unit (e.g. "m" stands for meters, "l"
  /// stands for liter).
  String? symbol;

  /// The class that defines a unit of measurement object.
  Unit(this.name, {double? value, this.symbol}) {
    this.value = value;
  }
}
