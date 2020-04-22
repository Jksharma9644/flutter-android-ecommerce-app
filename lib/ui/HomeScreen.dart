import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/ui/CategoryScreen.dart';
import 'package:sawjigrocerryapp/ui/CartScreen.dart';
import 'dart:convert';
import 'package:sawjigrocerryapp/services/product.service.dart';
import 'package:sawjigrocerryapp/ui/DrawerScreen.dart';
import 'package:sawjigrocerryapp/services/sharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sawjigrocerryapp/scopedmodel/main.dart';
import 'package:sawjigrocerryapp/ui/CartScreen.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new Home();
}

class Home extends State<HomeScreen> {
  SharedPref sharedPref = SharedPref();
  List list = [];
  var user;
  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    getProducts();
  }

  loadSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getString('userdetails');
  }

  final List<String> items = ['Balbhadra', 'Maulik', 'Roshi'];
  static const double height = 366.0;
  String name = 'My Wishlist';
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    ShapeBorder shapeBorder;
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            title: Text("Sawji Store"),
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
          drawer: new DrawerScreen(),
          body: FutureBuilder(
              future: getallProductType(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(child: Center(child: new Text('Loading')));
                } else {
                  return new SingleChildScrollView(
                    child: Container(
                      child: new Column(children: <Widget>[
                        new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _verticalD(),
                              new GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => CategoryScreen(
                                  //               productType:
                                  //                   'Fruits & Vegetables',
                                  //             )));
                                },
                                child: new Text(
                                  'Best value',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              _verticalD(),
                              new GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => CategoryScreen(
                                  //               productType:
                                  //                   'Fruits & Vegetables',
                                  //             )));
                                },
                                child: new Text(
                                  'Top sellers',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              _verticalD(),
                              new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             CategoryScreen(
                                      //               productType:
                                      //                   'Fruits & Vegetables',
                                      //             )));
                                    },
                                    child: new Text(
                                      'All',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  _verticalD(),
                                  IconButton(
                                    icon: keyloch,
                                    color: Colors.black26,
                                  )
                                ],
                              )
                            ]),
                        new Container(
                          height: 188.0,
                          margin: EdgeInsets.only(left: 5.0),
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                SafeArea(
                                  top: true,
                                  bottom: true,
                                  child: Container(
                                    width: 270.0,

                                    child: Card(
                                      shape: shapeBorder,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 180.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned.fill(
                                                  child: Image.asset(
                                                    'images/grthre.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )

                                          /*Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('',
                              style: titleStyle,
                            ),
                          ),
                        ),*/
                                        ],
                                      ),
                                    ),
                                    // description and share/explore buttons
                                    // share, explore buttons
                                  ),
                                ),
                                SafeArea(
                                  top: true,
                                  bottom: true,
                                  child: Container(
                                    width: 270.0,

                                    child: Card(
                                      shape: shapeBorder,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 180.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned.fill(
                                                  child: Image.asset(
                                                    'images/grtwo.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )

                                          /*Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('',
                              style: titleStyle,
                            ),
                          ),
                        ),*/
                                        ],
                                      ),
                                    ),
                                    // description and share/explore buttons
                                    // share, explore buttons
                                  ),
                                ),
                                SafeArea(
                                  top: true,
                                  bottom: true,
                                  child: Container(
                                    width: 270.0,

                                    child: Card(
                                      shape: shapeBorder,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 180.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned.fill(
                                                  child: Image.asset(
                                                    'images/groceries.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )

                                          /*Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('',
                              style: titleStyle,
                            ),
                          ),
                        ),*/
                                        ],
                                      ),
                                    ),
                                    // description and share/explore buttons
                                    // share, explore buttons
                                  ),
                                ),
                                SafeArea(
                                  top: true,
                                  bottom: true,
                                  child: Container(
                                    width: 270.0,

                                    child: Card(
                                      shape: shapeBorder,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 180.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned.fill(
                                                  child: Image.asset(
                                                    'images/back.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )

                                          /*Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('',
                              style: titleStyle,
                            ),
                          ),
                        ),*/
                                        ],
                                      ),
                                    ),
                                    // description and share/explore buttons
                                    // share, explore buttons
                                  ),
                                ),
                              ]),
                        ),
                        new Container(
                          margin: EdgeInsets.only(top: 7.0),
                          child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _verticalD(),
                                new GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => CategoryScreen(
                                    //               productType:
                                    //                   'Fruits & Vegetables',
                                    //             )));
                                  },
                                  child: new Text(
                                    'Categories',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                _verticalD(),
                                new GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => CategoryScreen(
                                    //               productType:
                                    //                   'Fruits & Vegetables',
                                    //             )));
                                  },
                                  child: new Text(
                                    'Popular',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                _verticalD(),
                                new Row(
                                  children: <Widget>[
                                    new GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             CategoryScreen(
                                        //               productType:
                                        //                   'Fruits & Vegetables',
                                        //             )));
                                      },
                                      child: new Text(
                                        'Whats New',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                        new Container(
                          alignment: Alignment.topCenter,
                          height: 700.0,
                          child: new GridView.builder(
                              itemCount: snapshot.data.length,
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(10.0),
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return new GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryScreen(
                                                    productType:
                                                        snapshot.data[index].id,
                                                  )));
                                    },
                                    child: new Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: new Card(
                                          shape: shapeBorder,
                                          elevation: 3.0,
                                          child: new Container(
                                            //  mainAxisSize: MainAxisSize.max,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 152.0,
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Positioned.fill(
                                                          child: Image.network(
                                                        snapshot.data[index]
                                                            .images[0].url,
                                                        fit: BoxFit.cover,
                                                      )),
                                                      Container(
                                                        color: Colors.black38,
                                                      ),
                                                      Container(
                                                        //margin: EdgeInsets.only(left: 10.0),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3.0,
                                                                bottom: 3.0),
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child:
                                                            new GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CategoryScreen(
                                                                              productType: snapshot.data[index].id,
                                                                            )));
                                                          },
                                                          child: new Text(
                                                            snapshot.data[index]
                                                                .type,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),

                                                      /*Positioned(
                                    child: FittedBox(

                                     fit: BoxFit.fill,
                                      alignment: Alignment.centerLeft,
                                      child: Text(photos[index].title,
                                        style: TextStyle(color: Colors.black87,fontSize: 15.0),
                                      ),

                                  )
                                  )*/
                                                    ],
                                                  ),
                                                ),

                                                // new Text(photos[index].title.toString()),
                                              ],
                                            ),
                                          ),
                                        )));
                              }),
                        )
                      ]),
                    ),
                  );
                }
                ;
              }));
    });
  }

  Icon keyloch = new Icon(
    Icons.arrow_forward,
    color: Colors.black26,
  );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0, right: 0.0, top: 5.0, bottom: 0.0),
      );
}
