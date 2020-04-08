import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:sawjigrocerryapp/ui/CheckoutScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sawjigrocerryapp/ui/UserScreen.dart';
class Cart_screen extends StatefulWidget {
  List<Products> items;

  Cart_screen({Key key, this.items}) : super(key: key);
  @override
  State<StatefulWidget> createState() => Cart(items);
}

class Cart extends State<Cart_screen> {
  List<Products> cartItems;
  double totalPrice = 0;
  Cart(this.cartItems);
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

  @override
  void initState() {
    super.initState();
    setState(() {
      for (var items in cartItems) {
        totalPrice += items.qty * double.parse(items.mrp);
      }
    });
  }

  void addItem(index) {
    setState(() {
      this.cartItems[index].qty = this.cartItems[index].qty + 1;
      totalPrice = 0;
      for (var items in cartItems) {
        totalPrice += items.qty * items.netPrice;
      }
    });
  }

  void decreaseItem(index) {
    setState(() {
      if (this.cartItems[index].qty > 0) {
        this.cartItems[index].qty = this.cartItems[index].qty - 1;
      }
      totalPrice = 0;
      for (var items in cartItems) {
        totalPrice += items.qty * items.netPrice;
      }
    });
  }

  _buildCartProduct(int index) {
    return ListTile(
        contentPadding: EdgeInsets.all(20.0),
        leading: Image.network(
          cartItems[index].images[0].url,
          height: 200.0,
          width: 80.0,
          fit: BoxFit.contain,
        ),
        title: Text(
          cartItems[index].name,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: new Container(
            padding: EdgeInsets.all(2.0),
            child: new Row(children: <Widget>[
              new Text(
                'MRP : ₹${cartItems[index].netPrice}',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
              new IconButton(
                icon: Icon(_add_icon(), color: Colors.amber.shade500),
                onPressed: () {
                  addItem(index);
                },
              ),
              Text(
                this.cartItems[index].qty.toString(),
                style: TextStyle(fontSize: 20.0, color: Colors.black87),
              ),
              new IconButton(
                icon: Icon(_sub_icon(), color: Colors.amber.shade500),
                onPressed: () {
                  decreaseItem(index);
                },
              ),
            ])),
        trailing: new Container(
          child: Text(
            "₹ " +
                (this.cartItems[index].qty * this.cartItems[index].netPrice)
                    .toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.orange,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Shopping Cart(${cartItems.length})',
              style: new TextStyle(color: Colors.black),
            )),
        body: ListView.separated(
            itemCount: cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCartProduct(index);
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[400],
              );
            }),
        bottomSheet: Container(
            alignment: Alignment.bottomLeft,
            height: 50.0,
            child: Card(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.info), onPressed: null),
                  Text(
                    'Total :',
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\₹ ${totalPrice}',
                    style: TextStyle(fontSize: 17.0, color: Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: OutlineButton(
                          borderSide: BorderSide(color: Colors.amber.shade500),
                          child: const Text('Checkout '),
                          textColor: Colors.amber.shade500,
                          onPressed: () async{
                              SharedPreferences prefs;
                              var user;
                             prefs = await SharedPreferences.getInstance();
                            user = prefs.getString('userdetails');
                            if (user == null) {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login_Screen()));
                            }
                             else {
                              user = json.decode(user);
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Checkout(
                                        items: cartItems,
                                        totalPrice: totalPrice,
                                        user:user
                                        )));
                            }
                           
                          },
                          shape: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                    ),
                  ),
                ],
              ),
            ))

        // Container(
        //     width: width,
        //     color: Colors.orange,
        //     child: new Row(children: <Widget>[
        //       new Container(
        //           margin: EdgeInsets.all(15),
        //           width: width * 0.45,
        //           child: Text(
        //             "Total:" +totalPrice.toString(),
        //             textAlign: TextAlign.left,
        //             style: TextStyle(
        //                 color: Colors.black, fontWeight: FontWeight.w600),
        //           )),
        //       new Container(
        //         width: (width * 0.45),
        //         margin: EdgeInsets.only(left: 2),
        //         child: OutlineButton(
        //           borderSide: BorderSide(color: Colors.white),
        //           child: const Text('Checkout'),
        //           textColor: Colors.black,
        //           onPressed: () {
        //             Navigator.push(context,
        //                 MaterialPageRoute(builder: (context) => Checkout(items:cartItems,totalPrice:totalPrice)));
        //           },
        //         ),
        //       ),
        //     ]))

        );
  }
}
