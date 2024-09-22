import 'package:flutter/material.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/payment_Screen.dart';

void main() {
  Stripe.publishableKey =
      "pk_test_51MWx8OAVMykife3CsjEzA1CiiY0XBTIHYbZ8jQlGtVFlwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf";
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentScreen(),
    );
  }
}
