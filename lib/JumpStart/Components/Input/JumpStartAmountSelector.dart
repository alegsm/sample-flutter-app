import 'package:flutter/material.dart';
import 'package:appfolio/JumpStart/Design/constants/JumpStartConstants.dart';
import 'package:appfolio/JumpStart/Design/constants/Round.dart';

class JumpStartAmountSelector extends StatefulWidget {

  final BoxDecoration decoration;
  final int startAmount;
  final int minAmount;
  final double height;
  final EdgeInsets margin;
  final Function onAmountChanged;
  final Color iconsColor;
  final TextStyle style;

  JumpStartAmountSelector(
      { this.minAmount = 0,
        this.decoration = Round.defaultBoxDecoration,
        this.startAmount,
        this.height = 40.0,
        this.margin = const EdgeInsets.only(top: 15.0),
        this.onAmountChanged,
        this.iconsColor = Colors.blue,
        this.style = JumpStartConstant.defaultTextStyle});

  @override
  _JumpStartAmountSelectorState createState() => new _JumpStartAmountSelectorState();
}

class _JumpStartAmountSelectorState extends State<JumpStartAmountSelector> {
  TextEditingController amountController = new TextEditingController(text: "0");
  int amount = 0;


  @override
  void initState() {
    super.initState();
    if(widget.startAmount == null)
      amount = widget.minAmount;
    else
      amount = widget.startAmount;
  }

  @override
  Widget build(BuildContext context) {
    amountController = new TextEditingController(text: "$amount");
    return new Container(
      margin: widget.margin,
      height: widget.height,
      decoration: widget.decoration,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          new IconButton(
              icon:
              new Icon(
                  Icons.remove,
                  color: widget.iconsColor
              ),
              onPressed: ()
              {
                setState((){
                  if(amount > widget.minAmount)
                  {
                    amount--;
                  }
                });
                widget.onAmountChanged(amount);
              }
          ),

          new Expanded(
            child:
            new TextField(
              textAlign: TextAlign.center,
              style: widget.style,
              decoration: new InputDecoration(border: InputBorder.none),
              controller: amountController,
              onChanged: (String val){
                amount = int.parse(val);
                if(amount == null || amount < widget.minAmount){
                  setState((){
                    amount = widget.minAmount;
                  });
                }
                widget.onAmountChanged(amount);
              },
              keyboardType: TextInputType.number,
            )
            ,
          ),

          new IconButton(
              icon:
              new Icon(
                  Icons.add,
                  color: widget.iconsColor,
              ),
              onPressed: ()
              {
                setState((){
                  amount++;
                });
                widget.onAmountChanged(amount);
              }
          ),

        ],
      ),
    );
  }
}
