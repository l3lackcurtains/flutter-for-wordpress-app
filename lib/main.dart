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
        title: 'Khata',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            primaryColor: Colors.deepPurple,
            fontFamily: 'Roboto'),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    Articles(),
    LocalArticles(),
    Categories(),
    Search(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w500, fontFamily: "Poppins"),
          unselectedLabelStyle: TextStyle(fontFamily: "Poppins"),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Articles')),
            BottomNavigationBarItem(
                icon: Icon(Icons.broken_image), title: Text('Local')),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text('Categories')),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Search')),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), title: Text('More')),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.deepPurple,
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
