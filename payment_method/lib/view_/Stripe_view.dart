import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_method/ViewModel/Stripe_Provider.dart';
import 'package:provider/provider.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  @override
  Widget build(BuildContext context) {
    final StripePro = Provider.of<StripeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.teal,
       body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Stripe Payment Integration',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            StripePro.loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      await StripePro.makePayment();
                    },
                    child: const Text('Make Payment'),
                  ),
          ],
        ),
      ),
      
    );
  }
}
