import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scheduler/Splash_Page/splash_screen.dart';
import 'package:scheduler/ProfilePage/EditProfile.dart';

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
          backgroundColor: Color(0xfff96060),
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
            margin: EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? height * 0.40
                : height * 0.20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: ExactAssetImage('asset/image/settingback2.png'),
                    fit: BoxFit.fill)),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Text(
              'ACCOUNT',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder:(context)=> EditProfilePage()));
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
          Divider(
            color: Color(0xff6A6A6A),
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Text(
              'GENERAL',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: ListTile(
              onTap: () {},
              title: Text(
                'Notifications',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
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
          Container(
            child: ListTile(
              onTap: () {},
              title: Text(
                'Pin & Password',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
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
          Container(
            child: ListTile(
              onTap: () {},
              title: Text(
                'Calendar Sync',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
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
          Container(
            child: ListTile(
              onTap: () {},
              title: Text(
                'Backup & Restore',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
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
          Container(
            margin: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Text(
              'ABOUT',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Container(
            child: ListTile(
              onTap: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Terms and Condition"),
                    content: Text(""),
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


          Divider(
            color: Color(0xff6A6A6A),
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Container(
            child: ListTile(
              onTap: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Privacy Policy"),
                    content: Text(""),
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
          Container(
            margin: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Text(
              'PROFILE ACCOUNT',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: ListTile(
              onTap: ()  =>signOut(),
              title: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
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
          Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "version 1.0",
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
        context, MaterialPageRoute(builder:(context)=> SplashScreen()), (route) => false);
  }

}
