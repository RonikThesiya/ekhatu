
import 'package:ekhatu/screens/home/view/client_details.dart';
import 'package:ekhatu/screens/home/view/credit_screen.dart';
import 'package:ekhatu/screens/home/view/debit_screen.dart';
import 'package:ekhatu/screens/home/view/home_screen.dart';
import 'package:ekhatu/screens/home/view/transaction_history.dart';
import 'package:ekhatu/screens/splash_screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main()
{
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => SplashScreen(),
        'main':(context) => HomeScreen(),
        'client': (context) => ClientDetails(),
        'debit': (context) => DebitScreen(),
        'credit': (context) => CreditScreen(),
        'history': (context) => History(),
      },
    ),
  );
}