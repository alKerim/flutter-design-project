import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';

//still not edited that much here

class historyPageSliver extends StatefulWidget {
  @override
  _historyPageSliverState createState() => _historyPageSliverState();
}

class _historyPageSliverState extends State<historyPageSliver> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.orangeAccent,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("History"),
            ),
          ),

          //The 'body' of the sliver list part
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                //Constrained box sets the minimum height of background color for Container
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    maxWidth: double.infinity,
                    minHeight: MediaQuery.of(context).size.height - 100.0,
                    maxHeight: double.infinity,
                  ),
                  //container to set background color
                  child: Container(
                    color: Colors.orangeAccent,
                    alignment: Alignment.topCenter,
                    //column to organize kind of "list"
                    child: Column(
                      children: <Widget>[
                        historyEntry("Yesterday", "1 hour", "7.5", "Lisa"),
                        historyEntry("Yesterday", "1 hour", "7.5", "Marina"),
                        historyEntry("Yesterday", "1 hour", "7.5", "Clara"),
                        historyEntry("Yesterday", "1 hour", "7.5", "Marissa"),

                      ],
                    ),

                  ),
                );
              },
              //the count of the amount of "Objects" in list... in this case x times the number of items in the column-widget above
              childCount: 1,
            ),
          ),


        ]);
  }




  //not needed for now... only backend
  Widget historyEntry(
      String date, String duration, String score, String person) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Container(
        //the boxdec. gives the entry its round shape
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            color: Colors.white,
            //the shadow for each entry element
            boxShadow: [ new BoxShadow(
                color: Colors.grey,
                blurRadius: 6.0,
                offset: Offset(-3.0, 3.0)

            )]
        ),
        //makes a listTile which is also 'clickable'
        child: ListTile(

          leading: CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.keyboard_arrow_right),
          ),

          title: Text(date, style: TextStyle(fontWeight: FontWeight.bold),),

          subtitle: Text(person),

          trailing: Icon(Icons.delete, color: Colors.grey,),

          //when history entry is tapped
          onTap: () {
            debugPrint("historyEntry Tapped");
            //navigateToDetail('Edit Note');
          },

        ),
      ),
    );
  }

}


