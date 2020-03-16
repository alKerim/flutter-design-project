import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class statisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      // dont need this appBar: AppBar(),
      body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 30),
            children: <Widget>[
              //Title of page
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 30.0),
                child: Text("Your personal Statistics",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),

              //first stats-item
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  //padding so content within box doesnt get to close to border
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Favourite Exercise",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: Expanded(
                            child: Image(
                            image: AssetImage("assets/images/random_statistics.PNG"),
                          ),)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("  over the course of last week",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50,),


              //second item in list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  //padding so content within box doesnt get to close to border
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Favourite Exercise",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                            child: Expanded(
                              child: Image(
                                image: AssetImage("assets/images/random_statistics.PNG"),
                              ),)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("  over the course of last week",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ))
    );
  }
}
