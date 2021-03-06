import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/ui/HomeScreen.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:sawjigrocerryapp/scopedmodel/main.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  final MainModel _model = MainModel();
   return ScopedModel<MainModel>(
    model: _model,

   child: new MaterialApp(
      title: 'Flutter Demo',
     theme: new ThemeData(

            primaryColor: Colors.white,
            primaryColorDark: Colors.white30,
            accentColor: Colors.blue

        ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    ));
    
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

  }

  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      decoration: new BoxDecoration(color : Color.fromRGBO(35, 177,77, 1)),
      child: new Container(
        color: Colors.black12,
        margin: new EdgeInsets.all(30.0),
        height: 250.0,
        width: 250.0,
        child: new Image.asset('images/logo.jpg')
      ),
    );
    
  }
}
