import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
        centerTitle: true,
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
                style: TextStyle(height: 1.6, color: Colors.black87),
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
                    leading: Image.asset(
                      "assets/more/favourite.png",
                      width: 36,
                    ),
                    title: Text('Favourites'),
                    subtitle: Text("Browse Favourite articles"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/more/contact.png",
                      width: 36,
                    ),
                    title: Text('Contactez-nous'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FlatButton.icon(
                            onPressed: () async {
                              const url = 'https://icilome.com';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            icon: Icon(
                              Icons.link,
                              color: Colors.black54,
                            ),
                            label: Text(
                              "https://icilome.com",
                              style: TextStyle(color: Colors.black54),
                            )),
                        FlatButton.icon(
                            onPressed: () async {
                              const url = 'mailto:info@icilome.com';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            icon: Icon(
                              Icons.mail_outline,
                              color: Colors.black54,
                            ),
                            label: Text(
                              "info@icilome.com",
                              style: TextStyle(color: Colors.black54),
                            )),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share('Visitez iciLome: https://icilome.net');
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/more/share.png",
                      width: 36,
                    ),
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
