import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  void initState() {
    super.initState();
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
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Image(
                image: AssetImage('assets/icon.png'),
                height: 50,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Text(
                "Version 2.0.0 \n flutterblog.crumet.com \n Demo flutter app for wordpress news website",
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
                
                ListTile(
                  leading: Image.asset(
                    "assets/more/contact.png",
                    width: 30,
                  ),
                  title: Text('Contact'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextButton(
                          onPressed: () async {
                            const url = 'https://flutterblog.crumet.com';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            "flutterblog.crumet.com",
                            style: TextStyle(color: Colors.black54),
                          )),
                      TextButton(
                          onPressed: () async {
                            const url = 'mailto:info@crumet.com';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            "info@crumet.com",
                            style: TextStyle(color: Colors.black54),
                          )),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share(
                        'Check out our blog: https://flutterblog.crumet.com');
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/more/share.png",
                      width: 30,
                    ),
                    title: Text('Share'),
                    subtitle: Text("Spread the words of flutter blog crumet"),
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
