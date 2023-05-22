import 'package:flutter/material.dart';

import '../../dexfi_ui.dart';

class DexVerticalDivider extends StatelessWidget {
  const DexVerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      color: DexColors.lightGray,
    );
  }
}
