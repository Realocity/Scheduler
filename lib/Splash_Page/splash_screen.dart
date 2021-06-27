import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scheduler/Dashboard/BottomBar/bottom_task_bar.dart';
import 'package:scheduler/Dashboard/HomePage.dart';
import 'package:scheduler/Login/Onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), openOnBoard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/image/logo_1.png'),
              )),
        ),
      ),
    );
  }

  void openOnBoard() {
    final dataCount = GetStorage();
    var uid = dataCount.read("uid");
    if (uid == null || uid == "") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => onboarding()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomBar()));
    }
  }
}
