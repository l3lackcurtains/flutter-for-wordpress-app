import 'package:flutter/material.dart';

Widget searchBoxes(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: GridView.count(
      crossAxisCount: 3,
      children: <Widget>[
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/politic.png")),
                Spacer(),
                Text("Politique")
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/sport.png")),
                Spacer(),
                Text("Sport")
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/faits-divers.png")),
                Spacer(),
                Text("Faits Divers"),
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child:
                        Image.asset("assets/boxed/conseil-des-ministres.png")),
                Spacer(),
                Text(
                  "Conseil des ministres",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/economie.png")),
                Spacer(),
                Text("Economie")
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/buzz.png")),
                Spacer(),
                Text(
                  "Divertissement et Buzz",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/revue-de-presse.png")),
                Spacer(),
                Text(
                  "Revue de Presse",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/opinion.png")),
                Spacer(),
                Text("Opinion"),
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/sante.png")),
                Spacer(),
                Text("Sante"),
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/A-ne-pas-manquer.png")),
                Spacer(),
                Text("A ne pass manquer",
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 12))
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/English.png")),
                Spacer(),
                Text("English"),
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/boxed/favoris.png")),
                Spacer(),
                Text("Favoris"),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
