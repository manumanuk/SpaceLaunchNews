import 'package:flutter/material.dart';
import 'LaunchRequestAPI.dart';
import 'dart:ui';


class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DetailsPageState createState() => _DetailsPageState();
}


class _DetailsPageState extends State<DetailsPage> {
  Future<List> futureLaunch;
  ScaffoldState scaffold;
  @override
  void initState() {
    super.initState();
    futureLaunch = fetchLaunch();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      body:
        FutureBuilder<List>(
          future: futureLaunch,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic launchInfo = snapshot.data[4];
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                Image(image: ExactAssetImage('assets/star_background.jpg'), fit: BoxFit.cover),
                BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  child: new Container(
                    decoration: new BoxDecoration(color: Colors.black87.withOpacity(0.1)),
                  ),
                ),
                Column(children: <Widget>[
                  AppBar(
                    title: Text(launchInfo['name'], style: TextStyle(fontFamily: 'Raleway')),
                    backgroundColor: Colors.black,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5), child: Column(children: <Widget>[
                    Align(alignment: Alignment.centerLeft, child: Text(launchInfo["provider"]['name'], style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 45, fontWeight: FontWeight.w300))),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Align(alignment: Alignment.centerLeft, child: Text("Vehicle: " + launchInfo["vehicle"]["name"], style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 30, fontWeight: FontWeight.w300))),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Align(alignment: Alignment.centerLeft, child: Text(("Pad: " + launchInfo["pad"]["name"]), style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 20, fontWeight: FontWeight.w500))),
                    Align(alignment: Alignment.centerLeft, child: Text((launchInfo["pad"]["location"]["name"]), style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 15, fontWeight: FontWeight.w500))),
                    //Align(alignment: Alignment.centerLeft, child: Text((launchInfo["pad"]["location"]["state"]), style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 15, fontWeight: FontWeight.w500))),
                    Align(alignment: Alignment.centerLeft, child: Text((launchInfo["pad"]["location"]["country"]), style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 15, fontWeight: FontWeight.w500))),
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
                          //Scaffold.of(context).showSnackBar(countdown);
                          print("pressed");
                        },),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 25)),
                    Text("Vehicle Specs", style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 30, fontWeight: FontWeight.w300)),
                    //Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean orci lacus, congue lacinia molestie eget, consectetur non purus. Integer eu justo pulvinar, iaculis libero vitae, sollicitudin lorem. Vivamus iaculis bibendum ullamcorper. Donec faucibus ultricies ipsum vel malesuada. Nam aliquet lacinia tincidunt. Curabitur neque orci, iaculis quis tellus maximus, rhoncus gravida velit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ullamcorper, tortor quis vehicula volutpat, purus ligula aliquet neque, ut lobortis mi velit et lectus. Etiam venenatis massa a semper malesuada. Maecenas hendrerit ac dui vitae finibus. Ut et eleifend dolor. Pellentesque et pretium lacus, sed aliquet enim. Suspendisse tincidunt ipsum ac augue hendrerit malesuada.")
                    //Text(DateTime.now().toString()),
                    //Text(snapshot.data.toString()),
                    //Text(launchInfo.toString()),
                    
                  ],)
                ),
              ],)],

              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),);
  }
}