import 'package:AUIS_classroom/components/Dep.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final url = "http://192.168.1.9:8081/capstone/web/web-service.php?action=";

Future _send(String link) async {
  try {
    http.Response response = await http.get(link);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

Future getReviews(String courseId) {
  String link = url + 'getReviews&courseId=' + _fix(courseId);
  print(link);
  return _send(link);
}

Future getFav(String studentId) {
  String link = url + 'getFav&studentId=' + studentId;
  print(link);
  return _send(link);
}

void unmarkFav(String studentId, String courseId) {
  String link =
      url + 'unmarkFav&studentId=' + studentId + '&courseId=' + _fix(courseId);
  print(link);
  _send(link);
}

void markFav(String studentId, String courseId) {
  String link =
      url + 'markFav&studentId=' + studentId + '&courseId=' + _fix(courseId);
  print(link);
  _send(link);
}

Future getCourseDetail(String courseId) async {
  courseId = _fix(courseId);
  String link = url + 'getcoursedetail&id=' + courseId;
  print(link);
  return _send(link);
}

String _fix(String text) {
  List<String> id = text.split(" ");
  return id[0] + '%20' + id[1];
}

Future getCourseLecture(String courseId) async {
  String link = url + 'getcourselecture&courseId=' + _fix(courseId);
  print(link);
  return _send(link);
}

Future<dynamic> getCourses(Dep dep) async {
  String link = url + 'getcourses&dep=' + dep.toString();
  print(link);
  return _send(link);
}

void comment(String studentId, String courseId, String comment) {
  String link = url +
      'comment&studentId=' +
      studentId +
      '&courseId=' +
      _fix(courseId) +
      '&comment=' +
      comment;
  print(link);
  _send(link);
}

// change this method later
// use post and a different php file
Future<String> register(String id, String fname, String lname, String email,
    String password) async {
  String link = url +
      "register&id=" +
      id +
      "&fname=" +
      fname +
      "&lname=" +
      lname +
      "&email=" +
      email +
      "&password=" +
      password;
  print(link);
  return _send(link);
}

// change this method later
// use post and a different php file
Future login(String id, String password) async {
  String link = url + "login&id=" + id + "&password=" + password;
  print(link);
  try {
    http.Response response = await http.get(link);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
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
