import 'package:AUIS_classroom/screens/Admin_AddCourse.dart';
import 'package:AUIS_classroom/screens/Admin_Course.dart';
import 'package:AUIS_classroom/screens/Admin_Home.dart';
import 'package:AUIS_classroom/screens/Course.dart';
import 'package:AUIS_classroom/screens/FavoriteScreen.dart';
import 'package:AUIS_classroom/screens/Home.dart';
import 'package:AUIS_classroom/screens/Search.dart';
import 'package:AUIS_classroom/screens/login.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Login.id:
      return MaterialPageRoute(builder: (context) => Login());
    case HomeScreen.id:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case AdminHomeScreen.id:
      return MaterialPageRoute(builder: (context) => AdminHomeScreen());
    case CourseScreen.id:
      List<dynamic> args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => CourseScreen(
                courseId: args[0],
                details: args[1],
                lectures: args[2],
                files: args[3],
                reviews: args[4],
              ));
    case AddCourseScreen.id:
      return MaterialPageRoute(builder: (context) => AddCourseScreen());
    case FavoriteCourseScreen.id:
      var args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => FavoriteCourseScreen(args));
    case AdminCourseScreen.id:
      List<dynamic> args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AdminCourseScreen(
                courseId: args[0],
                details: args[1],
                lectures: args[2],
                files: args[3],
                reviews: args[4],
                insights: args[5],
              ));
    case SearchScreen.id:
      return MaterialPageRoute(builder: (context) => SearchScreen());
    default:
      return MaterialPageRoute(builder: (context) => Login());
  }
}
