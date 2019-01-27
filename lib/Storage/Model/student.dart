import 'package:firebase_database/firebase_database.dart';

class Student{
  String _id, _age;
  String _name;
  String _city;
  String _department;
  String _description;
  String _imageUrl;

  Student(this._id,this._name, this._age, this._city, this._department, this._description, this._imageUrl);

  Student.map(dynamic object){
    this._name=object['name'];
    this._age=object['age'];
    this._city=object['city'];
    this._department=object['department'];
    this._description=object['description'];
    this._imageUrl=object['imageUrl'];

  }
  String get getName{
    return this._name;
  }
  String get getCity{
    return this._city;
  }
  String get getDepartment{
    return this._department;
  }
  String get getDescription{
    return this._description;
  }

  String get getId{
    return this._id;
  }
  String get getAge{
    return this._age;
  }


  String get getImageUrl{
    return this._imageUrl;
  }


 // to retrive the data from firebase , we will do that as snapshot
Student. fromSnapshot(DataSnapshot myDataSnapShot){
   this._id= myDataSnapShot.key;
  this._name=myDataSnapShot.value['name'];
  this._age=myDataSnapShot.value['age'];
  this._city=myDataSnapShot.value['city'];
  this._department=myDataSnapShot.value['department'];
  this._description=myDataSnapShot.value['description'];
   this._imageUrl=myDataSnapShot.value['imageUrl'];
}

}