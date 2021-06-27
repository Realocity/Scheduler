// import 'dart:html';
// import 'package:firedart/firestore/firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class RequestPage extends StatefulWidget {
//   final String uid;
//
//   RequestPage({Key key, @required this.uid}) : super(key: key);
//
//   @override
//   _RequestPageState createState() => _RequestPageState(uid);
// }
//
// class _RequestPageState extends State<RequestPage> {
//   final String uid;
//   _RequestPageState(this.uid);
//
//   var collections = Firestore.instance.collection('schedule');
//   String task;
//
//
//   void acceptFriendRequest(String theUid) async {
//     await Firestore.instance
//         .collection('schedule')
//         .document(uid)
//         .setData({
//       'schedule': theUid,
//     }).then((onValue) {
//       print('current user: ');
//       print(uid);
//       print(theUid);
//     });
//
//     await Firestore.instance
//         .collection('schedule')
//         .document(uid)
//         .setData({
//       'schedule': uid,
//     }).then((onValue) {
//     });
//
//     await Firestore.instance
//         .collection('schedule')
//         .document(uid)
//         .delete();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {  },
//         child: Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         title: Text(
//           "Requests",
//           style: TextStyle(
//             fontFamily: "tepeno",
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onPressed: () {
//               Navigator.of(signOut()).pop();
//             }),
//           ),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: collections
//             .document(uid)
//             .collection('requests')
//             .snapshot(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data.document.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot ds = snapshot.data.document[index];
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                   margin: EdgeInsets.all(8.0),
//                   child: ListTile(
//                     title: Text(
//                       ds['schedule'] ?? '',
//                       style: TextStyle(
//                         fontFamily: "tepeno",
//                         fontSize: 18.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                     trailing: Wrap(
//                       spacing: 7, // space between two icons
//                       children: <Widget>[
//                         IconButton(
//                           icon: Icon(
//                             Icons.check,
//                             size: 27.0,
//                             color: Colors.brown[900],
//                           ),
//                           onPressed: () {
//                             acceptFriendRequest(ds['schedule']);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.do_not_disturb,
//                             size: 27.0,
//                             color: Colors.brown[900],
//                           ),
//                           onPressed: () {
//                             //   _onDeleteItemPressed(index);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.remove_red_eye,
//                             size: 27.0,
//                             color: Colors.brown[900],
//                           ),
//                           onPressed: () {
//
//
//                           },
//                         ),
//                       ],
//                     ),
//
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return CircularProgressIndicator();
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
