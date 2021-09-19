import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui/pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final primaryColor = Color.fromRGBO(136, 14, 79, 1);
    final primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    final primaryLight = Color.fromRGBO(188, 71, 123, 1);

    return MaterialApp(
      title: 'ProDev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryLight,
        accentColor: primaryColor,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColorDark,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: primaryLight,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: primaryLight,
              ),
            ),
            alignLabelWithHint: true),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(
            primary: primaryColor,
          ),
          buttonColor: primaryColor,
          splashColor: primaryLight,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
