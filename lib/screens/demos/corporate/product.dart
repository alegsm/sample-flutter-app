

class CorporateProduct
{
  String code;
  final String name;
  final String ivaCode;
  final double unitPrice;
  int amount;

  CorporateProduct(this.code, this.name, this.ivaCode, this.unitPrice, this.amount);

  static List<CorporateProduct> createDummyData()
  {
    var dummy = <CorporateProduct> [];

    dummy.add(CorporateProduct(
      'code',
      'item 1',
      'taxCode',
      15.0,
      6
    ));
    dummy.add(CorporateProduct(
        'code',
        'item 2',
        'taxCode',
        15.0,
        3
    ));
    dummy.add(CorporateProduct(
        'code',
        'item 3',
        'taxCode',
        50.0,
        1
    ));
    dummy.add(CorporateProduct(
        'code',
        'item 4',
        'taxCode',
        30.0,
        2
    ));

    return dummy;
  }

  double get cost => amount != null ? amount * unitPrice : unitPrice;

  get iva
  {
    if (ivaCode == '2')
    {
      return cost * .12;
    }
    return .0;
  }
}
