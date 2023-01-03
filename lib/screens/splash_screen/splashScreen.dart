import 'dart:async';

import 'package:ekhatu/screens/home/controller/home_controller.dart';
import 'package:ekhatu/screens/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  HomeController homeController = Get.put(HomeController());

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration(seconds: 3),
            (){
          Get.offAllNamed('main');
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo/book.png",height: 300,width: 300,),
            SizedBox(height: 20,),
            Text("E - Khatu",style: TextStyle(fontSize: 30,color: Colors.indigo,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
