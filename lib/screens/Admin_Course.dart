import 'package:AUIS_classroom/components/Admin_CourseDetails.dart';
import 'package:AUIS_classroom/components/Admin_CourseFiles.dart';
import 'package:AUIS_classroom/components/Admin_CourseLectures.dart';
import 'package:AUIS_classroom/components/Admin_CourseReview.dart';
import 'package:AUIS_classroom/components/Course_files.dart';
import 'package:AUIS_classroom/components/Custom_Drawer.dart';
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
          drawer: Drawer(
            child: CustomDrawer(),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(widget.details['CourseId']),
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
                AdminDetails(widget.details),
                AdminLectures(widget.lectures, widget.details['CourseId']),
                AdminFiles(widget.files, widget.details['CourseId']),
                AdminReviews(widget.reviews, widget.details['CourseId']),
              ],
            ),
          ),
          
        ),
      ),
    );
  }
}
