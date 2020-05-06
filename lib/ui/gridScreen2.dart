import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:sawjigrocerryapp/ui/ProductDetailsScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sawjigrocerryapp/scopedmodel/main.dart';

class GridViewScreen2 extends StatefulWidget {
  List<Products> products;
  MainModel model;
  GridViewScreen2({Key key, this.products, this.model}) : super(key: key);
  @override
  State<StatefulWidget> createState() => Grid(products, model);
}

class Grid extends State<GridViewScreen2> {
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
            crossAxisCount: (orientation == Orientation.portrait) ? 1 : 3),
        itemBuilder: (BuildContext context, int index) {
          return SafeArea(
              top: false,
              bottom: false,
              child: new GestureDetector(
                  child: new Container(
                  height: 600,
                padding: new EdgeInsets.all(8.0),
                child: new Column(
                  children: <Widget>[
                    backgroundImage(products[index]),
                    onTopContent(products[index])
                  ],
                ),
              )));
        });
  }

  backgroundImage(item) {
    return Container(
      height: 200,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: item.images.length > 0
              ? new NetworkImage(
                  item.images[0].url,
                )
              : new NetworkImage(
                  'images/no-images.png',
                  // package: destination.assetPackage,
                  
                ),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  onTopContent(item) {
    return Container(
      height: 200.0,
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
           item.name
          ),
          new Text(
          item.qty.toString()
          ),
          new Container(
            height: 2.0,
            width: 150.0,
            color: Colors.redAccent,
          ),
          new Text(
               item.qty.toString()
          ),
          //new Container()
        ],
      ),
    );
  }
}
