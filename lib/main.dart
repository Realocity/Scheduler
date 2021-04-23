import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter/material.dart';

import 'Splash_Page/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  FlutterError.onError = (errorDetails) {
    FlutterError.dumpErrorToConsole(errorDetails, forceReport: false);
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.redAccent,
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text("Something went wrong")),
          ),
        ),
      ),
    );
  };
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: SplashScreen(),
    );
  }
}

