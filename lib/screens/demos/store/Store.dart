import 'package:appfolio/JumpStart/JumpStart.dart';
import 'package:flutter/material.dart';
import 'package:money/money.dart';


class Store
{
  String name;
  String imageUrl;
  bool isOpen;
  String shippingCost;
  String estimatedDeliveryTime;
  String label;
  Cart cart;

  Store({this.name, this.imageUrl, this.isOpen, this.shippingCost, this.label, this.estimatedDeliveryTime, this.cart});

  static List<Store> generateDummyData()
  {
    List<Store> dummy = [];
    dummy.add(new Store(name: "Megamaxi", imageUrl: "http://www.wsya.cl/wp-content/uploads/2016/03/mm_6diciembre-634x420.jpg", label:"Supermercado" ,isOpen: true, estimatedDeliveryTime: "80 - 120 min", shippingCost: "\$2.50"));
    return dummy;
  }
}

class Cart {

  static const double IVA = 0.12;
  DeliveryService deliveryService;
  Money totalWholesalePrice;
  DateTime creationDate;
  Money totalAmount;
  String storeName;
  Money subTotal;
  Money tax;


  List<CartItem> items;

  Cart({this.deliveryService, this.totalWholesalePrice, this.creationDate, this.tax, this.totalAmount, this.storeName, this.subTotal , this.items}){
    if(this.creationDate == null)
      this.creationDate = DateTime.now();

    if(totalAmount == null)
      totalAmount = new Money(0, new Currency('USD'));
    if(subTotal == null)
      subTotal = new Money(0, new Currency('USD'));
    if(tax == null)
      tax = new Money(0, new Currency('USD'));
    if(totalWholesalePrice == null)
      totalWholesalePrice = new Money(0, new Currency('USD'));
  }

  static Cart generateDummyData()
  {
    Money subTotalPrice = new Money(0, new Currency('USD'));
    List<CartItem> cartItem = CartItem.generateDummyData();
    cartItem.forEach((CartItem item){
      subTotalPrice += item.totalWholesalePrice;
    });

    Money tax = subTotalPrice * 0.12;
    Money totalWholesalePrice = subTotalPrice + tax;

    Cart cart = new Cart(
      deliveryService: DeliveryService.generateDummyData()[0],
      totalWholesalePrice: totalWholesalePrice,
      totalAmount: totalWholesalePrice + DeliveryService.generateDummyData()[0].price,
      subTotal: subTotalPrice,
      tax: tax,
    );
    return cart;
  }

  void addItem({Product product, int quantity})
  {
    if(items == null)
    {
      items = new List<CartItem>();
    }

    bool unique = true;

    items.forEach((item){
      if(item.product.id == product.id)
      {
        unique = false;
        item.quantity += quantity;
      }
    });

    if(unique)
      items.add(new CartItem.fromProduct(product: product, quantity: quantity));

    updateAmounts();
  }

  void removeItem({int itemIndex})
  {
    items.removeAt(itemIndex);
    updateAmounts();
  }

  void editItemQuantity({CartItem item, int add, int remove})
  {
    items.forEach((item){
      if(item.product.id == item.product.id)
      {
        if(add != null)
          item.quantity += add;

        else if(remove != null)
          if(item.quantity - remove > 0)
            item.quantity -= remove;
      }
    });

    updateAmounts();
  }

  void updateAmounts()
  {
    if(items != null)
    {
      totalWholesalePrice = new Money(0, new Currency('USD'));
      items.forEach((item){

        totalWholesalePrice += item.product.price * item.quantity;

      });

      tax = totalWholesalePrice * IVA;

      subTotal = totalWholesalePrice + tax;

      totalAmount = deliveryService != null ? totalWholesalePrice + tax + deliveryService.price : totalWholesalePrice + tax;
    }
  }

  int getTotalAmountOfItems()
  {
    int itemsAmount = 0;
    if(items != null) {
      items.forEach((item) {
        itemsAmount += item.quantity;
      });
    }
    return itemsAmount;
  }

}


class CartItem{

  Product product;
  int quantity;
  Money unitWholesalePrice;

  CartItem({this.product, this.quantity, this.unitWholesalePrice});

  CartItem.fromProduct({this.product, this.quantity})
  {
    this.unitWholesalePrice = product.price;
  }

  Money get totalWholesalePrice
  {
    return product.price * quantity;
  }

