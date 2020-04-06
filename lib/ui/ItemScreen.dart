import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/services/product.service.dart';
import 'package:sawjigrocerryapp/ui/ProductDetailsScreen.dart';
import 'package:sawjigrocerryapp/ui/CartScreen.dart';
class ItemScreen extends StatefulWidget{
  final String toolbarname;
  ItemScreen({Key key, this.toolbarname}) : super(key: key);
  @override
  State<StatefulWidget> createState() => Item(toolbarname);
}

class Item extends State<ItemScreen> {
  String toolbarname;
  List list = ['12', '11'];
  final List<String> items = ['Balbhadra', 'Maulik', 'Roshi'];
  static const double height = 366.0;
  String name ='My Wishlist';
  Item(this.toolbarname);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context){

  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = size.width / 2;
  final Orientation orientation = MediaQuery.of(context).orientation;
   


  return new Scaffold(
   key:_scaffoldKey,
   appBar: 
   new AppBar(
        backgroundColor: Colors.white,
        title: new Text('Sawji Grocerry Store'),
        actions: <Widget>[
         IconButton(
          tooltip: 'Search',
           icon: const Icon(Icons.search),
          onPressed:  ()  {
          
          }),
          new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            height: 150.0,
            width: 30.0,
            child: new GestureDetector(
              onTap: (){

              },
              child: new Stack(
                children: <Widget>[
                new IconButton(
                  icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart_screen()));
                         
                    }
                   ),
                      list.length == 0
                        ? new Container()
                        : new Positioned(
                         child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.orange.shade500),
                              new Positioned(
                                  top: 4.0,
                                  right: 5.5,
                                  child: new Center(
                                    child: new Text(
                                      list.length.toString(),
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
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Card(
              child: UserAccountsDrawerHeader(
                accountName: new Text("Naomi A. Schultz"),
                accountEmail: new Text("NaomiASchultz@armyspy.com"),
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
           
          ],
        ),
      ),
      body: Container(
            child: FutureBuilder(
              future: getProducts(),
              builder: (BuildContext context , AsyncSnapshot  snapshot){

                if(snapshot.data==null){
                  return Container(
                    child: Center(child: new Text('Loading'))
                  );
                  
                } else {
                  return Container(
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                      itemBuilder: (BuildContext context, int index) {
                        if(snapshot.data[index].images.length>0){
                          return new GestureDetector(
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productDetails:snapshot.data[index])));
                               },

                            child: new Card(
                                child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                  height: 150.0, 
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                        child: Image.network(
                                        snapshot.data[index].images[0].url,
                                          // package: destination.assetPackage,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                      // padding: EdgeInsets.all(5.0),
                                        child: IconButton(icon: const Icon(Icons.favorite_border), onPressed: (){
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
                                              'QTY :' + snapshot.data[index].qty.toString(),
                                            overflow: TextOverflow.ellipsis,
    
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text('MRP : ₹'+ snapshot.data[index].mrp)
                                          
                                        ),
                                        // Text(destination.description[1]),
                                        // Text(destination.description[2]),
                                      ],
                                    ),
                                ),
                              ),
                                ]
                                )
                              )
                          );
                               

                        }else{
                            return new Card(
                                child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                  height: 150.0,
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
                                        child: IconButton(icon: const Icon(Icons.favorite_border), onPressed: (){
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
                                              'QTY :' + snapshot.data[index].qty.toString(),
                                            overflow: TextOverflow.ellipsis,
    
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text('MRP : ₹'+ snapshot.data[index].mrp)
                                          
                                        ),
                                        // Text(destination.description[1]),
                                        // Text(destination.description[2]),
                                      ],
                                    ),
                                ),
                              ),
                                ]
                                )
                              );
                        }
                              
                            },
                      
                      ),
              );
                }
              }

            )





          )
    

  );

  }

}
