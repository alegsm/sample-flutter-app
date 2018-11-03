import 'package:flutter/material.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';



class JumpStartImageButton extends StatelessWidget {

  final Widget _image;
  final double _width;
  final double _height;
  final Function _onPressed;

  JumpStartImageButton(
    {
      double width = JumpStartConstant.defaultImageButtonSize,
      double height = JumpStartConstant.defaultImageButtonSize,
      Function onPressed,
      Widget image,
    }):

    this._width = width,
    this._image = image,
    this._height = height,
    this._onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: _width,
      height: _height,
      child: new FlatButton(
        child: _image,
        onPressed: _onPressed,
        padding: EdgeInsets.zero,
      )
    );
  }
}