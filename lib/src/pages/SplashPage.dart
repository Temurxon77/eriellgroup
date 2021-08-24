import 'package:flutter/material.dart';

import 'package:eriellapp/src/utils/constants.dart';
import 'package:eriellapp/src/utils/helperFunctions.dart';
import 'package:eriellapp/src/widgets/LogoItem.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState(){
    super.initState();
    checkUserCredentials().then((v) {
      Future.delayed(Duration(seconds: 2),() async =>  v ? await routeNamed(context: context,route: kLoginPage) : await routeNamed(context: context,route: kAdminPage));
    });
  }
  
  Future<bool> checkUserCredentials() async {
    try {
      final SharedPreferences prefs = await _prefs;
      return prefs.getString("userData")!.isEmpty;
    }catch(err){
      print(err);
      return true;
    }
  }
  @override
  Widget build(BuildContext context){
    return Material(child: LogoItem(height: 120.0,width: 120.0));
  }
}