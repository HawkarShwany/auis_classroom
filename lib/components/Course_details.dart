import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  Details(
    this.details,
    this.courseId,
  );
  final details;
  final courseId;

  @override
  Widget build(BuildContext context) {
    var pre = details['PrerequisiteCourseId'] == null
        ? 'none'
        : details['PrerequisiteCourseId'];
    return Container(
      width: 500,
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: kShadow
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              details['CourseId'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              details['CourseName'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Number of credits: " + details['Credits'],
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Prerequisites: " + pre,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Description",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              details['Discription'],
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