  static List<CartItem> generateDummyData(){
    List<CartItem> dummy = new List();
    dummy.add(new CartItem(product: Product.generateDummyData()[0], quantity: 2, unitWholesalePrice: Product.generateDummyData()[0].price));
    dummy.add(new CartItem(product: Product.generateDummyData2()[0], quantity: 5, unitWholesalePrice: Product.generateDummyData2()[0].price));
    return dummy;
  }

}

class Product{
  static String defaultImageUrl = "https://todoentrega.touwolf.com/pichincha/quito/distribuidora-la-lahdili-inc/producto/manteca-cereales-100-g";

  int id;
  String name;
  Money price;
  String description;
  List<String> imageUrls;
  int quantity = 1;
  String category;

  Product({this.id, this.imageUrls, this.name, this.price, this.description, this.category});

  String getFeaturedImage()
  {
    if(imageUrls != null && imageUrls.isNotEmpty)
    {
      return imageUrls[0];
    }
    else
    {
      return defaultImageUrl;
    }
  }

  List<String> getOtherImages()
  {
    if(imageUrls != null && imageUrls.length > 1)
    {
      return imageUrls;
    }
    else
    {
      return [];
    }
  }

  static List<Product> generateDummyData()
  {
    List<Product> dummy = [];
    dummy.add(
      new Product(
        id: 1,
        imageUrls: ["http://brandstore.vistaprint.in/render/undecorated/product/PVAG-0Q4K507W3K1Y/RS-K82Q06W655QY/jpeg?compression=95&width=700"],
        name: "item",
        price: new Money.fromDouble(10.99, new Currency('USD')),
        description: "Item",
        category: "category 1"
      )
    );
    dummy.add(
      new Product(
        id: 2,
        imageUrls: ["https://assets.academy.com/mgen/61/20057861.jpg"],
        name: "item",
        price: new Money.fromDouble(10.99, new Currency('USD')),
        description: "Item",
        category: "category 1"
      )
    );
    dummy.add(
      new Product(
        id: 3,
        imageUrls: ["http://www.windigotactical.com/images/KNOPSOFTWARE/00AVEG68YGQ%20-%20MENS%20Nike%20SB%20Everett%20Graphic%20Crew%20Sweatshirt%20-%20BlackWhite,Team%20RedWhite%2029750234.jpg"],
        name: "item",
        price: new Money.fromDouble(10.99, new Currency('USD')),
        description: "Item",
        category: "category 1"
      )
    );
    dummy.add(
      new Product(
        id: 4,
        imageUrls: ["https://cdn2.bigcommerce.com/n-biq04i/lk0gwzb/products/81/images/1768/3465__36190.1404575247.380.500.jpg?c=2"],
        name: "item",
        price: new Money.fromDouble(10.99, new Currency('USD')),
        description: "Item",
        category: "category 1"
      )
    );


    return dummy;

  }

  static List<Product> generateDummyData2()
  {
    List<Product> dummy = [];
    dummy.add(
        new Product(
            id: 4,
            imageUrls: ["https://todoentrega.touwolf.com/files/products/big/62/5a/ce/1107.png"],
            name: "Botella de vino tinto Casillero del diablo 1L",
            price:  new Money.fromDouble(99.99, new Currency("USD")),
            description: "Botella de vino tinto Casillero del diablo 1 asd asd asd asa sd asd La sda sda sd ad asd asd asd asd asdjhg jasdhlkjdsfgsdlfhkslkdufg kjdzfh dkjh kjsdfgds fjhgsdfj g jsdfh gkjdfsd a.",
            category: "category 4"
        )
    );

    return dummy;

  }
}

class ProductCategory
{

  String name;
  String imageUrl;
  int id;

  ProductCategory({this.name, this.imageUrl, this.id});

  static List<ProductCategory> generateDummyData()
  {
    List<ProductCategory> dummy = [];
    dummy.add(new ProductCategory(name: "sports", imageUrl: "https://www.asnailspace.net/wp-content/uploads/2016/12/1.jpg", id: 1));
    dummy.add(new ProductCategory(name: "casual", imageUrl: "https://i.ebayimg.com/images/g/DjsAAOSwTA9X5sMR/s-l300.jpg", id: 2));

    dummy.add(new ProductCategory(name: "casual", imageUrl: "https://i.ebayimg.com/images/g/DjsAAOSwTA9X5sMR/s-l300.jpg", id: 2));
    dummy.add(new ProductCategory(name: "sports", imageUrl: "https://www.asnailspace.net/wp-content/uploads/2016/12/1.jpg", id: 1));
    return dummy;
  }

}


