import 'package:AUIS_classroom/components/Course_details.dart';
import 'package:AUIS_classroom/components/Course_files.dart';
import 'package:AUIS_classroom/components/Course_lectures.dart';
import 'package:AUIS_classroom/components/Course_reviews.dart';
import 'package:AUIS_classroom/components/CustomBottomNavigationBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

class AdminCourseScreen extends StatefulWidget {
  static String id = '/AdminCourse';
  final details;
  final lectures;
  final files;
  final reviews;
  AdminCourseScreen({this.details, this.lectures, this.files, this.reviews});
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<AdminCourseScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //   [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]
    // );
    return SafeArea(
          child: DefaultTabController(
        length: 4,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: Drawer(),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text("Admin"),
            bottom: TabBar(
                isScrollable: true,
                labelColor: KBlue,
                unselectedLabelColor: Colors.white54,
                indicatorColor: KBlue,
                indicatorSize: TabBarIndicatorSize.label,
                dragStartBehavior: DragStartBehavior.start,
                tabs: [
                  Text('Details'),
                  Text('Video Lectures'),
                  Text('Files'),
                  Text('Reviews'),
                ]),
          ),
          body: Container(
            child: TabBarView(
              children: [
                Details(widget.details),
                Lectures(widget.lectures, widget.details['CourseId']),
                Files(),
                Reviews(widget.reviews, widget.details['CourseId']),
              ],
            ),
          ),
          
        ),
      ),
    );
  }
}
