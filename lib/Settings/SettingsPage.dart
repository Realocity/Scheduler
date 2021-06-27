import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scheduler/Splash_Page/splash_screen.dart';
import 'package:scheduler/Settings/ProfilePage/EditProfile.dart';
import 'package:scheduler/Settings/NotificationPage/Notification.dart';

import 'ProfilePage/profilepage.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xff3757F3),
          elevation: 0,
          title: Text(
            "Scheduler",
            style: TextStyle(fontSize: 30),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.short_text,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: bodyView()));
        }));
  }

  Widget bodyView() {
    double height = MediaQuery.of(context).size.height;

    return IntrinsicHeight(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            width: double.infinity,
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? height * 0.40
                : height * 0.30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: ExactAssetImage('asset/image/settingback1.png'),
                    fit: BoxFit.fill)),
          ),
          Row(
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.green,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),

          Container(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Divider(
          //   color: Color(0xff6A6A6A),
          //   thickness: 1,
          //   indent: 10,
          //   endIndent: 10,
          // ),
          // Container(
          //   margin: EdgeInsets.only(top: 20, left: 15, right: 15),
          //   child: Text(
          //     'GENERAL',
          //     style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),

          Row(
            children: [
              Icon(
                Icons.volume_up_outlined,
                color: Colors.green,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Notifications",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
          buildNotificationOptionRow("Reminder Vibrate", true),
          buildNotificationOptionRow("Reminder Pop-up", true),
          buildNotificationOptionRow("Reminder Repeat", false),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   child: ListTile(
          //     onTap: () {},
          //     title: Text(
          //       'Pin & Password',
          //       style: TextStyle(fontSize: 18),
          //     ),
          //     trailing: Icon(
          //       Icons.arrow_forward_ios,
          //       size: 18,
          //     ),
          //   ),
          // ),
          // Divider(
          //   color: Color(0xff6A6A6A),
          //   thickness: 1,
          //   indent: 10,
          //   endIndent: 10,
          // ),
          // Spacer(),
          // Container(
          //   child: ListTile(
          //     onTap: () {},
          //     title: Text(
          //       'Calendar Sync',
          //       style: TextStyle(fontSize: 18),
          //     ),
          //     trailing: Icon(
          //       Icons.arrow_forward_ios,
          //       size: 18,
          //     ),
          //   ),
          // ),
          // Divider(
          //   color: Color(0xff6A6A6A),
          //   thickness: 1,
          //   indent: 10,
          //   endIndent: 10,
          // ),
          // Spacer(),
          // Container(
          //   child: ListTile(
          //     onTap: () {},
          //     title: Text(
          //       'Backup & Restore',
          //       style: TextStyle(fontSize: 18),
          //     ),
          //     trailing: Icon(
          //       Icons.arrow_forward_ios,
          //       size: 18,
          //     ),
          //   ),
          // ),
          // Divider(
          //   color: Color(0xff6A6A6A),
          //   thickness: 1,
          //   indent: 10,
          //   endIndent: 10,
          // ),
          // Spacer(),
          Row(
            children: [
              Icon(
                Icons.touch_app,
                color: Colors.green,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),
          Container(
            child: ListTile(
              onTap: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Terms and Condition"),
                    content: Text(
                        "YOU ACKNOWLEDGE AND AGREE THAT, BY REGISTERING FOR AN NTASK ACCOUNT, DOWNLOADING OF THE APPLICATION OR ANY APPLICATION UPGRADES, USING THE APPLICATION ON YOUR MOBILE DEVICE, OR ACCESSING OR USING THE NTASK SERVICE, OR BY DOWNLOADING, SUBMITTING OR POSTING ANY CONTENT FROM, OR ON, OR THROUGH THE NTASK SERVICE, YOU ARE INDICATING THAT YOU HAVE READ, UNDERSTAND AND AGREE TO BE BOUND BY THESE TERMS OF SERVICE. IF YOU DO NOT AGREE TO THESE TERMS OF USE, YOU MUST NOT USE OUR SITE OR MOBILE APPLICATION OR THE SERVICES."),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("ACCEPT"),
                      ),
                    ],
                  ),
                );
              },
              title: Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.outbond_outlined,
                size: 18,
              ),
            ),
          ),

          // return showDialog(
          //   context: context,
          //   builder: (ctx) => AlertDialog(
          //     title: Text("Alert Dialog Box"),
          //     content: Text("You have raised a Alert Dialog Box"),
          //     actions: <Widget>[
          //       FlatButton(
          //         onPressed: () {
          //           Navigator.of(ctx).pop();
          //         },
          //         child: Text("okay"),
          //       ),
          //     ],
          //   ),
          // );

          // Divider(
          //   color: Color(0xff6A6A6A),
          //   thickness: 1,
          //   indent: 10,
          //   endIndent: 10,
          // ),
          Container(
            child: ListTile(
              onTap: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Privacy Policy"),
                    content: Text(
                        "This app never share users data with anyone. We are here to manage your most valuable and Important Schedule Securely. Thank You! "),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("okay"),
                      ),
                    ],
                  ),
                );
              },
              title: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              trailing: Icon(
                Icons.outbond_outlined,
                size: 18,
              ),
            ),
          ),
          Divider(
            color: Color(0xff6A6A6A),
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Spacer(),
          // Container(
          //   margin: EdgeInsets.only(top: 20, left: 15, right: 15),
          //   child: Text(
          //     'PROFILE ACCOUNT',
          //     style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
          // Container(
          //   child: ListTile(
          //     onTap: () => signOut(),
          //     title: Text(
          //       'Sign Out',
          //       style: TextStyle(
          //         fontSize: 18,
          //       ),
          //     ),
          //     trailing: Icon(
          //       Icons.arrow_forward_ios,
          //       size: 18,
          //     ),
          //   ),
          // ),
          // Divider(
          //   color: Color(0xff6A6A6A),
          //   thickness: 1,
          //   indent: 10,
          //   endIndent: 10,
          // ),
          Center(
            child: OutlineButton(
              padding: EdgeInsets.symmetric(horizontal: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                Navigator.of(signOut()).pop();
              },
              child: Text("SIGN OUT",
                  style: TextStyle(
                      fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "CopyRight © 2021 Shubham Sapkal",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ))
        ],
      ),
    );
  }

  signOut() async {
    final storage = GetStorage();
    storage.erase();
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false);
  }
}
Row buildNotificationOptionRow(String title, bool isActive) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600]),
      ),
      Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: isActive,
            onChanged: (bool val) {},
          ))
    ],
  );
}