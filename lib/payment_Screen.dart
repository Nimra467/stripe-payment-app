import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? payment;

  void makePayment() async {
    try {
      payment = await createPayment();
      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: payment!["client_secret"],
        style: ThemeMode.dark,
        merchantDisplayName: "Ali",
        googlePay: gpay,
      ));
      displayPaymentSheet();
    } catch (e) {}
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Done");
    } catch (e) {
      print("failed");
    }
  }

  createPayment() async {
    try {
      Map<String, dynamic> body = {"amount": "10000", "currency": "USD"};
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Baerer sk_test_51MWx8OVMykife3C3gP4wKOhTsRdF6r1PYhhg1PqupXDlTMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPlq00wmjWwZYA",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Payment app",
          style: TextStyle(color:Colors.white),
        ),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              makePayment();
            },
            child: Text("Pay me")),
      ),
    );
  }
}
