import 'package:flutter/material.dart';


class JumpStartLoaderScreen {

  static Widget customLoadScreen;

  static setCustomLoadScreen(Widget custom){
    customLoadScreen = custom;
  }

  static Widget generate()
  {

    if(customLoadScreen != null)
    {
      return customLoadScreen;
    }

    else {
      return new Stack(
        children: <Widget>[

          new Opacity(
            opacity: .6,
            child: new Container(
              color: Colors.black,
            ),
          ),

          new Align(
            alignment: Alignment.center,
            child: new SizedBox(

              width: 50.0,
              height: 50.0,
              child: new Container(
                decoration: new BoxDecoration(color: Colors.blue,
                    borderRadius: new BorderRadius.circular(100.0)),
                child: new CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),

        ],
      );
    }
  }

  static Widget handleLoading({bool isLoading, Widget showOnLoaded})
  {
    if(isLoading)
    {
      return new Stack(
        children: <Widget>[
          showOnLoaded,
          generate(),
        ],
      );
    }
    else
    {
      return showOnLoaded;
    }
  }
}