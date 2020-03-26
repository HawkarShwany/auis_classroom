import 'package:AUIS_classroom/screens/Admin_AddCourse.dart';
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
      return MaterialPageRoute(builder: (context) => CourseScreen());
    case AddCourseScreen.id:
      return MaterialPageRoute(builder: (context) => AddCourseScreen());
    case FavoriteCourseScreen.id:
      var args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => FavoriteCourseScreen(args));
    case SearchScreen.id:
      return MaterialPageRoute(builder: (context) => SearchScreen());
    default:
      return MaterialPageRoute(builder: (context) => Login());
  }
}
