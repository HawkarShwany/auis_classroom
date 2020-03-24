import 'package:AUIS_classroom/components/Admin_CourseCard.dart';
import 'package:AUIS_classroom/components/Custom_Drawer.dart';
import 'package:AUIS_classroom/components/Departments.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/screens/Admin_AddCourse.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/components/Dep.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  static const String id = '/AdminHome';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminHomeScreen> {
  Dep selectedDep = Dep.CORE;
  List<AdminCourseCard> courses = [];
  var response;
  // var user = Provider.of<User>(context);

  void convert(dynamic data) {
    courses.removeRange(0, courses.length);
    for (int i = 0; i < data['count']; i++) {
      courses.add(AdminCourseCard(
        courseID: data['data'][i]['CourseId'],
        courseTitle: data['data'][i]['CourseName'],
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectDep(selectedDep);
  }

  void selectDep(Dep dep) async {
    response = await Network.getCourses(dep);
    convert(response);
    setState(() {
      selectedDep = dep;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          
          Departments(
            selectDep: selectDep,
            selectedDep: selectedDep,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return courses[index];
              },
              itemCount: courses.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'AddCourse',
          child: Icon(Icons.add, color: KPrimaryColor,),
          onPressed: () {
            Navigator.pushNamed(context, AddCourseScreen.id);
          },
        ),
    );
  }
}
