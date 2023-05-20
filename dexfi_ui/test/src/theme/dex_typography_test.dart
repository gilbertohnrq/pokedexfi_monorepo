import 'package:dexfi_ui/src/theme/dex_typography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('headlineBold returns Text with correct TextStyle',
      (WidgetTester tester) async {
    Text text = const Text('headlineBold').headlineBold();
    TextStyle? style = text.style;

    expect(style!.fontSize, TypographyFontSize.headline);
    expect(style.fontWeight, TypographyFontWeight.bold);
    expect(style.height, TypographyLineHeight.headline);
  });

  testWidgets('subtitle3Bold returns Text with correct TextStyle',
      (WidgetTester tester) async {
    Text text = const Text('subtitle3Bold').subtitle3Bold();
    TextStyle? style = text.style;

    expect(style!.fontSize, TypographyFontSize.subtitle3);
    expect(style.fontWeight, TypographyFontWeight.bold);
    expect(style.height, TypographyLineHeight.subtitle);
  });

  testWidgets('subtitle1Bold returns Text with correct TextStyle',
      (WidgetTester tester) async {
    Text text = const Text('subtitle1Bold').subtitle1Bold();
    TextStyle? style = text.style;

    expect(style!.fontSize, TypographyFontSize.subtitle1);
    expect(style.fontWeight, TypographyFontWeight.bold);
    expect(style.height, TypographyLineHeight.subtitle);
  });

  testWidgets('subtitle2Bold returns Text with correct TextStyle',
      (WidgetTester tester) async {
    Text text = const Text('subtitle2Bold').subtitle2Bold();
    TextStyle? style = text.style;

    expect(style!.fontSize, TypographyFontSize.subtitle2);
    expect(style.fontWeight, TypographyFontWeight.bold);
    expect(style.height, TypographyLineHeight.subtitle);
  });

  testWidgets('body3Regular returns Text with correct TextStyle',
      (WidgetTester tester) async {
    Text text = const Text('body3Regular').body3Regular();
    TextStyle? style = text.style;

    expect(style!.fontSize, TypographyFontSize.body3);
    expect(style.fontWeight, TypographyFontWeight.regular);
    expect(style.height, TypographyLineHeight.body);
  });

  testWidgets('body1Regular returns Text with correct TextStyle',
      (WidgetTester tester) async {
    Text text = const Text('body1Regular').body1Regular();
    TextStyle? style = text.style;

    expect(style!.fontSize, TypographyFontSize.body1);
    expect(style.fontWeight, TypographyFontWeight.regular);
    expect(style.height, TypographyLineHeight.body);
  });

  testWidgets('body2Regular returns Text with correct TextStyle',
      (WidgetTester tester) async {
    Text text = const Text('body2Regular').body2Regular();
    TextStyle? style = text.style;

    expect(style!.fontSize, TypographyFontSize.body2);
    expect(style.fontWeight, TypographyFontWeight.regular);
    expect(style.height, TypographyLineHeight.body);
  });

  testWidgets('captionRegular returns Text with correct TextStyle',
      (WidgetTester tester) async {
    Text text = const Text('captionRegular').captionRegular();
    TextStyle? style = text.style;

    expect(style!.fontSize, TypographyFontSize.caption);
    expect(style.fontWeight, TypographyFontWeight.regular);
    expect(style.height, TypographyLineHeight.caption);
  });
}
