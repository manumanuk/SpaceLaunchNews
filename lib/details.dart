import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

import 'rocketlist.dart';


class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.title,@required this.rocketData}) : super(key: key);
  final String title;
  final RocketInfo rocketData;
  @override
  _DetailsPageState createState() => new _DetailsPageState(rocketData);
  
}


class _DetailsPageState extends State<DetailsPage> {
  ScaffoldState scaffold;
  Duration _countdown;
  Timer _timer;
  
  RocketInfo rocketData;
  _DetailsPageState(this.rocketData);

  @override
  void initState() {
    super.initState();
    if(this.rocketData.data!=null && this.rocketData.data["win_open"]!= null) {
      initiateCount();
    }
  }

  Duration get updatedCount {
    getCountdown();
    return _countdown;
  }
  void initiateCount() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(mounted){
        setState(() {
          getCountdown();
        });
      }
    });
  }
  void getCountdown() {
    if(rocketData.data != null) {
      String launchDate = rocketData.data["win_open"];
      DateTime launchTime = new DateTime(int.parse(launchDate.substring(0, 4)), int.parse(launchDate.substring(5, 7)), int.parse(launchDate.substring(8, 10)), int.parse(launchDate.substring(11, 13)), int.parse(launchDate.substring(14, 16)) + 0, 0);
      Duration difference = launchTime.difference(DateTime.now());
      _countdown = difference;
    }
  }

  Container tableCell(String info) {
      return Container(color: Colors.black, child: Padding(padding: EdgeInsets.all(10), child: Text(info, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.w300))));
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(image: ExactAssetImage('assets/starman_background.jpg'), fit: BoxFit.cover),
          BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: new Container(
              decoration: new BoxDecoration(color: Colors.black87.withOpacity(0.3)),
            ),
          ),
          ListView(children: <Widget>[
          Column(children: <Widget>[
            AppBar(
              title: Text(rocketData.data['name'], style: TextStyle(fontFamily: 'Raleway')),
              backgroundColor: Colors.black,
            ),
            Padding(padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5), child: Column(children: <Widget>[
              Align(alignment: Alignment.centerLeft, child: Text(rocketData.data["provider"]['name'], style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 45, fontWeight: FontWeight.w300))),
              Padding(padding: EdgeInsets.only(top: 10)),
              Align(alignment: Alignment.centerLeft, child: Text("Vehicle: " + rocketData.data["vehicle"]["name"], style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 30, fontWeight: FontWeight.w300))),
              Padding(padding: EdgeInsets.only(top: 5)),
              Align(alignment: Alignment.centerLeft, child: Text(("Pad: " + rocketData.data["pad"]["name"]), style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 20, fontWeight: FontWeight.w500))),
              Align(alignment: Alignment.centerLeft, child: Text((rocketData.data["pad"]["location"]["name"]), style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 15, fontWeight: FontWeight.w500))),
              Align(alignment: Alignment.centerLeft, child: Text((rocketData.data["pad"]["location"]["country"]), style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 15))),
              Padding(padding: EdgeInsets.only(top: 7)),
              Align(alignment: Alignment.center, child: Text((rocketData.data["launch_description"]), style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 12))),
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minWidth: media.width*0.60,
                  height: (media.width-20)*0.18,
                  child: RaisedButton(
                    color: Color(0xFF04878B),
                    child: Text(
                      'Launch 3D Model',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 30
                      )
                      ),
                    onPressed: () {
                      //HERE IS THE BUTTON
                    },
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 25)),
              Text("Vehicle Specs", style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 30, fontWeight: FontWeight.w300)),
              Padding(padding: EdgeInsets.only(top:10),),
              Table(border: TableBorder.all(color: Colors.yellow[200], width: 0.3), children: <TableRow>[
                TableRow(children: <Widget>[
                  tableCell("Height"),
                  tableCell(rocketData.height.toString() + " m")
                ]),
                TableRow(children: <Widget>[
                  tableCell("Diameter"),
                  tableCell(rocketData.diameter.toString() + " m")
                ]),
                TableRow(children: <Widget>[
                  tableCell("Dry mass"),
                  tableCell(rocketData.massKg.toString() + " kg")
                ]),
                TableRow(children: <Widget>[
                  tableCell("Payload to LEO"),
                  tableCell(rocketData.payloadKg.toString() + " kg")
                ]),
                TableRow(children: <Widget>[
                  tableCell("Reusablity"),
                  tableCell(rocketData.reusability)
                ]),
                TableRow(children: <Widget>[
                  tableCell("First stage thrust"),
                  tableCell(rocketData.seaThrust.toString() + " kN")
                ]),
                TableRow(children: <Widget>[
                  tableCell("Vaccuum thrust"),
                  tableCell(rocketData.vaccuumThrust.toString() + " kN")
                ]),
                TableRow(children: <Widget>[
                  tableCell("Launch Cost"),
                  tableCell("\$" + rocketData.cost.toString() + " million")
                ]),
              ],),
              Container(padding: EdgeInsets.all(50),)
              ],)),
            ]),],),
            displayCountdown(media),
          ],
        )
      );
  }

  Widget displayCountdown(media) {
    if (rocketData.data["win_open"]!=null) {
      return Container(
          margin: EdgeInsets.fromLTRB(15, media.height-10-75, 15, 15),
          child: Card(
            color: Colors.indigo,
            child: Padding(padding: EdgeInsets.all(15), child: Center(
              child: Text(
                'T-' + '$_countdown'.substring(0, _countdown.toString().length-7),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 16,
                  backgroundColor: Colors.indigo,
                  color: Colors.white,
                )
              )
            ))
          ),
        );
    } else {
      return Container(margin: EdgeInsets.fromLTRB(15, media.height-10-75, 15, 15),
          child: Card(
            color: Colors.white,
            child: Padding(padding: EdgeInsets.all(15), child: Center(
              child: Text("Launch date TBD. No countdown available.", style: TextStyle(
                  fontSize: media.width*0.04,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                )),
            ),
            ),
          ),
      );
    }
  }
}