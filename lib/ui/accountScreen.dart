import 'package:flutter/material.dart';
import '../services/auth.service.dart';
import './otpVerification.dart';

class Account_Screen extends StatefulWidget {
  var profileData;
  Account_Screen({Key key, this.profileData}) : super(key: key);
  @override
  State<StatefulWidget> createState() => account(profileData);
}

class account extends State<Account_Screen> {
  var profileData;
  var userProfile;
  account(this.profileData);
  String username = '';
  num mobilenumber;
  String eid = '';
   @override
  void initState() {
    super.initState();
    var profileRef = getUserProfile(profileData['user_id']);
       profileRef.then((value) => {setProfileData(value)});
  }
  setProfileData(res){
    if(res['status']){
      setState(() {
         profileData =res ['data'];
         username = profileData['username'];
         mobilenumber = profileData['mobile'];
        eid = profileData['email'];
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Icon ofericon = new Icon(
      Icons.edit,
      color: Colors.black38,
    );
    Icon keyloch = new Icon(
      Icons.vpn_key,
      color: Colors.black38,
    );
    Icon clear = new Icon(
      Icons.history,
      color: Colors.black38,
    );
    Icon logout = new Icon(
      Icons.do_not_disturb_on,
      color: Colors.black38,
    );

    Icon menu = new Icon(
      Icons.more_vert,
      color: Colors.black38,
    );
    bool checkboxValueA = true;
    bool checkboxValueB = false;
    bool checkboxValueC = false;

    //List<address> addresLst = loadAddress() as List<address> ;
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          'My Account',
        ),
      ),
      body: profileData!=null ?
      
      new Container(
          child: SingleChildScrollView(
            child: new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(7.0),
            alignment: Alignment.topCenter,
            height: 260.0,
            child: new Card(
              elevation: 3.0,
              child: Column(
                children: <Widget>[
                  new Container(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        margin: const EdgeInsets.all(10.0),
                        // padding: const EdgeInsets.all(3.0),
                        child: ClipOval(
                          child: Image.network(
                              'https://www.fakenamegenerator.com/images/sil-female.png'),
                        ),
                      )),

                  new FlatButton(
                    onPressed: null,
                    child: Text(
                      'Change',
                      style:
                          TextStyle(fontSize: 13.0, color: Colors.blueAccent),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.blueAccent)),
                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(
                            left: 10.0, top: 20.0, right: 5.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              username,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            _verticalDivider(),
                            new Text(
                              mobilenumber.toString(),
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                            _verticalDivider(),
                            new Text(
                              eid,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: ofericon,
                            color: Colors.blueAccent,
                            onPressed: null),
                      )
                    ],
                  ),
                  // VerticalDivider(),
                ],
              ),
            ),
          ),
          new Container(
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
            child: new Text(
              'Addresses',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
         new Container(
           height: 165.0,
           child: ListView(
             scrollDirection: Axis.horizontal,
             children: <Widget>[
               Container(
                 height: 165.0,
                 width: 250.0,
                 margin: EdgeInsets.all(7.0),
                 child: Card(
                   elevation: 3.0,
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,

                     children: <Widget>[
                       new Column(


                         children: <Widget>[
                           new Container(
                             margin:
                             EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,

                               children: <Widget>[
                                 new Text(
                                   'Naomi A. Schultz',
                                   style: TextStyle(
                                     color: Colors.black87,
                                     fontSize: 15.0,
                                     fontWeight: FontWeight.bold,
                                     letterSpacing: 0.5,
                                   ),
                                 ),
                                 _verticalDivider(),
                                 new Text(
                                   '2585 Columbia Boulevard',
                                   style: TextStyle(
                                       color: Colors.black45,
                                       fontSize: 13.0,
                                       letterSpacing: 0.5),
                                 ),
                                 _verticalDivider(),
                                 new Text(
                                   'Salisbury',
                                   style: TextStyle(
                                       color: Colors.black45,
                                       fontSize: 13.0,
                                       letterSpacing: 0.5),
                                 ),
                                 _verticalDivider(),
                                 new Text(
                                   ' MD 21801',
                                   style: TextStyle(
                                       color: Colors.black45,
                                       fontSize: 13.0,
                                       letterSpacing: 0.5),
                                 ),

                                 new Container(
                                   margin: EdgeInsets.only(left: 00.0,top: 05.0,right: 0.0,bottom: 5.0),
                                     child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisAlignment: MainAxisAlignment.start,
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
                                           value: checkboxValueA,
                                           onChanged: (bool value) {
                                             setState(() {
                                               checkboxValueA = value;
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
                       new Container(
                         alignment: Alignment.topLeft,
                         child: IconButton(
                             icon: menu,
                             color: Colors.black38,
                             onPressed: null),
                       )
                     ],
                   ),
                 ),
               ),
              
             ],
           )
         ),
          new Container(
            margin: EdgeInsets.all(7.0),
            child: Card(
              elevation: 1.0,
              child: Row(
                children: <Widget>[
                  new IconButton(icon: keyloch, onPressed: null),
                  _verticalD(),
                  new Text(
                    'Change Password',
                    style: TextStyle(fontSize: 15.0, color: Colors.black87),
                  )
                ],
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.all(7.0),
            child: Card(
              elevation: 1.0,
              child: Row(
                children: <Widget>[
                  new IconButton(icon: clear, onPressed: null),
                  _verticalD(),
                  new Text(
                    'Clear History',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),
          ),
          (profileData['isNumberVerified']==null || profileData['isNumberVerified'])
          ?new Container()
          :new Container(
             margin: EdgeInsets.all(7.0),
            child:  new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OTPVerification(mobile:profileData['mobile'] ,id:profileData['_id'])));
                },
                child: Card(
              elevation: 1.0,
              child: Row(
                children: <Widget>[
                  new IconButton(icon: logout, onPressed: null),
                  _verticalD(),
                  new Text(
                    'Verify Mobile Number',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.redAccent,
                    ),
                  )
                ],
              ),
            ),

            )
           
            
          )
        
        ],
      )
          )
      )
      :new Container(
       child : new Text("Loading")
      )
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );


}
