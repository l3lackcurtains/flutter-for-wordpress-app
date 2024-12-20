import 'package:flutter/material.dart';

import 'common/constants.dart';
import 'pages/articles.dart';
import 'pages/local_articles.dart';
import 'pages/search.dart';
import 'pages/settings.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF385C7B),
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.black,
        // textTheme: TextTheme(
        //   headline1: TextStyle(
        //     fontSize: 17,
        //     color: Colors.black,
        //     height: 1.2,
        //     fontWeight: FontWeight.w500,
        //     fontFamily: "Soleil",
        //   ),
        //   caption: TextStyle(color: Colors.black45, fontSize: 10),
        //   bodyText1: TextStyle(
        //       fontSize: 16,
        //       height: 1.5,
        //       color: Colors.black87,
        //       fontWeight: FontWeight.normal),
        // ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    Articles(),
    LocalArticles(),
    Search(),
    Settings()
  ];

  @override
  void initState() {
    super.initState();
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.flare), label: page2CategoryName),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Theme.of(context).primaryColor,
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
