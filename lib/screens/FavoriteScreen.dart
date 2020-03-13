import 'package:AUIS_classroom/components/CourseCard.dart';
import 'package:AUIS_classroom/components/Course_lectures.dart';
import 'package:AUIS_classroom/components/CustomBottomNavigationBar.dart';
import 'package:flutter/material.dart';

class FavoriteCourseScreen extends StatefulWidget {
  FavoriteCourseScreen(this.data);
  final data;
  @override
  _FavoriteCourseScreenState createState() => _FavoriteCourseScreenState();
}

class _FavoriteCourseScreenState extends State<FavoriteCourseScreen> {
  List<CourseCard> courses = [];
  var response;
  void convert(dynamic data) {
    courses.removeRange(0, courses.length);
    for (int i = 0; i < data['count']; i++) {
      courses.add(CourseCard(
        courseID: data['data'][i]['CourseId'],
        courseTitle: data['data'][i]['CourseName'],
        isFav: true,
      ));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convert(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return courses[index];
        },
      ),
      bottomNavigationBar: CustmoBottomNavigationBar(
        isHome: false,
        isFav: true,
      ),
    );
  }
}
