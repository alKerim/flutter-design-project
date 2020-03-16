import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:want_attention_app1/models/hEntry.dart';
import 'package:want_attention_app1/screens/old_input_Page.dart';

import 'package:want_attention_app1/utils/database_helper.dart';
//import 'package:want_attention_app1/screens/HistoryPageSliver.dart';

class historyPageSliver extends StatefulWidget {
  PageStorageKey pageStorageKey;

  //historyPageSliver(this.pageStorageKey);

  @override
  _historyPageSliverState createState() => _historyPageSliverState();
}



class _historyPageSliverState extends State<historyPageSliver> with AutomaticKeepAliveClientMixin {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<hEntry> hEntryList;
  int count = 0;

  bool get wantKeepAlive{
    return true;
  }

  @override


  Widget build(BuildContext context) {
    super.build(context);
    if (hEntryList == null) {
      hEntryList = List<hEntry>();
      updateListView();
    }
    //wrapped customscrollview with container to set a background color
    return Container(
      color: Colors.orangeAccent,
      child: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.orangeAccent,
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("History"),

          ),
          leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              //databaseHelper = DatabaseHelper();
              updateListView();
            },
          ),
        ),

        //The 'body' of the sliver list part
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              //Constrained box sets the minimum height of background color for Container
              return Container(
                    //color: Colors.orangeAccent,
                    alignment: Alignment.topCenter,
                    child: historyEntry(
                        index, //the index is passed because the historyEntry-widget can't access the index
                        this.hEntryList[index].date,
                        this.hEntryList[index].duration,
                        this.hEntryList[index].score,
                        this.hEntryList[index].name),
              );
            },
            //the count of the amount of "Objects" in list... in this case x times the number of items in the column-widget above
            childCount: count,
          ),
        ),
      ]),
    );
  }

  void _delete(BuildContext context, hEntry entry) async {
    int result = await databaseHelper.deleteHEntry(entry.id);
    if (result != 0) {
      _showSnackBar(context, 'Note deleted successfully');
      //update list view
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Color getScoreColor(double score) {
    // double s = double.parse(score);
    if (score <= 5.0) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  void navigateToDetail(hEntry specificEntry, String title) async{
    int result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return inputPage(specificEntry, title);
    }
    ));
    if(result == true) {
      updateListView();
    }
  }

  Widget historyEntry(
      int index, String date, String duration, double score, String person) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Container(
        //the boxdec. gives the entry its round shape
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            color: Colors.white,
            //the shadow for each entry element
            boxShadow: [
              new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 6.0,
                  offset: Offset(-3.0, 3.0))
            ]),
        //makes a listTile which is also 'clickable'
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: getScoreColor(score),
            //score is still a string will be changed in future to double
            child: Icon(Icons.keyboard_arrow_right),
          ),

          title: Text(
            date,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          subtitle: Text(person),

          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.grey,
            onPressed: () {
              debugPrint("delete Entry Pressed");
            },
          ),

          //when history entry is tapped
          onTap: () {
            debugPrint("historyEntry Tapped");
            navigateToDetail(this.hEntryList[index],"Edit Action");
            //navigateToDetail('Edit Note');
          },
        ),
      ),
    );
  }




  void updateListView(){
    databaseHelper = new DatabaseHelper();
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase(); //NULL pointer exception !!!!! find error
    dbFuture.then((database) {
      Future<List<hEntry>> hEntryListFuture = databaseHelper.getHEntryList();
      hEntryListFuture.then((hEntryList){
        //now updating UI through setting the new state
        setState(() {
          this.hEntryList = hEntryList;
          this.count = hEntryList.length;
        });
      });
    });
  }






  Widget _buildHistoryEntry(
      String date, String duration, String score, String person) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              color: Colors.white,
              //the shadow for each entry element
              boxShadow: [
                new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6.0,
                    offset: Offset(-3.0, 3.0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                height: 10.0,
              ),
            ],
          )),
    );
  }
}
