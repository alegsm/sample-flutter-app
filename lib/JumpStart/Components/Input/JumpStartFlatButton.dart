import 'package:flutter/material.dart';
import 'package:appfolio/JumpStart/Design/constants/Round.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';

class JumpStartFlatButton extends StatelessWidget {

  final BorderRadius _borderRadius;
  final Color _backgroundColor;
  final TextStyle _textStyle;
  final Alignment _alignment;
  final Function _onPressed;
  final EdgeInsets _margins;
  final EdgeInsets _padding;
  final int _designStyle;
  final double _height;
  final Border _border;
  final double _width;
  final String _text;
  final Icon _icon;

  JumpStartFlatButton(
    {
      BorderRadius borderRadius = Round.defaultRadius,
      Color backgroundColor = JumpStartConstant.defaultInputColor,
      TextStyle textStyle = JumpStartConstant.defaultButtonTextStyle,
      Alignment alignment = Alignment.center,
      Function onPressed,
      EdgeInsets margins = JumpStartConstant.buttonDefaultMargins,
      EdgeInsets padding = JumpStartConstant.buttonInputDefaultPadding,
      int designStyle = JumpStartConstant.STYLE_ROUND,
      double height = JumpStartConstant.defaultButtonHeight,
      Border border = JumpStartConstant.defaultBorder,
      double width = JumpStartConstant.defaultButtonWidth,
      String text = "",
      Icon icon,
    })
      :
      this._backgroundColor = backgroundColor,
      this._borderRadius = borderRadius,
      this._designStyle = designStyle,
      this._textStyle = textStyle,
      this._alignment = alignment,
      this._onPressed = onPressed,
      this._margins = margins,
      this._padding = padding,
      this._height = height,
      this._border = border,
      this._width = width,
      this._text = text,
      this._icon = icon;


  @override
  Widget build(BuildContext context) {

    if(_icon != null)
    {
      return new Align(
          alignment: const Alignment(0.0, -0.2),
          child: new Container(
            margin: _margins,
            padding: _padding,
            decoration: generateBoxDecoration(),
            child: new FlatButton.icon(
              icon: _icon,

              label:
              new Text(
                _text,
                style: _textStyle,
              ),
              onPressed: _onPressed,
            ),
          )
      );
    }
    else {
      return new Align(
          alignment: const Alignment(0.0, -0.2),
          child: new Container(
            margin: _margins,
            decoration: generateBoxDecoration(),
            child: new FlatButton(
              padding: _padding,
              child:
              new Text(
                _text,
                style: _textStyle,
              ),
              onPressed: _onPressed,
            ),
          )
      );
    }
  }

  BoxDecoration generateBoxDecoration()
  {
    BorderRadius radius;
    Border border;
    BoxDecoration decoration = new BoxDecoration();

    if(_designStyle == JumpStartConstant.STYLE_SHARP)
    {
      radius = BorderRadius.zero;
    }
    if(_designStyle == JumpStartConstant.STYLE_ROUND)
    {
      radius = _borderRadius;
    }

    if(radius != null) {
      border = _border;
      return new BoxDecoration(
        color: _backgroundColor,
        borderRadius: radius,
        border: border,
      );
    }

    else {
      return decoration;
    }
  }
}


