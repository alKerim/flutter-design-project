import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:want_attention_app1/models/hEntry.dart';
import 'package:want_attention_app1/utils/database_helper.dart';

//import 'package:flutter_picker/flutter_picker.dart';

//import 'dart:developer';

class inputPage extends StatefulWidget {
  final String appBarTitle;
  hEntry hentry;

  inputPage(this.hentry, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return inputPageState(this.hentry, this.appBarTitle);
  }
}

class inputPageState extends State<inputPage> {
  static var _score = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', ];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  hEntry hentry;

  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  inputPageState(this.hentry, this.appBarTitle);


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    nameController.text = hentry.name;
    dateController.text = hentry.date;
    durationController.text = hentry.duration;




    return WillPopScope(
      onWillPop: () {
        // Write some code to control things, when user press Back navigation button in device navigationBar
        moveToLastScreen();
      },



      child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }
            ),
          ),

          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[

                // First element: name
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: nameController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateName();
                    },
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                // Second Element: date
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: dateController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateDate();
                    },
                    decoration: InputDecoration(
                        labelText: 'Date (DD.MM.JJJJ)',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                // Third Element: duration
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: durationController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateDuration();
                    },
                    decoration: InputDecoration(
                        labelText: 'Duration (min)',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                //Fourth element: score
                ListTile(
                  title: DropdownButton(
                      items: _score.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),

                      style: textStyle,

                      value: getScoreAsString(hentry.score),

                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint('User selected $valueSelectedByUser');
                          updateScoreAsDouble(valueSelectedByUser);
                        });
                      }
                  ),
                ),

                // Fifth Element: save, delete buttons
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme
                              .of(context)
                              .primaryColorDark,
                          textColor: Theme
                              .of(context)
                              .primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();

                            });
                          },
                        ),
                      ),

                      Container(width: 5.0,),

                      Expanded(
                        child: RaisedButton(
                          color: Theme
                              .of(context)
                              .primaryColorDark,
                          textColor: Theme
                              .of(context)
                              .primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),

        )
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  //Convert String score into a double(type) before saving it to database
  void updateScoreAsDouble(String value){
    double d = double.parse(value);
    hentry.score = d;
  }

  //Convert double score to String score and display it to user DropDown
  String getScoreAsString(double value){
    String score;

    //this all to convert from double to int in order to use the "array"
    int pos(v) {
      double multiplier = .5;
      int k =  (multiplier * v).round();
      return k;
    }
    int k = pos(value) - 1;

    score = _score[k];
    return score;
  }

  //Update the name of hEntry object
  void updateName(){
    hentry.name = nameController.text;
  }

  //update the date of hEntry object
  void updateDate(){
    hentry.date = dateController.text;
  }

  //update the duration of hEntry object
  void updateDuration(){
    hentry.duration = durationController.text;
  }


  void _delete() async {

    moveToLastScreen();

    //Case 1: îf user is trying to delete the New Note i.e. he has come
    //to the detail page by pressing Action button of inputPage.
    if(hentry.id == null){
      _showAlertDialog('Status', 'No hEntry was deleted');
      return;
    }

    //Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteHEntry(hentry.id);
    if(result != 0) { //success
      _showAlertDialog('Status', 'Note Deleted Successfully');
    }
    else{
      _showAlertDialog('Status', 'Error occured while deleting note');
    }
  }


  //save data to database
  void _save() async {

    moveToLastScreen();

    //the line below would set the string date to the current date in dateformat
    //hentry.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    //case 1: update operation
    if(hentry.id != null){
      result = await helper.updateHEntry(hentry);
    }
    //case 2: insert operation
    else {
      result = await helper.insertHEntry(hentry);
      //debugger();
    }

    if(result != 0) { //success
      _showAlertDialog('Status', 'Note Saved Successfully');
    }
    else{
      _showAlertDialog('Status', 'Problem saving note');
    }
  }

  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }

}
