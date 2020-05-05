import 'package:AUIS_classroom/components/Admin_CourseDetails.dart';
import 'package:AUIS_classroom/components/Admin_CourseFiles.dart';
import 'package:AUIS_classroom/components/Admin_CourseLectures.dart';
import 'package:AUIS_classroom/components/Admin_CourseReview.dart';
import 'package:AUIS_classroom/components/Insights.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

class AdminCourseScreen extends StatefulWidget {
  static const String id = '/AdminCourse';
  final courseId;
  final details;
  final lectures;
  final files;
  final reviews;
  final insights;

  AdminCourseScreen(
      {@required this.courseId,
      @required this.details,
      @required this.lectures,
      @required this.files,
      @required this.reviews,
      @required this.insights});
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<AdminCourseScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //   [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]
    // );
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(widget.courseId),
          bottom: TabBar(
              // isScrollable: true,
              labelColor: KBlue,
              unselectedLabelColor: Colors.black,
              indicatorColor: KBlue,
              indicatorSize: TabBarIndicatorSize.label,
              dragStartBehavior: DragStartBehavior.start,
              tabs: [
                Icon(Icons.info_outline),
                Icon(Icons.ondemand_video),
                Icon(Icons.insert_drive_file),
                Icon(Icons.comment),
                Icon(Icons.pie_chart_outlined)
              ]),
        ),
        body: Container(
          child: TabBarView(
            children: [
              AdminDetails(widget.details, widget.courseId),
              AdminLectures(widget.lectures, widget.courseId),
              AdminFiles(widget.files, widget.courseId),
              AdminReviews(widget.reviews, widget.courseId),
              Insights(widget.insights, widget.courseId),
            ],
          ),
        ),
      ),
    );
  }
}
