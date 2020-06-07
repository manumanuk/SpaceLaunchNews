import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:SpaceLaunchNews/rocketlist.dart';

import 'rocketlist.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: ExactAssetImage('assets/home_background.jpg'),
              fit: BoxFit.cover
            ),
            BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.black87.withOpacity(0.4)),
              ),
            ),
            Column(children: <Widget>[
              Card(
                color: Colors.transparent,
                shadowColor: Colors.black,
                //margin: EdgeInsets.only(left: context.size.height/100*7, right: context.size.height/100*7, top: context.size.height/100*25, bottom: context.size.height/100*25),
                margin: EdgeInsets.only(left: media.width/100*5, right: media.width/100*5, top: media.height/100*33, bottom: media.height/100*9), 
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(child: Text(
                    'Space Launch News',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Raleway',
                      fontSize: media.height/100*6,
                    ),),),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
              ),
              Container(
                child: ButtonTheme(
                  minWidth: media.width/100*45,
                  height: media.width/100*50/3.5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: RaisedButton(
                    color: Color(0xFF04878B),
                    child: Text(
                      'Launch',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: media.width/100*7
                      )
                      ),
                    onPressed: ()=>Navigator.of(context).push(_createRoute())),
                  ),
              ),
            ]),
          ],
        )
      )
    );
  }

  Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RocketListPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

}