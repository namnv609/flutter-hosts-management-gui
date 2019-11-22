import 'package:example_flutter/pages/forms/ip_form.dart';
import 'package:example_flutter/pages/home.dart';
import 'package:example_flutter/pages/ip_detail.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static var routes = <String, WidgetBuilder>{
    HomePage.routeName: (context) => HomePage(),
    IPDetail.routeName: (context) => IPDetail(),
    IPForm.routeName: (context) => IPForm()
  };
}