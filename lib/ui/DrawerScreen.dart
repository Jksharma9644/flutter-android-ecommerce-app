import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/ui/UserScreen.dart';
import 'package:sawjigrocerryapp/services/sharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sawjigrocerryapp/ui/UserScreen.dart';
import 'package:sawjigrocerryapp/ui/orderHistoryScreen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new DrawerState();
}

class DrawerState extends State<DrawerScreen> {
  String name = 'My Wishlist';
  SharedPreferences prefs;
  var user;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
       user = prefs.getString('userdetails');
       if(user==null){

       }else{
           user =json.decode(user);
       }
     
    });
   

  }
 logout(){
  prefs.remove('userdetails');
   setState(() {
     user = null;
   });
 }

  @override
  Widget build(BuildContext context) {

    if(user!=null){
     return new Drawer(
      child: new ListView(
        children: <Widget>[
          new Card(
            child: UserAccountsDrawerHeader(
              accountName: new Text(user['name']),
              accountEmail: new Text(user['email']),
              onDetailsPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Account_Screen()));
              },
              decoration: new BoxDecoration(
                backgroundBlendMode: BlendMode.difference,
                color: Colors.white30,

                /* image: new DecorationImage(
               //   image: new ExactAssetImage('assets/images/lake.jpeg'),
                  fit: BoxFit.cover,
                ),*/
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.fakenamegenerator.com/images/sil-female.png")),
            ),
          ),
          new Card(
            elevation: 4.0,
            child: new Column(
              children: <Widget>[
                new ListTile(
                    leading: Icon(Icons.favorite),
                    title: new Text(name),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: name,)));
                    }),
                new Divider(),
                new ListTile(
                    leading: Icon(Icons.history),
                    title: new Text("Order History "),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Oder_History(toolbarname:' Order History', clientId: user['user_id'])));
                    }),
              ],
            ),
          ),
          new Card(
            elevation: 4.0,
            child: new Column(
              children: <Widget>[
                new ListTile(
                    leading: Icon(Icons.settings),
                    title: new Text("Setting"),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting_Screen(toolbarname: 'Setting',)));
                    }),
                new Divider(),
                new ListTile(
                    leading: Icon(Icons.help),
                    title: new Text("Help"),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Help_Screen(toolbarname: 'Help',)));
                    }),
              ],
            ),
          ),
          new Card(
            elevation: 4.0,
            child: new ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text(
                  "Logout",
                  style: new TextStyle(color: Colors.redAccent, fontSize: 17.0),
                ),
                onTap: () {
                  logout();
                }),
          )
        ],
      ),
    );
    }else{
       return new Drawer(
         child: new ListView(
        children: <Widget>[
          new Card( 
                 elevation: 4.0,
            child: new ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text(
                  "Login",
                  style: new TextStyle(color: Colors.redAccent, fontSize: 17.0),
                ),
                onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> Login_Screen()));
                }),

          )]));

    }
    
  }
}
