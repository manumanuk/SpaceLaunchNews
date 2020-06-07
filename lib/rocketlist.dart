
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

  RocketInfo(this.title, this.description, this.thumbnail, {this.height, this.diameter, this.massKg});
}
class RocketListPage extends StatelessWidget{
    Future<List> futureLaunch; 
  Size deviceSize;

  List<RocketInfo> rocketList = [
    RocketInfo("\"Don't Stop Me Now\" (ELaNa 32)",'PLACEHOLDER',Image.asset('assets/dontstopmenow.png'),height:17,diameter: 1.2,massKg: 225),
    RocketInfo('Starlink-9','PLACEHOLDER',Image.asset('assets/starlink_patch-min.png'),height: 70.0,massKg: 25600,diameter: 5.7),
    RocketInfo("SSMS (POC)",'PLACEHOLDER',Image.asset('assets/arianespace-min2.png'),height:30,diameter:3.0,massKg:137000),
    RocketInfo("Starlink-10",'PLACEHOLDER',Image.asset('assets/starlink_patch-min.png'),height: 70.0,massKg: 25600,diameter: 5.7),
    RocketInfo("GPS III SV03 (Columbus)",'PLACEHOLDER',Image.asset('assets/gps3.png'),height: 70.0,massKg: 25600,diameter: 5.7)

  ];
  

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
                    
                    for(var rocket in rocketList) {
                      if(snapshot.data[index]['name'] == rocket.title) {
                        rocket.data = snapshot.data[index];
                        rocket.providerName = snapshot.data[index]['provider']['name'];
                        rocket.vehicleName =  snapshot.data[index]['vehicle']['name'];

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
                  // ignore the below card, this was the backup in case a rocket from the API is NOT matched to our local list, but idc
                  // it won't happen. hopefully not
                  //   return     Card(margin: EdgeInsets.symmetric(horizontal:4,vertical:5),
                  //         child: ListTile(contentPadding: EdgeInsets.symmetric(horizontal:0,vertical:5),
                  //           leading: FlutterLogo(size: 56.0),
                  //           title: Text(snapshot.data[index]['name']),
                  //           subtitle: Text(snapshot.data[index]['id'].toString()),
                  //           onTap: () {

                  //           })
                  //           );
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