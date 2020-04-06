import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sawjigrocerryapp/model/category-modal.dart';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:sawjigrocerryapp/services/product.service.dart';
import 'package:sawjigrocerryapp/ui/ProductDetailsScreen.dart';
import 'package:sawjigrocerryapp/ui/CartScreen.dart';

class CategoryScreen extends StatefulWidget {
  final String productType;

  CategoryScreen({Key key, this.productType}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Category(productType);
}

class Category extends State<CategoryScreen> with TickerProviderStateMixin {
  String productType;
  List <Products>  cartItems;
   

  Category(this.productType);
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
    categories = data["CATEGORY"];
    getTabs(categories.length);
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  Tab getTab(String widgetNumber) {
    return Tab(
      text: widgetNumber,
    );
  }

  List<Widget> getWidgets() {
    _generalWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      _generalWidgets.add(getWidget(categories[i]['value']));
    }
    return _generalWidgets;
  }
  

  Widget getWidget(String category) {
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
                  child: GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 2 : 3),
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data[index].images.length > 0) {
                        return SafeArea(
                            top: false,
                            bottom: false,
                            child: SizedBox(
                                height: 800,
                                child: new GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ProductDetailsScreen(
                                      //                 productDetails: snapshot
                                      //                     .data[index]))
                                      //                     );
                                     
                                      setState((){
                                       
                                        cartItems.add(snapshot.data[index]);
                                        });
                                    },
                                    child: new Card(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                          SizedBox(
                                            height: 150.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned.fill(
                                                  child: Image.network(
                                                    snapshot.data[index]
                                                        .images[0].url,
                                                    // package: destination.assetPackage,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  // padding: EdgeInsets.all(5.0),
                                                  child: IconButton(
                                                      icon: const Icon(Icons
                                                          .favorite_border),
                                                      onPressed: () {}),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          Expanded(
                                            child: Container(
                                              height: 200,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16.0, 16.0, 16.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  // three line description
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Text(
                                                      'QTY :' +
                                                          snapshot
                                                              .data[index].qty
                                                              .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Text('MRP : ₹' +
                                                          snapshot.data[index]
                                                              .mrp)),
                                                  // Text(destination.description[1]),
                                                  // Text(destination.description[2]),
                                                ],
                                              ),
                                            ),
                                          ),
                                          
                                         
                                        
                                        ])))));
                      } else {
                        return new Card(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              SizedBox(
                                height: 150.0,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: Image.asset(
                                        'images/no-images.png',
                                        // package: destination.assetPackage,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      // padding: EdgeInsets.all(5.0),
                                      child: IconButton(
                                          icon:
                                              const Icon(Icons.favorite_border),
                                          onPressed: () {}),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 16.0, 16.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      // three line description
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          'QTY :' +
                                              snapshot.data[index].qty
                                                  .toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text('MRP : ₹' +
                                              snapshot.data[index].mrp)),
                                      // Text(destination.description[1]),
                                      // Text(destination.description[2]),
                                    ],
                                  ),
                                ),
                              ),
                               
                            ]));
                      }
                    },
                  ),
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

    return FutureBuilder(
        future: getproductCategoriesById('5cb2f8b139322600041b6f0d'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: new Text('Loading')));
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
                        'Sawji Grocerry Store',
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
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child:Stack(
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart_screen(items:cartItems)));
                        }),
                         new Positioned(
                        child: new Stack(
                          children: <Widget>[
                            new Icon(Icons.brightness_1,
                                size: 20.0, color: Colors.orange.shade500),
                               cartItems.length == 0
                           ? new Container():
                            new Positioned(
                                top: 4.0,
                                right: 5.5,
                                child: new Center(
                                  child: new Text(
                                   cartItems.length.toString(),
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

                          //  new IconButton(
                          //     icon: new Icon(
                          //       Icons.shopping_cart,
                          //       color: Colors.black,
                          //     ),
                          //     onPressed: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => Cart_screen()));
                          //     }),
                              
                        ),
                      ],
                    ),
                    body: TabBarView(
                      controller: _tabController,
                      children: getWidgets(),
                    )));
          }
        });
  }
}
