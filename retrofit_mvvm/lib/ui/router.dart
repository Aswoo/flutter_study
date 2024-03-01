import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:retrofit_mvvm/core/constants/app_constants.dart';
import 'package:retrofit_mvvm/ui/views/home_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
