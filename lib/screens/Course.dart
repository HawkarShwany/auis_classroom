import 'package:AUIS_classroom/components/Course_details.dart';
import 'package:AUIS_classroom/components/Course_files.dart';
import 'package:AUIS_classroom/components/Course_lectures.dart';
import 'package:AUIS_classroom/components/Course_reviews.dart';
import 'package:AUIS_classroom/components/CustomBottomNavigationBar.dart';
import 'package:AUIS_classroom/services/network.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  static String id = '/course';
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
    
 
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(),
        appBar: AppBar(
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
        body: TabBarView(children: [
          Details(widget.details),
          Lectures(widget.lectures, widget.details['CourseId']),
          Files(),
          Reviews(widget.reviews),
        ]),
        bottomNavigationBar: CustmoBottomNavigationBar(isHome: false,isFav: false,),
      ),
    );
  }
}
