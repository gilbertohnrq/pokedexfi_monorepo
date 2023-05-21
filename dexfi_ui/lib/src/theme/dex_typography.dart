import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';

abstract class TypographyFontSize {
  static const double headline = 24.0;
  static const double subtitle3 = 10.0;
  static const double subtitle1 = 14.0;
  static const double subtitle2 = 12.0;
  static const double body3 = 10.0;
  static const double body1 = 14.0;
  static const double body2 = 16.0;
  static const double caption = 8.0;
}

abstract class TypographyFontWeight {
  static const FontWeight bold = FontWeight.bold;
  static const FontWeight regular = FontWeight.w400;
}

abstract class TypographyLineHeight {
  static const double headline =
      TypographyFontSize.headline / TypographyFontSize.headline;
  static const double subtitle =
      TypographyFontSize.subtitle1 / TypographyFontSize.subtitle3;
  static const double body =
      TypographyFontSize.body1 / TypographyFontSize.body3;
  static const double caption =
      TypographyFontSize.caption / TypographyFontSize.caption;
}

extension DexTypography on Text {
  TextStyle _setDefaultStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    TextStyle? mergeStyle,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      color: color ?? DexColors.mediumGray,
      fontStyle: FontStyle.normal,
      fontFamily: 'Poppins',
    ).merge(mergeStyle);
  }

  Text _returnTextTypography({required TextStyle textStyle}) {
    return Text(
      data!,
      style: textStyle,
    );
  }

  Text headlineBold({TextStyle? style, Color? color}) {
    TextStyle defaultStyle = _setDefaultStyle(
            fontSize: TypographyFontSize.headline,
            fontWeight: TypographyFontWeight.bold,
            height: TypographyLineHeight.headline,
            color: color)
        .merge(style);

    return _returnTextTypography(textStyle: defaultStyle);
  }

  Text subtitle3Bold({TextStyle? style, Color? color}) {
    TextStyle defaultStyle = _setDefaultStyle(
            fontSize: TypographyFontSize.subtitle3,
            fontWeight: TypographyFontWeight.bold,
            height: TypographyLineHeight.subtitle,
            color: color)
        .merge(style);

    return _returnTextTypography(textStyle: defaultStyle);
  }

  Text subtitle1Bold({TextStyle? style, Color? color}) {
    TextStyle defaultStyle = _setDefaultStyle(
      fontSize: TypographyFontSize.subtitle1,
      fontWeight: TypographyFontWeight.bold,
      height: TypographyLineHeight.subtitle,
      color: color,
    ).merge(style);

    return _returnTextTypography(textStyle: defaultStyle);
  }

  Text subtitle2Bold({TextStyle? style, Color? color}) {
    TextStyle defaultStyle = _setDefaultStyle(
      fontSize: TypographyFontSize.subtitle2,
      fontWeight: TypographyFontWeight.bold,
      height: TypographyLineHeight.subtitle,
      color: color,
    ).merge(style);

    return _returnTextTypography(textStyle: defaultStyle);
  }

  Text body3Regular({TextStyle? style, Color? color}) {
    TextStyle defaultStyle = _setDefaultStyle(
      fontSize: TypographyFontSize.body3,
      fontWeight: TypographyFontWeight.regular,
      height: TypographyLineHeight.body,
      color: color,
    ).merge(style);

    return _returnTextTypography(textStyle: defaultStyle);
  }

  Text body1Regular({TextStyle? style, Color? color}) {
    TextStyle defaultStyle = _setDefaultStyle(
      fontSize: TypographyFontSize.body1,
      fontWeight: TypographyFontWeight.regular,
      height: TypographyLineHeight.body,
      color: color,
    ).merge(style);

    return _returnTextTypography(textStyle: defaultStyle);
  }

  Text body2Regular({TextStyle? style, Color? color}) {
    TextStyle defaultStyle = _setDefaultStyle(
      fontSize: TypographyFontSize.body2,
      fontWeight: TypographyFontWeight.regular,
      height: TypographyLineHeight.body,
      color: color,
    ).merge(style);

    return _returnTextTypography(textStyle: defaultStyle);
  }

  Text captionRegular({TextStyle? style, Color? color}) {
    TextStyle defaultStyle = _setDefaultStyle(
      fontSize: TypographyFontSize.caption,
      fontWeight: TypographyFontWeight.regular,
      height: TypographyLineHeight.caption,
      color: color,
    ).merge(style);

    return _returnTextTypography(textStyle: defaultStyle);
  }
}
