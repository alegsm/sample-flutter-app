import 'package:flutter/material.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';
import 'package:appfolio/JumpStart/Design/constants/Round.dart';

class JumpStartTextField extends StatelessWidget {

  final TextEditingController _controller;
  final InputDecoration _inputDecoration;
  final BorderRadius _roundBorderRadius;
  final Function _onChangeListener;
  final BorderStyle _borderStyle;
  final TextInputType _inputType;
  final Color _backgroundColor;
  final double _errorFontSize;
  final double _borderWidth;
  final EdgeInsets _margins;
  final String _errorString;
  final EdgeInsets _padding;
  final Color _borderColor;
  final Color _errorColor;
  final String _labelText;
  final Color _labelColor;
  final TextStyle _textStyle;
  final Color _hintColor;
  final int _designStyle;
  final double _fontSize;
  final String _hint;
  final bool _isPassword;

  JumpStartTextField(
      {
        String hint = "",
        String labelText,
        String errorString,
        Color backgroundColor,
        Function changeListener,
        TextEditingController controller,
        TextInputType inputType = TextInputType.text,
        int designStyle = JumpStartConstant.STYLE_ROUND,
        double fontSize = JumpStartConstant.defaultFontSize,
        double errorFontSize = JumpStartConstant.defaultFontSize,
        BorderRadius roundBorderRadius = Round.defaultRadius,
        Color hintColor = JumpStartConstant.defaultInputColor,
        Color errorColor = JumpStartConstant.defaultErrorColor,
        TextStyle textStyle = JumpStartConstant.defaultTextStyle,
        Color labelColor = JumpStartConstant.defaultInputColor,
        Color borderColor = JumpStartConstant.defaultInputColor,
        double borderWidth = JumpStartConstant.defaultInputBorderWidth,
        EdgeInsets margins = JumpStartConstant.textInputDefaultMargins,
        EdgeInsets padding = JumpStartConstant.textInputDefaultPadding,
        BorderStyle borderStyle = JumpStartConstant.defaultInputBorderStyle,
        bool isPassword = false, InputDecoration inputDecoration,
      })

      : this._hint = hint, this._onChangeListener = changeListener,
        this._controller = controller, this._errorString = errorString,
        this._borderColor = borderColor, this._borderWidth = borderWidth,
        this._backgroundColor = backgroundColor, this._hintColor = hintColor,
        this._labelText = labelText, this._inputType = inputType,
        this._labelColor = labelColor, this._borderStyle = borderStyle,
        this._designStyle = designStyle, this._margins = margins,
        this._padding = padding, this._roundBorderRadius = roundBorderRadius,
        this._fontSize = fontSize, this._errorFontSize = errorFontSize,
        this._errorColor = errorColor, this._textStyle = textStyle,
        this._isPassword = isPassword, this._inputDecoration = inputDecoration;

  @override
  Widget build(BuildContext context) {

    EdgeInsets padding = _padding;

    if(_errorString != null)
    {
      padding = new EdgeInsets.fromLTRB(_padding.left, _padding.top, _padding.right, _padding.bottom + 7.0);
    }

    return new Container(
        margin: _margins,
        padding: padding,
        decoration: generateBoxDecoration(),
        child: generateTextFieldWidget());

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
      radius = _roundBorderRadius;
    }

    if(radius != null) {
      border = new Border.all(
          color: _borderColor, width: _borderWidth, style: _borderStyle);
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

  TextField generateTextFieldWidget()
  {
    return new TextField(
        style: _textStyle,
        controller: getController(),
        onChanged: getChangeListener(),
        keyboardType: _inputType,
        obscureText: _isPassword,
        decoration: generateInputDecoration()
    );
  }

  InputDecoration generateInputDecoration()
  {
    if(_inputDecoration != null)
    {
      return _inputDecoration;
    }
    else {
      InputDecoration decoration = new InputDecoration(

        hintText: _hint,
        labelText: _labelText,
        errorText: _errorString,
        errorStyle: new TextStyle(
            color: _errorColor,
            fontSize: _errorFontSize),
        border: InputBorder.none,
        hintStyle: new TextStyle(color: _hintColor, fontSize: _fontSize),
        labelStyle: new TextStyle(color: _hintColor, fontSize: _fontSize),
      );
      return decoration;
    }
  }

  TextEditingController getController() {
    if(_controller != null) {
      return _controller;
    }
    else
    {
      return new TextEditingController();
    }
  }

  Function getChangeListener() {
    if(_onChangeListener != null) {
      return _onChangeListener;
    }
    else
    {
      return (String newString){};
    }
  }
}
