
import 'package:flutter/material.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpStartFormValidators.dart';

import 'package:appfolio/JumpStart/Components/Input/JumpStartFormField.dart';
import 'package:appfolio/JumpStart/Helpers/UI/JumpStartSharedDrawer.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpstartTextField.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpStartImageButton.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpStartFlatButton.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';
import 'package:appfolio/JumpStart/Design/constants/Round.dart';

class JumpStartDatePickerButton extends StatefulWidget {
  final TextStyle _textStyle;
  final Color _backgroundColor;
  final String _text;
  final Border _border;
  final int _designStyle;
  final Function _onDateSaved;
  final DateTime _selectedDate;
  final DateTime _minDate;
  final DateTime _maxDate;
  final EdgeInsets _padding;


  JumpStartDatePickerButton({
    TextStyle style = JumpStartConstant.defaultTextStyle,
    Color backgroundColor = Colors.transparent,
    String text = "",
    Border border = JumpStartConstant.defaultBorder,
    int designStyle = JumpStartConstant.STYLE_ROUND,
    Function onDateSaved,
    DateTime selectedDate,
    DateTime minDate,
    DateTime maxDate,
    EdgeInsets padding = JumpStartConstant.buttonInputDefaultPadding,
  })
  :
  _textStyle = style,
  _padding = padding,
  _backgroundColor = backgroundColor,
  _text = text,
  _border = border,
  _designStyle = designStyle,
  _onDateSaved = onDateSaved,
  _selectedDate = selectedDate,
  _minDate = minDate,
  _maxDate = maxDate;


  @override
  _JumpStartDatePickerButtonState createState() => new _JumpStartDatePickerButtonState();
}

class _JumpStartDatePickerButtonState extends State<JumpStartDatePickerButton> {


  String buttonText = "";
  DateTime selectedDate = new DateTime.now();
  DateTime minDate;
  DateTime maxDate;

  @override
  void initState() {
    super.initState();
    buttonText =  widget._text;
    if(widget._selectedDate != null)
    {
      selectedDate = widget._selectedDate;
    }
    if(widget._minDate != null)
    {
      selectedDate = widget._selectedDate;
    }
    else
    {
      minDate = new DateTime(selectedDate.year - 2);
    }

    if(widget._maxDate != null)
    {
      maxDate = widget._maxDate;
    }
    else
    {
      maxDate = new DateTime(selectedDate.year + 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new JumpStartFlatButton(
      margins: EdgeInsets.zero,
      textStyle: widget._textStyle,
      text: buttonText,
      padding: widget._padding,
      backgroundColor: widget._backgroundColor,
      border: widget._border,
      designStyle: widget._designStyle,
      onPressed: _selectDate);
  }

  _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: minDate,
        lastDate: maxDate
    );
    if (picked != null) {
      if(widget._onDateSaved != null)
        widget._onDateSaved(picked);
      setState(() {
        buttonText = "${picked.day} / ${picked.month} / ${picked.year}";
      });
    }
  }
}
