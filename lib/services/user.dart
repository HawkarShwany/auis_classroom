import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  String id ;
  String fname ;
  String lname ;
  String email;
  String password ;
  bool isAdmin;

  void setId(String id) {
    this.id = id;
    print(id);
    notifyListeners();
  }

  void setFname(String fname) {
    this.fname = fname;
    print(this.fname);
    notifyListeners();
  }

  void setLname(String lname) {
    this.lname = lname;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }
  void admin(bool isAdmin){
    this.isAdmin = isAdmin;
  }

}
