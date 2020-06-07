import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'LaunchRequestAPI.dart';
import 'package:http/http.dart' as http;

import 'rocketlist.dart';


class ARView extends StatefulWidget {
  ARView({Key key,this.title, @required this.vehicle}) : super(key: key);
  final String title;
  final String vehicle;
  @override
  _ARViewState createState() => _ARViewState(vehicle);
}


class _ARViewState extends State<ARView> {
  String vehicle;
  _ARViewState(this.vehicle);
  @override
  void initState() {
    super.initState();
  }

  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); 
  UnityWidgetController _unityWidgetController;
    double _sliderValue = 1.0;
    String _projectKey = 'crimson-flower-2283';
    var vehicleCodes = {"electron": "49839872-1659-4e18-a9bb-f1e3ec73d676", "falcon-9":"db8bd485-b070-4370-813e-638fe4fd44f7"}; //, "vega":""
    var defaultScales = {"electron": "0.1", "falcon-9":"0.001", "vega":"0"};
    String _entryID = '6b973c24-23cf-4fca-894e-76f52e37500f';
    void onUnityCreated(controller) {
      this._unityWidgetController = controller;
      setScale("0", _entryID);
      print(vehicle);
      for(String v in vehicleCodes.keys){
        if(v == vehicle){
          setScale(defaultScales[v], vehicleCodes[v]);
          break;
        }else{
          setScale("0", vehicleCodes[v]);
        }
      }
    }


    void setScale(String scale, String vcode) {
    String url = 'https://console.echoar.xyz/post';
    print(scale);
    http.post(url, body: {
      'key': _projectKey,
      'entry': vcode,
      'data': 'scale',
      'value': scale,
    }).then((value) => print(value.body));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: WillPopScope(
          onWillPop: () {
            // Pop the category page if Android back button is pressed.
          },
          child: Container(
            color: Colors.yellow,
            child:UnityWidget(
                    onUnityViewCreated: onUnityCreated,
                    isARScene: true,
                  ),
            /*
            child: Stack(children: 
            <Widget>[
              UnityWidget(
                    onUnityViewCreated: onUnityCreated,
                    isARScene: true,
                  ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text("Model Scale:"),
                        ),
                        Slider(
                          onChanged: (value) {
                            setState(() {
                              _sliderValue = value;
                            });
                            setScale(value.toString());
                          },
                          value: _sliderValue,
                          min: 0.1,
                          max: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],),*/


          ),
        ),
      ),
    );
      // Callback that connects the created controller to the unity controller
  }

}