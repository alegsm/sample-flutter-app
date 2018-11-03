import 'package:flutter/material.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';

class Sharp{

  static BoxDecoration defaultBoxDecoration({Color borderColor = Colors.black, Color backgroundColor = Colors.transparent})
  {
    return new BoxDecoration(color: backgroundColor, border: new Border.all(color: borderColor));
  }
}