import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sawjigrocerryapp/ui/HomeScreen.dart';
import 'package:sawjigrocerryapp/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sawjigrocerryapp/ui/customModal.dart';
class OTPVerification extends StatefulWidget {
  int fields;
  final String lastPin;
  var onSubmit;
  double fieldWidth;
  double fontSize;
  bool isTextObscure;
  bool showFieldAsBox;
  final num mobile;
  final String id;

  OTPVerification(
      {this.mobile,
      this.id,
      this.lastPin,
      this.fields: 5,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState(mobile,id);
  }
}

class PinEntryTextFieldState extends State<OTPVerification> {
  List<String> _pin;
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;
  final num mobile;
  final String id;
  PinEntryTextFieldState(this.mobile ,this .id);
  Widget textfields = Container();
  bool sentOtp = false;

  @override
  void initState() {
    super.initState();
    var request = {"mobile": mobile , "_id": id};
    var otpRef =sendOTP(request);
    otpRef.then((data)=>{checkOtpIsSend(data)});

    _pin = List<String>(widget.fields);
    _focusNodes = List<FocusNode>(widget.fields);
    _textControllers = List<TextEditingController>(widget.fields);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin.length; i++) {
            _pin[i] = widget.lastPin[i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }
  
  checkOtpIsSend(res){
    if(res["status"]){
      setState(() {
         sentOtp = true;
      });
     
    }

  }
  checkDetails(res){
    if(res["status"]){
       setState(() {
         sentOtp = false;
      });
      Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
       showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Success",
        description:res['message'],
        buttonText: "Go to Cart",
        pageRedirection:"Cart"
      ),
    );
     
    }
  }

  @override
  void dispose() {
    _focusNodes.forEach((FocusNode f) => f.dispose());
    _textControllers.forEach((TextEditingController t) => t.dispose());
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController tEditController) => tEditController.clear());
  }

  Widget buildTextField(int i, BuildContext context, [bool autofocus = false]) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i].text = widget.lastPin[i];
      }
    }

    _focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {}
    });

    final String lastDigit = _textControllers[i].text;
    return new Container(
        width: widget.fieldWidth,
        margin: EdgeInsets.only(right: 10.0),
        child: TextField(
          controller: _textControllers[i],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: widget.fontSize),
          focusNode: _focusNodes[i],
          obscureText: widget.isTextObscure,
          decoration: InputDecoration(
              counterText: "",
              border: widget.showFieldAsBox
                  ? OutlineInputBorder(borderSide: BorderSide(width: 2.0))
                  : null),
          onChanged: (String str) {
            _pin[i] = str;
            if (i + 1 != widget.fields) {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            } else {
              clearTextFields();
              FocusScope.of(context).requestFocus(_focusNodes[0]);
              widget.onSubmit(_pin.join());
            }
          },
          onSubmitted: (String str) {
            clearTextFields();
         
            widget.onSubmit(_pin.join());
          },
        ));
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });
    FocusScope.of(context).requestFocus(_focusNodes[0]);
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Verifiction code")),
        body:sentOtp==false 
        ? new Container(
          child :new Center(
            child: new Text("Please Wait while we sending ") ,
          )
        )
        :new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(left: 65, top: 30),
              width: 400,
              child: new Center(
                  child: new Text(
                "Please enter the OTP sent on your registereed mobile number",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              )),
            ),
            new Container(
                padding: EdgeInsets.all(20),
                child: generateTextFields(context)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: FlatButton(
                      color: Colors.black,
                      child: const Text(
                        'Resend',
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      onPressed: () {},
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: FlatButton(
                      color: Colors.black,
                      child: const Text(
                        'Verify',
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                        //   void _mobileNoVerify() {
                          var request = {'otp': _pin.join()};
                          var responseRef = verifyOTP(request);
                          responseRef.then((value) => {checkDetails(value)});
                          // This is just a demo, so no actual login here.
                        
                      },
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                ),
              ],
            )
          ],
        ));
  }
}
