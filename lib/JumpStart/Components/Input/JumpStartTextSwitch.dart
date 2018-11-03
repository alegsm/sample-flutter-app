import 'package:flutter/material.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';
import 'package:appfolio/JumpStart/Design/constants/Round.dart';


class JumpStartTextSwitch extends StatefulWidget {

  double height;
  bool initialValue;
  BoxDecoration decoration;
  String text;
  EdgeInsets margin;
  TextStyle style;
  Function onValueChanged;


  JumpStartTextSwitch({
    this.margin = const EdgeInsets.only(top: 15.0),
    this.height = 40.0,
    this.initialValue = false,
    this.decoration = Round.defaultBoxDecoration,
    this.text = "",
    this.onValueChanged,
    this.style = JumpStartConstant.defaultTextStyle
  });

  @override
  _JumpStartTextSwitchState createState() => new _JumpStartTextSwitchState();
}

class _JumpStartTextSwitchState extends State<JumpStartTextSwitch> {

  bool isChecked = false;


  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: widget.margin,
      child: new GestureDetector(
        onTap: (){
          setState((){
            isChecked = !isChecked;
          });
          widget.onValueChanged(isChecked);
        },
        child: new Container(
          decoration: widget.decoration,
          child:  new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Expanded(flex: 2,
                child:
                new Container(
                  margin: new EdgeInsets.only(left: 20.0),
                  child: new Text(widget.text, style: widget.style),
                ),
              ),
              new Container(
                height: 40.0,
                child:
                new Switch(value: isChecked, onChanged: (bool value){
                  setState((){
                    isChecked = value;
                  });
                  widget.onValueChanged(value);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
