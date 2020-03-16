import 'dart:io';
//import 'package:async/async.dart';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class inputStoragePage extends StatefulWidget {
  //local temporary storage
  final Storage storage;

  //constructor requires a storage when called
  inputStoragePage({Key key, @required this.storage}) : super();

  @override
  inputTestState createState() => inputTestState();
}

//state is instantiated
class inputTestState extends State<inputStoragePage> {
  TextEditingController controller = TextEditingController();
  String state; //local string that holds temporary storage in form of a String
  Future<Directory> _appDocDir; //holds directory path so later be able to display it

  @override
  void initState() {
    super.initState();
    //access storage and then able to read
    widget.storage.readData().then((String value) {
      //value is the current String in the storage
      setState(() {
        state = value; //we set the local string to the just updated Storage
      });
    });
  }

  //method writeData in State-class
  Future<File> writeData() async {
    setState(() {
      state = controller.text;
      controller.text = '';
    });

    return widget.storage.writeData(state);
  }

  void getAppDirectory(){
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reading and Writing Files'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${state ?? "File is Empty"}'),
              SizedBox(height: 5.0, child: Container(color: Colors.black,),),
              TextField(style: TextStyle(backgroundColor: Colors.grey),
                controller: controller,
              ),
              RaisedButton(
                onPressed: writeData,
                child: Text('Write to File'),
              ),
              RaisedButton(
                child: Text("Get DIR path"),
                onPressed: getAppDirectory,
              ),
              FutureBuilder<Directory>(
                future: _appDocDir,
                builder:
                    (BuildContext context, AsyncSnapshot<Directory> snapshot) {
                  Text text = Text('');
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      text = Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      text = Text('Path: ${snapshot.data.path}');
                    } else {
                      text = Text('Unavailable');
                    }
                  }
                  return new Container(
                    child: text,
                  );
                },
              )
            ],
          ),
        ));
  }
}

class Storage {

  //get the local path
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  //get local File
  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  //get read the file
  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  //Write data (put in String and return file)
  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString(data);
  }
}
