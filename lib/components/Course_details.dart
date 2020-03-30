import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;

class Details extends StatelessWidget {
  Details(this.courseId);
  final courseId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Network.getCourseDetail(courseId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var pre = snapshot.data['PrerequisiteCourseId'] == null? 'none': snapshot.data['PrerequisiteCourseId'];
          return Container(
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: KSecondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    snapshot.data['CourseId'],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data['CourseName'],
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Number of credits: " + snapshot.data['Credits'],
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
                    snapshot.data['Discription'],
                    style: TextStyle(height: 1.5),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
