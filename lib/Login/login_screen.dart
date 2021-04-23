// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:companion_mobile/navigation-Animator/navigation.dart';
// import 'package:companion_mobile/screens/user_sign_in/welcome_screen.dart';
// import 'package:companion_mobile/utils/colors.dart';
// import 'package:companion_mobile/utils/strings.dart';
// import 'package:companion_mobile/widget/app_bar.dart';
// import 'package:companion_mobile/widget/common_button.dart';
// import 'package:companion_mobile/widget/validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fzregex/fzregex.dart';
// import 'package:fzregex/utils/pattern.dart';
// import 'package:keyboard_avoider/keyboard_avoider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'forgot_password_screen.dart';
//
// // import 'package:companion_mobile/widget/flutter_toast.dart';
// ScrollController _scrollController; //<==
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final databaseReference = FirebaseFirestore.instance;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   bool passwordValid = false;
//   bool emailValid = false;
//   bool _passwordVisible;
//   String passwordErrorMessageValue = "";
//   bool showPasswordMessage = false;
//   String errorMessageValue = "";
//   bool showErrorMessage = false;
//   TextEditingController userEmailController =
//       new TextEditingController(); // use  for user email address
//   TextEditingController userPasswordController =
//       new TextEditingController(); // use for user password
//   final FocusNode _emailFocusNode = FocusNode();
//   final FocusNode _passwordFocusNode = FocusNode();
//   final FocusNode _buttonFocusNode = FocusNode();
//
//   bool scrolled = false;
//   _scrollListener() {
//     if (!scrolled && MediaQuery.of(context).viewInsets.bottom != 0) {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//       setState(() {
//         scrolled = true;
//       });
//     }
//     if (MediaQuery.of(context).viewInsets.bottom == 0) {
//       setState(() {
//         scrolled = false;
//       });
//     }
//   }
//
//   @override
//   void didUpdateWidget(covariant LoginScreen oldWidget) {
//     // TODO: implement didUpdateWidget
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//     _passwordVisible = false;
//   }
//
//   @override
//   void dispose() {
//     userEmailController.dispose();
//     userPasswordController.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     passwordValid =
//         Fzregex.hasMatch(userPasswordController.text, FzPattern.passwordHard);
//     emailValid = RegExp(
//             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
//         .hasMatch(userEmailController.text);
//     return Scaffold(
//       /// Common app bar
//       resizeToAvoidBottomPadding: false,
//       resizeToAvoidBottomInset: false,
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(50.0), // here the desired height
//           child: CommonAppBar()),
//       body: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//
//           // autoScroll: true,
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: KeyboardAvoider(
//                 autoScroll: true,
//                 focusPadding: MediaQuery.of(context).viewInsets.bottom + 70,
//                 child: TextId()),
//           )
//           // Form(
//           //   key: _formKey,
//           //   child: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.start,
//           //     children: [
//           //       SizedBox(
//           //         height: 70.0,
//           //       ),
//           //       Center(
//           //           child: Text(
//           //         'Sign In',
//           //         style: TextStyle(
//           //             fontFamily: Strings.Poppins,
//           //             fontSize: 34.0,
//           //             color: AppColors.darkGreen,
//           //             fontWeight: FontWeight.w800),
//           //       )),
//           //       SizedBox(
//           //         height: 20.0,
//           //       ),
//           //       Padding(
//           //         padding: EdgeInsets.only(right: 30.0, left: 30.0),
//           //         child: TextFormField(
//           //           maxLength: 256,
//           //           autovalidateMode: AutovalidateMode.onUserInteraction,
//           //           controller: userEmailController,
//           //           textInputAction: TextInputAction.next,
//           //           focusNode: _emailFocusNode,
//           //           onFieldSubmitted: (term) {
//           //             _fieldFocusChange(
//           //                 context, _emailFocusNode, _passwordFocusNode);
//           //           },
//           //           validator: (value) {
//           //             value = value.trim();
//           //             emailValid = RegExp(
//           //                     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
//           //                 .hasMatch(value);
//           //
//           //             if (value.isEmpty) {
//           //               // return "Please enter your email";
//           //             }
//           //             if (!emailValid) {
//           //               // return 'Invalid email';
//           //             }
//           //             return null;
//           //           },
//           //           onChanged: (value) {
//           //             // use = value;
//           //             setState(() {
//           //               emailValid = RegExp(
//           //                       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//           //                   .hasMatch(value);
//           //             });
//           //           },
//           //           decoration: InputDecoration(
//           //               errorText: (showErrorMessage) ? errorMessageValue : null,
//           //               counterText: '',
//           //               labelText: 'Email',
//           //               labelStyle: TextStyle(fontFamily: Strings.Poppins),
//           //               suffixIcon: GestureDetector(
//           //                   onTap: () {},
//           //                   child: (showErrorMessage == true &&
//           //                           emailValid == true)
//           //                       ? ImageIcon(
//           //                           AssetImage('assets/images/wrongSign.png'),
//           //                           color: Colors.red,
//           //                         )
//           //                       : (emailValid == true &&
//           //                               showErrorMessage == false)
//           //                           ? ImageIcon(
//           //                               AssetImage('assets/images/correct.png'))
//           //                           : SizedBox(
//           //                               height: 0,
//           //                               width: 0,
//           //                             ))),
//           //         ),
//           //       ),
//           //       SizedBox(
//           //         height: 30.0,
//           //       ),
//           //       Padding(
//           //         padding: EdgeInsets.only(right: 30.0, left: 30.0),
//           //         child: TextFormField(
//           //           obscureText: !_passwordVisible,
//           //           controller: userPasswordController,
//           //           autovalidateMode: AutovalidateMode.disabled,
//           //           textInputAction: TextInputAction.next,
//           //           focusNode: _passwordFocusNode,
//           //           onFieldSubmitted: (term) {
//           //             _fieldFocusChange(
//           //                 context, _passwordFocusNode, _buttonFocusNode);
//           //           },
//           //           validator: (value) {
//           //             value = value.trim();
//           //             if (value.isEmpty) {
//           //               return "Please enter your password";
//           //             }
//           //
//           //             passwordValid =
//           //                 Fzregex.hasMatch(value, FzPattern.passwordHard);
//           //
//           //             /// Password (Hard) Regex
//           //             /// Allowing all character except 'whitespace'
//           //             /// Must contains at least: 1 uppercase letter, 1 lowecase letter, 1 number, & 1 special character (symbol)
//           //             /// Minimum character: 8
//           //             // if (passwordValid != true) {
//           //             //   return "Must contains:1 Uppercase,1 Lowercase,1 number & 1 special character";
//           //             // }
//           //             return null;
//           //           },
//           //           onChanged: (value) {
//           //             setState(() {
//           //               passwordValid =
//           //                   Fzregex.hasMatch(value, FzPattern.passwordHard);
//           //             });
//           //           },
//           //           decoration: InputDecoration(
//           //             errorText: (showPasswordMessage)
//           //                 ? passwordErrorMessageValue
//           //                 : null,
//           //             labelText: 'Password',
//           //             labelStyle: TextStyle(fontFamily: Strings.Poppins),
//           //             suffixIcon: GestureDetector(
//           //               onTap: () {
//           //                 setState(() {
//           //                   _passwordVisible = !_passwordVisible;
//           //                 });
//           //               },
//           //               child:
//           //                   (showPasswordMessage == true && passwordValid == true)
//           //                       ? ImageIcon(
//           //                           AssetImage('assets/images/wrongSign.png'),
//           //                           color: Colors.red,
//           //                         )
//           //                       : (passwordValid == true &&
//           //                               showPasswordMessage == false)
//           //                           ? ImageIcon(
//           //                               AssetImage('assets/images/correct.png'))
//           //                           : Icon(_passwordVisible
//           //                               ? Icons.visibility
//           //                               : Icons.visibility_off),
//           //             ),
//           //           ),
//           //         ),
//           //       ),
//           //
//           //       SizedBox(
//           //         height: 30.0,
//           //       ),
//           //       Center(
//           //           child: FlatButton(
//           //         onPressed: () {
//           //           Navigator.push(
//           //               context, FadeNavigation(widget: ForgotPasswordScreen()));
//           //         },
//           //         child: Text(
//           //           'Forgot Password?',
//           //           style: TextStyle(
//           //               fontFamily: Strings.Poppins, color: AppColors.darkGreen),
//           //         ),
//           //       )),
//           //       SizedBox(
//           //         height: 30.0,
//           //       ),
//           //
//           //       /// Common button
//           //       FlatButton(
//           //         focusNode: _buttonFocusNode,
//           //         autofocus: true,
//           //         splashColor: AppColors.darkGreen,
//           //         onPressed: () {
//           //           if (userEmailController.text.isNotEmpty &&
//           //               userPasswordController.text.isNotEmpty) {
//           //             if (!RegExp(
//           //                     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//           //                 .hasMatch(userEmailController.text)) {
//           //               Fluttertoast.showToast(
//           //                   msg: "Email is Invalid",
//           //                   toastLength: Toast.LENGTH_LONG,
//           //                   gravity: ToastGravity.CENTER,
//           //                   timeInSecForIosWeb: 1,
//           //                   backgroundColor: Colors.black,
//           //                   textColor: Colors.white,
//           //                   fontSize: 14);
//           //               if (!passwordValid) {
//           //                 Fluttertoast.showToast(
//           //                     msg: "Password is Invalid",
//           //                     toastLength: Toast.LENGTH_LONG,
//           //                     gravity: ToastGravity.CENTER,
//           //                     timeInSecForIosWeb: 1,
//           //                     backgroundColor: Colors.black,
//           //                     textColor: Colors.white,
//           //                     fontSize: 14);
//           //               }
//           //             } else {
//           //               if (_formKey.currentState.validate()) {
//           //                 _signInWithEmailAndPassword();
//           //               }
//           //             }
//           //           } else {
//           //             Fluttertoast.showToast(
//           //                 msg: "Please Fill All The Required Fields",
//           //                 toastLength: Toast.LENGTH_LONG,
//           //                 gravity: ToastGravity.CENTER,
//           //                 timeInSecForIosWeb: 1,
//           //                 backgroundColor: Colors.black,
//           //                 textColor: Colors.white,
//           //                 fontSize: 14);
//           //           }
//           //         },
//           //         child: Center(
//           //           child: CommonButton(
//           //             title: 'Login',
//           //             borderColor: Colors.white,
//           //             fillColor: (passwordValid && emailValid)
//           //                 ? AppColors.darkGreen
//           //                 : AppColors.grey,
//           //             buttonTextColor: AppColors.white,
//           //           ),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           ),
//     );
//   }
//
//   void _signInWithEmailAndPassword() async {
//     try {
//       setState(() {
//         errorMessageValue = "";
//         showErrorMessage = false;
//         passwordErrorMessageValue = "";
//         showPasswordMessage = false;
//       });
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//               email: userEmailController.text,
//               password: userPasswordController.text);
//       var authToken = await userCredential.user.getIdToken();
//       print("==================> $authToken");
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       if (userCredential.user.uid.isNotEmpty) {
//         prefs.setString('userId', userCredential.user.uid);
//         // databaseReference.collection('petParentsV1').doc()
//
//         databaseReference
//             .collection("petParentsV1")
//             .doc(userCredential.user.uid.toString())
//             .get()
//             .then((value) {
//           if (value.data() != null) {
//             prefs.setString("primaryPetId", value.get("primaryPetId"));
//             prefs.setString("primaryDeviceId", value.get("primaryDeviceId"));
//             prefs.setString("firstName",
//                 (value.get("firstName") != null) ? value.get("firstName") : "");
//             prefs.setString(
//                 "emailId",
//                 (value.get("emailId") != null)
//                     ? value.get("emailId")
//                     : ""); // var jsn = jsonEncode(value.data());
//             // print("$jsn");
//             value.data().forEach((key, value) {
//               print("$value");
//             });
//
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => WelcomeScreen()));
//           } else {
//             Fluttertoast.showToast(
//                 msg: "User not registered in database",
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.CENTER,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.black,
//                 textColor: Colors.white,
//                 fontSize: 14);
//           }
//         });
//
//         //     .then((QuerySnapshot snapshot) {
//         //   snapshot.docs.forEach((f) => print('${f.data}'));
//         // });
//
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         setState(() {
//           errorMessageValue = "We do not recognize this email.";
//           showErrorMessage = true;
//         });
//         // Fluttertoast.showToast(
//         //     msg: "No user found for that email.",
//         //     toastLength: Toast.LENGTH_LONG,
//         //     gravity: ToastGravity.CENTER,
//         //     timeInSecForIosWeb: 1,
//         //     backgroundColor: Colors.black,
//         //     textColor: Colors.white,
//         //     fontSize: 14);
//
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         setState(() {
//           passwordErrorMessageValue = "The password you entered is incorrect. ";
//           showPasswordMessage = true;
//         });
//         // Fluttertoast.showToast(
//         //     msg: "Wrong password provided for that user.",
//         //     // toastLength: Toast,
//         //     gravity: ToastGravity.CENTER,
//         //     timeInSecForIosWeb: 1,
//         //     backgroundColor: Colors.black,
//         //     textColor: Colors.white,
//         //     fontSize: 14);
//         print('Wrong password provided for that user.');
//       }
//     }
//   }
//
//   _fieldFocusChange(
//       BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
//     currentFocus.unfocus();
//     FocusScope.of(context).requestFocus(nextFocus);
//   }
// }
//
// class TextId extends StatefulWidget {
//   @override
//   _TextIdState createState() => _TextIdState();
// }
//
// class _TextIdState extends State<TextId> {
//   final databaseReference = FirebaseFirestore.instance;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   bool passwordValid = false;
//   bool emailValid = false;
//   bool _passwordVisible;
//   String passwordErrorMessageValue = "";
//   bool showPasswordMessage = false;
//   String errorMessageValue = "";
//   bool showErrorMessage = false;
//   TextEditingController userEmailController =
//       new TextEditingController(); // use  for user email address
//   TextEditingController userPasswordController =
//       new TextEditingController(); // use for user password
//   final FocusNode _emailFocusNode = FocusNode();
//   final FocusNode _passwordFocusNode = FocusNode();
//   final FocusNode _buttonFocusNode = FocusNode();
//
//   void _signInWithEmailAndPassword() async {
//     try {
//       setState(() {
//         errorMessageValue = "";
//         showErrorMessage = false;
//         passwordErrorMessageValue = "";
//         showPasswordMessage = false;
//       });
//
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//               email: userEmailController.text,
//               password: userPasswordController.text);
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       if (userCredential.user.uid.isNotEmpty) {
//         prefs.setString('userId', userCredential.user.uid);
//         // databaseReference.collection('petParentsV1').doc()
//
//         databaseReference
//             .collection("petParentsV1")
//             .doc(userCredential.user.uid.toString())
//             .get()
//             .then((value) {
//           if (value.data() != null) {
//             prefs.setString("primaryPetId", value.get("primaryPetId"));
//             prefs.setString("primaryDeviceId", value.get("primaryDeviceId"));
//             prefs.setString("firstName",
//                 (value.get("firstName") != null) ? value.get("firstName") : "");
//             prefs.setString("emailId",
//                 (value.get("emailId") != null) ? value.get("emailId") : "");
//             // var jsn = jsonEncode(value.data());
//             // print("$jsn");
//             value.data().forEach((key, value) {
//               print("$value");
//             });
//
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => WelcomeScreen()));
//           } else {
//             Fluttertoast.showToast(
//                 msg: "User not registered in database",
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.CENTER,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.black,
//                 textColor: Colors.white,
//                 fontSize: 14);
//           }
//         });
//
//         //     .then((QuerySnapshot snapshot) {
//         //   snapshot.docs.forEach((f) => print('${f.data}'));
//         // });
//
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         setState(() {
//           errorMessageValue = "We do not recognize this email.";
//           showErrorMessage = true;
//         });
//         // Fluttertoast.showToast(
//         //     msg: "No user found for that email.",
//         //     toastLength: Toast.LENGTH_LONG,
//         //     gravity: ToastGravity.CENTER,
//         //     timeInSecForIosWeb: 1,
//         //     backgroundColor: Colors.black,
//         //     textColor: Colors.white,
//         //     fontSize: 14);
//
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         setState(() {
//           passwordErrorMessageValue = "The password you entered is incorrect. ";
//           showPasswordMessage = true;
//         });
//         // Fluttertoast.showToast(
//         //     msg: "Wrong password provided for that user.",
//         //     // toastLength: Toast,
//         //     gravity: ToastGravity.CENTER,
//         //     timeInSecForIosWeb: 1,
//         //     backgroundColor: Colors.black,
//         //     textColor: Colors.white,
//         //     fontSize: 14);
//         print('Wrong password provided for that user.');
//       }
//     }
//   }
//
//   _fieldFocusChange(
//       BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
//     currentFocus.unfocus();
//     FocusScope.of(context).requestFocus(nextFocus);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _passwordVisible = false;
//   }
//
//   @override
//   void dispose() {
//     userEmailController.dispose();
//     userPasswordController.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 70.0,
//           ),
//           Center(
//               child: Text(
//             'Sign In',
//             style: TextStyle(
//                 fontFamily: Strings.Poppins,
//                 fontSize: 34.0,
//                 color: AppColors.darkGreen,
//                 fontWeight: FontWeight.w800),
//           )),
//           SizedBox(
//             height: 20.0,
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: 30.0, left: 30.0),
//             child: TextFormField(
//               maxLength: 256,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               controller: userEmailController,
//               textInputAction: TextInputAction.next,
//               focusNode: _emailFocusNode,
//               onFieldSubmitted: (term) {
//                 _fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
//               },
//               validator: (value) {
//                 value = value.trim();
//                 emailValid = RegExp(
//                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
//                     .hasMatch(value);
//
//                 if (value.isEmpty) {
//                   // return "Please enter your email";
//                 }
//                 if (!emailValid) {
//                   // return 'Invalid email';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 // use = value;
//                 setState(() {
//                   emailValid = RegExp(
//                           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                       .hasMatch(value);
//                 });
//               },
//               decoration: InputDecoration(
//                   errorText: (showErrorMessage) ? errorMessageValue : null,
//                   counterText: '',
//                   labelText: 'Email',
//                   labelStyle: TextStyle(fontFamily: Strings.Poppins),
//                   suffixIcon: GestureDetector(
//                       onTap: () {},
//                       child: (showErrorMessage == true && emailValid == true)
//                           ? ImageIcon(
//                               AssetImage('assets/images/wrongSign.png'),
//                               color: Colors.red,
//                             )
//                           : (emailValid == true && showErrorMessage == false)
//                               ? ImageIcon(
//                                   AssetImage('assets/images/correct.png'))
//                               : SizedBox(
//                                   height: 0,
//                                   width: 0,
//                                 ))),
//             ),
//           ),
//           SizedBox(
//             height: 30.0,
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: 30.0, left: 30.0),
//             child: TextFormField(
//               obscureText: !_passwordVisible,
//               controller: userPasswordController,
//               autovalidateMode: AutovalidateMode.disabled,
//               textInputAction: TextInputAction.next,
//               focusNode: _passwordFocusNode,
//               onFieldSubmitted: (term) {
//                 _fieldFocusChange(
//                     context, _passwordFocusNode, _buttonFocusNode);
//               },
//               validator: (value) {
//                 value = value.trim();
//                 if (value.isEmpty) {
//                   return "Please enter your password";
//                 }
//
//                 passwordValid = Fzregex.hasMatch(value, FzPattern.passwordHard);
//
//                 /// Password (Hard) Regex
//                 /// Allowing all character except 'whitespace'
//                 /// Must contains at least: 1 uppercase letter, 1 lowecase letter, 1 number, & 1 special character (symbol)
//                 /// Minimum character: 8
//                 // if (passwordValid != true) {
//                 //   return "Must contains:1 Uppercase,1 Lowercase,1 number & 1 special character";
//                 // }
//                 return null;
//               },
//               onChanged: (value) {
//                 setState(() {
//                   passwordValid =
//                       Fzregex.hasMatch(value, FzPattern.passwordHard);
//                 });
//               },
//               decoration: InputDecoration(
//                 errorText:
//                     (showPasswordMessage) ? passwordErrorMessageValue : null,
//                 labelText: 'Password',
//                 labelStyle: TextStyle(fontFamily: Strings.Poppins),
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _passwordVisible = !_passwordVisible;
//                     });
//                   },
//                   child: (showPasswordMessage == true && passwordValid == true)
//                       ? ImageIcon(
//                           AssetImage('assets/images/wrongSign.png'),
//                           color: Colors.red,
//                         )
//                       : (passwordValid == true && showPasswordMessage == false)
//                           ? ImageIcon(AssetImage('assets/images/correct.png'))
//                           : Icon(_passwordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                 ),
//               ),
//             ),
//           ),
//
//           SizedBox(
//             height: 30.0,
//           ),
//           Center(
//               child: FlatButton(
//             onPressed: () {
//               Navigator.push(
//                   context, FadeNavigation(widget: ForgotPasswordScreen()));
//             },
//             child: Text(
//               'Forgot Password?',
//               style: TextStyle(
//                   fontFamily: Strings.Poppins, color: AppColors.darkGreen),
//             ),
//           )),
//           SizedBox(
//             height: 30.0,
//           ),
//
//           /// Common button
//           FlatButton(
//             focusNode: _buttonFocusNode,
//             autofocus: true,
//             splashColor: AppColors.darkGreen,
//             onPressed: () {
//               if (userEmailController.text.isNotEmpty &&
//                   userPasswordController.text.isNotEmpty) {
//                 if (!RegExp(
//                         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//                     .hasMatch(userEmailController.text)) {
//                   Fluttertoast.showToast(
//                       msg: "Email is Invalid",
//                       toastLength: Toast.LENGTH_LONG,
//                       gravity: ToastGravity.CENTER,
//                       timeInSecForIosWeb: 1,
//                       backgroundColor: Colors.black,
//                       textColor: Colors.white,
//                       fontSize: 14);
//                   if (!passwordValid) {
//                     Fluttertoast.showToast(
//                         msg: "Password is Invalid",
//                         toastLength: Toast.LENGTH_LONG,
//                         gravity: ToastGravity.CENTER,
//                         timeInSecForIosWeb: 1,
//                         backgroundColor: Colors.black,
//                         textColor: Colors.white,
//                         fontSize: 14);
//                   }
//                 } else {
//                   if (_formKey.currentState.validate()) {
//                     _signInWithEmailAndPassword();
//                   }
//                 }
//               } else {
//                 Fluttertoast.showToast(
//                     msg: "Please Fill All The Required Fields",
//                     toastLength: Toast.LENGTH_LONG,
//                     gravity: ToastGravity.CENTER,
//                     timeInSecForIosWeb: 1,
//                     backgroundColor: Colors.black,
//                     textColor: Colors.white,
//                     fontSize: 14);
//               }
//             },
//             child: Center(
//               child: CommonButton(
//                 title: 'Login',
//                 borderColor: Colors.white,
//                 fillColor: (passwordValid && emailValid)
//                     ? AppColors.darkGreen
//                     : AppColors.grey,
//                 buttonTextColor: AppColors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
