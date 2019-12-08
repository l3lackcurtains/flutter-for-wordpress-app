import 'package:flutter/material.dart';

Widget searchBoxes(BuildContext context) {
  return GridView.count(
    padding: EdgeInsets.all(16),
    shrinkWrap: true,
    physics: ScrollPhysics(),
    crossAxisCount: 3,
    children: <Widget>[
      Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Column(
            children: <Widget>[
              SizedBox(
                  width: 100,
                  height: 45,
                  child: Image.asset("assets/boxed/politic.png")),
              Spacer(),
              Text(
                "Politique",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/sport.png")),
              Spacer(),
              Text(
                "Sport",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/faits-divers.png")),
              Spacer(),
              Text(
                "Faits Divers",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/society.png")),
              Spacer(),
              Text(
                "Société",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/conseil-des-ministres.png")),
              Spacer(),
              Text(
                "Conseil des ministres",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/diplomatie.png")),
              Spacer(),
              Text(
                "Diplomatie",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/sante.png")),
              Spacer(),
              Text(
                "Sante",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/buzz.png")),
              Spacer(),
              Text(
                "Divertissement et Buzz",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/revue-de-presse.png")),
              Spacer(),
              Text(
                "Revue de Presse",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/economie.png")),
              Spacer(),
              Text(
                "Economie",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/A-ne-pas-manquer.png")),
              Spacer(),
              Text(
                "A ne pass manquer",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/opinion.png")),
              Spacer(),
              Text(
                "Opinion",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/benin.png")),
              Spacer(),
              Text(
                "Bénin",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/international.png")),
              Spacer(),
              Text(
                "International",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/English.png")),
              Spacer(),
              Text(
                "English",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                  height: 45,
                  child: Image.asset("assets/boxed/favoris.png")),
              Spacer(),
              Text(
                "Favoris",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
