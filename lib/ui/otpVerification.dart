
import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/ui/HomeScreen.dart';
import 'package:sawjigrocerryapp/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sms_autofill/sms_autofill.dart';
class OTPVerification extends StatefulWidget {


  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final num mobile;
  final String id;

  const OTPVerification({Key key,this.mobile , this .id ,this.fieldKey, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted}) : super(key: key);

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: Colors.yellow,
            fontSize: 24.0
        ),
      ),
    );
  }
  @override
  State<StatefulWidget> createState() => otpState(mobile ,id);
}

class otpState extends State<OTPVerification> {

  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _otp;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autovalidate = false;
  bool _formWasEdited = false;
  final num mobileNo;
  final String userId;
  otpState(this.mobileNo ,this .userId);

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool _obscureText = true;
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: Text('Verification code'),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
               
                new SafeArea(

                    top: false,
                    bottom: false,
                    child: Card(
                        elevation: 5.0,
                        child: Form(
                            key: formKey,
                            autovalidate: _autovalidate,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(height: 24.0),
                                   
                                    const SizedBox(height: 24.0),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.lock,color: Colors.black38,),
                                          hintText: '',
                                          labelText: 'Enter Your 6 digit OTP',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),

                                      validator: (val) =>
                                      val.length > 6 ? 'Invalid OTP' : null,
                                      onSaved: (val) => _otp = val,
                                    ),

                                    SizedBox(height: 35.0,),
                                    new Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          new Container(
                                            alignment: Alignment.bottomLeft,
                                            margin: EdgeInsets.only(left: 10.0),
                                            child: new GestureDetector(
                                              onTap: (){
                                                var request={
                                                 	"mobile":mobileNo.toString(),
	                                                "_id":userId
                                                };
                                                  sendOTP(request);
                                              },
                                              child: Text('Send OTP',style: TextStyle(
                                                  color: Colors.blueAccent,fontSize: 13.0
                                              ),),
                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.bottomRight,
                                            child: new GestureDetector(
                                              onTap: (){
                                                _submit();
                                              },
                                              child: Text('Verify ',style: TextStyle(
                                                  color: Colors.orange,fontSize: 20.0,fontWeight: FontWeight.bold
                                              ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /*   const SizedBox(height:24.0),

                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('FORGOT PASSWORD?',style: TextStyle(
                                    color: Colors.blueAccent,fontSize: 13.0
                                  ),),
                                ),

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('LOGIN',style: TextStyle(
                                      color: Colors.orange,fontSize: 15.0
                                  ),),
                                ),

                              ],
                            )


*/
                                  ]
                              ),
                            )

                        )        //login,
                    ))
              ],
            ),
          )
        ));
  }

  void _submit() {
    final form = formKey.currentState;
    print(form);

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _mobileNoVerify();
    }
    else{
      showInSnackBar('Please fix the errors in red before submitting.');

    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }
  void _mobileNoVerify() {
    var request= {
       'otp': _otp
    };
    var responseRef =  verifyOTP(request);
    responseRef.then((value) => {checkDetails(value)});
    // This is just a demo, so no actual login here.
    
  }
  void checkDetails(res) async {
    print(res);
    if(res['status']==true){
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("userdetails", json.encode(res['data']));
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    }else{
      showInSnackBar(res['message']);
    }

  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  }
