import 'package:AUIS_classroom/components/Dep.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final getUrl = "http://192.168.1.9:8081/capstone/web/web-service.php?action=";
final postUrl = "http://192.168.1.9:8081/capstone/web/login.php";

// add socketExeption

Future _send(String link) async {
  print('from network: ' + link);
  try {
    http.Response response = await http.get(link);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print( "frome network: "+data['data'].toString());
      // print('data from network: '+data.toString());
      return data;
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

void addCourse(
    {@required String courseId,
    @required String courseTitle,
    @required String courseDesc,
    @required String prerequisites,
    @required String department,
    @required int credits}) {
  String link = getUrl +
      'addCourse&courseId=' +
      _fix(courseId) +
      '&courseTitle=' +
      _fix(courseTitle) +
      '&courseDesc=' +
      _fix(courseDesc) +
      '&department=' +
      department +
      '&pre='+ _fix(prerequisites)+
      '&credits=' +
      credits.toString();
  print(courseDesc);
  _send(link);
}

void review(String review, String courseId, String studentId) {
  String link = getUrl +
      'review&studentId=' +
      studentId +
      '&courseId=' +
      _fix(courseId) +
      '&review=' +
      review;
  _send(link);
}

Future getReviews(String courseId) {
  String link = getUrl + 'getReviews&courseId=' + _fix(courseId);
  return _send(link);
}

Future getFav(String studentId) {
  String link = getUrl + 'getFav&studentId=' + studentId;
  return _send(link);
}

void unmarkFav(String studentId, String courseId) {
  String link = getUrl +
      'unmarkFav&studentId=' +
      studentId +
      '&courseId=' +
      _fix(courseId);
  _send(link);
}

void markFav(String studentId, String courseId) {
  String link =
      getUrl + 'markFav&studentId=' + studentId + '&courseId=' + _fix(courseId);
  _send(link);
}

Future getCourseDetail(String courseId) async {
  courseId = _fix(courseId);
  String link = getUrl + 'getcoursedetail&id=' + courseId;
  return _send(link);
}

String _fix(String text) {
  String fixedText = '';
  if (text != null) {
    List<String> strings = text.split(" ");

    for (var i = 0; i < strings.length; i++) {
      fixedText += strings[i];
      fixedText += '%20';
    }
    return fixedText;
  }

  return null;
}

Future getCourseLecture(String courseId) async {
  String link = getUrl + 'getcourselecture&courseId=' + _fix(courseId);
  return _send(link);
}

Future getCourses(Dep dep) async {
  String link = getUrl + 'getcourses&dep=' + dep.toString();
  var response = await _send(link);
  // print("from getcourses network: "+response.toString());
  return response;
}

void comment(String studentId, String courseId, String comment) {
  String link = getUrl +
      'comment&studentId=' +
      studentId +
      '&courseId=' +
      _fix(courseId) +
      '&comment=' +
      comment;
  _send(link);
}

Future register(String id, String fname, String lname, String email,
    String password) async {
  try {
    http.Response response = await http.post(postUrl, body: {
      'action': 'studentregister',
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'password': password,
    });
    print("from network: " + response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print("from network: " + data.toString());
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  } catch (e) {
    return e;
  }
}

Future adminLogin(String email, String password) async {
  try {
    http.Response response = await http.post(postUrl, body: {
      'action': 'adminlogin',
      'email': email,
      'password': password,
    });
    print("from network 1: " + response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print("from network 2: " + data.toString());
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  } catch (e) {
    print(e.toString());
    return {
      "data": "incorrect",
      "id": 321,
      "fname": "noone",
      "lname": "shwany",
      "email": "@auis.edu.krd"
    };
  }
}

Future login(String id, String password) async {
  try {
    http.Response response = await http.post(postUrl, body: {
      'action': 'studentlogin',
      'id': id,
      'password': password,
    });
    print("from network: " + response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print("from network: " + data.toString());
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  } catch (e) {
    print("something weng wrong:" + e.toString());

    return {
      "data": "incorrect",
      "id": 321,
      "fname": "noone",
      "lname": "shwany",
      "email": "@auis.edu.krd"
    };
  }
}
