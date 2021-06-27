import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Dashboard/BottomBar/bottom_task_bar.dart';
import '../Dashboard/HomePage.dart';
import 'login_page.dart';


class onboarding extends StatefulWidget {

  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  GlobalKey<NavigatorState> _key = GlobalKey();
  int currentPage = 0;
  PageController _pageController =
      new PageController(initialPage: 0, keepPage: true);
  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            print("1 time ");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Press Once Again!",
                textAlign: TextAlign.center,
              ),
            ));
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      onBoardPage("onboard1", "Welcome to Scheduler"),
                      onBoardPage("onboard2", "Manage Your Day"),
                      onBoardPage("onboard3", "Work Happens"),
                      onBoardPage("onboard4", "Task and Assignments"),
                    ],
                    onPageChanged: (value) => {setCurrentPage(value)},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) => getIndicator(index)),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/image/path1.png'),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                    ),
                    InkWell(
                      onTap: () => signInWithEmail(),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 100),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xff3757F3),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 9),
                                  blurRadius: 20,
                                  spreadRadius: 3)
                            ]),
                        child: Column(
                          children: [
                            Text(
                              "Continue with Google",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Secured Log-in",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage())),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 110),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xff80DDF6).withOpacity(0.1),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 9),
                                  blurRadius: 20,
                                  spreadRadius: 3)
                            ]),
                        child: Text(
                          "Continue with Email",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextButton(
                        onPressed: () => showBottomInfo(context),
                        child: Text(
                          "Why do I need to create an account?",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNo) ? Colors.black : Colors.grey),
    );
  }

  Column onBoardPage(String img, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('asset/image/$img.png'))),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            "See how millions of people rely on Scheduler to stay organized and get more done.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  setCurrentPage(int value) {
    currentPage = value;
    setState(() {});
  }

  Future signInWithEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    final dataCount = GetStorage();   // instance of getStorage class

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        if (user.uid != null) {
          dataCount.write("uid",user.uid);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomBar()));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }
  showBottomInfo(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: new Wrap(children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.sync),
                        title: new Text('Sync your tasks across all devices'),
                        onTap: () => {}),

                    new ListTile(
                        leading: new Icon(Icons.cloud),
                        title: new Text(
                            'Backup your data in a securedn & private cloud'),
                        onTap: () => {}),
                    new ListTile(
                      leading: new Icon(Icons.family_restroom),
                      title: new Text(
                          'Collaborate with loved ones, family or colleagues'),
                      onTap: () => {},
                    ),
                  ]))
                ]),
          );
        });
  }
}
