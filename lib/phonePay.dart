import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PhonepayScreen extends StatefulWidget {
  final int paymentAmount;
  const PhonepayScreen({super.key, required this.paymentAmount});

  @override
  State<PhonepayScreen> createState() => _PhonepayScreenState();
}

class _PhonepayScreenState extends State<PhonepayScreen> {
  String environmentValue = "SANDBOX";
  String appId = "";
  String merchantId = "PGTESTPAYUAT86";
  bool enableLogging = true;
  String checksum = "";
  String saltkey = "96434309-7796-489d-8924-ab56988a6076";
  String saltIndex = "1";
  String callBackUrl = "www.google.com";
  String apiEndPoint = "/pg/v1/pay";
  String body = "";
  Object? result;
  String packageName = "com.phonepe.simulator";
  Razorpay _razorpay = Razorpay();

  getChecksum() {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "t_5252",
      "merchantUserId": "90223250",
      "amount": widget.paymentAmount,
      "callbackUrl": callBackUrl,
      "mobileNumber": "9999999999",
      "paymentInstrument": {
        "type": "PAY_PAGE",
      },
    };
    String base64body = base64.encode(
      utf8.encode(
        json.encode(requestData),
      ),
    );
    checksum =
        '${sha256.convert(utf8.encode(base64body + apiEndPoint + saltkey)).toString()}###$saltIndex';
    return base64body;
  }

  @override
  void initState() {
    super.initState();
    phonepeInit();
    body = getChecksum().toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  @override
  Widget build(BuildContext context) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    startPgtransaction();
                  },
                  child: Text('phonepay')),
            ),
            Text('resut/n$result'),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                razorPayPayment();
              },
              child: const Text('RazorPay'),
            ),
          ],
        ),
      ),
    );
  }

  void startPgtransaction() {
    var response = PhonePePaymentSdk.startTransaction(
        body, callBackUrl, checksum, packageName);
    response.then((val) async {
      if (val != null) {
        String status = val['status'].toString();
        String error = val['error'].toString();

        if (status == 'SUCCESS') {
          result = "Flow complete - status : SUCCESS";
        } else {
          result = "Flow complete - status : $status and error $error";
        }
      } else {
        result = "Flow Incomplete";
      }
    }).catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void phonepeInit() {
    PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogging)
        .then((val) => {log('phonepeintialized-$val')})
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void razorPayPayment() {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': widget.paymentAmount,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    _razorpay.open(options);
  }

  void handleError(error) {
    result = {"error": error};
    setState(() {});
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds

    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
    // Do something when an external wallet is selected
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
