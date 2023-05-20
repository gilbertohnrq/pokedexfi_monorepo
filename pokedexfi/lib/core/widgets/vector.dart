import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedexfi/core/extensions/string_extensions.dart';

enum Vectors { pokeball, pokePlaceholder }

class Vector extends StatelessWidget {
  const Vector(
    this.vector, {
    Key? key,
    this.size,
    this.color,
    this.path,
  }) : super(key: key);

  final Vectors? vector;
  final double? size;
  final Color? color;
  final String? path;

  @override
  Widget build(BuildContext context) {
    if (vector == null) return Container();
    String fileName = describeEnum(vector!).toSnakeCase();
    String path = this.path ?? 'icons';

    path = 'assets/$path/$fileName.svg';

    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? DexColors.white, BlendMode.srcIn),
    );
  }
}
