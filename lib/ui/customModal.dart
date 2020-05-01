import 'package:flutter/material.dart';
import 'package:sawjigrocerryapp/ui/HomeScreen.dart';
import './otpVerification.dart';
import './CartScreen.dart';
import './UserScreen.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText,pageRedirection;
  var data;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    @required this.data,
    this.pageRedirection,
    this.image,
  });
  dialogContent(BuildContext context) {
    Actionpage(action) {
       Navigator.of(context).pop();
      print(data);
      switch (action) {
        case 'Login':
          {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
          break;

        case 'OTP':
          {
            //statements;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OTPVerification(mobile:data['mobile'] ,id:data['_id'])));
          }
          break;
         case 'Cart':
          {
            //statements;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Cart_screen()));
                
          }
          break;

        default:
          {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
               
          }
          break;
      }
    }

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: () {
                    Actionpage(pageRedirection);

                    // To close the dialog
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
