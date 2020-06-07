
import 'package:SpaceLaunchNews/LaunchRequestAPI.dart';
import 'package:SpaceLaunchNews/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RocketInfo {
  String title;
  String description;
  Image thumbnail;
  dynamic data = [];
  String vehicleName;
  String providerName;
  // all in metric because I'm not an animal.
  double height;
  double diameter;
  double massKg;
  double payloadKg;
  String reusability;
  double seaThrust;
  double vaccuumThrust;
  double cost;


  RocketInfo({this.title, this.description, this.thumbnail, this.height, this.diameter, this.massKg, this.payloadKg, this.reusability, this.seaThrust, this.vaccuumThrust, this.cost});
}
class RocketListPage extends StatelessWidget{
    Future<List> futureLaunch; 
    Size deviceSize;
    var imageKeys = {"electron": "dontstopmenow.png", "falcon-9":"starlink_patch-min.png", "vega": "arianespace-min2.png", "default":"default.png"};
    var specsKeys = {"electron": {"height":17.0,"diameter": 1.2,"massKg": 225.0,"payloadKg": 225.0, "reusability": 'First stage', "seaThrust": 162.0, "vaccuumThrust": 192.0, "cost": 6.0}, 
                    "falcon-9":{"height": 70.0,"diameter": 5.7, "massKg": 25600.0, "payloadKg": 22800.0, "reusability": 'First stage, fairings', "seaThrust": 845.0, "vaccuumThrust": 981.0, "cost": 62.0}, 
                    "vega": {"height":30.0,"diameter":3.0,"massKg":137000.0, "payloadKg": 1500.0, "reusability": 'None', "seaThrust": 2261.0, "vaccuumThrust": 260.0, "cost": 37.0}, 
                    "default":{"height":0.0,"diameter":0.0,"massKg":0.0, "payloadKg": 0.0, "reusability": 'No Data', "seaThrust": 0.0, "vaccuumThrust": 0.0, "cost": 0.0}
                    };
    List<RocketInfo> rocketList = new List();
  

// Widget rocketList(BuildContext context) =>  {
  
// }

Widget appBarColumn(BuildContext context) => SafeArea(
      child:new Column(children:[Center(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), child: Text('Rocket List', textScaleFactor: 1.5, style: TextStyle(color: Colors.white),),))])      

      );

    // Widget allCards(BuildContext context) => SingleChildScrollView(
    //     child: Column(
    //       children: <Widget>[
    //         appBarColumn(context),

    //         SizedBox(
    //           height: deviceSize.height * 0.01,
    //         ),
    //        Expanded(
    //       child: SizedBox(
    //         height: 200.0,
    //         child:rocketList(context))),
    //         // balanceCard(),

    //       ],
    //     ),
    //   );
 Widget _buildItemsForListView(BuildContext context, int index) {
      return Text('HI');
      // return ListTile(
      //   title:Text('hi',textScaleFactor: 2.5),
      //   // title: _newsArticles[index].urlToImage == null ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL) : Image.network(_newsArticles[index].urlToImage), 
      //   // subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
      // );
  }

  @override
  Widget build(BuildContext context) {
    futureLaunch = fetchLaunch();
  deviceSize = MediaQuery.of(context).size;
    
      return Stack(
      // fit: StackFit.expand,
      children:[
        // Image.asset(
        //     'assets/rocket.JPG',
        //     height: MediaQuery.of(context).size.height,
        //     width: MediaQuery.of(context).size.width,
        //     fit: BoxFit.cover,
        //   ),
      Scaffold(backgroundColor: Color.fromRGBO(0,7, 45, 1.0),
        appBar: AppBar( backgroundColor: Color.fromRGBO(0,7, 45, 1.0),
          title: Text('Rocket Launches List',textAlign: TextAlign.center,style:TextStyle(fontFamily: 'Roboto')),
        ),
    //     body: ListView.builder(
    //       itemCount: 5,
    //       itemBuilder: (context, index) {
    //        return     Card(margin: EdgeInsets.all(4),
    //             child: ListTile(
    //               leading: FlutterLogo(size: 56.0),
    //               title: Text('Two-line ListTile'),
    //               subtitle: Text('Here is a second line'),
    //               onTap: () {

    //               },
    //     // onTap: ,
       
    //   ),
    // );
    //       }  
    //     )
    body: new Center(child:FutureBuilder<List>(
                future: futureLaunch,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
                    for( var i = 0 ; i < snapshot.data.length; i++) {
                        RocketInfo rocket = new RocketInfo();
                        rocket.data = snapshot.data[index];
                        rocket.providerName = snapshot.data[index]['provider']['name'];
                        rocket.vehicleName =  snapshot.data[index]['vehicle']['name'];
                        rocket.title = snapshot.data[index]['name'];
                        rocket.description = snapshot.data[index]['launch_description'];
                        String tSlug = snapshot.data[index]['vehicle']['slug'];
                        if(imageKeys.containsKey(tSlug)){
                          String r = imageKeys[tSlug];
                          rocket.thumbnail = Image.asset('assets/$r');
                          rocket.height = specsKeys[tSlug]['height'];
                          rocket.diameter = specsKeys[tSlug]['diameter'];
                          rocket.massKg = specsKeys[tSlug]['massKg'];
                          rocket.payloadKg = specsKeys[tSlug]['payloadKg'];
                          rocket.reusability = specsKeys[tSlug]['reusability'];
                          rocket.seaThrust = specsKeys[tSlug]['seaThrust'];
                          rocket.vaccuumThrust = specsKeys[tSlug]['vaccuumThrust'];
                          rocket.cost = specsKeys[tSlug]['cost'];
                        }else{
                          String r = imageKeys['default'];
                          rocket.thumbnail = Image.asset('assets/$r');
                          rocket.height = specsKeys[tSlug]['height'];
                          rocket.diameter = specsKeys[tSlug]['diameter'];
                          rocket.massKg = specsKeys[tSlug]['massKg'];
                          rocket.payloadKg = specsKeys[tSlug]['payloadKg'];
                          rocket.reusability = specsKeys[tSlug]['reusability'];
                          rocket.seaThrust = specsKeys[tSlug]['seaThrust'];
                          rocket.vaccuumThrust = specsKeys[tSlug]['vaccuumThrust'];
                          rocket.cost = specsKeys[tSlug]['cost'];
                          }
                        rocketList.add(rocket);

                        return     Card(margin: EdgeInsets.symmetric(horizontal:20,vertical:10),
                          child: ListTile(contentPadding: EdgeInsets.symmetric(horizontal:16,vertical:8),
                            leading: rocket.thumbnail,
                            title: Text(snapshot.data[index]['name']),
                            subtitle: Text( snapshot.data[index]['provider']['name']+' — '+snapshot.data[index]['vehicle']['name']),
                            onTap: () {
                                Navigator.push(context,routeToDetails(index));
                            })
                            );
                      }
                    }
                  );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  print(snapshot);
                  return Center(child:CircularProgressIndicator());
                },
              ),)
      )]);

    
  }
  Route routeToDetails(index) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>DetailsPage(title:rocketList[index].vehicleName, rocketData: rocketList[index]),
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