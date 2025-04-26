import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeProvider with ChangeNotifier{
  bool isloading = false;
  bool get loading => isloading;

  Map<String, dynamic>? paymentIntent;

  // Update loading state
  void _setLoading(bool value) {
    isloading = value;
    notifyListeners();
  }

  Future<void> makePayment() async {
    try {
      _setLoading(true); // Set loading to true when starting payment
      paymentIntent = await _createPaymentIntent();
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: 'US', currencyCode: 'US', testEnv: true);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'ali',
          googlePay: gpay,
        ),
      );

      await _displayPaymentSheet();
      _setLoading(true);
    } catch (e) {
      print('Error in makePayment-------> ${e.toString()}');
      _setLoading(true);
      rethrow; // Optionally, rethrow the error if you want to handle it higher up
    } finally {
      _setLoading(
          false); // Set loading to false after payment process completes
    }
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Payment successful--------->');
    } catch (e) {
      print('Error in displaying payment sheet-----> $e');
      rethrow; // Handle the error in the UI if necessary
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {'amount': '1000', 'currency': 'USD'};
      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer your-secret-key',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      return json.decode(response.body);
    } catch (e) {
      print('Error in createPaymentIntent: ${e.toString()}');
      throw Exception('Payment intent creation failed');
    }
  }
}