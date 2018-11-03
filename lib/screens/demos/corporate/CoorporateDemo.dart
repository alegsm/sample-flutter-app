import 'package:appfolio/JumpStart/JumpStart.dart';
import 'package:appfolio/screens/demos/corporate/Bill.dart';
import 'package:appfolio/screens/demos/corporate/Client.dart';
import 'package:appfolio/screens/demos/corporate/Entity.dart';
import 'package:appfolio/screens/demos/corporate/product.dart';
import 'package:flutter/material.dart';

class CorporateDemo extends StatefulWidget
{
  final Entity entity = Entity.createDummyEntity();

  @override
  _CorporateDemoState createState() => new _CorporateDemoState();
}

class _CorporateDemoState extends State<CorporateDemo>
{
  BillData bill;
  bool isLoading = false;

  @override
  void initState()
  {
    super.initState();
    bill = BillData.generateDummyBill();
  }

  @override
  Widget build(BuildContext context)
  {
    final content = new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey[700],
        elevation: 1.0,
        title: new Text('CORPORATE BILL'),
      ),

      body: generateBillDetails(context),
    );
    
    return content;
  }

  Widget generateBillDetails(BuildContext context)
  {
    Client client = bill.client;
    return SafeArea(
      child: Container(
        margin: new EdgeInsets.all(10.0),
        padding: new EdgeInsets.only(top: 15.0, bottom: 15.0),
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.grey[700]),
          borderRadius: Round.defaultRadius,
        ),
        child: new Column(
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 45.0,
                  height: 45.0,
                  margin: new EdgeInsets.only(left: 10.0, right: 10.0),
                  child:  Image.network(
                    widget.entity.logo,
                  ),
                ),
                new Expanded(
                  flex: 2,
                  child: new Padding(
                    padding: new EdgeInsets.only(top: 7.0, bottom: 7.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(widget.entity.name,
                            style: new TextStyle(
                                fontSize: JumpStartConstant.defaultFontSizeBig)),
                        new Text(widget.entity.legalId,
                            style: new TextStyle(
                                fontSize: JumpStartConstant.defaultFontSize,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                ),

                new Container(
                  padding: new EdgeInsets.all(3.0),
                  decoration: new BoxDecoration(
                    border: new Border.all(color: bill.color,
                        width: JumpStartConstant.defaultInputBorderWidth),
                  ),
                  margin: new EdgeInsets.only(right: 20.0),
                  child: new Text(
                      bill.state,
                      style: new TextStyle(
                          color: bill.color,
                          fontSize: JumpStartConstant.defaultFontSize,
                          fontWeight: FontWeight.w700
                      )
                  ),
                ),
              ],
            ),

             Container(
              margin:  EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0),
              child:  Row(
                children: <Widget>[
                   Text('Code:',
                      style: new TextStyle(
                          fontSize: JumpStartConstant.defaultFontSizeBig,
                          fontWeight: FontWeight.w300)),

                   Container(
                     margin: EdgeInsets.only(left: 10.0),
                     child: Text(bill.vendorCode,
                       style: new TextStyle(
                         color: Colors.blue[900],
                         fontSize: JumpStartConstant.defaultFontSize,
                         fontWeight: FontWeight.w300,
                       )
                     ),
                   )

                ],
              ),),

            new Container(
              margin: new EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0),
              child: new Row(
                children: <Widget>[
                  new Flexible(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Text('Access Code: ',
                            style: new TextStyle(
                                fontSize: JumpStartConstant.defaultFontSize,
                                fontWeight: FontWeight.w300)),

                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            bill.vendorAccessCode,
                            style: new TextStyle(
                              color: Colors.purple,
                              fontSize: JumpStartConstant.defaultFontSize,
                              fontWeight: FontWeight.w300,
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            new Container(
              margin: new EdgeInsets.only(left: 15.0, top: 20.0),
              child: new Row(
                children: <Widget>[
                  new Flexible(child:
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('Client Information', style: new TextStyle(
                          fontSize: JumpStartConstant.defaultFontSizeBig)),
                      new Text('Name: ${client.name}', style: new TextStyle(
                          fontSize: JumpStartConstant.defaultFontSize,
                          fontWeight: FontWeight.w300)),
                      new Text(client.legalStr, style: new TextStyle(
                          fontSize: JumpStartConstant.defaultFontSize,
                          fontWeight: FontWeight.w300)),
                      new Text('Phone: ${client.phone}', style: new TextStyle(
                          fontSize: JumpStartConstant.defaultFontSize,
                          fontWeight: FontWeight.w300)),
                      new Text('Address: ${client.address}', style: new TextStyle(
                          fontSize: JumpStartConstant.defaultFontSize,
                          fontWeight: FontWeight.w300)),
                      new Text('Billing date: ${bill.registeredStr}',
                          style: new TextStyle(
                              fontSize: JumpStartConstant.defaultFontSize,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                  ),
                ],
              ),
            ),

            new Container(
              margin: new EdgeInsets.only(top: 20.0),
              decoration: new BoxDecoration(color: Colors.grey[700]),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),

                    child: new Text('Bill details', style: new TextStyle(
                        fontSize: JumpStartConstant.defaultFontSizeBig,
                        color: Colors.white)),
                  ),
                ],),
            ),

            new Container(
              child: new Column(
                children: generateDetailsList(),
              ),
            ),


            new Container(
              margin: new EdgeInsets.only(right: 10.0, bottom: 10.0, top: 20.0),
              child: new Align(
                alignment: Alignment.centerRight,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text('Sub-total: \$${(bill.amountWithoutIva).toStringAsFixed(2)}'),
                    new Text('Disccount: \$${bill.discount.toStringAsFixed(2)}'),
                    new Text('Tip: \$${bill.tip.toStringAsFixed(2)}'),
                    new Container(
                      child: new Text('Tax: \$${bill.iva.toStringAsFixed(2)}'),
                      margin: new EdgeInsets.only(bottom: 15.0),
                    ),

                    new Text('Total:', style: new TextStyle(
                        fontSize: JumpStartConstant.defaultFontSize),),
                    new Text('\$${(bill.fullAmount).toStringAsFixed(2)}',
                        style: new TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateDetailsList()
  {
    List<Widget> detailsWidgetsList = new List<Widget>();
    for (var product in bill.products)
    {
      detailsWidgetsList.add(generateDetails(product));
    }
    return detailsWidgetsList;
  }

  Widget generateDetails(CorporateProduct product)
  {
    return new Container(

        child: new Column(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  new Flexible(
                    child: new Column(
                      children: <Widget>[
                        new Text(product.amount.toString(),
                            style: new TextStyle(
                                fontSize: JumpStartConstant.defaultFontSizeSmall,
                                fontWeight: FontWeight.bold)),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),

                  new Flexible(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(product.name,
                            style: new TextStyle(
                                fontSize: JumpStartConstant.defaultFontSizeSmall,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  new Flexible(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text('${product.amount} * ${product.unitPrice.toStringAsFixed(2)} = ${product.unitPrice.toStringAsFixed(2)}',
                            style: new TextStyle(
                                fontSize: JumpStartConstant.defaultFontSizeSmall,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            new Container(height: 1.0, color: Colors.grey[700])
          ],
        )
    );
  }
}
