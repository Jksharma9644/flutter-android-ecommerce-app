import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:sawjigrocerryapp/ui/ProductDetailsScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sawjigrocerryapp/scopedmodel/main.dart';

class GridViewScreen extends StatefulWidget {
  List<Products> products;
  MainModel model;
  GridViewScreen({Key key, this.products, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Grid(products, model);
}

class Grid extends State<GridViewScreen> {
  List<Products> products;
  MainModel model;
  Grid(this.products, this.model);
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double height = 2000;
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
      itemBuilder: (BuildContext context, int index) {
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
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                    child: new Column(
                  children: <Widget>[
                    new Card(
                        
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                     
                      child: new Stack(
                        children: <Widget>[
                          new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                 height: 60,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                        child: products[index].images.length > 0
                                            ? Image.network(
                                                products[index].images[0].url,
                                                // package: destination.assetPackage,
                                                fit: BoxFit.fitHeight,
                                              )
                                            : Image.asset(
                                                'images/no-images.png',
                                                // package: destination.assetPackage,
                                                fit: BoxFit.scaleDown,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                new Container(
                                    height: 50,
                                    padding: EdgeInsets.all(10),
                                    child: new Text(
                                      products[index].name,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600),
                                    )
                                    ),
                                new Container(
                                
                                  alignment: Alignment.bottomRight,
                                  child: new Row(
                                    children: <Widget>[
                                       Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text('Qty :' + products[index].qty.toString(),
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text('₹' + products[index].mrp,
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 20.0,
                                          child: RaisedButton(
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              model.incrementCount();
                                              model.addCartItems(
                                                  products[index]);
                                            },
                                            child: Text(
                                              "Add",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    )
                  ],
                ))));
      },
    );
  }
}
