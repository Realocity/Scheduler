import 'package:flutter/material.dart';
import 'package:scheduler/Calendar_Page/calendar_page.dart';
import 'package:scheduler/Dashboard/HomePage.dart';
import 'package:scheduler/Settings/SettingsPage.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, Object>> _pages = [
    {'page': HomePage(), 'title': 'Task'},
    {'page': CalendarPage(), 'title': 'Calendar'},
    {'page': Setting(), 'title': 'Setting'},
  ];
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _pages[_currentIndex]['page'],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.redAccent, spreadRadius: 3),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.redAccent,
          currentIndex: _currentIndex,
          onTap: onTapTab,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle), label: "Task"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined), label: "Calendar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }

  onTapTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
