import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:sawjigrocerryapp/ui/paymentScreen.dart';
import 'package:sawjigrocerryapp/ui/razorPayScreen.dart';
import 'package:sawjigrocerryapp/services/product.service.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sawjigrocerryapp/scopedmodel/main.dart';
import 'package:sawjigrocerryapp/ui/customModal.dart';
import 'package:sawjigrocerryapp/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sawjigrocerryapp/ui/paymentScreen.dart';
class Checkout extends StatefulWidget {
  final List<Products> items;
  double totalPrice;
  var user;
  Checkout({Key key, this.items, this.totalPrice, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => check_out(items, totalPrice, user);
}

class Item {
  final String itemName;
  final String itemQun;
  final String itemPrice;

  Item({this.itemName, this.itemQun, this.itemPrice});
}

class check_out extends State<Checkout> {
  SharedPreferences prefs;
  final List<Products> items;
  String orderId;
  double totalPrice;
  var userDetails;
  var user;
  var profileData;
  var address;

  String _addName;
  String _addLocation;
  check_out(this.items, this.totalPrice, this.userDetails);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxValueA = true;

   @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }
  void placeOrder(MainModel model) async {
    var selectedCount =0;
    var selectedAddress = [];
    var selectedIndex = 0;
    var order_list = convertOrderListToJson(model.cartList);
    for( var i =0 ;i<address.length ; i++){
      if(address[i]["selected"]){
        selectedIndex = i;
        selectedCount = selectedCount+1;
      }
    }
    if(selectedCount>1){
        scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("please select only one delivery address")
    ));
    }else{
        if(selectedCount==1){
          selectedAddress.add(address[selectedIndex]);
                var request = {
            "ORDER_DETAILS": order_list,
            "CLIENT_ID": userDetails['user_id'],
            "ORDER_STATUS": "pending",
            "CLIENT_INFO": {
              "email": userDetails['email'],
              "name": userDetails['name'],
              "userid": userDetails['user_id'],
              "address": selectedAddress
            },
            "TOTAL_AMOUNT": model.cartTotal,
            "PAYMENT_STATUS": "pending",
            "platform": "android",
            "PAYMENT_MODE": ""
          };
    var responseRef = placeorder(request);
    responseRef.then((res) => {checkOrderPlaced(res, profileData , model)});
        }else{
         scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("please select any address ")
    ));
        }
    }
  
   
  }
  getUserProfileData(user){
   var profileRef = getUserProfile( user["user_id"]);
       profileRef.then((value) => {setProfileData(value)});
  }

  loadSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
       user = prefs.getString('userdetails');
      if (user == null) {
      } else {
        user = json.decode(user);
        getUserProfileData(user);
      }
     
    });
  }
  setProfileData(res){
    if(res['status']){
      setState(() {
         profileData =res ['data'];
         address = profileData['address'];
      });
     
    }
  }


  void checkOrderPlaced(res, clientInfo , model) {
    print(res);
    if (res['status']) {
      orderId = res["OrderId"];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => 
              // RazorPayScreen(
              //     totalPrice:model.cartTotal,
              //     orderId: orderId,
              //     clinetInfo: clientInfo)
                    Patment(
                          totalPrice:model.cartTotal,
                  orderId: orderId,
                  clinetInfo: clientInfo
                      
                    )
                  
                  ));
    }
  }

  void addAddress() {
    final _formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Name'),
                            keyboardType: TextInputType.text,
                      validator: (val) =>
                      val.length < 1 ? 'Please Provide Name' : null,
                      onSaved: (val) => _addName = val,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:InputDecoration(labelText: 'Your full address'),
                       keyboardType: TextInputType.text,
                      validator: (val) =>
                      val.length < 1 ? 'Addresss can not be blank' : null,
                      onSaved: (val) => _addLocation = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                       shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("Add Address"),
                      
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          var req={
                            "address": address
                          };
                        
                          var AddReq = {"name" :_addName ,"location": _addLocation ,"selected" : false};
                          req["address"].add(AddReq);
                           Navigator.of(context).pop();
                    
                         var  ref=  updateProfile(req, user["user_id"]);
                         ref.then((value) => {getUserProfileData(user)});
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

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

  String toolbarname = 'CheckOut';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    AppBar appBar = AppBar(
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
                /*Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder:(BuildContext context) =>
                      new CartItemsScreen()
                  )
              );*/
              },
            ),
          ),
        )
      ],
    );

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return new Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        body: new Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(5.0),
                child: Card(
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // three line description
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Delivery',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.play_circle_outline,
                                                color: Colors.blue,
                                              ),
                                              onPressed: null)
                                        ],
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Payment',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.check_circle,
                                                color: Colors.black38,
                                              ),
                                              onPressed: null)
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ],
                        )))),
            _verticalDivider(),
          new Row(
          children: <Widget>[
              new Container(
              margin: EdgeInsets.only(
                  left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
              child: new Text(
                'Delivery Address',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
                new Container(
                alignment: Alignment.topRight,
                width: 50.0,
                 margin: EdgeInsets.only(
                  left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                  



            child : new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                      shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0)),
                    onPressed: () async {
                                    addAddress();
                                  },
                    child: new Text("+",
                    style: TextStyle(
                      fontSize: 20
                    ),
                    ),
                  )),

          ],

          ),
             
            new Container(
                height: 165.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: address.length,
                   itemBuilder: (BuildContext context, int index){
                    return Container(
                      height: 165.0,
                      width: 200.0,
                      margin: EdgeInsets.all(7.0),
                      child: Card(
                        elevation: 3.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Column(
                              children: <Widget>[
                                new Container(
                                  margin: EdgeInsets.only(
                                      left: 12.0,
                                      top: 5.0,
                                      right: 0.0,
                                      bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                       address[index]["name"],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      new Text(
                                       address[index]["location"],
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 13.0,
                                            letterSpacing: 0.5),
                                      ),
                                      _verticalDivider(),
                                    
                                      new Container(
                                        margin: EdgeInsets.only(
                                            left: 00.0,
                                            top: 05.0,
                                            right: 0.0,
                                            bottom: 5.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            new Text(
                                              'Delivery Address',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black26,
                                              ),
                                            ),
                                            _verticalD(),
                                            new Checkbox(
                                              value:    address[index]["selected"] ? address[index]["selected"] : false,
                                              onChanged: (bool value) {
                                                setState(() {
                                                address[index]["selected"] = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    );
                   }
                    
                    
                    ),
                  ),

                  // children: <Widget>[
                  //   Container(
                  //     height: 165.0,
                  //     width: 56.0,
                  //     child: Card(
                  //       elevation: 3.0,
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: <Widget>[
                  //           new Container(
                  //               alignment: Alignment.center,
                  //               child: IconButton(
                  //                 icon: Icon(Icons.add),
                  //                 onPressed: () async {
                  //                   addAddress();
                  //                 },
                  //               )),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                    
                  //   ]
        
            _verticalDivider(),
            new Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
              child: new Text(
                'Order Summary',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    left: 12.0, top: 5.0, right: 12.0, bottom: 5.0),
                height: 200,
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext cont, int ind) {
                      return SafeArea(
                          child: Column(
                        children: <Widget>[
                          Divider(height: 15.0),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            child: new Container(
                              width: width,
                              child: new Row(
                                children: <Widget>[
                                  Container(
                                    width: width / 2,
                                    child: Text(model.cartList[ind].name,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    width: width / 4,
                                    child: Text(
                                        "Qty:" +
                                            model.cartList[ind].qty.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                      width: width * 0.15,
                                      child: Text(
                                          '\₹' +
                                              (model.cartList[ind].qty *
                                                      model.cartList[ind]
                                                          .netPrice)
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                    })),
          ],
        ),
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
                    '\₹ ${model.cartTotal}',
                    style: TextStyle(fontSize: 17.0, color: Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: OutlineButton(
                          borderSide: BorderSide(color: Colors.amber.shade500),
                          child: const Text('CONFIRM ORDER'),
                          textColor: Colors.amber.shade500,
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => RazorPayScreen(totalPrice:totalPrice)));
                            placeOrder(model);
                          },
                          shape: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }

  IconData _add_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.add;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  IconData _sub_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.remove;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
