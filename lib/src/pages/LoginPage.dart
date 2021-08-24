import 'dart:convert';

import 'package:eriellapp/src/utils/constants.dart';
import 'package:eriellapp/src/utils/helperFunctions.dart';
import 'package:eriellapp/src/widgets/LogoItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static final RegExp reg1 = new RegExp(r"^([A-z]{4,})$");
  static final RegExp reg2 = new RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
  static final RegExp reg3 = new RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          nameController.dispose();
          passwordController.dispose();
          return true;
        },
        child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(start: 0),
          automaticallyImplyLeading: false,
          automaticallyImplyMiddle: false,
          middle: const Text("Войти"),
          // leading: CupertinoButton(
          //     padding: EdgeInsets.all(0),
          //     onPressed: ()=> popPage(context: context), child: Icon(CupertinoIcons.back)),
          ),
        child: OrientationBuilder(
          builder: (context,orientation) {
            double paddingVal = 10;
            if(orientation == Orientation.landscape) {
              paddingVal = 50;
            }
            return Stack(
                children: [
                  Positioned(child: normalBuild(context,paddingVal)),
                  // Positioned(child: Container(
                  //     alignment: Alignment.center,
                  //     color: Colors.blueGrey.withAlpha(90),
                  //     child: CircularProgressIndicator(color: materialColor)))
                ]
            );
          },
        )
        )
    );
  }

  Future<void> clearText(TextEditingController? controller) async {
    controller?.clear();
  }
  Future<String> validation() async {
    try{
      if(nameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        final Future<SharedPreferences> _prefs =  SharedPreferences.getInstance();
        final SharedPreferences? prefs = await _prefs;
        final Map<String,dynamic> data = await json.decode(prefs!.getString("userData").toString());
        return data['name'] == nameController.text && data['password'] == passwordController.text ? "" : "Имя или пароль введены неверно";
      }
      return "Данные не заполнены";
    }catch(err){
      print(err);
      return "Something went wrong....";
    }
  }

  Widget normalBuild(BuildContext context,double? paddingVal) {
    return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(paddingVal ?? 0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.vertical,
                children: [
                  Flexible(flex: 1,child: LogoItem(height: 120,width: 120)),
                  Flexible(flex: 1,child: const Text("Вход в админ панель",style: const TextStyle(color: materialColor,fontSize: 20.0))),
                  const SizedBox(height: 20),
                  Flexible(
                      flex: 2,
                      child: CupertinoTextField(
                          padding: const EdgeInsets.all(10),
                          maxLength: 32,
                          autofocus: false,
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          placeholder: 'Вова',
                          decoration: BoxDecoration(border: Border.all(color: materialColor,width: 0.7),borderRadius: BorderRadius.circular(10)),
                          suffix: CupertinoButton(child: Icon(CupertinoIcons.clear_circled_solid),onPressed: () => clearText(nameController)),
                          prefix: Icon(CupertinoIcons.person)
                      )),
                  const SizedBox(height: 10),
                  Flexible(
                      flex: 2,
                      child: CupertinoTextField(
                          padding: const EdgeInsets.all(10),
                          maxLength: 32,
                          controller: passwordController,
                          obscureText: true,
                          autofocus: false,
                          keyboardType: TextInputType.visiblePassword,
                          placeholder: 'пароль',
                          decoration: BoxDecoration(border: Border.all(color: materialColor,width: 0.7),borderRadius: BorderRadius.circular(10)),
                          suffix: CupertinoButton(child: Icon(CupertinoIcons.clear_circled_solid),onPressed: () => clearText(passwordController)),
                          prefix: Icon(CupertinoIcons.lock)
                      )),
                  const SizedBox(height: 20),
                  Flexible(
                      flex: 2,
                      child: CupertinoButton(
                          color: materialColor,
                          onPressed: () async {
                            await validation().then((value) async {
                              if (value.isEmpty) {
                                clearText(nameController);
                                clearText(passwordController);
                                await routeNamed(context: context, route: kAdminPage);
                              } else {
                                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value),duration: Duration(seconds: 3)));
                              }
                              print(value);
                            });
                            },
                          child: const Text("Войти",style: TextStyle(color: Colors.white))
                      )
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                      flex: 2,
                      child: TextButton(
                          onPressed: () async => await routeNamed(context: context,route: kSignUpPage),
                          child: const Text("Зарегистрироваться сейчас",style: TextStyle(color: materialColor))
                      )
                  )
                ]
            )
        )
    );
  }
}