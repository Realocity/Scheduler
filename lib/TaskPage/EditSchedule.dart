import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scheduler/Util/button.dart';
import 'package:scheduler/Util/input_field.dart';
import 'package:firedart/firestore/models.dart' as yo;
import 'package:scheduler/Util/theme.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;
  final yo.CollectionReference postsRef =
  Firestore.instance.collection('/schedule');

  DateTime _selectedDate = DateTime.now();
  bool showFieldRepeat = true;
  bool showtimeField = true;
  bool showDate = true;
  Map<String, dynamic> postData = new Map<String, dynamic>();

  String _selectedSchedule;

  List<String> scheduleList = [
    'Task',
    'Event',
    'Birthday',
    'Reminder',
    'TODO List',
  ];

  String _startTime = "8:30 AM";
  String _endTime = "9:30 AM";
  int _selectedColor = 0;
  String _selectedColorCode = "";
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = 'None';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
    'annually',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                title: "Select Schedule",
                hint: "Selected Type -",
                widget: Row(
                  children: [
                    DropdownButton<String>(
                        value: _selectedSchedule ??= scheduleList[0],
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        style: subTitleTextStle,
                        underline: Container(height: 0),
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedSchedule = newValue;
                            if (_selectedSchedule == "Task") {
                              setState(() {
                                showFieldRepeat = true;
                                showtimeField = false;
                                showDate = false;
                              });
                            } else if (_selectedSchedule == "Event") {
                              setState(() {
                                showFieldRepeat = false;
                                showtimeField = false;
                                showDate = false;
                              });
                            } else if (_selectedSchedule == "Birthday") {
                              setState(() {
                                showFieldRepeat = false;
                                showtimeField = true;
                                showDate = false;
                              });
                            } else if (_selectedSchedule == "Reminder") {
                              setState(() {
                                showFieldRepeat = true;
                                showtimeField = true;
                                showDate = false;
                              });
                            } else if (_selectedSchedule == "TODO List") {
                              setState(() {
                                showFieldRepeat = true;
                                showtimeField = true;
                                showDate = false;
                              });
                            }
                          });
                        },
                        items: scheduleList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                    SizedBox(width: 7),
                  ],
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              Text(
                "Add Schedule",
                style: headingTextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              InputField(
                title: "Title",
                hint: "Enter title here.",
                controller: _titleController,
              ),
              InputField(
                  title: "Note",
                  hint: "Enter note here.",
                  controller: _noteController),
              showDate == false
                  ? InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: (Icon(
                    FlutterIcons.calendar_ant,
                    color: Colors.grey,
                  )),
                  onPressed: () {
                    // _showDatePicker(context);
                    _selectDate(context);

                  },
                ),
              )
                  : Opacity(
                opacity: 0.0,
              ),
              showtimeField == false
                  ? Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        icon: (Icon(
                          FlutterIcons.clock_faw5,
                          color: Colors.grey,
                        )),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: (Icon(
                          FlutterIcons.clock_faw5,
                          color: Colors.grey,
                        )),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  )
                ],
              )
                  : Opacity(
                opacity: 0.0,
              ),
              InputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: Row(
                  children: [
                    DropdownButton<String>(
                      //value: _selectedRemind.toString(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        style: subTitleTextStle,
                        underline: Container(height: 0),
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedRemind = int.parse(newValue);
                          });
                        },
                        items: remindList
                            .map<DropdownMenuItem<String>>((int value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()),
                          );
                        }).toList()),
                    SizedBox(width: 6),
                  ],
                ),
              ),
              showFieldRepeat == false
                  ? InputField(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: Row(
                  children: [
                    DropdownButton<String>(
                      //value: _selectedRemind.toString(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        style: subTitleTextStle,
                        underline: Container(height: 0),
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedRepeat = newValue;
                          });
                        },
                        items: repeatList.map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                    SizedBox(width: 6),
                  ],
                ),
              )
                  : Opacity(
                opacity: 0.0,
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorChips(),
                  MyButton(
                    label: "Update Schedule",
                    onTap: () {
                      // print("All Values will show under this ");
                      // print("Title -  ${_titleController.text} ");
                      //
                      // print("Note -  ${_noteController.text} ");
                      //
                      // print("Date -  ${_selectedDate.month} ");
                      // print("Start Time -  ${_startTime.numericOnly()} ");
                      // print("End Time -  ${_endTime.numericOnly()} ");
                      // print("Remind -  ${_selectedRemind.hours} ");
                      // print("Repeat -  ${_selectedRepeat.toString()} ");
                      // print("Color -  ${_selectedColor.toString()} ");
                      _validateInputs();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateInputs() {
    try {
      if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
        ///condition fields for task
        if (showFieldRepeat == true &&
            showtimeField == false &&
            showDate == false) {
          postData["title"] = _titleController.text.trim();
          postData["note"] = _noteController.text.trim();
          postData["date"] =DateFormat.yMd().format(_selectedDate);
          postData["startTime"] = _startTime;
          postData["endTime"] = _endTime;
          postData["remind"] = _selectedRemind;
          postData["color"] = _selectedColor;
        }

        ///condition fields for Birthday
        else if (showFieldRepeat == false &&
            showtimeField == true &&
            showDate == false) {
          postData["title"] = _titleController.text.trim();
          postData["note"] = _noteController.text.trim();
          postData["date"] = DateFormat.yMd().format(_selectedDate);
          postData["remind"] = _selectedRemind;
          postData["repeat"] = _selectedRepeat;
          postData["color"] = _selectedColor;
        }

        ///condition fields for reminder

        else if (showFieldRepeat == true &&
            showtimeField == true &&
            showDate == false) {
          postData["title"] = _titleController.text.trim();
          postData["note"] = _noteController.text.trim();
          postData["date"] = DateFormat.yMd().format(_selectedDate);
          postData["remind"] = _selectedRemind;
          postData["color"] = _selectedColor;
        }

        ///condition fields for TODO
        else if (showFieldRepeat == true &&
            showtimeField == true &&
            showDate == false) {
          postData["title"] = _titleController.text.trim();
          postData["note"] = _noteController.text.trim();
          postData["date"] =DateFormat.yMd().format(_selectedDate);
          postData["remind"] = _selectedRemind;
          postData["color"] = _selectedColor;
        }

        /// All fields && Event
        else {
          postData["title"] = _titleController.text.trim();
          postData["note"] = _noteController.text.trim();
          postData["date"] = DateFormat.yMd().format(_selectedDate);
          postData["startTime"] = _startTime;
          postData["endTime"] = _endTime;
          postData["remind"] = _selectedRemind;
          postData["repeat"] = _selectedRepeat;
          postData["color"] = _selectedColor;
        }
        _addTaskToDB();
      } else if (_titleController.text.isEmpty ||
          _noteController.text.isEmpty) {
        Fluttertoast.showToast(
            msg:
            "All fields are required.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print("${e}");
    }
  }

  _addTaskToDB() async {
    try {
      final dataCount = GetStorage();
      var uid = dataCount.read("uid");
      databaseReference
          .collection("schedule")
          .doc(uid.toString())
          .collection(_selectedSchedule)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          postsRef
              .document(uid)
              .collection(_selectedSchedule)
              .document(_titleController.text.trim())
              .create(postData);
          Fluttertoast.showToast(
              msg: "$_selectedSchedule Added Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        } else {
          postsRef
              .document(uid)
              .collection(_selectedSchedule)
              .document(_titleController.text.trim())
              .exists
              .then((value) {
            if (value == true) {
              Fluttertoast.showToast(
                  msg:
                  "$_selectedSchedule with ${_titleController
                      .text} Already Exists",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              postsRef
                  .document(uid)
                  .collection(_selectedSchedule)
                  .document(_titleController.text.trim())
                  .create(postData)
                  .onError((error, stackTrace) {
                Fluttertoast.showToast(
                    msg: "${error}",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);

                return null;
              });
              Fluttertoast.showToast(
                  msg: "$_selectedSchedule Added Successfully",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pop(context);
            }

            return value;
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  _colorChips() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Color",
        style: titleTextStle,
      ),
      SizedBox(
        height: 8,
      ),
      Wrap(
        children: List<Widget>.generate(
          5,
              (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;

                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                      ? pinkClr
                      : index == 2
                      ? yellowClr
                      : index == 3
                      ? aquaClr
                      : index == 4
                      ? greenClr
                      : index == 5,
                  child: index == _selectedColor
                      ? Center(
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 18,
                    ),
                  )
                      : Container(),
                ),
              ),
            );
          },
        ).toList(),
      ),
    ]);
  }

  _appBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios, size: 24, color: primaryClr),
        ),
        actions: [
          CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("asset/image/logo_1.png")),
          SizedBox(
            width: 20,
          ),
        ]);
  }

