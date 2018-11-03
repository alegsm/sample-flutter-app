import 'package:appfolio/screens/demos/corporate/Client.dart';
import 'package:appfolio/screens/demos/corporate/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bill
{
  static const AUTH_STATE = 'AUTHORIZED';
  static const CANCEL_STATE = 'CANCELLED';

  final String code;
  final String vendorCode;
  final String vendorAccessCode;
  final String paymentWay;
  String state;
  final double discount;
  final double tip;
  final double iva;
  final double amount;
  final String clientId;
  final int registered;

  Bill(this.code, this.vendorCode, this.vendorAccessCode, this.paymentWay,
      this.state, this.discount, this.tip, this.iva, this.amount, this.clientId,
      this.registered);

  static Bill createDummyBill()
  {
    return Bill(
      'code',
      'vendorCode',
      'accessCode',
      'Credit Card',
      AUTH_STATE,
      10.0,
      5.0,
      10.0,
      100.0,
      '1',
      DateTime.now().millisecondsSinceEpoch
    );
  }
}

class BillData
{
  final Bill bill;
  final List<CorporateProduct> products;
  final Client client;

  BillData(this.bill, this.products, this.client);

  static BillData generateDummyBill()
  {
    return BillData(
      Bill.createDummyBill(),
      CorporateProduct.createDummyData(),
      Client.createDummyClient(),
    );
  }

  get state => bill.state;

  set state(String value) => bill.state = value;

  get vendorCode => bill.vendorCode;

  get vendorAccessCode => bill.vendorAccessCode;

  get amountWithoutIva => bill.amount - bill.iva;

  get discount => bill.discount;

  get tip => bill.tip;

  get iva => bill.iva;

  get fullAmount => bill.amount - bill.discount + bill.tip;

  get color
  {
    if (bill.state == Bill.AUTH_STATE)
    {
      return Colors.blue[900];
    }
    if (bill.state == Bill.CANCEL_STATE)
    {
      return Colors.red[500];
    }
    return Colors.orange;
  }

  get registeredStr
  {
    final now = new DateTime.now();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(bill.registered);
    String pre = '';
    String pattern = 'EEE, d/M/y';

    var diff = now.difference(dateTime);
    if (diff.inHours < 24 &&
        now.day == dateTime.day)
    {
      pre = 'Today ';
      pattern = 'h:mm a';
    }
    else if (diff.inHours < 48 &&
        now.day == dateTime.day + 1)
    {
      pre = 'Yesterday ';
      pattern = 'h:mm a';
    }
    else if (diff.inHours < 100 &&
        now.day == dateTime.day + 1)
    {
      pattern = 'EEE, d/M/y, h:mm a';
    }

    final format = new DateFormat(pattern);
    return pre + format.format(dateTime);
  }
}