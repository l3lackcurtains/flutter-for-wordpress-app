import 'package:flutter/material.dart';

Widget articleBoxFeatured() {
  return SizedBox(
    height: 280,
    width: 360,
    child: Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 200,
            width: 400,
            child: Card(
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child: Image.network(
                  'https://images.pexels.com/photos/3098847/pexels-photo-3098847.jpeg?crop=entropy&cs=srgb&dl=woman-wearing-red-and-white-striped-long-sleeved-top-3098847.jpg&fit=crop&fm=jpg&h=960&w=1280',
                  fit: BoxFit.cover,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 1,
              margin: EdgeInsets.all(10),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 80,
          right: 20,
          child: Container(
            alignment: Alignment.bottomRight,
            height: 200,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg"),
                      ),
                      title: Text(
                        'By Icilome',
                        style: TextStyle(fontSize: 13),
                      ),
                      subtitle: Text(
                        'Janaury 23, 2019',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Silicon Valley Guru Affected by the Fulminant Slashed Investments",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "We woke reasonably late following the feast.. ",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                    fontFamily: "Nunito"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
