import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sawjigrocerryapp/ui/customModal.dart';
import 'package:sawjigrocerryapp/services/product.service.dart';

class RazorPayScreen extends StatefulWidget {
  double totalPrice;
  String orderId;
  var clinetInfo;
  RazorPayScreen({Key key, this.totalPrice, this.orderId, this.clinetInfo});

  @override
  State<StatefulWidget> createState() =>
      Payment(totalPrice, orderId, clinetInfo);
}

class Payment extends State<RazorPayScreen> {
  Razorpay _razorpay;
  double totalPrice;
  String orderId;
  var clinetInfo;
  Payment(this.totalPrice, this.orderId, this.clinetInfo);
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    launchPayment();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    var req= {
      "PAYMENT_STATUS" :"rejected",
      "ORDER_STATUS" :"failed"
    };
    editOrderById(req,orderId);
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Payment Failed ",
        description:
            "Your payment has been failed"  ,
        buttonText: "Okay",
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
     var req= {
      "PAYMENT_STATUS" :"success",
      "ORDER_STATUS" :"process"
    };
    editOrderById(req,orderId);
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Payment Success",
        description:
            "Your order has been placed successfully",
        buttonText: "Okay",
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'Wallet Name ' + response.walletName,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0);
    print(response);
  }

  void launchPayment() async {
    var options = {
      'key': 'rzp_test_r5qsMwR8B6D5gY',
      'amount': totalPrice * 100,
      "currency": "INR",
      'name': 'sawji',
      "order_id": orderId,
      'description': 'Test payment from Flutter app',
      "prefill":{
        "email" :clinetInfo["email"],
        "mobile" :clinetInfo["mobile"]
      }
    };
    try {
      print(totalPrice);
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
