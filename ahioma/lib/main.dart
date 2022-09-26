import 'dart:convert';

import 'package:ahioma/config/app_config.dart' as config;
import 'package:ahioma/route_generator.dart';
import 'package:ahioma/src/models/user.dart';
import 'package:ahioma/src/screens/on_boarding.dart';
import 'package:ahioma/src/screens/signin.dart';
import 'package:ahioma/src/screens/tabs.dart';
import 'package:ahioma/src/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ahioma/src/scoped_model/user.dart';

bool isTokenExpired = false;


void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var jwt;
  var role;
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  Future<String> jwtOrEmpty() async {
    await Future.delayed(Duration(seconds: 3), () async{
      var storage = FlutterSecureStorage();
      jwt = await storage.read(key: 'login');
      role = await storage.read(key: 'role');
      Map<String, dynamic> decodedToken = JwtDecoder.decode(jwt);
      print(decodedToken);
      print(jwt);
      isTokenExpired = JwtDecoder.isExpired(jwt);
      print(isTokenExpired);
    });

    if (jwt == null && role == null) {
      return '';
    }
    else if (jwt == null && role == 'Guest') {
      return 'b';
    }

     return isTokenExpired.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahioma',
      navigatorKey: navigatorKey,
      home: FutureBuilder(
        future: jwtOrEmpty(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(child: Image(image: AssetImage('img/hioma.gif'),fit: BoxFit.cover,));
          }
          if (snapshot.data == '') {
            return OnBoardingWidget();
          } else {
            if (snapshot.data == 'true') {
              return SignInWidget(doAfter: null,);
            } else if (snapshot.data == 'a') {
              return SignInWidget(doAfter: null,);
            }
            else {
              return TabsWidget(currentTab: 2);
            }
          }
        },
      ),
      // initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color(0xFF252525),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        accentColor: config.Colors().mainDarkColor(1),
        hintColor: config.Colors().secondDarkColor(1),
        focusColor: config.Colors().accentDarkColor(1),
        textTheme: TextTheme(
          button: TextStyle(color: Color(0xFF252525)),
          headline: TextStyle(
              fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
          display1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1)),
          display2: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1)),
          display3: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.Colors().mainDarkColor(1)),
          display4: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().secondDarkColor(1)),
          subhead: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().secondDarkColor(1)),
          title: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().mainDarkColor(1)),
          body1: TextStyle(
              fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
          body2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1)),
          caption: TextStyle(
              fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        accentColor: config.Colors().mainColor(1),
        focusColor: config.Colors().accentColor(1),
        hintColor: config.Colors().secondColor(1),
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
          headline:
              TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
          display1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1)),
          display2: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1)),
          display3: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.Colors().mainColor(1)),
          display4: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().secondColor(1)),
          subhead: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().secondColor(1)),
          title: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().mainColor(1)),
          body1:
              TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
          body2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1)),
          caption: TextStyle(
              fontSize: 12.0, color: config.Colors().secondColor(0.6)),
        ),
      ),
    );
  }
}
