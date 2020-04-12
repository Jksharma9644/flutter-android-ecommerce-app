import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sawjigrocerryapp/scopedmodel/main.dart';
import 'package:sawjigrocerryapp/ui/CartScreen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products productDetails;
  ProductDetailsScreen({Key key, @required this.productDetails})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemDetailClass(productDetails);
}

class ItemDetailClass extends State<ProductDetailsScreen> {
  Products productDetails;
  ItemDetailClass(this.productDetails);

  // In the constructor, require a Todo.
  String toolbarname = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List list = ['12', '11'];

  String itemname = 'Apple';
  int item = 0;
  String itemprice = '\$15';

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.5;
    toolbarname = productDetails.name;
    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;
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

    IconData _add_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.add_circle;
        case TargetPlatform.iOS:
          return Icons.add_circle;
      }
      assert(false);
      return null;
    }

    IconData _sub_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.remove_circle;
        case TargetPlatform.iOS:
          return Icons.remove_circle;
      }
      assert(false);
      return null;
    }

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return new Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(_backIcon()),
              alignment: Alignment.centerLeft,
              tooltip: 'Back',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(toolbarname),
            backgroundColor: Colors.white,
            actions: <Widget>[
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
                            onPressed: () {}),
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
          body: Container(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                Card(
                  elevation: 4.0,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // photo and title
                          SizedBox(
                            height: 250.0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                new Container(
                                  child: new Carousel(
                                    images: [
                                      new Image.network(
                                        productDetails.images.length > 0
                                            ? widget
                                                .productDetails.images[0].url
                                            : 'images/no-images.png',

                                        // package: destination.assetPackage,
                                      ),
                                    ],
                                    boxFit: BoxFit.scaleDown,
                                    showIndicator: false,
                                    autoplay: false,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    child: DefaultTextStyle(
                        style: descriptionStyle,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Flexible(
                              child: new Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  widget.productDetails.name,
                                  maxLines: 20,
                                  style: descriptionStyle.copyWith(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '₹ ' + widget.productDetails.mrp,
                                style: descriptionStyle.copyWith(
                                    fontSize: 20.0, color: Colors.black54),
                              ),
                            ),
                          ],
                        ))),
                Container(
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 20.0, 10.0, 20.0),
                            child: DefaultTextStyle(
                                style: descriptionStyle,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // three line description
                                    Row(
                                      children: <Widget>[
                                        // new IconButton(
                                        //   icon: Icon(_add_icon(),
                                        //       color: Colors.amber.shade500),
                                        //   onPressed: () {
                                        //     item = item + 1;
                                        //   },
                                        // ),
                                        Container(
                                          margin: EdgeInsets.only(left: 2.0),
                                        ),
                                        Text("QTY:" + widget.productDetails.qty.toString(),
                                          style: descriptionStyle.copyWith(
                                              fontSize: 20.0,
                                              color: Colors.black87),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 2.0),
                                        ),
                                        // new IconButton(
                                        //   icon: Icon(_sub_icon(),
                                        //       color: Colors.amber.shade500),
                                        //   onPressed: () {
                                        //     if (item < 0) {
                                        //     } else {
                                        //       item = item - 1;
                                        //     }
                                        //   },
                                        // ),
                                      ],
                                    ),

                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: OutlineButton(
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade500),
                                            child: const Text('Add to cart'),
                                            textColor: Colors.amber.shade500,
                                            onPressed: () {
                                                 model.incrementCount();
                                                 model.addCartItems(widget.productDetails);
                                            },
                                            shape: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            )),
                                      ),
                                    ),
                                  ],
                                ))))),
                Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    child: DefaultTextStyle(
                        style: descriptionStyle,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // three line description
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Details',
                                style: descriptionStyle.copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ],
                        ))),
                Container(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                    child: new Html(data: widget.productDetails.description)),
              ]))));
    });
  }
}
