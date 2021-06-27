import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(Notification());
}

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NotificationPage(title: 'Notification Page'),
    );
  }
}


class NotificationPage extends StatefulWidget {
  NotificationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _statusText = "Waiting...";
  final String _finished = "Finished creating channel";
  final String _error = "Error while creating channel";

  void _createNewChannel() async {
    setState(() {
      _statusText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _statusText,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewChannel,
        child: Icon(Icons.add),
      ),
    );
  }
}

 const MethodChannel _channel =
MethodChannel('somethinguniqueforyou.com/channel_test');

Map<String, String> channelMap = {
  "id": "CHAT_MESSAGES",
  "name": "Chats",
  "description": "Chat notifications",
};
