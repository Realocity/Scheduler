import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scheduler/Dashboard/HomePage.dart';
import 'package:scheduler/Login/sign_up_page.dart';
import 'Forgotpassword.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 35),
                ),
                Text(
                  "Sign in to continue...",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(hintText: "Please Enter Your Email"),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(hintText: "Enter your password here"),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: openForgotPassword,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        signInWithEmail();
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xff80DDF6).withOpacity(0.5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(0, 9),
                                blurRadius: 20,
                                spreadRadius: 3)
                          ]),
                      child: Text(
                        "Log In",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openForgotPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Forgotpassword()));
  }

  Future signInWithEmail() async {
    try {
      final dataCount = GetStorage();   // instance of getStorage class

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(), password: passwordController.text.trim());

      if (userCredential.user.uid.isNotEmpty) {
        dataCount.write("uid", userCredential.user.uid);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "user-not-found") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "User Not Found",
          textAlign: TextAlign.center,
        )));
      } else if (e.code == "invalid-email"||e.code=="wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Incorrect Email Id/ Password",
                textAlign: TextAlign.center)));
      }
    }
  }
}