class DeliveryService
{
  String name;
  Money price;
  String provider;
  String serviceDescription;

  DeliveryService({this.name, this.price, this.provider, this.serviceDescription});

  static List<DeliveryService> generateDummyData(){

    List<DeliveryService> dummy = new List();

    dummy.add(new DeliveryService(name: 'Envío Express', price: new Money.fromDouble(3.0, new Currency('USD')), serviceDescription: 'Entrega estimada: 120 - 180 minutos.', provider: 'Puntualy'));
    dummy.add(new DeliveryService(name: 'Envío planificado', price: new Money.fromDouble(2.0, new Currency('USD')), serviceDescription: 'Entrega al siguiente día: \nSelecciona la hora de entrega entre 10:00am y 8:00pm.', provider: 'Puntualy'));

    return dummy;
  }
}

class StoreCategoryGridItem extends StatelessWidget {

  final ProductCategory category;

  final Function onTap;

  StoreCategoryGridItem({this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return new Material(
      borderRadius: BorderRadius.circular(10.0),
        elevation: 2.0,
        child: new InkWell(
          onTap: onTap,
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(category.imageUrl, fit: BoxFit.cover),
            ],
          ),)
    );
  }
}

class ProductGridItem extends StatelessWidget {

  final Product product;
  final Function onTap;
  final Function onCornerTap;

  ProductGridItem({this.product, this.onTap, this.onCornerTap});

  @override
  Widget build(BuildContext context) {
    return new Stack(children: <Widget>[
      new Container(
        child: new InkWell(
          onTap: onTap,
          child: new Material(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            elevation: 2.0,
            child: new GridTile(
              child: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: new Hero(
                      tag: product.id,
                      child: new Image.network(
                        product.getFeaturedImage(),
                        fit: BoxFit.cover),
                    )
                  ),

                  new Container(
                    child: new Align(
                      alignment: Alignment.bottomRight,
                      child:
                      new Container(
                        padding: new EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Align(
                              alignment: Alignment.bottomCenter,
                              child: new Text(product.name, style: new TextStyle(color: Colors.pink[900], fontSize: 12.0), textAlign: TextAlign.center, maxLines: 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),),
      ),

      new Positioned(
        left: 0.0,
        top: 0.0,
        child: new InkWell(
          onTap: onCornerTap,
          child: new Container(
            width: 30.0,
            height: 30.0,
            decoration: new BoxDecoration(color: Colors.white),
            child: new Icon(Icons.add_shopping_cart, color: Colors.pink[900], size: 20.0),
          ),
        ),
      ),
    ],);
  }

}

class ProductListItem extends StatelessWidget {

  final Function onTap;
  final Function onCornerTap;
  final Product product;

  ProductListItem({this.product, this.onTap, this.onCornerTap});

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[

        new InkWell(
          onTap: onTap,
          child:
          new Container(
            margin: new EdgeInsets.only(bottom: 10.0),
            child:
            new Material(
              color: Colors.white,
              elevation: 1.0,
              borderRadius: BorderRadius.circular(10.0),
              child: new Container(
                margin: new EdgeInsets.only(bottom: 5.0),
                child:new Container(
                  padding: new EdgeInsets.all(5.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new SizedBox(
                            width: 80.0,
                            height: 80.0,
                            child: new Hero(
                              tag: product.id,
                              child: new Image.network(product.getFeaturedImage(), fit: BoxFit.contain),
                            ),
                          ),
                        ],
                      ),

                      new Expanded(child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                new Flexible(child: new Text(product.name, style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),),
                                new Container(height:1.0, decoration: new BoxDecoration(color: Colors.black)),
                                new Container(
                                  margin: new EdgeInsets.only(top: 2.0, bottom: 5.0),
                                  child: new Text("\$${product.price.amountAsString}", style: new TextStyle(fontSize: 12.0, color: Colors.pink[900])),
                                ),

                                new Text(product.description, maxLines: 1, style: new TextStyle(fontSize: JumpStartConstant.defaultFontSize, color: Colors.black)),
                                new Text(product.category, style: new TextStyle(fontSize: JumpStartConstant.defaultFontSize, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        new Positioned(
          left: 0.0,
          top: 0.0,
          child: new InkWell(
            onTap: onCornerTap,
            child: new Container(
              width: 30.0,
              height: 30.0,
              child: new Icon(Icons.add_shopping_cart, color: Colors.pink[900], size: 20.0),
            ),
          ),
        ),
      ],
    );
  }
}
