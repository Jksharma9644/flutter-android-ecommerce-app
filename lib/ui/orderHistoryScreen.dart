import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:sawjigrocerryapp/services/product.service.dart';

class Oder_History extends StatefulWidget {
  final String toolbarname;
  final String clientId;
  Oder_History({Key key, this.toolbarname, this.clientId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => oder_history(toolbarname, clientId);
}

class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final String address;
  final String cancelOder;

  Item(
      {this.name,
      this.deliveryTime,
      this.oderId,
      this.oderAmount,
      this.paymentType,
      this.address,
      this.cancelOder});
}

class oder_history extends State<Oder_History> {
  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  VoidCallback _showBottomSheetCallback;
  final String clientId;

  var orderList = [];

  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  oder_history(this.toolbarname, this.clientId);
  @override
  void initState() {
    super.initState();
    loadOrderApi();
  }

  void loadOrderApi() {
    var dataRef = getOrderById(clientId);
    dataRef.then((data) => {getAllOrders(data)});
  }

  void getAllOrders(data) {
    setState(() {
      orderList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final Orientation orientation = MediaQuery.of(context).orientation;
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
        ),
        body: orderList.length == 0
            ? new Container(): ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (BuildContext cont, int ind) {
                  return SafeArea(
                      child: Column(children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                        color: Colors.black12,
                        child: Card(
                            elevation: 4.0,
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 10.0, 10.0, 10.0),
                                child: GestureDetector(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // three line description
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        orderList[ind]['CLIENT_INFO']['name'],
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(top: 3.0),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'To Deliver On :' + '26-04-2020',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                    Divider(
                                      height: 10.0,
                                      color: Colors.amber.shade500,
                                    ),

                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.all(3.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Order Id',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black54),
                                                ),
                                                Container(
                                                  width: 150,
                                                  margin:
                                                      EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    orderList[ind]['ORDER_ID'],
                                                      
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black87),
                                                  ),
                                                )
                                              ],
                                            )),
                                        Container(
                                            padding: EdgeInsets.all(3.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Order Amount',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black54),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    orderList[ind]
                                                            ['TOTAL_AMOUNT']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Container(
                                            padding: EdgeInsets.all(3.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Payment Type',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black54),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    'Online',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black87),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                    Divider(
                                      height: 10.0,
                                      color: Colors.amber.shade500,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 20.0,
                                          color: Colors.amber.shade500,
                                        ),

                                        Text( orderList[ind]["CLIENT_INFO"]["address"].length>0 ?  orderList[ind]["CLIENT_INFO"]["address"][0]["name"] + "  , " + orderList[ind]["CLIENT_INFO"]["address"][0]["location"] : "",
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black54)),
                                      ],
                                    ),
                                    Divider(
                                      height: 10.0,
                                      color: Colors.amber.shade500,
                                    ),
                                    Container(
                                      child : new Row(
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.all(2),
                                          child: _status("Order" ,
                                            orderList[ind]['ORDER_STATUS']),
                                          ),
                                           Padding(padding: EdgeInsets.all(2),
                                          child: _status("Payment",
                                            orderList[ind]['PAYMENT_STATUS']),
                                          )

                                        ],
                                      )
                                    
                                      )
                                  ],
                                ))))),
                  ]));
                }));
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  Widget _status(type ,status) {
    if (status == 'cancelled' || status == 'failed' || status == 'rejected') {
      return FlatButton.icon(
          label: Text(
            type  +" : " + status,
            style: TextStyle(color: Colors.black),
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 18.0,
            color: Colors.red,
          ),
          onPressed: () {
            // Perform some action
          });
    } else {
      if(status == 'pending' || status == 'process' ){
      return FlatButton.icon(
          label: Text(
            type  +" : " + status,
            style: TextStyle(color: Colors.black),
          ),
          icon: const Icon(
            Icons.check_circle,
            size: 18.0,
            color: Colors.orange,
          ),
          onPressed: () {
            // Perform some action
          });
      }else{
         return FlatButton.icon(
          label: Text(
            type  +" : " + status,
            style: TextStyle(color: Colors.black),
          ),
          icon: const Icon(
            Icons.check_circle,
            size: 18.0,
            color: Colors.green,
          ),
          onPressed: () {
            // Perform some action
          });
      }
      
    }
    if (status == "3") {
      return Text('Process');
    } else if (status == "1") {
      return Text('Order');
    } else {
      return Text("Waiting");
    }
  }

  erticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }
}
