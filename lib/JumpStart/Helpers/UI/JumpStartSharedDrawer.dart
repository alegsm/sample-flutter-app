import 'package:flutter/material.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpstartTextField.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpStartImageButton.dart';
import 'package:appfolio/JumpStart/Components/Input/JumpStartFlatButton.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';


class SharedDrawer {

  static Drawer sharedDrawer;
  static Function _drawerFactory;
  static final SharedDrawer _singleton = new SharedDrawer._internal();

  factory SharedDrawer() {
    return _singleton;
  }

  SharedDrawer._internal();

  void setSharedDrawerFactory(Function drawerFactory)
  {
    _drawerFactory = drawerFactory;
  }

  Drawer getSharedDrawer() {
    if(_drawerFactory != null)
      return _drawerFactory();
    else
      return new Drawer();
  }

}