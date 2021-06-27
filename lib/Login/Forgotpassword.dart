import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'login_page.dart';

class Forgotpassword extends StatefulWidget {
  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController _emailController = new TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Forgot Password",
              style: TextStyle(fontSize: 35),
            ),
            Text(
              "Please enter your mail ID to receive your password and reset information",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Mail ID",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration:
                  InputDecoration(hintText: "Please Enter Your Register Email"),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  if (_emailController.text != null ||
                      _emailController.text.isNotEmpty) {
                    return resetPassword(_emailController.text);
                  } else {
                    print("Controller empty");
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Color(0xff3757F3)),
                  child: Text(
                    "Send Request",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth
          .sendPasswordResetEmail(email: email.trim())
          .then((value) {
        print("here");
        Fluttertoast.showToast(
            msg: "Please Check Your Registered Mail Account",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        new Future.delayed(
            const Duration(seconds: 2),
            () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage())));
      });
      // _showDialog("Please Check Your Mail ");
    } catch (e) {
      print("An error occurred while trying to send email verification");
      print(e.message);
    }
  }
}
