import 'package:AUIS_classroom/components/Course_details.dart';
import 'package:AUIS_classroom/components/Course_files.dart';
import 'package:AUIS_classroom/components/Course_lectures.dart';
import 'package:AUIS_classroom/components/Course_reviews.dart';
import 'package:AUIS_classroom/components/CustomBottomNavigationBar.dart';
import 'package:AUIS_classroom/components/Custom_Drawer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

class CourseScreen extends StatefulWidget {
  static const String id = '/course';
  final details;
  final lectures;
  final files;
  final reviews;
  CourseScreen({this.details, this.lectures, this.files, this.reviews});
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //   [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]
    // );
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
        elevation: 10,
        child: CustomDrawer(),
      ),
        appBar: AppBar(
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
              Details(widget.details),
              Lectures(widget.lectures, widget.details['CourseId']),
              Files(widget.files,widget.details['CourseId']),
              Reviews(widget.reviews, widget.details['CourseId']),
            ],
          ),
        ),
        bottomNavigationBar: CustmoBottomNavigationBar(
          isHome: false,
          isFav: false,
        ),
      ),
    );
  }
}
