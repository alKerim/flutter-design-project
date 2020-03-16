import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class statisticsPageSliver extends StatefulWidget {
  @override
  _statisticsPageSliverState createState() => _statisticsPageSliverState();
}

class _statisticsPageSliverState extends State<statisticsPageSliver> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        backgroundColor: Colors.blueAccent,
        expandedHeight: 100.0,

        flexibleSpace: FlexibleSpaceBar(
          title: Text("You personal Statistics"),
        ),
      ),

      SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            //Constrained box sets the minimum height of background color for Container
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                maxWidth: double.infinity,
                minHeight: MediaQuery.of(context).size.height - 100,
                maxHeight: double.infinity,
              ),
              //container to set background color
              child: Container(
                color: Colors.blueAccent,
                alignment: Alignment.center,
                //column to organize kind of "list"
                child: Column(
                  children: <Widget>[
                    _buildStatsEntry("The developement over last week", "assets/images/random_statistics.PNG", "Your favourite exercise is benching"),
                    _buildStatsEntry("The developement over last week", "assets/images/random_statistics.PNG", "Your favourite exercise is benching"),
                    _buildStatsEntry("The developement over last week", "assets/images/random_statistics.PNG", "Your favourite exercise is benching"),
                    _buildStatsEntry("The developement over last week", "assets/images/random_statistics.PNG", "Your favourite exercise is benching"),
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

  Widget _buildStatsEntry(
      String statisticTitle, String imgPathStatistic, String conclusion) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
              Text(statisticTitle,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Container(
                  child: Expanded(
                    child: Image(
                      image: AssetImage(imgPathStatistic),
                    ),)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(conclusion,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


