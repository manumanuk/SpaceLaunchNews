
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class RocketListPage extends StatelessWidget{ 
  Size deviceSize;List<bool> numberTruthList = [true, true, true, true , true, true];

// Widget rocketList(BuildContext context) =>  {
  
// }

Widget appBarColumn(BuildContext context) => SafeArea(
      child:new Column(children:[Center(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), child: Text('Rocket List', textScaleFactor: 1.5, style: TextStyle(color: Colors.white),),))])      
        // child: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        //   child: new Column(
        //     children: <Widget>[
        //       new Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: <Widget>[
        //           new IconButton(
        //             icon: new Icon(
        //               defaultTargetPlatform == TargetPlatform.android
        //                   ? Icons.arrow_back
        //                   : Icons.arrow_back_ios,
        //               color: Colors.white,
        //             ),
        //             onPressed: () => Navigator.canPop(context)
        //                 ? Navigator.pop(context)
        //                 : null,
        //           ),
        //           new Center(child: new Text('Rocket List',textAlign: TextAlign.center,)
        //           // new ProfileTile(
        //           //   title: "Rocket List",
        //           //   subtitle: "",
        //           //   textColor: Colors.white,
        //           // ),

        //           ),],
        //       ),
        //     ],
        //   ),
        // ),
      );

    Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            appBarColumn(context),

            SizedBox(
              height: deviceSize.height * 0.01,
            ),
           Expanded(
          child: SizedBox(
            height: 200.0,
            child:rocketList(context))),
            // balanceCard(),

          ],
        ),
      );
 Widget _buildItemsForListView(BuildContext context, int index) {
      return Text('HI');
      // return ListTile(
      //   title:Text('hi',textScaleFactor: 2.5),
      //   // title: _newsArticles[index].urlToImage == null ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL) : Image.network(_newsArticles[index].urlToImage), 
      //   // subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
      // );
  }
Widget rocketList(BuildContext context) => 
  ListView.builder(
            itemCount: 6,
              itemBuilder: (context, i){
                if(numberTruthList[i]){
                  return ListTile(
                    title: Text("$i"),
                  );
                }
              },
  );
    
  @override
  Widget build(BuildContext context) {
  deviceSize = MediaQuery.of(context).size;
    
      return Stack(
      // fit: StackFit.expand,
      children:[Image.asset(
            'assets/rocket.JPG',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
      Scaffold(backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Rocket List',textAlign: TextAlign.center,style:TextStyle(fontFamily: 'Roboto'))
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
           return     Card(margin: EdgeInsets.all(4),
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text('Two-line ListTile'),
        subtitle: Text('Here is a second line'),
        // onTap: ,
       
      ),
    );
          }
            
          
        )
      )]);
    return Scaffold(
      // body: Stack(
      //   fit: StackFit.expand,
      //   children: <Widget>[
      //     LoginBackground(
      //       showIcon: false,
      //     ),
          
      //      allCards(context)
      //   ],
      // ),
    );
  }
  
  }