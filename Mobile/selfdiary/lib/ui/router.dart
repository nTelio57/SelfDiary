import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:selfdiary/ui/views/HomeView.dart';
import 'package:selfdiary/welcome_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
            builder: (_)=> WelcomeView()
        );
      case '/home' :
        return MaterialPageRoute(
            builder: (_)=> HomeView()
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}