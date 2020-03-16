import 'package:flutter/material.dart';
import 'package:want_attention_app1/old/HistoryPage.dart';
import 'package:want_attention_app1/HistoryPageSliver.dart';
import 'package:want_attention_app1/old/StatsPage.dart';
import 'package:want_attention_app1/utils/database_helper.dart';

import 'ActionPage.dart';
import 'StatsPageSliver.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  //The controller of the horizontal swiper-view
  final _homeController = PageController(
    initialPage: 1,
  );

  DatabaseHelper helper = new DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return MaterialApp(
      title: 'Snapchat Layout Test',
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        //Horizontal swiper-view
        body: PageView(
          controller: _homeController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (int i){
          },
          children: <Widget>[
            Container(
              child: historyPageSliver(),
            ),
            Container(
              child: actionPage(),
            ),
            //vertical EXPLORE function , but does not work properly yet
            /*Container(
              child: PageView(
                controller: _homeController,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    ActionPage(),
                    Container(
                      //width: 300,
                      child: Center(child: Text("Explore"),),
                      color: Colors.purpleAccent,
                    ),
                  ],
              ),
            ),*/
            Container(
              child: statisticsPageSliver(),
            )
          ],
        ),
      ),
    );
  }
}


