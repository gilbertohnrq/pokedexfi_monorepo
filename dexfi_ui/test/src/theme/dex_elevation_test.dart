import 'dart:ui';

import 'package:dexfi_ui/src/theme/dex_elevation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DexElevation dropShadow1 should have correct properties', () {
    final shadows = DexElevation.dropShadow1;

    expect(shadows.length, 1);

    final boxShadow = shadows[0];
    expect(boxShadow.color, const Color(0xFF000000).withOpacity(0.2));
    expect(boxShadow.blurRadius, 2.0);
    expect(boxShadow.offset.dx, 0);
    expect(boxShadow.offset.dy, 1);
  });
}
