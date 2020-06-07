
import 'package:SpaceLaunchNews/LaunchRequestAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RocketInfo {
  final String title;
  final String description;
  final Image thumbnail;
  List<dynamic> data;

  RocketInfo(this.title, this.description, this.thumbnail);
}
class RocketListPage extends StatelessWidget{
    Future<List> futureLaunch; 
  Size deviceSize;List<bool> numberTruthList = [true, true, true, true , true, true];

  List<RocketInfo> rocketList = [
    RocketInfo("\"Don't Stop Me Now\" (ELaNa 32)",'PLACEHOLDER',Image.asset('assets/dontstopmenow.png')),
    RocketInfo('Starlink-9','PLACEHOLDER',Image.asset('assets/starlink_patch-min.png')),
    RocketInfo("SSMS (POC)",'PLACEHOLDER',Image.asset('assets/arianespace-min2.png')),
    RocketInfo("Starlink-10",'PLACEHOLDER',Image.asset('assets/starlink_patch-min.png')),
    RocketInfo("GPS III SV03 (Columbus)",'PLACEHOLDER',Image.asset('assets/gps3.png'))

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
          title: Text('Rocket List',textAlign: TextAlign.center,style:TextStyle(fontFamily: 'Roboto')),
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
    body:              FutureBuilder<List>(
                future: futureLaunch,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
                    
                    for(var rocket in rocketList) {
                      if(snapshot.data[index]['name'] == rocket.title) {
                        rocket.data = snapshot.data[index];
                        return     Card(margin: EdgeInsets.all(4),
                          child: ListTile(
                            leading: rocket.thumbnail,
                            title: Text(snapshot.data[index]['name']),
                            subtitle: Text(rocket.description),
                            onTap: () {

                            })
                            );
                      }
                    }

                    return     Card(margin: EdgeInsets.all(4),
                          child: ListTile(
                            leading: FlutterLogo(size: 56.0),
                            title: Text(snapshot.data[index]['name']),
                            subtitle: Text(snapshot.data[index]['id'].toString()),
                            onTap: () {

                            })
                            );
                  }
                  );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  print(snapshot);
                  return Center(child:CircularProgressIndicator());
                },
              ),
      )]);

    
  }
  
  }