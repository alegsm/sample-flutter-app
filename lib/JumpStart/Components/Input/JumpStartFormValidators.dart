import 'package:flutter/material.dart';
import 'package:appfolio/JumpStart/Design/constants/Round.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';

class JumpStartFormValidators
{
  static const int EMPTY_VALIDATOR = 3;
  static const int EXACT_SIZE_VALIDATOR = 1;
  static const int MAIL_VALIDATOR = 2;
  static const int VALID_NUMBER_VALIDATOR = 4;


  static String emptyValidator(String value, {String message})
  {
    if(value.isEmpty) {
      if(message != null)
        return message;
      else
        return "Este campo es obligatorio";
    }
    else
      return null;
  }

  static String exactSizeValidator(String value, int maxSize,
      {String message, bool emptyCheck})
  {
    if(maxSize != null) {
      if (value.length != maxSize || (emptyCheck && value.length == 0)) {
        if (message != null) {
          return message;
        }
        else {
          if (emptyValidator(value) == null) {
            return "Este campo debe tener ${maxSize} caracteres.";
          }
          else {
            return emptyValidator(value);
          }
        }
      }
      else
        return null;
    }
    else
    {
      return null;
    }
  }

  static String mailValidator(String value,
      {String message, bool emptyCheck})
  {
    if(!value.contains('@') || (emptyCheck && value.length == 0)) {
      if (message != null) {
        return message;
      }
      else
      {
        if(emptyValidator(value) == null) {
          return "La dirección de correo no es válida.";
        }
        else
        {
          return emptyValidator(value);
        }
      }
    }
    else
      return null;
  }

  static String validNumberValidator(String value,
      {String message, bool emptyCheck})
  {
    bool isValidDouble = false;
    try {
      double.parse(value);
      isValidDouble = true;
    }
    catch(e)
    {
      isValidDouble = false;
    }


    if(!isValidDouble || (emptyCheck && value.length == 0)) {
      if (message != null) {
        return message;
      }
      else
      {
        if(emptyValidator(value) == null) {
          return "El número no el válido.";
        }
        else
        {
          return emptyValidator(value);
        }
      }
    }
    else
      return null;
  }
}