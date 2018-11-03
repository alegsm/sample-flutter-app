import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:appfolio/JumpStart/Components/Input/JumpStartFormValidators.dart';

import 'package:appfolio/JumpStart/Helpers/UI/JumpStartSharedDrawer.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpstartTextField.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpStartImageButton.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpStartFlatButton.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';
import 'package:appfolio/JumpStart/Design/constants/Round.dart';


class JumpStartFormField extends StatelessWidget {

  final String _hint;
  final String _text;
  final Function _onSave;
  final bool _isPassword;
  final bool _showNextIcon;
  final int _validatorType;
  final bool _requiredField;
  final String _customMessage;
  final int _validatorMaxSize;
  final Function _customValidator;
  final EdgeInsets _margins;
  final TextInputType _inputType;
  final BoxDecoration decoration;
  final TextInputFormatter customFormatter;
  final Color nextIconColor;
  final TextStyle textStyle;
  final TextStyle errorTextStyle;

  JumpStartFormField({
    this.textStyle = JumpStartConstant.defaultTextStyle,
    this.errorTextStyle = JumpStartConstant.defaultErrorTextStyle,
    this.customFormatter,
    this.decoration = Round.defaultBoxDecoration,
    this.nextIconColor = Colors.blue,
    String hint,
    Function onSave,
    bool isPassword = false,
    String text = "",
    EdgeInsets margins = JumpStartConstant.textInputDefaultMargins,
    String customMessage,
    int validatorMaxSize,
    bool showNextIcon = false,
    bool requiredField = false,
    FormFieldValidator<String> customValidator,
    TextInputType inputType =  TextInputType.text,
    int validatorType = JumpStartFormValidators.EMPTY_VALIDATOR
  }):
        _hint = hint,
        _text = text,
        _onSave = onSave,
        _margins = margins,
        _inputType = inputType,
        _isPassword = isPassword,
        _showNextIcon = showNextIcon,
        _requiredField = requiredField,
        _validatorType = validatorType,
        _customMessage = customMessage,
        _customValidator = customValidator,
        _validatorMaxSize = validatorMaxSize;

  @override
  Widget build(BuildContext context) {
    return generateFormTextField(context);

  }

  Widget generateFormTextField(BuildContext context)
  {
    IconButton icon;
    if(_showNextIcon) {
      icon = new IconButton(
          icon: new Icon(Icons.redo, color: nextIconColor, size: 20.0),
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          });
    }
    return new Container(
      margin: _margins,
      padding: new EdgeInsets.only(left: 20.0, right: 10.0),
      child: new TextFormField(
        initialValue: _text,
        obscureText: _isPassword,
        keyboardType: _inputType,
        inputFormatters: getFormatter(),
        decoration: new InputDecoration(
            hintText: _hint,
            hintStyle: textStyle,
            errorStyle: errorTextStyle,
            //icon: new Icon(Icons.edit, color: Colors.blue, size: 20.0),
            border: InputBorder.none,
            suffixIcon: icon
        ),
        style: textStyle,
        validator: selectValidator(),
        onSaved: _onSave,
      ),
      decoration: decoration,
    );
  }

  FormFieldValidator<String> selectValidator()
  {
    if(_customValidator != null)
    {
      return _customValidator;
    }
    else {
      switch (_validatorType) {
        case JumpStartFormValidators.EMPTY_VALIDATOR:
          return  (String val){return JumpStartFormValidators.emptyValidator(val, message: _customMessage);};
          break;

        case JumpStartFormValidators.MAIL_VALIDATOR:
          return (String val){return JumpStartFormValidators.mailValidator(val, message: _customMessage, emptyCheck: _requiredField);};
          break;

        case JumpStartFormValidators.EXACT_SIZE_VALIDATOR:
          return (String val){return JumpStartFormValidators.exactSizeValidator(val, _validatorMaxSize, message: _customMessage, emptyCheck: _requiredField);};
          break;

        case JumpStartFormValidators.VALID_NUMBER_VALIDATOR:
          return (String val){return JumpStartFormValidators.validNumberValidator(val, message: _customMessage, emptyCheck: _requiredField);};
          break;

        default:
          return (val){};
      }
    }
  }

  List getFormatter()
  {
    List list = [];
    if(customFormatter != null)
    {
      list.add(customFormatter);
    }
    else if(_validatorMaxSize != null)
    {
      list.add(
        TextInputFormatter.withFunction(
          (TextEditingValue oldVal, TextEditingValue newVal) {
            if(newVal.text.length > _validatorMaxSize)
              return new TextEditingValue(text: oldVal.text);
            else
              return newVal;
          })
      );
    }
    return list;
  }

}

