import 'package:flutter/painting.dart';

class DexElevation {
  const DexElevation._();

  static final dropShadow1 = [
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.2),
      blurRadius: 2.0,
      offset: const Offset(0, 1),
    ),
  ];

  static final dropShadow2 = [
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.2),
      blurRadius: 6.0,
      offset: const Offset(0, 3),
    ),
  ];

  static final innerShadow1 = [
    BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.2),
      blurRadius: 2.0,
      offset: const Offset(0, 0),
      spreadRadius: -2.0,
    ),
  ];
}
