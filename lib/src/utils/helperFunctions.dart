import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

Future<void> routeNamed({@required BuildContext? context,String? route}) async {
  try{
    await Navigator.pushNamed(context!,route ?? "").catchError(throw FlutterError("Cannot push new Named route.... $route"));
  }catch(err){
    print(err);
  }
}

Future<void> popAndRouteNamed({@required BuildContext? context,String? route}) async {
  try{
    await Navigator.popAndPushNamed(context!,route ?? "").catchError(throw FlutterError("Cannot push new Named route.... $route"));
  }catch(err){
    print(err);
  }
}

Future<void> popPage({@required BuildContext? context}) async {
  try{
    if(await Navigator.canPop(context!)) {
      Navigator.pop(context);
    } else {
      throw FlutterError("Cannot Pop Page...");
    }
  }catch(err){
    print(err);
  }
}