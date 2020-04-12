import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:sawjigrocerryapp/ui/ProductDetailsScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sawjigrocerryapp/scopedmodel/main.dart';
class GridViewScreen extends StatefulWidget {
  List<Products> products;
  MainModel model;
  GridViewScreen({Key key, this.products , this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Grid(products,model);
}

class Grid extends State<GridViewScreen> {
  List<Products> products;
  MainModel model;
  Grid(this.products ,this .model);
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double height = 2000;
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
      itemBuilder: (BuildContext context, int index) {
        if (products[index].images.length > 0) {
          return SafeArea(
              top: false,
              bottom: false,
              child: new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                                productDetails: products[index])));

                    // setState(() {
                    //   cartItems.add(products[index]);
                    // });
                  },
                  child: new Card(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 100.0,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Image.network(
                                  products[index].images[0].url,
                                  // package: destination.assetPackage,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 300,
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 16.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // three line description
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'QTY :' + products[index].qty.toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child:
                                        Text('MRP : ₹' + products[index].mrp)),
                                // Text(destination.description[1]),
                                // Text(destination.description[2]),
                              ],
                            ),
                          ),
                        ),
                        new Center(
                          child: FlatButton(
                            color: Colors.redAccent,
                            child: const Text('Add to Cart'),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            textColor: Colors.white,
                            onPressed: () {
                              // launch(data[index]["link"],
                              //     forceWebView: false);
                              model.incrementCount();
                              model.addCartItems(products[index]);
                            },
                          ),
                        )
                      ]))));
        } else {
           return SafeArea(
              top: false,
              bottom: false,
              child: new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                                productDetails: products[index])));

                    // setState(() {
                    //   cartItems.add(products[index]);
                    // });
                  },
                  child:  new Card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  height: 100.0,
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
                            icon: const Icon(Icons.favorite_border),
                            onPressed: () {

                            }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // three line description
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'QTY :' + products[index].qty.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text('MRP : ₹' + products[index].mrp)),
                        // Text(destination.description[1]),
                        // Text(destination.description[2]),
                      ],
                    ),
                  ),
                ),
                new Center(
                  child: FlatButton(
                    color: Colors.redAccent,
                    child: const Text('Add to Cart'),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                    onPressed: () {
                      // launch(data[index]["link"],
                      //     forceWebView: false);
                    },
                  ),
                )
              ]))
                  
                  ));
          
          
        }
      },
    );
  }
}
