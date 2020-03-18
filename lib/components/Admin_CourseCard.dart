import 'package:AUIS_classroom/screens/Admin_Course.dart';
import 'package:AUIS_classroom/screens/Course.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:provider/provider.dart';

class AdminCourseCard extends StatefulWidget {
  AdminCourseCard({this.courseID, this.courseTitle});
  String courseID;
  String courseTitle;

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<AdminCourseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: KSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.courseID,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.courseTitle,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: () async {
              // use the courseID
              String courseId = widget.courseID;
              var details = await Network.getCourseDetail(courseId);
              var lectures = await Network.getCourseLecture(courseId);
              var reviews = await Network.getReviews(courseId);
              // Navigator.pushNamed(context, CourseScreen.id, arguments: CourseScreen(response));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminCourseScreen(
                    details: details,
                    lectures: lectures,
                    // files: ,
                    reviews: reviews,
                  ),
                ),
              );
            },
            child: Text(
              "Edit",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}