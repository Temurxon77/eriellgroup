import 'dart:convert';

import 'package:eriellapp/src/pages/LoginPage.dart';
import 'package:eriellapp/src/utils/constants.dart';
import 'package:eriellapp/src/utils/helperFunctions.dart';
import 'package:eriellapp/src/widgets/LogoItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<SharedPreferences>? _prefs;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(start: 0),
          automaticallyImplyLeading: false,
          automaticallyImplyMiddle: false,
          middle: const Text("Регистрация"),
          leading: CupertinoButton(
              padding: EdgeInsets.all(0),
              onPressed: ()=> popPage(context: context), child: Icon(CupertinoIcons.back)),
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
    );
  }


  Future<void> clearText(TextEditingController? controller) async {
    controller?.clear();
  }
  Future<void> saveData(BuildContext context) async {
    if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      SharedPreferences? prefs = await _prefs;
      final bool isValid = LoginPage.reg1.hasMatch(nameController.text) && LoginPage.reg2.hasMatch(passwordController.text) && LoginPage.reg3.hasMatch(emailController.text)
      ? true : false;
      if(isValid) {
        Map<String, String> data = {
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text
        };
        final info = json.encode(data);
        prefs!.setString("userData", info.toString()).then((val) =>
            routeNamed(context: context, route: kLoginPage)
        );
      }
    }
  }
  Widget normalBuild(BuildContext context,double? paddingVal) {
    return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.all(paddingVal ?? 0),
          child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
           direction: Axis.vertical,
           children: [
             const Flexible(flex: 1,child: const LogoItem(height: 120,width: 120)),
             Flexible(flex: 1,child: const Text("Регистрация",style: const TextStyle(color: materialColor,fontSize: 20.0))),
             const SizedBox(height: 20),
             Flexible(
                 flex: 2,
                 child: CupertinoTextField(
                     padding: const EdgeInsets.all(10),
               controller: nameController,
               keyboardType: TextInputType.text,
                placeholder: 'Вова',
                decoration: BoxDecoration(border: Border.all(color: materialColor,width: 0.7),borderRadius: BorderRadius.circular(10)),
                suffix: CupertinoButton(child: const Icon(CupertinoIcons.clear_circled_solid),onPressed: () => clearText(nameController)),
                prefix: const Icon(CupertinoIcons.person)
              )),
              const SizedBox(height: 10),
              Flexible(
              flex: 2,
              child: CupertinoTextField(
                padding: const EdgeInsets.all(10),
               controller: emailController,
                 keyboardType: TextInputType.emailAddress,
                  placeholder: 'ya@luchshiy.ru',
                  decoration: BoxDecoration(border: Border.all(color: materialColor,width: 0.7),borderRadius: BorderRadius.circular(10)),
                  suffix: CupertinoButton(child: Icon(CupertinoIcons.clear_circled_solid),onPressed: () => clearText(emailController)),
                  prefix: const Icon(CupertinoIcons.mail)
             )),
             const SizedBox(height: 10),
              Flexible(
                  flex: 2,
                  child: CupertinoTextField(
                      padding: const EdgeInsets.all(10),
               controller: passwordController,
                obscureText: true,
                 keyboardType: TextInputType.visiblePassword,
                  placeholder: 'пароль',
                      decoration: BoxDecoration(border: Border.all(color: materialColor,width: 0.7),borderRadius: BorderRadius.circular(10)),
                  suffix: CupertinoButton(child: const Icon(CupertinoIcons.clear_circled_solid),onPressed: () => clearText(passwordController)),
                  prefix: const Icon(CupertinoIcons.lock)
             )),
             const SizedBox(height: 20),
             Flexible(
               flex: 2,
               child: CupertinoButton(
                 color: materialColor,
                 onPressed: () async {
                   _prefs = SharedPreferences.getInstance();
                   saveData(context);
                 },
                 child: const Text("Зарегистрироваться",style: const TextStyle(color: Colors.white))
               )
             ),
             Flexible(
                 flex: 2,
                 child: TextButton(
                     onPressed: () async => await popAndRouteNamed(context: context,route: kLoginPage),
                     child: const Text("Войти",style: const TextStyle(color: materialColor))
                 )
             )
          ]
          )
    )
    );
  }
}