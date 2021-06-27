import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scheduler/CheckList.dart';
import 'package:scheduler/TaskPage/NewTask.dart';
import 'package:scheduler/Util/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scheduler/NewNote.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filterType = "today";
  FirebaseFirestore databaseReference = FirebaseFirestore.instance;
  String _selectedSchedule;

  List<String> scheduleList = [
    'Task',
    'Event',
    'Birthday',
    'Reminder',
    'TODO List',
  ];

  // final yo.CollectionReference postsRef =
  // Firestore.instance.collection('/schedule');
  DateTime today = new DateTime.now();
  String taskPop = "close";
  var monthNames = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];
  CalendarController ctrlr = new CalendarController();
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Color(0xff3757F3),
                elevation: 0,
                title: Text(
                  "Scheduler",
                  style: TextStyle(fontSize: 30),
                ),
                actions: [
                  DropdownButton<String>(
                      value: _selectedSchedule ??= scheduleList[0],
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(height: 0),
                      onChanged: (String newValue) {
                        setState(() {
                          _selectedSchedule = newValue;
                        });
                      },
                      items: scheduleList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList())
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today ${monthNames[today.month - 1]}, ${today.day}/${today.year}",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: databaseReference
                            .collection('/schedule')
                            .doc(uid)
                            .collection(_selectedSchedule)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CupertinoActivityIndicator(
                              radius: 20,
                            ));
                          }
                          return
                              Container(
                                  height: MediaQuery.of(context).size.height,
                                  child:snapshot.data.docs == null
                                      ? Center(child: Text("No Data Available",style: TextStyle(color: Colors.black),)): new ListView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {},
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: (taskPop == "open")
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: InkWell(
                        onTap: closeTaskPop,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 1,
                              ),
                              InkWell(
                                onTap: openNewTask,
                                child: Container(
                                  child: Text(
                                    "Add Task",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                color: Colors.black.withOpacity(0.2),
                              ),
                              InkWell(
                                onTap: openNewNote,
                                child: Container(
                                  child: Text(
                                    "Add Quick Note",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                color: Colors.black.withOpacity(0.2),
                              ),
                              InkWell(
                                onTap: openNewCheckList,
                                child: Container(
                                  child: Text(
                                    "Add Checklist",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTaskPage()));
        },
        tooltip: '',
        child: Icon(Icons.add),
      ),
    );
  }

  openTaskPop() {
    taskPop = "open";
    setState(() {});
  }

  closeTaskPop() {
    taskPop = "close";
    setState(() {});
  }

  changeFilter(String filter) {
    filterType = filter;
    setState(() {});
  }

  Slidable taskWidget(int colorIndex, String title, String time, index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: Offset(0, 9),
              blurRadius: 20,
              spreadRadius: 1)
        ]),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: colorIndex == 0
                            ? primaryClr
                            : colorIndex == 1
                                ? pinkClr
                                : colorIndex == 2
                                    ? yellowClr
                                    : colorIndex == 3
                                        ? aquaClr
                                        : colorIndex == 4
                                            ? greenClr
                                            : colorIndex == 5,
                        width: 4)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: Text(
                    time,
                    maxLines: 1,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 50,
              width: 5,
              color: colorIndex == 0
                  ? primaryClr
                  : colorIndex == 1
                      ? pinkClr
                      : colorIndex == 2
                          ? yellowClr
                          : colorIndex == 3
                              ? aquaClr
                              : colorIndex == 4
                                  ? greenClr
                                  : colorIndex == 5,
            )
          ],
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Edit",
          color: Colors.white,
          icon: Icons.edit,
          onTap: () {},
        ),
        IconSlideAction(
          caption: "Delete",
          color: colorIndex == 0
              ? primaryClr
              : colorIndex == 1
                  ? pinkClr
                  : colorIndex == 2
                      ? yellowClr
                      : colorIndex == 3
                          ? aquaClr
                          : colorIndex == 4
                              ? greenClr
                              : colorIndex == 5,
          icon: Icons.delete,
          onTap: () {
            deleteFunction(title);
          },
        )
      ],
    );
  }

  openNewTask() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTaskPage()));
  }

  openNewNote() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewNote()));
  }

  openNewCheckList() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CheckList()));
  }

  Future<void> getVal() async {
    final dataCount = await GetStorage();
    setState(() {
      uid = dataCount.read("uid");
    });
  }

  Future<void> deleteFunction(String title) async {
    try {
      databaseReference
          .collection("schedule")
          .doc(uid)
          .collection(_selectedSchedule)
          .doc(title)
          .delete();
    } on Exception catch (e) {
      print(e);
    }
  }
}
