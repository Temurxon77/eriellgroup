import 'package:eriellapp/src/pages/AdminPage.dart';
import 'package:eriellapp/src/pages/LoginPage.dart';
import 'package:eriellapp/src/pages/SignUpPage.dart';
import 'package:eriellapp/src/pages/SplashPage.dart';
import 'package:eriellapp/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminRoute {
  static Route<CupertinoPageRoute> onGenerateRoute(RouteSettings settings) {
    switch(settings.name){
      case kSplashPage:
        return CupertinoPageRoute(
            builder: (context) => SplashScreen()
        );
      case kSignUpPage:
        return CupertinoPageRoute(builder: (context)=> SignUpPage());
      case kLoginPage:
        return CupertinoPageRoute(builder: (context)=> LoginPage());
      case kAdminPage:
        return CupertinoPageRoute(builder: (context)=> AdminPage());
      default:
        return errorRoute(settings);
    }
  }
  static Route<CupertinoPageRoute> errorRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context)=> const Material(
      child: Center(child: const Text("PAGE NOT FOUND! (404)",style: const TextStyle(fontSize: 30,color: Colors.redAccent)))
    ));
  }
}

