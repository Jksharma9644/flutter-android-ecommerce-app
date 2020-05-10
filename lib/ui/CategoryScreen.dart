import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sawjigrocerryapp/model/category-modal.dart';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:sawjigrocerryapp/services/product.service.dart';
import 'package:sawjigrocerryapp/ui/ProductDetailsScreen.dart';
import 'package:sawjigrocerryapp/ui/CartScreen.dart';
import 'package:sawjigrocerryapp/ui/gridViewScreen.dart';
import './gridScreen2.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sawjigrocerryapp/scopedmodel/main.dart';
class CategoryScreen extends StatefulWidget {
  final String productType;
  final String productTypeName;

  CategoryScreen({Key key, this.productType , this .productTypeName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Category(productType, productTypeName);
}

class Category extends State<CategoryScreen> with TickerProviderStateMixin {
  String productType;
  final String productTypeName;

  List<Products> cartItems;

  Category(this.productType ,this.productTypeName);
  List<Tab> _tabs = List<Tab>();
  List<Widget> _generalWidgets = List<Widget>();
  TabController _tabController;
  var categories = [];

  @override
  void initState() {
    var productCategory = getproductCategoriesById(productType);
    productCategory.then((value) => {getcategories(value)});
    super.initState();
    setState(() {
      cartItems = [];
    });
  }

  List<Tab> getTabs(int count) {
    _tabs.clear();
    for (int i = 0; i < count; i++) {
      _tabs.add(getTab(categories[i]['name']));
    }
    return _tabs;
  }

  void getcategories(data) {
    setState(() {
        categories = data["CATEGORY"];
         getTabs(categories.length);
    });
  
   
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  Tab getTab(String widgetNumber) {
    return Tab(
      text: widgetNumber,
    );
  }

  List<Widget> getWidgets(global) {
    _generalWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      _generalWidgets.add(getWidget(categories[i]['value'], global));
    }
    return _generalWidgets;
  }

  Widget getWidget(String category ,MainModel  global) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double height = 2000;

    return Container(
        child: FutureBuilder(
            future: getProductsByCategory(category),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Center(child: new Text('Loading')));
              } else {
                return Container(
                  child: GridViewScreen(products:snapshot.data ,model: global)
                );
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    IconData _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      }
      assert(false);
      return null;
    }
 return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
           if (categories.length == 0) {
      return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(_backIcon()),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
           productTypeName,
            style: TextStyle(fontSize: 16.0),
          ),
          // actions: <Widget>[
          //   Padding(
          //     padding: const EdgeInsets.only(right: 16.0),
          //     child: Stack(
          //       children: <Widget>[
          //         new IconButton(
          //             icon: new Icon(
          //               Icons.shopping_cart,
          //               color: Colors.black,
          //             ),
          //             onPressed: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) =>
          //                           Cart_screen()));
          //             }),
          //         new Positioned(
          //             child: new Stack(
          //           children: <Widget>[
          //             new Icon(Icons.brightness_1,
          //                 size: 20.0, color: Colors.orange.shade500),
          //             model.cartItemsCount == 0
          //                 ? new Container()
          //                 : new Positioned(
          //                     top: 4.0,
          //                     right: 5.5,
          //                     child: new Center(
          //                       child: new Text(
          //                        model.cartItemsCount.toString(),
          //                         style: new TextStyle(
          //                             color: Colors.white,
          //                             fontSize: 11.0,
          //                             fontWeight: FontWeight.w500),
          //                       ),
          //                     )),
          //           ],
          //         )),
          //       ],
          //     ),
          //   ),
          // ],

            actions: <Widget>[
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () async {
                  final int selected = await showSearch<int>(
                    context: context,
                    //delegate: _delegate,
                  );
                },
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Container(
                  height: 150.0,
                  width: 30.0,
                  child: new GestureDetector(
                    onTap: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Cart_screen()));
                    },
                     child: Stack(
                      children: <Widget>[
                        new IconButton(
                            icon: new Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cart_screen()));
                            }),
                        model.cartItemsCount == 0
                            ? new Container()
                            : new Positioned(
                                child: new Stack(
                                children: <Widget>[
                                  new Icon(Icons.brightness_1,
                                      size: 20.0,
                                      color: Colors.orange.shade500),
                                  new Positioned(
                                      top: 4.0,
                                      right: 5.5,
                                      child: new Center(
                                        child: new Text(
                                         model.cartItemsCount.toString(),
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ],
                              )),
                      ],
                    ),
                  ),
                ),
              )
            ],
        ),
      );
    } else {
      return DefaultTabController(
          length: categories.length,
          child: new Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(_backIcon()),
                  alignment: Alignment.centerLeft,
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                productTypeName,
                  style: TextStyle(fontSize: 16.0),
                ),
                bottom: PreferredSize(
                    child: TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.white,
                        tabs: _tabs,
                        controller: _tabController),
                    preferredSize: Size.fromHeight(30.0)),
                actions: <Widget>[
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () async {
                  final int selected = await showSearch<int>(
                    context: context,
                    //delegate: _delegate,
                  );
                },
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Container(
                  height: 150.0,
                  width: 30.0,
                  child: new GestureDetector(
                    onTap: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Cart_screen()));
                    },
                    child: Stack(
                      children: <Widget>[
                        new IconButton(
                            icon: new Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cart_screen()));
                            }),
                        model.cartItemsCount == 0
                            ? new Container()
                            : new Positioned(
                                child: new Stack(
                                children: <Widget>[
                                  new Icon(Icons.brightness_1,
                                      size: 20.0,
                                      color: Colors.orange.shade500),
                                  new Positioned(
                                      top: 4.0,
                                      right: 5.5,
                                      child: new Center(
                                        child: new Text(
                                         model.cartItemsCount.toString(),
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ],
                              )),
                      ],
                    ),
                  ),
                ),
              )
            ],
              ),
              body: TabBarView(
                controller: _tabController,
                children: getWidgets(model),
              )));
    }

        });
    
  }
}
