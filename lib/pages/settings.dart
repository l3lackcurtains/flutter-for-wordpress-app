import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'favoutite_articles.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Plus',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins')),
        elevation: 5,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 60,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text("Portail togolais par excellence"),
            ),
            Divider(
              height: 10,
              thickness: 2,
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouriteArticles(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favourites'),
                    subtitle: Text("Browse Favourite articles"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //
                  },
                  child: ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('A propos'),
                    subtitle: Text("Know more about Icilome"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //
                  },
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Contactez-nous'),
                    subtitle: Text("Get in touch with us"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share('https://icilome.net');
                  },
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Partager'),
                    subtitle: Text("Spread the words of Icilome"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
