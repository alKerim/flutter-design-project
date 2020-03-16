import 'package:flutter/material.dart';
import 'package:want_attention_app1/old_input_Page.dart';
import 'package:want_attention_app1/old/justforTesting_storage.dart';

import 'package:want_attention_app1/utils/database_helper.dart';
import 'package:want_attention_app1/HistoryPageSliver.dart';

import 'models/hEntry.dart';

class actionPage extends StatefulWidget {
  @override
  _actionPageState createState() => _actionPageState();
}

class _actionPageState extends State<actionPage> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  final buttonImage = new AssetImage("assets/images/lion_face.jpg");

  final buttonImage2 = new NetworkImage(
      "http://logok.org/wp-content/uploads/2014/05/Total-logo-earth.png");

  final actionController = new PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,

      //Beginning with an AppBar, for access setting from main screen
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        leading: SizedBox(
          width: 400,
        ),
        //title: new Text("MainPage", style: TextStyle(color: Colors.white, fontSize: 20.0),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              //open new page with settings
            },
          ),
        ],
      ),

      //the circle actionbutton will be in center
      body: Center(
          // in container verpacken und größe festlegen
          child: ClipOval(
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          height: MediaQuery.of(context).size.width - 30,

          //Box ist ein Kreis
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: buttonImage,
            ),
            shape: BoxShape.circle,
            border: Border.all(
                style: BorderStyle.solid, color: Colors.white, width: 4.0),
          ),
          child: FlatButton(
            padding: EdgeInsets.all((0.0)),

            //Function of the button
            onPressed: () {
              debugPrint("Action Button clicked");
              return navigateToDetail(hEntry('','','', 2.0), "New Action");
            },
            child: null,
          ),
        ),
      )),
    );
  }

  void navigateToDetail(hEntry specificEntry, String title) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return inputPage(specificEntry, title);
    }));
    
  }

}

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Input Info'),
        ),
        body: const Center(
          child: Text(
            'This is the input Info page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    },
  ));
}