// _compareTime() {
//   print("compare time");
//   print(_startTime);
//   print(_endTime);

//   var _start = double.parsestartTime);
//   var _end = toDouble(_endTime);

//   print(_start);
//   print(_end);

//   if (_start > _end) {
//     Get.snackbar(
//       "Invalid!",
//       "Time duration must be positive.",
//       snackPosition: SnackPosition.BOTTOM,
//       overlayColor: context.theme.backgroundColor,
//     );
//   }
// }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  _getTimeFromUser({@required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    print(_pickedTime.format(context));
    String _formatedTime = _pickedTime.format(context);
    print(_formatedTime);
    if (_pickedTime == null)
      print("time canceld");
    else if (isStartTime)
      setState(() {
        _startTime = _formatedTime;
      });
    else if (!isStartTime) {
      setState(() {
        _endTime = _formatedTime;
      });
      //_compareTime();
    }
  }

  _showTimePicker() async {
    return showTimePicker(
      initialTime: TimeOfDay(hour: 8, minute: 30),
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900,8),
        lastDate: DateTime(2101,12));
    if (picked != null && picked != _selectedDate)
      setState(() {

        String a =DateFormat.yMd().format(picked);
        print("$a");
        _selectedDate=picked;
        print("$_selectedDate)");
      });
  }
}
