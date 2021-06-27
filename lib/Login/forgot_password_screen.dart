// import 'package:companion_mobile/navigation-Animator/navigation.dart';
// import 'package:companion_mobile/screens/survey_screen/survey_screen_dog_name.dart';
// import 'package:companion_mobile/screens/user_sign_in/check_mail.dart';
// import 'package:companion_mobile/screens/user_sign_in/welcome_screen.dart';
// import 'package:companion_mobile/utils/FirebaseHandler.dart';
// import 'package:companion_mobile/utils/colors.dart';
// import 'package:companion_mobile/utils/strings.dart';
// import 'package:companion_mobile/widget/app_bar.dart';
// import 'package:companion_mobile/widget/common_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:keyboard_avoider/keyboard_avoider.dart';
// import 'package:package_info/package_info.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   TextEditingController magicEmailController =
//       new TextEditingController(); // use for email address
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String _email;
//   bool isEmailFilled = false;
//   String userEmail = "";
//   bool isEmailFill = false;
//   bool emailEntered = false;
//   bool showErrorMessage = false;
//   bool emailValid = false;
//   final FocusNode _emailFocusNode = FocusNode();
//   final FocusNode _buttonFocusNode = FocusNode();
//   String errorMessageValue = "";
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   void _showDialog(String error) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text("Request"),
//           content: new Text(error),
//           actions: <Widget>[
//             new FlatButton(
//               child: new Text("Close"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: true,
//
//       /// Common app bar
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(50.0), // here the desired height
//           child: CommonAppBar()),
//       body: KeyboardAvoider(
//         autoScroll: true,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 70,
//               ),
//               Center(
//                   child: Text(
//                 'Forgot Password?',
//                 style: TextStyle(
//                     fontFamily: Strings.Poppins,
//                     fontSize: 28.0,
//                     color: AppColors.darkGreen,
//                     fontWeight: FontWeight.bold),
//               )),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Center(
//                 child: Text(
//                   'No worries. Enter the email you used to \nsign up and we will send you a reset link.',
//                   style: TextStyle(
//                       color: AppColors.grey, fontFamily: Strings.Poppins),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 40.0, left: 40.0),
//                 child: TextFormField(
//                   controller: magicEmailController,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   focusNode: _emailFocusNode,
//                   textInputAction: TextInputAction.next,
//                   validator: (value) {
//                     value = value.trim();
//                     emailValid = RegExp(
//                             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
//                         .hasMatch(value);
//                     if (value.isNotEmpty) {
//                       // return 'Invalid email';
//                     }
//
//                     return null;
//                   },
//                   onChanged: (val) {
//                     setState(() {
//                       emailValid = RegExp(
//                               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
//                           .hasMatch(val);
//                     });
//
//                     if (emailValid) {
//                       setState(() {
//                         emailEntered = true;
//                       });
//                     }
//                   },
//                   onSaved: (value) => _email = value,
//                   onFieldSubmitted: (val) {
//                     _fieldFocusChange(
//                         context, _emailFocusNode, _buttonFocusNode);
//                     setState(() {
//                       isEmailFilled = true;
//                       //signIn();
//                     });
//                   },
//                   decoration: InputDecoration(
//                       errorText: (showErrorMessage) ? errorMessageValue : null,
//                       labelText: 'Email',
//                       labelStyle: TextStyle(fontFamily: Strings.Poppins),
//                       suffixIcon: (showErrorMessage == true &&
//                               emailValid == true)
//                           ? ImageIcon(AssetImage('assets/images/wrongSign.png'))
//                           : (emailValid == true && showErrorMessage == false)
//                               ? ImageIcon(
//                                   AssetImage('assets/images/correct.png'))
//                               : SizedBox(
//                                   height: 0,
//                                   width: 0,
//                                 )),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.0,
//               ),
//               Padding(
//                   padding: EdgeInsets.only(left: 40.0),
//                   child: Text(
//                     'We will email you the login link.',
//                     style: TextStyle(
//                         fontFamily: Strings.Poppins, color: AppColors.grey),
//                   )),
//               SizedBox(
//                 height: 100.0,
//               ),
//
//               /// Common button
//               Padding(
//                 padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                 child: FlatButton(
//                   splashColor: AppColors.orange,
//                   onPressed: () {
//                     if (magicEmailController.text.isNotEmpty) {
//                       if (!RegExp(
//                               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
//                           .hasMatch(magicEmailController.text)) {
//                         setState(() {
//                           errorMessageValue = "We do not recognize this email.";
//                           showErrorMessage = true;
//                         });
//
//                         return null;
//                       } else {
//                         setState(() {
//                           resetPassword(magicEmailController.text);
//                         });
//                       }
//                     } else {
//                       Fluttertoast.showToast(
//                           msg: "Please Fill All Required Fields",
//                           // toastLength: Toast,
//                           gravity: ToastGravity.CENTER,
//                           timeInSecForIosWeb: 1,
//                           backgroundColor: Colors.black,
//                           textColor: Colors.white,
//                           fontSize: 14);
//                     }
//                   },
//                   child: CommonButton(
//                     title: 'Reset Password',
//                     borderColor: Colors.white,
//                     fillColor:
//                         emailEntered ? AppColors.darkGreen : AppColors.grey,
//                     buttonTextColor: AppColors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   _fieldFocusChange(
//       BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
//     currentFocus.unfocus();
//     FocusScope.of(context).requestFocus(nextFocus);
//   }
// }
