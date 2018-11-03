import 'package:appfolio/JumpStart/JumpStart.dart';
import 'package:appfolio/screens/demos/store/Store.dart';
import 'package:flutter/material.dart';
import 'package:money/money.dart';

class StoreDemoPage extends StatefulWidget {

  StoreDemoPage();

  @override
  _StoreDemoPageState createState() => new _StoreDemoPageState();
}

class _StoreDemoPageState extends State<StoreDemoPage> with TickerProviderStateMixin{

  bool showProductAddDialog= false;
  double _appBarElevation = 0.0;
  List<Product> featuredList = Product.generateDummyData();
  double size = 0.0;
  List<Product> searchResultList = Product.generateDummyData();
  Money itemPrice;
  Product itemToAdd;
  List<ProductCategory> storeProductCategories = ProductCategory.generateDummyData();
  FocusNode searchFocus = new FocusNode();
  TextEditingController searchController = new TextEditingController();
  bool isSearching = false;

  double searchBarPadding = 5.0;
  double searchBarMargin = 16.0;
  double searchBarTopMargin = 10.0;
  double searchBarElevation = 0.0;
  double searchBarHeight = 45.0;
  double searchBarFontSize = 16.0;
  double closeIconSize = 0.0;
  double closeIconMargin = 0.0;
  double radius = 10.0;
  double searchBarLeftPadding = 10.0;

  Store store;

