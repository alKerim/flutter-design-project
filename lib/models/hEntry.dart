
class hEntry {

  int _id;
  String _name;
  String _date;
  String _duration;
  double _score;

  hEntry(this._name, this._date, this._duration, this._score); //for information:: hEntry(_name) : this._name = _name;

  hEntry.withId(this._id, this._name, this._date, this._duration, this._score);

  int get id => _id; //when "id" is called then "_id" is returned
  String get name => _name;
  String get date => _date;
  String get duration => _duration;
  double get score => _score;

  set name(String newName) {
    if(newName.length <= 255) {
      this._name = newName;
    }
  }

  set date(String newDate) {
    if(newDate.length <= 255) {
      this._date = newDate;
    }
  }

  set duration(String newDuration) {
    if(newDuration.length <= 255) {
      this._duration = newDuration;
    }
  }

  set score(double newScore) {
    if(newScore > 0.0 && newScore <= 10.0) {
      this._score = newScore;
    }
  }

  //Convert a hEntry object into a Map object... dynamic because we want to be flexible with the types
  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();
    if(id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['date'] = _date;
    map['duration'] = _duration;
    map['score'] = _score;

    return map;
  }

  //Extract a hEntry Object from a Map object
  hEntry.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._name= map['name'];
    this._duration = map['duration'];
    this._score = map['score'];
  }
}