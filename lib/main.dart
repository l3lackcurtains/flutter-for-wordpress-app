import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:icilome_mobile/pages/articles.dart';
import 'package:icilome_mobile/pages/categories.dart';
import 'package:icilome_mobile/pages/local_articles.dart';
import 'package:icilome_mobile/pages/search.dart';
import 'package:icilome_mobile/pages/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Icilome',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue.shade500,
          accentColor: Color(0xFFE74C3C),
          textTheme: TextTheme(
              title: TextStyle(
                fontSize: 17,
                color: Colors.black,
                height: 1.2,
                fontWeight: FontWeight.w500,
                fontFamily: "Soleil",
              ),
              caption: TextStyle(color: Colors.black45, fontSize: 10),
              body1: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              )),
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Firebase Cloud Messeging setup
  final FirebaseMessaging _fcm = FirebaseMessaging();

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    Articles(),
    LocalArticles(),
    Categories(),
    Search(),
    Settings()
  ];

  @override
  void initState() {
    super.initState();
    // Allow notification access

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Alert Dialog title"),
              content: new Text("Alert Dialog body"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
    _fcm.subscribeToTopic('all');
    _fcm.requestNotificationPermissions(IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w500, fontFamily: "Soleil"),
          unselectedLabelStyle: TextStyle(fontFamily: "Soleil"),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Actualites')),
            BottomNavigationBarItem(
                icon: Icon(Icons.broken_image), title: Text('Local')),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text('Section')),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Recherche')),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), title: Text('Plus')),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Theme.of(context).accentColor,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
