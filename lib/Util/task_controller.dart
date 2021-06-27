// import 'package:get/get.dart';
// import 'package:scheduler/Util/task.dart';
//
//
// class TaskController extends GetxController {
//   get tasks => null;
//
//   //this will hold the data and update the ui
//
//   @override
//   void onReady() {
//     getTasks();
//     super.onReady();
//   }
//
//   final taskList = List<Task>().obs;
//
//   // add data to table
//   Future<void> addTask({Task task}) async {
//   }
//
//   // get all the data from table
//   void getTasks() async {
//     taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
//   }
//
//   // delete data from table
//   void deleteTask(Task task) async {
//     getTasks();
//   }
//
//   // update data int table
//   void markTaskCompleted(int id) async {
//
//     getTasks();
//   }
// }