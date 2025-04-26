import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payment_method/Routes/RoutesName.dart';
import 'package:payment_method/view_/Stripe_view.dart';

class Routes {
  static Route<dynamic> generate_Route(RouteSettings s) {
    switch (s.name) {
      case Routesname.Stripe_view:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) => Homeview(),
          );
        }

      default:
        {
          return MaterialPageRoute(
            builder: (_) => Scaffold(body: Center(child: Text('No Route'))),
          );
        }
    }
  }
}
