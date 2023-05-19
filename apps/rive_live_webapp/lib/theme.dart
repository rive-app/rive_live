// ignore_for_file: implementation_imports

import 'package:flutter/widgets.dart';

/// Colors used in the Rive Theme
/// Define them as getters and keep them const
class RiveColors {
  factory RiveColors() => _instance;
  const RiveColors._();
  static const RiveColors _instance = RiveColors._();

  Color get grey11 => const Color(0xFF111111);
  Color get grey18 => const Color(0xFF181818);
  Color get grey1D => const Color(0xFF1D1D1D);
  Color get grey20 => const Color(0xFF202020);
  Color get grey24 => const Color(0xFF242424);
  Color get grey28 => const Color(0xFF282828);
  Color get grey32 => const Color(0xFF323232);
  Color get grey38 => const Color(0xFF383838);
  Color get grey44 => const Color(0xFF444444);
  Color get grey66 => const Color(0xFF666666);
  Color get grey70 => const Color(0xFF707070);
  Color get grey88 => const Color(0xFF888888);
  Color get grey8C => const Color(0xFF8C8C8C);
  Color get greyAA => const Color(0xFFAAAAAA);
  Color get greyCC => const Color(0xFFCCCCCC);
  Color get greyDC => const Color(0xFFDCDCDC);
  Color get greyEC => const Color(0xFFEBEBEB);
  Color get greyF1 => const Color(0xFFF1F1F1);

  Color get white => const Color(0xFFFFFFFF);
  Color get black => const Color(0xFF000000);
  Color get transparent => const Color(0x00000000);

  Color get blue => const Color(0xFF57A5E0);
  Color get blueAlt => const Color(0xFF33A7FF);
  Color get blueLight => const Color(0xFF79B7E6);
  Color get magenta => const Color(0xFFFF5678);
  Color get magentaDark => const Color(0xFFD041AB);
  Color get green => const Color(0xFF4CBE9C);
  Color get greenLight => const Color(0xFF5Bcaae);
  Color get amber => const Color(0xFFF6C566);
  Color get amberLight => const Color(0xFFFFD582);
  Color get red => const Color(0xFFFD2040);
  Color get redLight => const Color(0xFFFF3B58);
}
