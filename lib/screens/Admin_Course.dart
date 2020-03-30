import 'package:AUIS_classroom/components/Admin_CourseDetails.dart';
import 'package:AUIS_classroom/components/Admin_CourseFiles.dart';
import 'package:AUIS_classroom/components/Admin_CourseLectures.dart';
import 'package:AUIS_classroom/components/Admin_CourseReview.dart';
import 'package:AUIS_classroom/components/Custom_Drawer.dart';
import 'package:AUIS_classroom/components/Insights.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

class AdminCourseScreen extends StatefulWidget {
  static String id = '/AdminCourse';
  final courseId;
  
  AdminCourseScreen({@required this.courseId});
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
        length: 5,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: Drawer(
            child: CustomDrawer(),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(widget.courseId),
            bottom: TabBar(
                // isScrollable: true,
                labelColor: KBlue,
                unselectedLabelColor: Colors.white54,
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
                AdminDetails(widget.courseId),
                AdminLectures(widget.courseId),
                AdminFiles(widget.courseId),
                AdminReviews(widget.courseId),
                Insights(widget.courseId),
              ],
            ),
          ),
          
        ),
      ),
    );
  }
}
