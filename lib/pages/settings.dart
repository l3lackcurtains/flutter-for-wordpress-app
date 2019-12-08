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
                height: 50,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text(
                "Version 1.0 \n iciLome.com \n Le portail togolais par excellence! \n Copyright @iciLome.com",
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.6, color: Colors.black54),
              ),
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
                    leading: Icon(Icons.phone),
                    title: Text('Contactez-nous'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 8),
                        Text("https://www.iciLome.com"),
                        SizedBox(height: 8),
                        Text("info@iciLome.com")
                      ],
                    ),
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
