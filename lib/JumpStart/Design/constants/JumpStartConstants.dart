import 'package:flutter/material.dart';

class JumpStartConstant
{
  static const int STYLE_CLEAN = 0;
  static const int STYLE_ROUND = 1;
  static const int STYLE_SHARP = 2;

  static const double defaultFontSizeHuge = 40.0;
  static const double defaultFontSizeBigger = 20.0;
  static const double defaultFontSizeBig = 16.0;
  static const double defaultFontSize = 14.0;
  static const double defaultFontSizeSmall = 10.0;

  static const double defaultButtonWidth = 100.0;
  static const double defaultButtonHeight = 70.0;

  static const double defaultInputBorderWidth = 1.0;
  static const double defaultImageButtonSize = 40.0;
  static const Color defaultInputColor = Colors.blue;
  static const Color defaultButtonColor = Colors.white;
  static const Color defaultErrorColor = Colors.redAccent;

  static const BorderStyle defaultInputBorderStyle = BorderStyle.solid;
  static const BorderSide defaultBorderSide = const BorderSide(color: defaultInputColor, width: defaultInputBorderWidth, style: defaultInputBorderStyle);
  static const Border defaultBorder = const Border(top: defaultBorderSide, bottom: defaultBorderSide, left: defaultBorderSide, right: defaultBorderSide);

  static const EdgeInsets buttonDefaultMargins = const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0);
  static const EdgeInsets buttonInputDefaultPadding = const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0);

  static const EdgeInsets textInputDefaultMargins = const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0);
  static const EdgeInsets textInputDefaultPadding = const EdgeInsets.fromLTRB(15.0, 0.0, 5.0, 0.0);
  static const TextStyle defaultButtonTextStyle =  const TextStyle(color: defaultButtonColor, fontSize: defaultFontSize);
  static const TextStyle defaultTextStyle =  const TextStyle(color: defaultInputColor, fontSize: defaultFontSize);
  static const TextStyle defaultTextStyleBig =  const TextStyle(color: defaultInputColor, fontSize: defaultFontSizeBig);
  static const TextStyle defaultTextStyleBigger =  const TextStyle(color: defaultInputColor, fontSize: defaultFontSizeBigger);
  static const TextStyle defaultTextStyleHuge =  const TextStyle(color: defaultInputColor, fontSize: defaultFontSizeHuge);
  static const TextStyle defaultTextStyleSmall =  const TextStyle(color: defaultInputColor, fontSize: defaultFontSizeSmall);
  static const TextStyle defaultErrorTextStyle =  const TextStyle(color: defaultErrorColor, fontSize: defaultFontSizeSmall, height: 2.0);
}