import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'favoutite_articles.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notification = false;

  @override
  void initState() {
    super.initState();
    checkNotificationSetting();
  }

  checkNotificationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'notification';
    final value = prefs.getInt(key) ?? 0;
    if (value == 0) {
      setState(() {
        _notification = false;
      });
    } else {
      setState(() {
        _notification = true;
      });
    }
  }

  saveNotificationSetting(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'notification';
    final value = val ? 1 : 0;
    prefs.setInt(key, value);
    if (value == 1) {
      setState(() {
        _notification = true;
      });
    } else {
      setState(() {
        _notification = false;
      });
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'More',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Poppins'),
        ),
        elevation: 5,
        backgroundColor: Colors.white,
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
                      width: 30,
                    ),
                    title: Text('Favoris'),
                    subtitle: Text("Parcourir vos favoris"),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/more/contact.png",
                    width: 30,
                  ),
                  title: Text('Contactez-nous'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () async {
                            const url = 'https://icilome.com';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            "https://icilome.com",
                            style: TextStyle(color: Colors.black54),
                          )),
                      FlatButton(
                          onPressed: () async {
                            const url = 'mailto:info@icilome.com';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            "info@icilome.com",
                            style: TextStyle(color: Colors.black54),
                          )),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share('Visitez iciLome: https://icilome.com');
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/more/share.png",
                      width: 30,
                    ),
                    title: Text('Partager'),
                    subtitle: Text("Spread the words of Icilome"),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/more/notification.png",
                    width: 30,
                  ),
                  isThreeLine: true,
                  title: Text('Alerte'),
                  subtitle: Text("Changer vos préférences"),
                  trailing: Switch(
                      onChanged: (val) async {
                        await saveNotificationSetting(val);
                      },
                      value: _notification),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
