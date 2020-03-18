import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';

class AddCourseScreen extends StatelessWidget {
  static const String id = '/AddCourse';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text("Add a new course"),
        ),
      ),
    );
  }
}
