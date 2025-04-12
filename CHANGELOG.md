# 3.0.3
- New mass unit: grains (@TheRealFakeAdmin)
- New density units: lb/in³ and lb/ft³ (@Kheirlb)
- New pressure units: ksi, megapascal (@Kheirlb)

# 3.0.2
- Minor refinements to US volume units (cups, tablespoon, teaspoon)

# 3.0.1
- New unit: imperial quarts (@jacksonlo)
- New unit: teaspoon US (@vasba)

# 3.0.0
- Improvements to the conversion algorithm: now it is simpler and ~10% faster
- Now requires Dart >= 3.0
- New unit: kilopascal (@jmguazzo)

**Breaking**:
- In custom conversion `leafNodes` has been renamed to `children`

# 2.1.1
- Added Illuminance property (@denxorz)
- Added kilojoules (@lhengl)
- Fixed typos (@denxorz)
- Bump Dart constraints

# 2.1.0
Added 5 new properties: density, amount of substance, molar volume, molar mass
and reciprocal of molar mass. Now it is also possible to define a compound unit
in the form of a ratio (e.g. Density units are defined as the ratio between mass
and volume).

Thanks to @Dokotela for his PRs!

# 2.0.1
- Improved Pascal-Bar conversion
- We forced the use of types. So that many more error will be caught at
compile-time. E.g. ConversionNode has an associated type that is the type of the
name (e.g. LENGTH, AREA, etc.)

# 2.0.0
- We finally introduce extensions on `num` and `String`. Checkout the
documentation for more details. Now you can easily convert in this way: 
```dart
1.convertFromTo(LENGTH.meters, LENGTH.inches)
```

- We also refactor a little bit the code: now all the properties inherit from
`CustomProperty`, this change leads to a reduction of ~500 lines of code.

- We fixed a wrong conversion (energy foot pound)

**Breaking**:
- `Node` becomes `ConversionNode`
- `SimpleCustomConversion` becomes
`SimpleCustomProperty`
- `CustomConversion` becomes `CustomProperty`


# 1.2.0
Improved the formatting of the string representation of the number
(`stringValue`): now it is also possible to choose between decimal or
scientific notation. Added feet (US survey), feet squared (US survey) and
kilocalories.

# 1.1.1+2
Fix links in `README.md`.

# 1.1.1+1
Updated `README.md`.

# 1.1.1
Fix compatibility issue of 1.1.0 with the previous release.

# 1.1.0
In this release we added a complete `CustomConversion` definition. You are not
anymore tied to `SimpleCustomProperty`! Check it out in the updated README. We
also simplified all the code!

# 1.0.0
`units_converter` is stable since some releases. In this first 1.x version we
made a huge work to improve the algorithm conversion. Now it is **2x faster**
then the previous one and it is simpler (less line of code with known
algorithms). We added more test, the **code coverage is now 100%**. This release
will not break anything, it is compatible with the previous one.

# 0.4.1
Added hectoPascal. Added a bunch of other test (99% code coverage). Minor bug
fix (non-critical).

# 0.4.0
Breaking. In this release we used the `lints` package and changed enum to
camelCase. We also added minutes/kilometer and energy foot pounds units.

# 0.3.0+1
Added mils.

# 0.3.0
Add support for null safety. Added some test. Added fluid ounces, gill,
pennyweight, troy ounce. Bugfix.

# 0.2.0+2
Fix time typo and time symbols

# 0.2.0+1
Fix force conversion. Fix some comment and README

# 0.2.0
Added Property class. It is the parent of all the properties. In this way we can
also remove some code. Now you can assign a custom name to a Property object.

# 0.1.0
First release
