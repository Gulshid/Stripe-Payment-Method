import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_method/Routes/Routes.dart';
import 'package:payment_method/Routes/RoutesName.dart';
import 'package:payment_method/ViewModel/Stripe_Provider.dart';
import 'package:payment_method/view_/Stripe_view.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initialize_Stripe();
  runApp(const MyApp());
}

Future<void> Initialize_Stripe() async {
  Stripe.publishableKey = "your-publishable-key";
  await Stripe.instance.applySettings();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => StripeProvider())],

          child: Builder(
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Stripe Payment',
                theme: ThemeData(
                  applyElevationOverlayColor: true,
                  brightness: Brightness.light,
                  appBarTheme: AppBarTheme(color: Colors.teal),
                  primarySwatch: Colors.blue,
                  textTheme: Typography.englishLike2018.apply(
                    fontSizeFactor: 1.sp,
                  ),
                ),

                initialRoute: Routesname.Stripe_view,
                onGenerateRoute: Routes.generate_Route,
             
              );
            },
          ),
        );
      },
    );
  }
}