  bool _handleScrollNotification(ScrollNotification notification) {
    final double elevation = notification.metrics.extentBefore <= 0.0 ? 0.0 : 1.0;
    if (elevation != _appBarElevation) {
      setState(() {
        _appBarElevation = elevation;
      });
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    store = Store.generateDummyData()[0];
    searchFocus.addListener((){
      print(searchFocus.hasFocus);
      if(searchFocus.hasFocus && !isSearching)
      {
        setState((){
          searching();
        });
      }
      else if(!searchFocus.hasFocus && isSearching)
      {
        setState((){
          notSearching();
        });
      }
    });
  }

  void searching()
  {
    isSearching = true;
    searchBarPadding = 15.0;
    searchBarMargin = 0.0;
    searchBarTopMargin = 0.0;
    searchBarElevation = 1.0;
    searchBarHeight = 50.0;
    _appBarElevation = 0.0;
    searchBarFontSize = 20.0;
    closeIconSize = 50.0;
    closeIconMargin = 5.0;
    searchBarLeftPadding = 20.0;
    radius = 0.0;
  }
  void notSearching()
  {
    isSearching = false;
    searchBarPadding = 5.0;
    searchBarMargin = 16.0;
    searchBarTopMargin = 10.0;
    searchBarElevation = 0.0;
    searchBarHeight = 45.0;
    searchBarFontSize = 16.0;
    closeIconSize = 0.0;
    closeIconMargin = 0.0;
    searchBarLeftPadding = 10.0;
    radius = 10.0;
  }

  @override
  Widget build(BuildContext context) {

    return new Stack(
      children: <Widget>[

        generateBody(),

        StoreShoppingCart.showAddProductDialogOrNot(
            this,
            context: context,
            price: itemPrice,
            show: showProductAddDialog,
            onAmountChanged: (int amount){
              setState((){
                itemPrice = itemToAdd.price * amount;
                itemToAdd.quantity = amount;
              });
            },
            onTouchOutside:(){
              setState((){
                showProductAddDialog = false;
              });
            },
            onProductAdded: (){
              showProductAddDialog = false;

              setState((){
                StoreShoppingCart.addToShoppingCart(itemToAdd);
              });//showShoppingCart();
            }),
      ],
    );
  }

  void showShoppingCart()
  {
    StoreShoppingCart.showShoppingCart(mainContext: context, onContinue: (){
    });
  }

  Widget generateBody()
  {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        backgroundColor: Colors.grey[200],
        body: new NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child:
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Material(
                elevation: 0.0,
                color: Colors.white,
                child: SafeArea(
                  bottom: false,
                  child: Container(
                    child: new TabBar(
                      indicatorWeight: 2.0,
                      indicatorColor: Colors.pink[900],
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 50.0),
                      tabs:[
                        new Tab(icon: new Icon(Icons.home, color: Colors.pink[900])),
                        new Tab(icon: new Icon(Icons.search, color: Colors.pink[900])),
                      ],
                    ),
                  ),
                )
              ),
              Flexible(
                child: new TabBarView(
                  children: [
                    generateHomeBody(),
                    generateSearchBody(),
                  ],
                ),
              ),
            ],
          ),

        ),

      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          showShoppingCart();
        },
        backgroundColor: Colors.pink[900],
        child:
        new Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: new BottomAppBar(
          color: Colors.white,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(icon: Icon(Icons.navigate_before, color: Colors.pink[900]),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              ),
              new IconButton(icon: Icon(Icons.home, color: Colors.pink[900]),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget generateHomeBody()
  {
    return Material(
      color: Colors.transparent,
      child: new CustomScrollView(
        slivers: <Widget>[
          new SliverList(
            delegate: new SliverChildListDelegate(<Widget>[
              generateBigCard(),
            ]),
          ),

          new SliverSafeArea(
            top: false,
            minimum: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            sliver: new SliverGrid(
              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 0.9,
              ),
              delegate: new SliverChildBuilderDelegate((BuildContext context, int index) {

                return new ProductGridItem(product: featuredList[index],
                  onCornerTap: (){
                    setState((){
                      itemToAdd = featuredList[index];
                      itemPrice = itemToAdd.price;
                      showProductAddDialog = true;
                    });
                  }
                );

              },
                childCount: featuredList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget generateBigCard()
  {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Expanded(child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              color: Colors.white,
              width:  MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 451 / 980,
              child:
              new Image.network("http://ebaykit02.esp-digital3.com/clients/00269genesis/profile/images/banner-1.jpg",
                fit: BoxFit.fill,
              ),
            )
          ],
        ),)
      ],
    );
  }

  Widget generateCategoriesGrid()
  {
    return new CustomScrollView(slivers: <Widget>[

      new SliverSafeArea(
        top: false,
        minimum: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        sliver: new SliverGrid(
          gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          delegate: new SliverChildBuilderDelegate((BuildContext context, int index) {
            return new StoreCategoryGridItem(category: storeProductCategories[index],
            );
          },
            childCount: storeProductCategories.length,
          ),
        ),
      ),

    ]);
  }

  Widget generateSearchBody()
  {
    return new CustomScrollView(
      slivers: <Widget>[

        new SliverList(
            delegate: new SliverChildListDelegate(
                <Widget>[

                  new AnimatedContainer(
                    duration: new Duration(milliseconds: 500),
                    curve: Curves.bounceOut,
                    margin: new EdgeInsets.fromLTRB(searchBarMargin, searchBarTopMargin, searchBarMargin, 5.0),
                    child: new Material(
                      borderRadius: BorderRadius.circular(radius),
                      color: Colors.white,
                      elevation: searchBarElevation,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new AnimatedContainer(
                              duration: new Duration(milliseconds: 500),
                              curve: Curves.bounceOut,
                              padding: new EdgeInsets.fromLTRB(searchBarLeftPadding, searchBarPadding, 5.0, searchBarPadding),
                              child:
                              new TextField(
                                style: new TextStyle(fontSize: searchBarFontSize),
                                focusNode: searchFocus,
                                controller: searchController,
                                decoration: new InputDecoration(border: InputBorder.none, hintText: " Search", prefixIcon: new Icon(Icons.search, color: Colors.pink[900],)),
                              ),
                            ),),

                          new Column(
                            children: <Widget>[
                              new AnimatedContainer(
                                margin: new EdgeInsets.only(right: closeIconMargin),
                                width: closeIconSize,
                                height: closeIconSize,
                                duration: new Duration(milliseconds: 500),
                                curve: Curves.bounceOut,
                                child:
                                new IconButton(icon: new Icon(Icons.clear), onPressed: (){
                                  setState(()
                                  {
                                    notSearching();
                                    searchController = new TextEditingController(text: "");
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                  });
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            )),

        new SliverSafeArea(
          top: false,
          minimum: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          sliver: new SliverList(delegate: new SliverChildBuilderDelegate(

            (BuildContext context, int i)
            {
              return new ProductListItem(product: searchResultList[i], onTap: (){
              },
                onCornerTap: (){
                  setState((){
                    itemToAdd = searchResultList[i];
                    itemPrice = itemToAdd.price;
                    showProductAddDialog = true;
                  });
                },);
            },
            childCount: searchResultList.length,
          ))
        ),
      ],
    );
  }
}

class StoreShoppingCart
{

  static Store currentStore;

  static List<Widget> generateShoppingCartIcon(Function onTap, {bool show = true}){

    if(show) {
      List<Widget> icon = [
        new Container(
          margin: EdgeInsets.zero,
          child: new IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
              tooltip: 'Shopping cart',
              onPressed: onTap
          ),),
      ];

      if (currentStore != null && currentStore.cart != null && currentStore.cart.items != null && currentStore.cart.items.length > 0) {

        icon = [
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text("(${currentStore.cart.getTotalAmountOfItems()})", style: new TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold)),
              new Container(
                margin: EdgeInsets.zero,
                child: new IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.red,),
                    tooltip: 'Shopping cart',
                    onPressed: onTap
                ),),
            ],
          ),
        ];
      }

      return icon;
    }

    else
      return [];

  }

  static void showShoppingCart({BuildContext mainContext, VoidCallback onContinue}) {
    Store store = StoreShoppingCart.currentStore;
    showModalBottomSheet<Null>(context: mainContext, builder: (BuildContext context) {
      if (StoreShoppingCart.currentStore != null && StoreShoppingCart.currentStore.cart != null && StoreShoppingCart.currentStore.cart.items != null && StoreShoppingCart.currentStore.cart.items.length > 0) {
        return _generateShoppingCart(currentStore.cart, (){
          Navigator.of(context).pop();
          onContinue();
        });
      }
      else
      {
        return new Container(
            padding: new EdgeInsets.only(bottom: 10.0),
            margin: new EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0, right: 15.0),
            child:
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.only(left: 5.0, right: 10.0),
                  child: new Icon(Icons.remove_shopping_cart, color: Colors.grey),
                ),
                new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Flexible(child: new Text("Cart", style: new TextStyle(color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.bold))),
                  ],
                ),
              ],)
        );
      }
    });
  }

  static Widget _generateShoppingCart(Cart cart, VoidCallback onContinue){
    return new Stack(
      children: <Widget>[
        new CustomScrollView(slivers: <Widget>[

          new SliverList(delegate: new SliverChildListDelegate(<Widget>[

            new Container(
                padding: new EdgeInsets.only(bottom: 10.0),
                decoration: new BoxDecoration(border: new Border(bottom: new BorderSide(color: Colors.blueGrey[700], width: 1.0))),
                margin: new EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0, right: 15.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 5.0, right: 10.0),
                      child: new Icon(Icons.shopping_cart),
                    ),
                    new Text("Carrito de compras: ", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                  ],)
            ),

          ])),
          new SliverSafeArea(
            sliver: new SliverList(delegate: new SliverChildListDelegate(generateItemsList())),
            minimum: new EdgeInsets.only(bottom: 20.0, left: 10.0),
          ),
        ]),
        new Align(
          alignment: Alignment.bottomCenter,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              new InkWell(
                onTap: onContinue,
                child: new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new Material(
                      elevation: 1.0,
                      color: Colors.red,
                      child: new Container(
                        padding: new EdgeInsets.all(10.0),
                        child: new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                          new Text("Editar y continuar", style: new TextStyle(color: Colors.white, fontSize: JumpStartConstant.defaultFontSizeBig)),
                          new Container(child: new Icon(Icons.arrow_forward, color: Colors.white), margin: new EdgeInsets.only(left: 10.0),)
                        ],),
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static List<Widget> generateItemsList()
  {
    List<Widget> widgets = [];

    currentStore.cart.items.forEach((CartItem p){

      widgets.add(generateCartItem(p));

    });

    widgets.add(
        new Container(
            decoration: new BoxDecoration(border: new Border(top: new BorderSide(color: Colors.blueGrey[700], width: 1.0))),
            margin:new EdgeInsets.only(left: 5.0, top: 20.0, right: 15.0),
            padding: new EdgeInsets.only(top: 10.0),
            child: new Text("Total:", style: new TextStyle(fontSize: 16.0))
        ));

    widgets.add(
        new Container(
            margin: new EdgeInsets.only(left: 5.0),
            child: new Text("\$${currentStore.cart.totalWholesalePrice.amountAsString}", style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)))
    );

    return widgets;
  }

  static Widget generateCartItem(CartItem p)
  {
    return new CartListItem(item: p, onTap: (){});
  }

  static Widget showAddProductDialogOrNot(TickerProvider vSync, {Money price, bool show,  Function onTouchOutside, Function onAmountChanged, Function onProductAdded, BuildContext context})
  {
    double width = MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    double opacity;
    double radius = 10.0;
    double margin;
    double elevation;

    double bottom;


    if(show){
      radius = 20.0;
      bottom = 0.0;
      opacity = 1.0;
      margin = 30.0;
      elevation = 5.0;
    }
    else
    {
      radius = 0.0;
      bottom = MediaQuery.of(context).size.height * -1;
      opacity = 0.0;
      margin = 0.0;
      elevation = 0.0;
      //child = new Container();
    }

    return new Stack(
        alignment: FractionalOffset.center,
        children: <Widget>[
          new AnimatedPositioned(
            width: width,
            height: height,
            bottom: bottom,
            duration: new Duration(milliseconds: 300),
            child: StoreShoppingCart._generateAddProductDialog(
              price: price,
              onAmountChanged: onAmountChanged,
              onTouchOutside: onTouchOutside,
              onProductAdded: onProductAdded,
              radius: radius,
              margin: margin,
              elevation: elevation,
            ),
            curve: Curves.easeInOut,
          )]);
  }


  static Widget _generateAddProductDialog({Money price, double elevation, double margin, double radius, double width, double height, Function onTouchOutside, Function onProductAdded, Function onAmountChanged})
  {

    return new Container(
        child: new Material(
          color: Colors.transparent,
          child: new SizedBox(
            child: new Stack(
              children: <Widget>[

                new InkWell(
                    onTap: onTouchOutside,
                    child: new Container()
                ),

                new Align(
                  alignment: Alignment.center,
                  child: new Container(
                    margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                    child: new Material(
                      color: Colors.pink[900],
                      animationDuration: new Duration(milliseconds: 800),
                      borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                      elevation: elevation,
                      child: new Container(
                          padding: new EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
                          child:new Column(
                            mainAxisSize: MainAxisSize.min,
                            children:  <Widget>[

                              new Container(
                                margin: new EdgeInsets.only(bottom: 20.0),
                                child: new Text(
                                  "How many items do you want to add?",
                                  style: new TextStyle(
                                      fontSize: 15.0, color: Colors.white),),
                              ),

                              new Container(
                                margin: new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                                child: new JumpStartAmountSelector(

                                  margin: EdgeInsets.zero,
                                  onAmountChanged: onAmountChanged,
                                  minAmount: 1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.pink[900], width: 1.0)),
                                  iconsColor: Colors.pink[900],
                                  style: new TextStyle(color: Colors.pink[900]),
                                ),
                              ),

                              new Container(
                                margin: new EdgeInsets.only(top: 20.0),
                                child: new Text("\$${price.toString()}", style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              ),

                              new JumpStartFlatButton(
                                designStyle: JumpStartConstant.STYLE_ROUND,
                                borderRadius: BorderRadius.circular(10.0),
                                border: new Border.all(color: Colors.white),
                                backgroundColor: Colors.white,
                                text: "add",
                                textStyle: new TextStyle(color: Colors.pink[900]),
                                onPressed: onProductAdded,
                              ),
                            ],
                          )),
                    ),
                  ),),
              ],
            ),
          ),
        ));
  }

  static void addToShoppingCart(Product product)
  {
    if(currentStore != null)
    {
      if(currentStore.cart == null)
      {
        currentStore.cart = new Cart();
      }
      if(currentStore.cart.items == null)
      {
        currentStore.cart.items = new List<CartItem>();
      }
      currentStore.cart.addItem(product: product, quantity: product.quantity);
    }
  }

  static void editProductInCart({CartItem item, int add, int remove})
  {
    if(currentStore != null && currentStore.cart != null && currentStore.cart.items != null)
    {
      currentStore.cart.editItemQuantity(item: item, add: add, remove: remove);
    }
  }
}

