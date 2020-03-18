import 'package:AUIS_classroom/components/CourseCard.dart';
import 'package:AUIS_classroom/components/Course_lectures.dart';
import 'package:AUIS_classroom/components/CustomBottomNavigationBar.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteCourseScreen extends StatefulWidget {
  static const String id = '/favoriteScreen';
  FavoriteCourseScreen(this.data);
  final data;
  @override
  _FavoriteCourseScreenState createState() => _FavoriteCourseScreenState();
}

class _FavoriteCourseScreenState extends State<FavoriteCourseScreen> {
  List<CourseCard> courses = [];
  var response;
  void updateScreen() async {
    var response =
        await Network.getFav(Provider.of<User>(context, listen: false).id);
        convert(response);
        setState(() {
          print("set state" + courses.length.toString()+ courses[0].courseID);
        });
  }

  void convert(dynamic data) {
    courses.removeRange(0, courses.length);
    for (int i = 0; i < data['count']; i++) {
      courses.add(CourseCard(
        courseID: data['data'][i]['CourseId'],
        courseTitle: data['data'][i]['CourseName'],
        updateFavScreen: updateScreen,
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
