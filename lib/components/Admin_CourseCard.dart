import 'package:AUIS_classroom/screens/Admin_Course.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

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
        color: KPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: kShadow
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.courseID,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 24,
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
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: () async {
              // use the courseID
              var details = await Network.getCourseDetail(widget.courseID);
              var lectures = await Network.getCourseLecture(widget.courseID);
              var files = await Network.getFiles(widget.courseID);
              var reviews = await Network.getReviews(widget.courseID);
              var insights = await Network.getInsights(widget.courseID);

              Navigator.pushNamed(context, AdminCourseScreen.id, arguments: [
                widget.courseID,
                details,
                lectures,
                files,
                reviews,
                insights,
              ]);
            },
            child: Text(
              "Edit",
              style: KPillTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
