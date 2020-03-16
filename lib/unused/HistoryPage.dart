import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class historyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //height: MediaQuery.of(context).size.height - 30,
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0.0,
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.white,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
          child: ListView(
            children: <Widget>[
              _buildHistoryEntry("Yesterday", "30 min", "9.4", "Push-ups"),
              _buildHistoryEntry("Wednesday", "30 min", "9.2", "Burpees"),
              _buildHistoryEntry("Wednesday", "30 min", "9.4", "Push-ups"),
              _buildHistoryEntry("Wednesday", "30 min", "9.2", "Burpees"),
              _buildHistoryEntry("Wednesday", "30 min", "9.4", "Push-ups"),
              _buildHistoryEntry("Wednesday", "30 min", "9.2", "Burpees"),
              _buildHistoryEntry("Wednesday", "30 min", "9.4", "Push-ups"),
              _buildHistoryEntry("Wednesday", "30 min", "9.2", "Burpees"),
              _buildHistoryEntry("Wednesday", "30 min", "9.2", "Burpees"),
              _buildHistoryEntry("Wednesday", "30 min", "9.4", "Push-ups"),
              _buildHistoryEntry("Wednesday", "30 min", "9.2", "Burpees"),
              _buildHistoryEntry("Wednesday", "30 min", "9.2", "Burpees"),
              _buildHistoryEntry("Wednesday", "30 min", "9.4", "Push-ups"),
              _buildHistoryEntry("Wednesday", "30 min", "9.2", "Burpees"),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryEntry(
      String date, String duration, String score, String person) {
    return Container(

        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    date,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    duration,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    person,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    score,
                    style: TextStyle(),
                  ),
                ],
              ),

            ],
          ),

            SizedBox(height: 8.0,),

            Container(
              height: 1.0,
              color: Colors.grey,
            )
          ],
        )
        );
  }
}
