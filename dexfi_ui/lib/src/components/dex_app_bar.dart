import 'package:flutter/material.dart';

class DexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DexAppBar({super.key, required this.title, required this.color});

  final Widget title;
  final Color color;

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    double height = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height * 0.1750
        : MediaQuery.of(context).size.height * 0.28;

    return Container(
      height: height,
      color: color,
      alignment: Alignment.center,
      child: title,
    );
  }
}
