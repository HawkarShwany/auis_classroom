import 'dart:io';

import 'package:AUIS_classroom/components/Dep.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final getUrl = "http://192.168.1.9:8081/capstone/web/web-service.php?action=";
final postUrl = "http://192.168.1.9:8081/capstone/web/login.php";

// add socketExeption

Future _send(String link) async {
  print('from network: ' + link);
  try {
    http.Response response = await http.get(link);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      print(response.statusCode);
    }
  } catch (e) {
      AlertDialog();
    
    print(e);
  }
}

Future getInsights(String courseId){
  String link = getUrl + 'getInsights&courseId='+ _fix(courseId);
  return _send(link);
}

Future downVote(String fileId, String studentId){
  String link = getUrl + 'downvote&fileId=' + fileId+'&studentId='+studentId;
  return _send(link);
}

Future upVote(String fileId, String studentId){
  String link = getUrl + 'upvote&fileId=' + fileId+'&studentId='+studentId;
  return _send(link);
}

Future rateCourse(String studentId, String courseId, String rate){
  String link = getUrl + 'rateCourse&studentId=' + studentId + '&courseId=' + _fix(courseId) + '&rate='+ rate;
  return _send(link);
}

Future searchCourse(String keyWord){
  String link = getUrl + 'searchCourse&keyword='+ _fix(keyWord);
  return _send(link);
}

Future deleteCourse(String courseId){
  String link = getUrl + 'deleteCourse&courseId=' + _fix(courseId);
  return _send(link);
}

Future updateCourse(
    {@required String originalCourseId,
    @required String newCourseId,
    @required String courseTitle,
    @required String courseDesc,
    @required String prerequisites,
    @required String department,
    @required int credits}) {
  String link = getUrl +
      'updateCourse&originalCourseId=' +
      _fix(originalCourseId) +
      '&courseId=' +
      _fix(newCourseId) +
      '&courseTitle=' +
      _fix(courseTitle) +
      '&courseDesc=' +
      _fix(courseDesc) +
      '&department=' +
      department +
      '&pre=' +
      _fix(prerequisites) +
      '&credits=' +
      credits.toString();
  return _send(link);
}

Future addCourse(
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
      '&pre=' +
      _fix(prerequisites) +
      '&credits=' +
      credits.toString();
  print(courseDesc);
  return _send(link);
}

Future deleteFile(String id) {
  String link = getUrl + 'deleteFile&id=' + id;
  print(link);
  return _send(link);
}

Future getFiles(String courseId) {
  String link = getUrl + 'getFiles&courseId=' + _fix(courseId);
  return _send(link);
}

Future<File> downloadFile(String fileId)async{
  Directory appDocDir = await getApplicationDocumentsDirectory();
String appDocPath = appDocDir.path;
  File file;
  try {
    http.Response response = await http.post(
      "http://192.168.1.9:8081/capstone/web/upload.php",
      body: {
        'action': 'downloadFile',
        'id': fileId,
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
       file = File(appDocPath+ data['name'].toString());
      file.writeAsBytesSync(base64Decode(data['file'].toString()));
     return file;
    } else {
      print("bad response:       " + response.statusCode.toString());
      return file;
    }
  } catch (e) {
    print("Error: "+ e.toString());
    return file;
  }
}

Future addFile(File file, String courseId) async {
  String filename= file.path.split('/').last;
  String filetype = filename.split('.').last;
  try {
    String fileString = base64Encode(file.readAsBytesSync());
    print('trying............');
    http.Response response = await http.post(
      "http://192.168.1.9:8081/capstone/web/upload.php",
      body: {
        'action': 'uploadFile',
        'file': fileString,
        'name': filename,
        'type': filetype,
        'courseId': courseId
      },
    );
    print('somting going on');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(" file response:     " + data.toString());
      return data;
    } else {
      print("bad response:       " + response.statusCode.toString());
    }
  } catch (e) {
    print('error : ' + e.toString());
    return {"response": "error file was not uploaded"};
  }
}

void addYouTubeVideo(String title, String url, String courseId) {
  String link = getUrl +
      'addVideo&title=' +
      title +
      '&url=' +
      url +
      '&courseId=' +
      courseId +
      '&type=video';
  _send(link);
}

void deleteVideo(dynamic videoId) {
  String link = getUrl + 'deleteVideo&id=' + videoId.toString();
  _send(link);
}

Future deleteReivew(dynamic reviewId) {
  String link = getUrl + 'deleteReview&id=' + reviewId.toString();
  return _send(link);
}

Future deleteComment(dynamic commentId) {
  String link = getUrl + 'deleteComment&id=' + commentId.toString();
  return _send(link);
}

Future review(String review, String courseId, String studentId) {
  String link = getUrl +
      'review&studentId=' +
      studentId +
      '&courseId=' +
      _fix(courseId) +
      '&review=' +
      review;
  return _send(link);
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
  
  return response;
}

Future comment(String studentId, String courseId, String comment) {
  String link = getUrl +
      'comment&studentId=' +
      studentId +
      '&courseId=' +
      _fix(courseId) +
      '&comment=' +
      comment;
  return _send(link);
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