class CartListItem extends StatelessWidget {

  final VoidCallback onTap;
  final CartItem item;
  final bool isEditable;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  CartListItem({this.onTap, this.item}): this.isEditable = false, onAdd = null, onRemove = null, onDelete = null;

  CartListItem.editable({this.item, this.onDelete, this.onRemove, this.onAdd, this.onTap}): this.isEditable = true;

  @override
  Widget build(BuildContext context) {
    if(isEditable)
      return generateEditable();
    else
      return generateNonEditable();
  }

  Widget generateNonEditable()
  {
    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      child: new Row(
        children: <Widget>[

          new SizedBox(
            height: 40.0,
            width: 40.0,
            child: new Image.network(item.product.getFeaturedImage(), fit: BoxFit.cover),
          ),
          new SizedBox(
              width: 30.0,
              height: 30.0,
              child: new CircleAvatar(
                  backgroundColor: Colors.red,
                  child: new Text("${item.quantity}", style: new TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold))
              )),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.only(left: 10.0, right: 10.0),
                child: new Text(item.product.name, style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
              new Container(
                margin: new EdgeInsets.only(left: 10.0, right: 10.0),
                child: new Text("\$${item.totalWholesalePrice}", style: new TextStyle(fontSize: 12.0)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget generateEditable()
  {
    return new Container(
        margin: new EdgeInsets.only(bottom: 15.0),
        child: new Stack(
          children: <Widget>[

            new Material(
              color: Colors.white,
              elevation: 1.0,
              child: new Row(
                children: <Widget>[

                  new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new SizedBox(
                        height: 120.0,
                        width: 120.0,
                        child: new Image.network(item.product.getFeaturedImage(), fit: BoxFit.cover),
                      ),
                    ],
                  ),

                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        new Container(
                          margin:new EdgeInsets.only(top:10.0, right: 10.0, bottom: 5.0),
                          decoration: new BoxDecoration(border: new Border(bottom: new BorderSide(color: Colors.black, width: 1.0))),
                          child: new Text("${item.product.name}", style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                        ),

                        new Container(
                          margin: new EdgeInsets.only(bottom: 15.0),
                          child: new Text("Precio unitario: \$${item.unitWholesalePrice.amountAsString}", style: new TextStyle(fontSize: 14.0), textAlign: TextAlign.start,),
                        ),

                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            new Expanded(
                                child:
                                new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Container(
                                        height: 35.0,
                                        margin: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        decoration: new BoxDecoration(border: new Border.all(color: Colors.black)),
                                        child:
                                        new Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new IconButton(icon: new Icon(Icons.remove, color: Colors.black, size: 17.0), onPressed: onRemove),
                                            new Container(child:  new Text("${item.quantity}"), margin: new EdgeInsets.only(left: 15.0, right: 15.0)),
                                            new IconButton(icon: new Icon(Icons.add, color: Colors.black, size: 17.0), onPressed: onAdd),
                                          ],
                                        ),
                                      ),
                                    ])
                            ),

                            new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Container(
                                    width: 35.0,
                                    height: 35.0,
                                    color: Colors.red,
                                    margin: new EdgeInsets.only(left: 20.0, right: 10.0),
                                    child: new IconButton(icon: new Icon(Icons.delete, color: Colors.white, size: 20.0,), onPressed: onDelete)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),

            new Positioned(
              top: 0.0,
              left: 0.0,
              child:
              new Container(
                  width: 30.0,
                  height: 30.0,
                  color: Colors.red,
                  child: new Align(
                      alignment: Alignment.center,
                      child: new Text("${item.quantity}", style: new TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold)))
              ),
            ),
          ],
        ));
  }

}
